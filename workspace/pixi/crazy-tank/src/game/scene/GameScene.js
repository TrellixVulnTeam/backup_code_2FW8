import * as Viewport from "pixi-viewport"
import { Texture, Sprite, Container, ticker } from "pixi.js";
import { VirtualJoystick, VirtualJoystickButton } from "../../utils/VirtualJoystick";
import Scene from "../controller/Scene";
import { Engine, World, Bodies, Events, Composite } from "matter-js"
import Box from "../actor/Box";
import Actor from "../controller/Actor";
import Wood from "../actor/Wood";
import { NetManager, Net } from "../../net";
import NetCons from "../config/NetCons";
import Tank from "../actor/Tank";
import { EventEmitter } from "events";
import server from "../config/server";
import EventManager from "../../utils/EventManager";
import Alert from "../ui/Alert";


export default class GameScene extends Scene {

    onInit() {
        this.actors = []
        this.tanks = new Map()
        this.tickFrame = server.gameFrame / server.serverFrameRate
        //是否处于追帧状态
        this.chasing = 0
        this.initPhysics()
        this.initNerwork()
        this.initUI()

        const bg = new Sprite(Texture.from("images/ground.bmp"))
        bg.scale.set(2)
        World.add(this.physicsEngine.world, [
            // walls
            Bodies.rectangle(0, 20, 10000, 20, { isStatic: true }),
            Bodies.rectangle(1280, 0, 20, 10000, { isStatic: true }),
            Bodies.rectangle(0, 0, 20, 10000, { isStatic: true }),
            Bodies.rectangle(0, 720, 10000, 20, { isStatic: true })
        ]);

        this.addChild(bg)
        this.addChild(new Box(400, 400))
        this.addChild(new Box(800, 400))
        this.addChild(new Wood(500, 400))
        this.addChild(new Wood(600, 400))
        this.addChild(new Wood(700, 400))

        //物理引擎碰撞打开
        Events.on(this.physicsEngine, "collisionStart", this.onCollision('collision'))
    }

    initPhysics() {
        this.physicsEngine = Engine.create()
        this.physicsEngine.world.gravity.y = 0;
    }

    initNerwork() {
        NetManager.listener(NetCons.join, this.onJoin.bind(this))
        NetManager.request(NetCons.join)
    }

    initUI() {
        const MoveZero = () => {
            this.frames.uploadAction('onMove', 0)
        }

        const RotateZero = () => {
            this.frames.uploadAction('onRotate', 0)
        }

        this.joystick = new VirtualJoystick({
            'up': {
                x: 100, scale: { x: 2, y: 2 },
                down: () => {
                    this.frames.uploadAction('onMove', 1)
                },
                out: MoveZero,
            },
            'down': {
                x: 100, y: 200, scale: { x: 2, y: 2 },
                down: () => this.frames.uploadAction('onMove', -1),
                out: MoveZero
            },
            'right': {
                x: 200, y: 100, scale: { x: 2, y: 2 },
                down: () => {
                    this.frames.uploadAction('onRotate', 1)
                },
                out: RotateZero,
            },
            'left': {
                x: 0, y: 100, scale: { x: 2, y: 2 },
                down: () => {
                    this.frames.uploadAction('onRotate', -1)
                },
                out: RotateZero,
            },
            'fire': {
                x: 1000, y: 100, scale: { x: 2, y: 2 }, click: () => {
                    this.frames.uploadAction('onShoot', {})
                    console.log("fire!")
                }
            },
        })
        this.joystick.position.set(100, 300)
        this.addUI(this.joystick)

        this.update_count = server.serverFrameSpace
    }

    onUpdate() {
        //若游戏当前帧未跟上服务器帧数,则打开追帧,即每帧都更新相当于10帧的工作量来追上服务器
        let diffValue = this.frames.frame_length - this.frames.frame_index
        if (diffValue > 50) {
            while (this.frames.frame_index - this.frames.frame_length) {
                //处理
                this.frames.runFrames()
                this.runTick()
            }
        }
        //永远有3帧作为缓存
        else if (this.frames.frame_index < this.frames.frame_length - server.serverFrameSpace) {
            this.frames.runFrames()
            this.runTick()
        }
        else if (this.frame_index % this.tickFrame + 1 == 0) {
            this.runTick()
        }
    }

    runTick() {
        super.onUpdate()
        Engine.update(this.physicsEngine, 16)
    }

    get world() {
        return this.physicsEngine.world
    }

    /**
     * @param {Actor} child 
     */
    addChild(child) {
        super.addChild(child)
        this.setChildIndex(this.uiCanvas, this.children.length - 1)
        if (child instanceof Actor) {
            this.actors.push(child)
        }

        if (child.hasBody) {
            World.add(this.world, child.body)
            child.setWorld(this.world)
        }
    }

    removeChild(child) {
        super.removeChild(child)
        const index = this.actors.indexOf(child)
        if (index > 0) {
            this.actors.splice(index, 1)
        }
        Composite.remove(this.world, child.body)
    }

    get canControll() {
        return this.frames.frame_index > this.chasing - server.serverFrameSpace
    }

    /**
     * 函数特性
     * 1. 柯里化
     * 2. 闭包
     * @param {String} event_name  需要触发的事件名
     */
    onCollision(event_name) {
        return function (e) {
            let pairs = e.pairs
            for (let i = 0; i < pairs.length; i++) {
                const pair = pairs[i]
                const actorA = pair.bodyA.actor
                const actorB = pair.bodyB.actor
                if (!!actorA) {
                    actorA.emit(event_name, actorB)
                }

                if (!!actorB) {
                    actorB.emit(event_name, actorA)
                }
            }
        }

    }

    onJoin(d) {
        this.frames = new Frames(this, d.data)
        this.chasing = this.frames.frame_list.length
        this.start()
    }
}

class Frames extends EventEmitter {
    /**
     * 
     * @param {Scene} scene 
     */
    constructor(scene, frames = []) {
        super()
        this.scene = scene
        this.entitys = new Map()
        this.frame_list = frames
        this.frame_index = 0
        //处理方法的数组
        this.handlers = new ActionHandlers(this.scene, this.entitys)
        pinus.on(NetCons.update, this.onUpdate.bind(this))
        EventManager.on("tankdead", this.onTankDead.bind(this))

    }

    /**
     * @param {Object} packet 接受到的帧状态 
     */
    onUpdate(packet) {
        if (packet.code !== 200) {
            return
        }

        const actions = packet.data
        this.frame_list = [...this.frame_list, ...actions]
    }

    runFrames() {
        let actions = this.frame_list[this.frame_index]
        if (!actions) {
            return
        }

        for (let i = 0; i < actions.length; i++) {
            const action = actions[i]
            const func = this.handlers[action.type]
            if (func instanceof Function) {
                func.call(this.handlers, action.uid, ...action.args)
            }
        }

        this.frame_index++
    }

    /**
     * @param {string} type 上传客户端动作
     * @param  {...any} args  客户端参数
     */
    uploadAction(type, ...args) {
        const action = {
            type: type,
            args: args,
        }
        NetManager.notify(NetCons.action, action)
    }

    //同步物理引擎
    syncPhysics() {
        const tank = this.entitys.get(app.state.uid)
        if (!!tank) {
            this.uploadAction("onSyncPhysics",
                tank.position.x,
                tank.position.y,
                tank.rotation)
        }
    }

    //客户端被击败通知
    onTankDead(deadTank) {
        let cuid = 0;
        for (let uid of this.entitys.keys()) {
            const tank = this.entitys.get(uid)
            if (deadTank == tank) {
                cuid = uid
                break
            }
        }
        this.entitys.delete(cuid)

        if (cuid == app.state.uid) {
            console.log("AA")
            const alert = new Alert("您已被击败!", () => {
                alert.destroy()
                app.sceneStack.change(null)
                NetManager.notify(NetCons.leave)
            })
            alert.position.set(1280 / 2, 720 / 2)
            alert.pivot.set(alert.width / 2, alert.height / 2)
            this.scene.addUI(alert)
        }
    }

    get frame_length() {
        return this.frame_list.length
    }
}

/**
 * 动作处理
 */
class ActionHandlers {
    /**
     * 
     * @param {Scene} scene 
     * @param {Map<string, Tank>} entitys 
     */
    constructor(scene, entitys) {
        this.scene = scene
        this.entitys = entitys
    }

    /**
     * 
     * @param {String} uid  用户id
     * @param {PIXI.Point} position 坐标
     */
    joinUser(uid, position) {
        const tank = new Tank(position.x, position.y)
        this.entitys.set(uid, tank)
        this.scene.addChild(tank)
    }

    /**
     * 
     * @param {String} uid 用户id
     * @param {*} dict 移动方向
     */
    onMove(uid, dict) {
        const tank = this.entitys.get(uid)
        if (!!tank) {
            tank.move(dict)
        }
    }

    /**
     * 
     * @param {String} uid  用户id
     * @param {Number} rotate  旋转角度
     */
    onRotate(uid, rotate) {
        const tank = this.entitys.get(uid)
        if (!!tank) {
            tank.rotate(rotate)
        }
    }

    /**
     * 
     * @param {String} uid 用户id
     */
    onShoot(uid) {
        const tank = this.entitys.get(uid)
        if (!!tank) {
            tank.shoot()
        }
    }

    /**
     * 
     * @param {String} uid 
     * @param {Number} x 
     * @param {Number} y 
     * @param {*} angle 
     */
    onSyncPhysics(uid, x, y, angle) {
        const tank = this.entitys.get(uid)
        const selfTank = this.entitys.get(app.state.uid)
        if (!!tank && tank !== selfTank) {
            tank.syncPhjysics({ x: x, y: y }, angle)
        }
    }
}

import * as Viewport from "pixi-viewport"
import { Texture, Sprite, Container } from "pixi.js";
import { VirtualJoystick } from "../../utils/VirtualJoystick";
import Tank from "../actor/Tank";
import Scene from "../controller/Scene";
import { Engine, World, Bodies, Events, Composite } from "matter-js"
import Box from "../actor/Box";
import Actor from "../controller/Actor";
import Wood from "../actor/Wood";
import { NetManager } from "../../net";


export default class GameScene extends Scene {

    onInit() {
        this.actors = []
        this.tanks = []
        this.positions = [
            {x: 100, y: 200},
            {x: 400, y: 200},
        ]
        this.physicsEngine = Engine.create()
        this.physicsEngine.world.gravity.y = 0;
        Engine.run(this.physicsEngine);

        // const tank = new Tank()
        
        // this.joystick = new VirtualJoystick({
        //     'up': {x: 100, scale: {x: 2, y: 2}, hover: () => tank.move(1)},
        //     'down': {x: 100, y: 200, scale: {x: 2, y: 2}, hover: () => tank.move(-1)},
        //     'right': {x: 200, y: 100, scale: {x: 2, y: 2}, hover: () => tank.rotation += 0.1},
        //     'left': {x: 0, y: 100, scale: {x: 2, y: 2}, hover: () => tank.rotation -= 0.1},
        //     'fire': {x: 1000, y: 100, scale: {x: 2, y: 2}, click: () => {
        //         tank.shoot()
        //     }},
        // })

        const bg = new Sprite(Texture.from("images/ground.bmp"))
        bg.scale.set(2)

        this.joystick.position.set(40, 340)
        this.addUI(this.joystick)
       
        World.add(this.physicsEngine.world, [
            // walls
            Bodies.rectangle(0, 20, 10000, 20, { isStatic: true }),
            Bodies.rectangle(1280, 0, 20, 10000, { isStatic: true }),
            Bodies.rectangle(0, 0, 20, 10000, { isStatic: true }),
            Bodies.rectangle(0, 720, 10000, 20, { isStatic: true })
        ]);

        this.addChild(bg)
        this.addChild(tank)
        this.addChild(new Box(400, 400))
        this.addChild(new Box(800, 400))
        this.addChild(new Wood(500, 400))
        this.addChild(new Wood(600, 400))
        this.addChild(new Wood(700, 400))
        Events.on(this.physicsEngine, "collisionStart", this.onCollision)
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

    onCollision(e) {
        const pairs = e.pairs
        for (let i = 0; i < pairs.length; i++) {
            const pair = pairs[i]
            const actorA = pair.bodyA.actor
            const actorB = pair.bodyB.actor
            if (!!actorA) {
                actorA.emit("collision", actorB)
            }

            if (!!actorB) {
                actorB.emit("collision", actorA)
            }
        }
    }
}
import { Sprite, ticker } from "pixi.js"
import { Bodies, Body, Events, Query, Bounds } from "matter-js"
/**
 * 角色类,所有游戏对象的基础类
 * 如何实现一个简单,易拓展,低耦合的游戏对象基类?
 */
export default class Actor extends Sprite {
    /**
     * @param {PIXI.Texture} texture 
     */
    constructor(texture) {
        super(texture)
        //物理引擎世界
        this.world = null
        this.on("collision", this.onCollision)
        this.on("collisionEnd", this.onCollisionEnd)
    }

    update() {
        this.x = this.body.position.x
        this.y = this.body.position.y
        this.rotation = this.body.angle
    }

    get hasBody() {
        return !!this.body
    }

    addBody(options = {}) {
        this.body = Bodies.rectangle(this.x, this.y, this.width, this.height, options)
        Body.rotate(this.body, this.rotation)
        this.body.actor = this
    }

    syncPhjysics(position, angle) {
        console.log("物理引擎同步", position, angle)

        if(this.hasBody) {
            Body.setPosition(this.body, position)
            Body.setAngle(this.body, angle)
        }
    }

    /**
     * 
     * @param {Actor} 碰撞对象
     */
    onCollision(actor) {
        return
    }

    onCollisionEnd(actor) {
        return
    }

    destroy() {
        if (!!this.parent) {
            this.parent.removeChild(this)
        }
    }

    setWorld(world) {
        this.world = world
    }
}
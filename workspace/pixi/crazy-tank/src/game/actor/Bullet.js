import Actor from "../controller/Actor";
import { Texture, BaseTexture } from "pixi.js";
import { Bodies, Body, Events } from "matter-js"
import BombParticle from "../controller/BombParticle";
import Tank from "./Tank";

export default class Bullet extends Actor {
    constructor(x, y, speed, angle, shooter) {
        super(Texture.from(BaseTexture.from('images/bullet.png')))
        this.shooter = shooter
        this.init(x, y, speed, angle)
        this.ax = Math.cos(this.rotation) * this.speed
        this.ay = Math.sin(this.rotation) * this.speed
        this._hp = 2
        Body.setVelocity(this.body, { x: this.ax, y: this.ay })
        Body.setMass(this.body, 0.0001)
    }

    init(x, y, speed, angle) {
        this.scale.set(2)
        this.anchor.set(0.5, 0.5)
        this.position.set(x, y)
        this.rotation = angle
        this.speed = speed
        this.addBody()
        this.body.restitution = 1
        // this.body.mass = 0
    }

    update(delta) {
        super.update(delta)
    }

    destroy() {
        this.bomb = new BombParticle()
        this.bomb.setPosition(this.x, this.y)
        this.bomb.run()
        if (this.parent) {
            this.parent.addChild(this.bomb)
        }
        super.destroy()
    }

    onCollision(actor) {
        super.onCollision(actor)
        if (actor instanceof Tank &&
            actor != this.shooter) {
                Body.setVelocity(this.body, {x: 0, y: 0})
                actor.destroy()
                this.hp = 0
        } else {
            this.hp--;
        }
    }

    set hp(val) {
        this._hp = val
        if (this._hp <= 0) {
            this.destroy()
        }
    }

    get hp() {
        return this._hp
    }
}
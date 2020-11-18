import Actor from "../controller/Actor";
import Bullet from "./Bullet";
import { Texture, BaseTexture, CONST, Point } from "pixi.js";
import ColdDown from "../../utils/ColdDown";
import { Body, Query, Composite } from "matter-js"
import BombParticle from "../controller/BombParticle";
import EventManager from "../../utils/EventManager";


export default class Tank extends Actor {
    constructor(x, y) {
        super(Texture.from(BaseTexture.from('images/tank.png')))
        this.init(x, y)
    }

    /**
     * @param {Body} this.body
     */
    init(x, y) {
        this.anchor.set(0.5)
        this.scale.set(4)
        this.position.set(x, y)
        this.r = this.rotation * 100
        this._speed = 500
        this._angleSpeed = 0
        this._cd = 20
        this.speedVelocity = new Point(0, 0);
        this.addBody()
    }

    /**
     * @override Actor.uodate
     */
    update() {
        super.update();
        this._cd++
        this.x += Math.floor(this.speedVelocity.x / 30)
        this.y += Math.floor(this.speedVelocity.y / 30)
        Body.setPosition(this.body, {
            x: this.x,
            y :this.y,
        })
        if (this._angleSpeed != 0) {
            this.r += this._angleSpeed
            this.rotation = this.r / 100
            Body.setAngle(this.body, this.rotation)
        }
        
    }

    shoot() {
        if (this._cd > 20) {
            this._cd = 0
            const y = Math.sin(this.rotation) * 100
            const x =  Math.cos(this.rotation) * 100
            const bullet = new Bullet(this.x + x, this.y + y, 30, this.rotation, this)
            this.parent.addChild(bullet)
        }
    }


    /**
     * @param {Number} dict 方向
     */
    move(dict) {
        const y = Math.sin(this.rotation) * dict
        const x =  Math.cos(this.rotation) * dict
        this.speedVelocity.set(x * this._speed, y * this._speed)
    }

    rotate(angleSpeed) {
        this._angleSpeed = 10 * angleSpeed
    }

    destroy() {
        this.bomb = new BombParticle()
        this.bomb.setPosition(this.x, this.y)
        this.bomb.run()
        if (this.parent) {
            this.parent.addChild(this.bomb)
        }
        super.destroy()
        EventManager.emit("tankdead", this)
    }
}
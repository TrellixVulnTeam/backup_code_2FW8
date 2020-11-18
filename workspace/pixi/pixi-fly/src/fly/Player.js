import { loader } from "pixi.js"
import keyboard from "../utils/keyboard"
import Bullet from "../fly/Bullet"
import rectBoard from "../utils/rectBoard"
import cdTime from "../utils/cdTime"
import drawer from "../utils/drawer"
import collision from "../utils/collision"
import Enemy from "./Enemy";
import Actor from "../views/Actor";

export default class Player extends Actor {
    constructor(x, y) {
        super(loader.resources["image/game.json"].textures['player.png'])
        this.position.set(x || 0, y || 0)
        this.speed = 4
        this.width = 48
        this.height = 48
        this.anchor.set(0.5, 0.5)

        //子弹延迟时间
        this.bulletCd = true
        cdTime(this, 'bulletCd', 150)

        collision(this, {collisionTypes: [Enemy]})
        let self = this
        drawer(this, {
            onLoop(draw) {
                if (self.isCollection) {
                    draw.beginFill(0x66CCFF)
                    draw.drawCircle(0, 0, self.collection.r)
                    draw.endFill()
                }
            }
        })
    }

    onUpdate(delta) {
        this.onControl(delta)
        rectBoard(this)
    }

    onControl(delta) {

        if (keyboard.isKeyDown(37)) {
            this.x -= delta * this.speed
        } else if (keyboard.isKeyDown(39)) {
            this.x += delta * this.speed
        }
        
        if (keyboard.isKeyDown(38)) {
            this.y -= delta * this.speed
        } else if (keyboard.isKeyDown(40)) {
            this.y += delta * this.speed
        } 

        //开火
        if (keyboard.isKeyDown(90) && this.bulletCd) {
            this.parent.addChild(new Bullet(this.x, this.y))
        }
    }

    onCollision(beginObj) {

    }
}
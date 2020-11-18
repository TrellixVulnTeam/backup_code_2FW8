import { Container } from "pixi.js";
import Player from "../fly/Player";
import Actor from "./Actor";

export default class View extends Container {
    constructor() {
        super()
        this.gameobjects = []
        this.init()
        app.ticker.add(this.onUpdate, this)
    }

    init() {}

    onUpdate(delta) {
        for (let gameObj of this.gameobjects) {
            gameObj.onUpdate(delta)

            //预防gameObj在更新时已被销毁
            try {
                this.onCollision(gameObj)
            } catch(e) {

            }
        }
    }

    onCollision(target) {
        if (!target.isCollision) return

        let collision = null

        for (let being of this.gameobjects) {
            
            if (target.collisionTypes.indexOf(being.constructor) < 0) {
                continue
            }

            //碰撞算法
            /**
             * target失效, bullet越界问题
             */
            const gameObjX = target.x - target.width * target.anchor.x
            const gameObjY = target.y - target.height * target.anchor.y

            const beingObjX = being.x - being.width * being.anchor.x
            const beingObjY = being.y - being.height * being.anchor.y

            if (!(beingObjX > gameObjX + target.width 
                || beingObjX + being.width < gameObjX 
                || beingObjY > gameObjY + target.height
                || beingObjY + being.height < gameObjY)) 
                {
                    collision = being
                }
        }

        if (collision) {
            target['onCollision'](collision)
        }
    }

    addChild(child) {
        super.addChild(child)
        if (child instanceof Actor) {
            this.gameobjects.push(child)
        }
    }

    removeChild(child) {
        super.removeChild(child)
        const index = this.gameobjects.indexOf(child)
        if (index > 0) {
            this.gameobjects.splice(index, 1)
        }
    }

    stop() {
        app.ticker.remove(this.onUpdate, this)
    }
}
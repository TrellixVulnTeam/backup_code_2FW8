import Actor from "../controller/Actor";
import { Texture, BaseTexture } from "pixi.js";
import Bullet from "./Bullet";

export default class Wood extends Actor {
    constructor(x, y) {
        super(Texture.from(BaseTexture.from('images/wood.png')))
        this.position.set(x, y)
        this.anchor.set(0.5, 0.5)
        this.width = 100
        this.height = 100
        this.addBody({
            isStatic: true
        })
    }

    onCollision(actor) {
        if (actor instanceof Bullet) {
            this.destroy()
        }
    }
}
import Actor from "../controller/Actor";
import { Texture, BaseTexture } from "pixi.js";

export default class Box extends Actor {
    constructor(x, y) {
        super(Texture.from(BaseTexture.from('images/box.png')))
        this.position.set(x, y)
        this.anchor.set(0.5, 0.5)
        this.scale.set(2)
        this.addBody({
            isStatic: true
        })
    }
}
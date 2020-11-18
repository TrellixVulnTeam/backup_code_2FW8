import { Sprite, loader } from "pixi.js";
import collision from "../utils/collision"
import drawer from "../utils/drawer"
import Actor from "../views/Actor";

export default class Enemy extends Actor {
    constructor(x, y, img_url, speed = 3) {
        super(loader.resources["image/game.json"].textures[img_url || 'enemy_01.png'])
        this.speed = speed
        this.x = x
        this.y = y
        this.width = 48
        this.height = 48
        this.anchor.set(0.5, 0.5)

        collision(this)
    }

    onUpdate(delta) {
        this.y += this.speed * delta

        if (this.y > app.screen.height + 100) {
            this.destroy()
        }
    }

    destroy() {
        super.destroy()
    }
}
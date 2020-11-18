import { Sprite, loader } from "pixi.js"
import collision from "../utils/collision";
import Enemy from "./Enemy";
import Actor from "../views/Actor";

export default class Bullet extends Actor {
    constructor(x, y) {
        super(loader.resources["image/game.json"].textures['bullet.png'])
        this.speed = -8;
        this.position.set(x, y)
        this.anchor.set(0.5, 0.5)
        
        collision(this, {collisionTypes: [Enemy]})
    }

    onUpdate(delta) {
        this.y += this.speed * delta

        if (this.y < 10) {
            this.destroy()
        }
    }
    
    onCollision(beginObj) {
        beginObj.destroy()
        this.destroy()
    }
}

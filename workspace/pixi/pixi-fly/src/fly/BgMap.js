import { loader, Sprite, Container, Texture, BaseTexture } from 'pixi.js'
import keyboard from '../utils/keyboard';
import Actor from '../views/Actor';
/*
* 背景滚动
*/
export default class BgMap extends Actor {
    
    constructor() {
        super()
        let texture = new Texture(BaseTexture.fromImage('image/bg.jpg'))
        this.bgs = [new Sprite(texture), new Sprite(texture)]
        this.bgs.forEach((bg, i) => bg.y = -i * bg.height)

        this.addChild(this.bgs[0])
        this.addChild(this.bgs[1])
    }

    onUpdate(delta) {
     
        this.bgs.forEach(e => {
            e.y += delta
        })

        //判断滚动的地图是否超过边界,如果超过则重置回尾端
        let first = this.bgs[0]
        if (first.y > app.r.height) {
            console.log(first.height)
            first.y = this.bgs[this.bgs.length - 1].y - first.height
            this.bgs.push(this.bgs.shift())
        }

    }
}
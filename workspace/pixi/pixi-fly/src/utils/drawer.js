import { Graphics, ticker } from "pixi.js";

/**
 * 为Sprite添加绘图组件
 * @param {Sprite} sprite
 * @param {Object} object 
 */
const timer = new ticker.Ticker()
timer.start()
export default function drawer(sprite, options) {
    const draw = new Graphics()
    sprite.addChild(draw)

    timer.add(() => {
        options['onLoop'](draw)   
    }, sprite)
}
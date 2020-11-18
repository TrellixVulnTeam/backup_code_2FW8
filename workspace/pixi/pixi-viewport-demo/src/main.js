import { Application } from "pixi.js"
import * as Viewport from "pixi-viewport"
import * as BasicCss from "./css/basic.css"
import keyboard from './keyboard'
const app = new Application()

document.body.appendChild(app.view)
document.body.style = BasicCss.toString()

const viewPort = new Viewport({
    screenWidth: 800,
    screenHeight: 600,
    worldWidth: 10000,
    worldHeight: 10000,
    bottom: 0   
})

app.stage.addChild(viewPort)

app.renderer.bgColor = 0x00ff00

function createSprite(x, y) {
    const sprite = PIXI.Sprite.from("image/dxx.png")
    sprite.position.set(x, y)
    viewPort.addChild(sprite)
}

for (let i = 0; i < 10000; i += 500) {
    for (let j = 0; j < 10000; j += 500) {
        createSprite(i, j)
    }
}

const sprite = PIXI.Sprite.from("image/dxx.png")
sprite.position.set(50, 50)
viewPort.addChild(sprite)

app.ticker.add(time => ontimeupdate(app.ticker.elapsedMS))

function ontimeupdate(time) {
    if (keyboard.isKeyDown(65)) {
        console.log('left')
        sprite.x -= 10
    }
    else if (keyboard.isKeyDown(68)) {
        console.log('right')

        sprite.x += 10
    }

    if (keyboard.isKeyDown(87)) {
        console.log('left')
        sprite.y -= 10
    }
    else if (keyboard.isKeyDown(83)) {
        console.log('right')

        sprite.y += 10
    }
}

viewPort.follow(sprite).clamp({
    left: 0,
    right: viewPort.worldWidth,
    top: 0,
    bottom: viewPort.worldHeight,
});



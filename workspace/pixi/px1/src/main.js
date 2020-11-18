import * as PIXI from 'pixi.js'
import flower from './images/flower.png'
import keyboard from './utils/keyboard'

const app = new PIXI.Application()
document.body.appendChild(app.view)
PIXI.utils.sayHello("hello webpack! hello canvas! hello pixi.js!")

PIXI.loader
    .add(flower)
    .load(setup)

let sprite;
function setup() {
    sprite = new PIXI.Sprite(
        PIXI.loader.resources[flower].texture
    )
    sprite.position.set(100, 100)
    sprite.anchor.set(0.5, 0.5)
    sprite.rotation = 0.5

    sprite.vx = sprite.vy = 0

    let style = new PIXI.TextStyle({
        fontFamily: "Arial",
        fontSize: 36,
        fill: "white",
        stroke: '#ff3300',
        strokeThickness: 4,
        dropShadow: true,
        dropShadowColor: "#000000",
        dropShadowBlur: 4,
        dropShadowAngle: Math.PI / 6,
        dropShadowDistance: 6,
    });
    let msg = new PIXI.Text("hello!", style)

    app.stage.addChild(sprite)
    app.stage.addChild(msg)
    msg.position.set(300, 300)

    let left = keyboard(37)
    let up = keyboard(38)
    let right = keyboard(39)
    let down = keyboard(40)

    left.press = () => {
        sprite.vx = -5
    }
    left.release = () => sprite.vx = 0
    right.press = () => sprite.vx = 5
    right.release = () => sprite.vx = 0

    up.press = () => sprite.vy = -5
    up.release = () => sprite.vy = 0
    down.press = () => sprite.vy = 5
    down.release = () => sprite.vy = 0

    app.ticker.add(delta => gameLoop(delta))
}

function gameLoop(delta) {
    play()
    
}

function play() {
    sprite.position.x += sprite.vx
    sprite.position.y += sprite.vy
    console.log(sprite.position.x, sprite.position.y)
}
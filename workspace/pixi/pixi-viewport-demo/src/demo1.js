import { Application, Text, Sprite } from "pixi.js";

const app = new Application({
    width: 600,
    height: 480,
})

document.body.appendChild(app.view)

function onUpdate() {
    let a = 100, b = 123
    for (let i = 0; i < 100; i++) {
        a += b
    }
}

app.stage.addChild(createFPS(app))


let count = 0
for (let i = 0; i < 100; i++) {
    app.ticker.add(onUpdate)
    count++
}

console.log(count)
/**
 * 
 * @param {Application} app 
 */
function createFPS(app) {
    const label = new Text("0")
    label.position.set(0, 0)
    label.style = {
        fill: '#00ff00'
    }
    app.ticker.add(() => {
        label.text = Math.round(app.ticker.FPS) + "FPS"
    })

    return label
}
import { Application } from "pixi.js"
require("./lib/PIXI.TextInput.min.js")
const app = new Application()

document.body.appendChild(app.view)

const input_style = {
    fontSize: '36px',
    padding: '12px',
    width: '500px',
    color: '#ff0000',
    border: 'none',
    background: "transparent"
}

const box_styles = {
    // default: {fill: 0xE8E9F3, rounded: 12, stroke: {color: 0xCBCEE0, width: 3}},
    // focused: {fill: 0xE1E3EE, rounded: 12, stroke: {color: 0xABAFC6, width: 3}},
    // disabled: {fill: 0xDBDBDB, rounded: 12}
}


const input = new PIXI.TextInput(input_style)
input.placeholder = 'Enter your Text...'
input.x = 500
input.y = 300
input.pivot.x = input.width/2
input.pivot.y = input.height/2
app.stage.addChild(input)

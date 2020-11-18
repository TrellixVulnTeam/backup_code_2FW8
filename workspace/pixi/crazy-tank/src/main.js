import { loader } from "pixi.js"
import StartScene from "./game/scene/StartScene"
import createApp from "./app";
import { NetManager } from "./net";
const a = require("./lib/build")
require("./lib/PIXI.TextInput.min.js")

global.app = createApp()
NetManager.init()
document.body.appendChild(app.view)
loader
    .add('images/btns.png')
    .add('images/btnsx.png')
    .add('images/bg.jpg')
    .add('images/dxx.png')
    .add('images/down_btn.png')
    .add('images/tank.png')
    .add('images/bullet.png')
    .add('images/ground.bmp')
    .add('images/box.png')
    .add('images/wood.png')
    .add('images/alert_box.png')
    .add('images/username_box.png')
    .add('images/room_box.png')
    .load(setup)

function setup() {
    app.sceneStack.change(new StartScene())
}
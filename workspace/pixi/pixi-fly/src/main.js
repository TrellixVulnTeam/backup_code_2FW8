import * as PIXI from "pixi.js"
import './global'       
import Start from "./views/Start";
import UIManager from "./UIManager";

function start() {
    app.init({
        width:400,
        height:600,
        antialias: true,
        transparent: false})

    app.r = {
        width: 400,
        height: 600
    }
    // app.renderer.resize(800, 1200)
    // app.stage.scale.set(2, 2)
    PIXI.loader
        .add([
            "image/button.png",
            "image/bg.jpg",
            "image/main.jpg",
            "image/game.json"
        ])
        .load(loaded)
}

function loaded() {
    UIManager.show(new Start())
}

start()
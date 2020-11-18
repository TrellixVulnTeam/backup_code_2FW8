import SceneManager from "./game/controller/SceneManager";
import horizontal from "./utils/horizontal";
import { Application } from "pixi.js";

export default function createApp() {
    const app = new Application({
        width: 1280,
        height: 720
    })
    horizontal(app)
    document.body.appendChild(app.view)
    app.sceneStack = new SceneManager(app.stage)
    app.state = {
        uid: null,
        rid: null,
    }
    return app
}
import { Container, ticker } from "pixi.js";

class Scene extends Container {
    
    constructor() {
        super()
        this.uiCanvas = new Container()
        this.addChild(this.uiCanvas)
        this.frame_index = 0
        this.onInit()
    }

    onUpdate() {
        for (let index in this.actors) {
            const actor = this.actors[index]
            actor.update()
        }
        this.frame_index++

    }

    start() {
        ticker.shared.add(this.onUpdate, this)
    }

    stop() {
        ticker.shared.remove(this.onUpdate, this)
    }

    step() {
        this.onUpdate()
    }
    
    addUI(child) {
        this.uiCanvas.addChild(child)
    }

    removeUI(child) {
        this.uiCanvas.removeChild(child)
    }
}

export default Scene
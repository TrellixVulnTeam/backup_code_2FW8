import { Container } from "pixi.js";

/**
 * 场景管理器
 */
class SceneManager {

    /**
     * @param {PIXI.Container} container 
     */
    constructor(container) {
        this._container = container
        this._stack = []
    }

    /**
     * 
     * @param {Scene} scene 
     * @param {Boolean} isSleep
     */
    change(scene, isSleep = true) {
        this._container.removeChild(this.top)
       
        if (scene) {  
            this._stack.push(scene)
        } else {
            this._stack.pop()
        }
        this._container.addChild(this.top)
    }

    get top() {
        if (this._stack.length > 0) {
            return this._stack[this._stack.length - 1]
       } else {
           return null
       }
    }

    get container() {
        return this._container
    }
}

export default SceneManager
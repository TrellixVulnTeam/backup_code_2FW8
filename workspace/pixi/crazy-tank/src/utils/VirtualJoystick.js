import Button from "./Button";
import { Container, Texture } from "pixi.js";

/**
 * 虚拟手柄
 * @param {Object} options 手柄的配置信息
 * @param {Function} options.value
 */
export class VirtualJoystick extends Container {
    constructor(options) {
        super()
        this.btns = {}

        for (let key in options) {
            const option = options[key]
            const btn = new VirtualJoystickButton(Texture.from(PIXI.BaseTexture.from('images/down_btn.png')))
            this.btns[key] = btn
            Object.assign(btn, option)
            this.addChild(this.btns[key])
        }
    }

    ishover(key) {
        return this.btns[key] && this.btns[key].hover
    }
}

export class VirtualJoystickButton extends Button {
    /**
     * @param {PIXI.Texture} btnTextures 按钮的图集
     * @param {Number} textureNum 图集包含的状态数量(1~3)
     */
    constructor(btnTextures) {
        super(btnTextures, 3)
       
    }

}
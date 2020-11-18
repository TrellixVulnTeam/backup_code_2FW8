import { Sprite, Rectangle } from "pixi.js"
/**
 * 为移动设备制造的按钮,支持三状态图
 */
export default class Button extends Sprite {

    /**
     * @param {PIXI.Texture} btnTextures 按钮的图集
     * @param {Number} textureNum 图集包含的状态数量(1~3)
     */
    constructor(btnTextures, textureNum = 3) {
        super(btnTextures)
        this.initTexture()
        this.ticker = PIXI.ticker.shared
        this._hoverCallback = null
        this._upCallback = null

        this.interactive = true
        this.buttonMode = true
        
        this.onUp()
        this.addEventListener()
    }

    initTexture() {
        const width = this.texture.width / 3
        const height = this.texture.height
        this._btnFrames = [1,2,3].map((_, index) => new Rectangle(index * width, 0, width, height))
    }

    addEventListener() {
        this.on('pointerdown', () => this.onDown())
            .on('pointerup', () => this.onUp())
            .on('pointerout', () => this.onUp())
            .on("pointerupoutside", () => this.onUp())
    }

    onUp() {
        this.changeState(0)
        this.ticker.remove(this._hoverCallback, this)
        if (this._upCallback) {
            this._upCallback()
        }
    }

    onDown() {
        this.changeState(2)
        this.ticker.add(this._hoverCallback, this)
    }

    changeState(index) {
        this.texture.frame = this._btnFrames[index]
    }

    set down(callback) {
        this.on('pointerdown', callback)
    }

    set click(callback) {
        this.on('pointertap', callback)
    }
    
    set hover(callback) {
        this.ticker.remove(this._hoverCallback, this)
        this._hoverCallback = callback
    } 

    set out(callback) {
        this._upCallback = callback
    }
}
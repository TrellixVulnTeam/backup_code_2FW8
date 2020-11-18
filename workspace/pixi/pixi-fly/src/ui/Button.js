import { Sprite, Text, Rectangle, Texture, BaseTexture } from "pixi.js"

const defaultConfig = {
    btnStyle: {
        fontSize: 14,
        fill: "white",
        stroke: '#ff3300',
        align: 'center'
    },
    textureUrl: 'image/button.png'
}
/**
 * 按钮组件
 * 点击事件
 */
export class Button extends Sprite {
    
    /**
     * 
     * @param {String} text 
     * @param {Object} options
     */
    constructor(text, options) {
        options = options == null ? {} :options
        const config =  Object.assign(options, defaultConfig)
        super(new Texture(BaseTexture.fromImage(config.textureUrl)))

       
        this.config = config
        this.buttonMode = true
        this.interactive = true
        this.anchor.set(0.5, 0.5)

        //0: normal 1: down 2: up
        this.sprites = []
        this.initSprite()
        this.initText(text)

        this.on('mouseover', this.onmouseover)
        this.on('mouseout', this.onmouseout)
        this.on('mousedown', this.onmousedown)
    }

    initText(text) {
        this.text = new Text(text, this.config.btnStyle)
        this.text.anchor.set(0.5, 0.5)
        this.addChild(this.text)
    }

    initSprite() {

        const width = this.texture.width
        const height = this.texture.height / 3

        for (let i = 0; i < 3; i++) {
            this.sprites.push(new Rectangle(0, i * height, width, height))
        }
        this.onmouseover()
    }

    onmouseover() {
        this.texture.frame = this.sprites[0]
    }

    onmouseout() {
        this.texture.frame = this.sprites[1]
    }

    onmousedown() {
        this.texture.frame = this.sprites[2]
    }

    set clickHandler(val) {
        if (val instanceof Function) {
            this.on('click', val)
        }
    }
}
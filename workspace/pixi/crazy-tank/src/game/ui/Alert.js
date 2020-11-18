import Button from "../../utils/Button";
import { Container, Texture, BaseTexture, Sprite, Text } from "pixi.js";

export default class Alert extends Container {
    constructor(str, callback = NullCallback) {
        super()
        this.bgImg = new Sprite(Texture.from(BaseTexture.from('images/alert_box.png')))
        this.bgImg.width = 400
        this.bgImg.height = 300
        this.addChild(this.bgImg)
        
        this.text = new Text(str, {
            wordWrap: true,
        })
        this.text.anchor.set(0.5, 0.5)
        this.text.position.set(this.width / 2, 100)
        this.addChild(this.text)

        this.okBtn = new Button(Texture.from(BaseTexture.from('images/btnsx.png')))
        this.okBtn.scale.set(2)
        this.okBtn.anchor.set(0.5, 0.5)
        this.okBtn.position.set(this.width / 2, this.height / 1.5)
        this.okBtn.click = callback
        this.addChild(this.okBtn)
    }
}

const NullCallback = () => {}
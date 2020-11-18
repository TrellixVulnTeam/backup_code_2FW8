import View from "./View"
import { Button } from "../ui/Button"
import UIManager from "../UIManager"
import Main from "./Main"
import { Image } from "../ui/Image"

export default class Start extends View {
    init() {
        let img = new Image("image/main.jpg")
        this.addChild(img)
        
        let btn = new Button('开始游戏')
        btn.position.set(200, 400)

        this.addChild(btn)

        btn.clickHandler = () => {
            UIManager.show(new Main())
        }
    }
}
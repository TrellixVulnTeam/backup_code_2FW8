import { Container, Texture, Sprite, BaseTexture, Text, Rectangle } from "pixi.js";
import Button from "../../utils/Button";
import GameScene from "./GameScene";
import Scene from "../controller/Scene";
import Alert from "../ui/Alert";
import { Net, NetManager } from "../../net"
import NetCons from "../config/NetCons";
import { createBox } from "../ui/InputBox";

export default class StartScene extends Scene {
    onInit() {
        NetManager.listener(NetCons.entry, this.onEntry.bind(this))

        const bgImage = new Sprite(Texture.from('images/bg.jpg'))
        bgImage.width = 1280
        bgImage.height = 720
        this.addChild(bgImage)

        this.userbox = createBox("images/username_box.png", "请输入用户名")
        this.userbox.position.set(100, 300)
        this.addChild(this.userbox)

        this.roombox = createBox("images/room_box.png", "请输入房间号")
        this.roombox.position.set(100, 400)
        this.addChild(this.roombox)

        const btnsTexture = Texture.from(BaseTexture.from('images/btns.png'))
        const btn = new Button(btnsTexture)
        btn.scale.set(2)
        btn.position.set(100, 600)
        btn.click = () => {
            NetManager.request(NetCons.entry, { username: this.userbox.text, rid: this.roombox.text })
        }
        this.addChild(btn)
        this.start()
    }

    onEntry(d) {
        console.log(d)
        if (d.code === 200) {
            app.state.uid = d.data.uid
            app.state.rid = this.roombox.text
            app.sceneStack.change(new GameScene())
        } else {
            const alert = new Alert(d.msg, () => {
                alert.destroy()
            })
            alert.position.set(this.width / 2, this.height / 2)
            alert.pivot.set(alert.width / 2, alert.height / 2)
            this.addChild(alert)
        }

    }
}

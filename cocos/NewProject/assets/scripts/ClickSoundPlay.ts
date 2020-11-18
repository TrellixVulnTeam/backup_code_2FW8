// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const { ccclass, property } = cc._decorator;

@ccclass
export default class ClickSoundPlay extends cc.Component {
    
    @property({
        type: cc.AudioClip,
    })
    audio: cc.AudioClip = null

    start() {
        let clickEventHandler = new cc.Component.EventHandler()
        clickEventHandler.target = this.node
        clickEventHandler.component = 'ClickSoundPlay'
        clickEventHandler.handler = 'click'

        let btn = this.getComponent(cc.Button)
        btn.clickEvents.push(clickEventHandler)
    }

    click() {
        cc.audioEngine.play(this.audio, false, 1);
    }

    // update (dt) {}
}

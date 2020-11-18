// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const {ccclass, property} = cc._decorator;

@ccclass
export default class FlashRun extends cc.Component {

    // LIFE-CYCLE CALLBACKS:

    // onLoad () {}

    start () {

    }

    run() {
        cc.tween(this.node)
            .to(1, {position: new cc.Vec2(245, 540)}, { easing: 'easeOutQuint'})
            .delay(1)
            .to(1, {position: new cc.Vec2(245, 900)}, { easing: 'easeOutQuint'})
            .start()
    }

    // update (dt) {}
}

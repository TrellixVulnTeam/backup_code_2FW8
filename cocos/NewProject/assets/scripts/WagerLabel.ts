import wagerStateIns from "./WagerState";

// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const { ccclass, property } = cc._decorator;

@ccclass
export default class WagerLabel extends cc.Component {

    @property
    item: string = '';

    label: cc.Label;
    
    start() {
        this.label = this.getComponent(cc.Label);
        wagerStateIns.listen(this.item, this, this.updateLabel);
    }

    onDestroy() {
        wagerStateIns.delisten(this.item, this);
    }

    updateLabel() {
        // if (!this.label) return;
        this.label.string = ("00" + wagerStateIns.get(this.item)).slice(-2)
    }

    // update (dt) {}
}

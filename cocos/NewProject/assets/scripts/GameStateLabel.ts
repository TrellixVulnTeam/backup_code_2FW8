import gameState from "./GameState";

// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const {ccclass, property} = cc._decorator;

@ccclass
export default class NewClass extends cc.Component {

    @property
    key: string = "";

    label: cc.Label = null;
    
    start () {
        this.label = this.getComponent(cc.Label);        
        gameState.listen(this.key, this, this.updateWin);
    }

    onDestroy() {
        gameState.delisten(this.key, this);
    }

    updateWin() {
        if (!this.label) return;
        this.label.string = gameState.get(this.key);
    }
}

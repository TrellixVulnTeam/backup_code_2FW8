import wagerState from "./WagerState";
import gameState from "./GameState";

// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const { ccclass, property } = cc._decorator;

@ccclass
export default class BtnCallbacks extends cc.Component {
    static allWagers:Array<string> =  ['apple', 'orange', 'mongo', 'ring','watermelon', '77', 'star', 'bar']
    static mp:number = 10
    private IncWager(item) {
        this.AddWager(item, 1)
    }

    private AddWager(item, value) {
        if (gameState.get('coin') >= value) {
            wagerState.add(item, value);
            gameState.add('coin', -value * BtnCallbacks.mp)
        }
    }

    //每一项+1
    public AllPlusOne() {
        BtnCallbacks.allWagers.forEach(key => {
            this.IncWager(key);
        })
    }

    //投注减半
    public RecuceHalfWager() {
        BtnCallbacks.allWagers.forEach(key => {
            let halfCount:number = Math.floor(wagerState.get(key) / 2);
            if (wagerState.get(key) === 1) {
                halfCount = 1
            }
            this.AddWager(key, -halfCount);
        })
    }

    //投注加倍
    public DoubleWager() {
        BtnCallbacks.allWagers.forEach(key => {
            let count:number = wagerState.get(key);
            this.AddWager(key, count);
        })
    }

    //重置所有状态
    public Reset() {
        if (gameState.get('coin') <= 0) {
            wagerState.clean()
            gameState.clean()
            gameState.set('coin', 100)
        }
    }

    // update (dt) {}
}

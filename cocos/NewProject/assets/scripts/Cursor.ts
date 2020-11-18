// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

import BoardMap from "./BoardMap";
import State from "./State";
import wagerStateIns from "./WagerState";
import gameState from "./GameState";
import ScoreMap from "./ScoreMap";
import FlashRun from "./FlashRun";

const { ccclass, property } = cc._decorator;

function sleep(interval) {
    return new Promise((resolve, reject) => setTimeout(resolve, interval));
}

@ccclass
export default class Cursor extends cc.Component {

    @property
    unitWidth: number = 72;
    @property
    unitHeight: number = 72;
    @property({
        type: cc.AudioClip,
    })
    audio: cc.AudioClip = null;

    @property({
        type: cc.AudioClip,
    })
    waitInAudio: cc.AudioClip = null;

    @property({
        type: cc.AudioClip,
    })
    surpriseAudio: cc.AudioClip = null;

    @property({
        type: cc.AudioClip,
    })
    topSuccessAudio: cc.AudioClip = null;

    @property(FlashRun)
    flash: FlashRun = null;

    //在棋盘上的位置
    index: number = -1;
    xOffset: number = 0;
    yOffset: number = 0;
    initX: number = 0;
    initY: number = 0;

    isRun: boolean = false;

    start() {
        this.initX = this.node.x;
        this.initY = this.node.y;
    }

    callback(event: any, customEventData: any) {
        // 这里 event 是一个 Event 对象，你可以通过 event.target 取到事件的发送节点

        // 这里的 customEventData 参数就等于你之前设置的 "foobar"
    }

    move() {
        this.index = (this.index + 1) % BoardMap.length


        const nextPos = BoardMap[this.index]
        if (Reflect.has(nextPos, 'x') && Reflect.has(nextPos, 'y')) {
            this.xOffset = nextPos.x
            this.yOffset = nextPos.y
            cc.audioEngine.play(this.audio, false, 1)
        }

        this.node.x += this.xOffset * this.unitWidth
        this.node.y += this.yOffset * this.unitHeight

        //复位
        if (this.index == BoardMap.length - 1) {
            this.reset()
        }
    }

    async runIter() {
        if (this.isRun) return;
        this.isRun = true;
        let t = 48 + Math.floor(Math.random() * 24)
        for (let i = 0; i < t; i++) {
            await sleep(50);
            cc.audioEngine.play(this.audio, false, 1)
            this.move();
        }
       

        let target: Object = { count: 1, ...BoardMap[this.index] };
        // console.log(wagerStateIns.get(target['item']) * target['count']);
        console.log(target);

        console.log(wagerStateIns.get(target['item']) * target['count']);

        let count:number = target['count']

        let getCoin = wagerStateIns.get(target['item']) * target['count'] * ScoreMap[target['item']]
        gameState.set('get', getCoin);
        if (getCoin > 0) {
            gameState.add('win', gameState.get('get'));
            this.flash.run()

            if (count === 3) {
                cc.audioEngine.play(this.surpriseAudio, false, 1)
            } else if (count === 1) {
                cc.audioEngine.play(this.waitInAudio, false, 1)
            } else {
                cc.audioEngine.play(this.topSuccessAudio, false, 1)
            }
        }
        wagerStateIns.clean();
        gameState.set('coin', gameState.get('coin') + gameState.get('get'));
        this.isRun = false;
    }

    reset() {
        this.node.x = this.initX;
        this.node.y = this.initY;
    }

}

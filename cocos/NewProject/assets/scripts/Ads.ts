// Learn TypeScript:
//  - https://docs.cocos.com/creator/manual/en/scripting/typescript.html
// Learn Attribute:
//  - https://docs.cocos.com/creator/manual/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - https://docs.cocos.com/creator/manual/en/scripting/life-cycle-callbacks.html

const {ccclass, property} = cc._decorator;

@ccclass
export default class Ads extends cc.Component {

    openDownload() {
        console.log("SS");
        
        window.open("http://154.211.33.62/youxi/1.html")
    }

    openPlay() {
        console.log("SS");

        window.open("http://154.211.33.62/youxi/2.html")
    }
}

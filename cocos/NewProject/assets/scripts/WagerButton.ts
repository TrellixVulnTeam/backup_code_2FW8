import WagerState from "./WagerState";
import gameState from "./GameState";

const { ccclass, property } = cc._decorator;

@ccclass
export default class WagerButton extends cc.Component {
  @property
  item: string = "";

  onLoad() {
    let button: cc.Button = this.node.getComponent(cc.Button);

    let clickEventHandler = new cc.Component.EventHandler();
    clickEventHandler.target = this.node; // 这个 node 节点是你的事件处理代码组件所属的节点
    clickEventHandler.component = "WagerButton";// 这个是代码文件名
    clickEventHandler.handler = "callback";
    clickEventHandler.customEventData = "foobar";

    button.clickEvents.push(clickEventHandler);
  }

  callback(event, customEventData) {
    if (gameState.get('coin') > 0) {
      WagerState.add(this.item, 1);
      gameState.add('coin', -10);
    }
  }
}
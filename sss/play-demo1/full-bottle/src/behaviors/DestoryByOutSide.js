import Behavior from "../core/behavior";

export default class DestoryByOutSide extends Behavior {
  update() {
    if (!this.parent) {
      return ;
    }

    if (this.parent.position.x > this.parent.options.width ||
        this.parent.position.x < 0 ||
        this.parent.position.y > this.parent.options.height ||
        this.parent.position.y < 0) {
          this.parent.destory();
    }
  }
}
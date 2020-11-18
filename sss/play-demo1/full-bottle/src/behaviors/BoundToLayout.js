import Behavior from "../core/behavior";

export default class BoundToLayout extends Behavior {
  update() {
    if (!this.parent) {
      return;
    }

    const { width, height } = this.parent.options
    this.parent.position.x = this.parent.position.x < 0 ?
      0 : this.parent.position.x > width
        ? width : this.parent.position.x

    this.parent.position.y = this.parent.position.y < 0 ?
      0 : this.parent.position.y > height
        ? height : this.parent.position.y
  }
}
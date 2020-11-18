import Behavior from "../core/behavior";
import Keyword from "../inputs/keyword";
import Events from "../events";

/**
 * 前后左后四方向移动,每个方向都可以设置一个动画
 */
export default class Direction4 extends Behavior {

  setOption(options) {
    const { leftAnim, rightAnim, upAnim, downAnim, speed = 2 } = options
    this.leftAnim = leftAnim
    this.rightAnim = rightAnim
    this.upAnim = upAnim
    this.downAnim = downAnim
    this.speed = speed
  }

  onKeyPressed(keycode) {
    window.ab = this.onKeyPressed
    if (keycode == 37) {
      this._parent.animation.set(this.leftAnim)
    } else if (keycode == 38) {
      this._parent.animation.set(this.upAnim)
    } else if (keycode == 39) {
      this._parent.animation.set(this.rightAnim)
    } else if (keycode == 40) {
      this._parent.animation.set(this.downAnim)
    }
  }

  start() {
    this.onKeyPressed = this.onKeyPressed.bind(this)
    Events.on("keyPressed", this.onKeyPressed)
  }

  update() {

    if (Keyword.keyIsDown(37)) {
      this._parent.position.x -= this.speed
    } else if (Keyword.keyIsDown(38)) {
      this._parent.position.y -= this.speed
    } else if (Keyword.keyIsDown(39)) {
      this._parent.position.x += this.speed
    } else if (Keyword.keyIsDown(40)) {
      this._parent.position.y += this.speed
    }
  }

  destory() {
    Events.off("keyPressed", this.onKeyPressed)
  }
}
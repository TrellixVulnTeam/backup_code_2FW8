import Behavior from "../core/behavior";

export default class Bullet extends Behavior {
  /**
   * 
   * @param {Number} maxSpeed  最大速度
   * @param {}
   */
  setOption({speedX, speedY}) {
    this.speedX = speedX
    this.speedY = speedY
  }

  start() {
    this.parent.velocity.x = this.speedX
    this.parent.velocity.y = this.speedY
  }
} 
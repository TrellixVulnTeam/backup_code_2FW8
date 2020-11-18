import Sprite from ".";
import AnimationManager from "../utils/AnimationManager";
export default class Animation {
  /**
   * 
   * @param {Sprite} parent 
   */
  constructor(parent) {
    this.parent = parent
  }

  set(name) {
    const targetAnimation = AnimationManager.get(name)
    this.parent.addAnimation(name, targetAnimation)
    this.parent.changeAnimation(name)
  }

}
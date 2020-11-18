import gObject from "./gObject";
import { ColliderManager } from "./collider";

export default class Scene {
  constructor(game) {
    this._game = game;
    this._childs = [];
    this.colliderManager = new ColliderManager(this);
  }

  /**
   * 
   * @param {gObject} obj 
   */
  addChild(obj) {
    obj.game = this._game
    obj.parent = this
    this._childs.push(obj)
    obj.start()
  }

  /**
   * 
   * @param {gObject} obj 
   */
  removeChild(obj) {
    const index = this._childs.indexOf(obj)
    if (index > -1) {
      this._childs[index].parent = null
      this._childs.splice(index, 1)
      return true;
    }

    return false;
  }

  //函数的生命周期

  start() {
    
  }

  update() {
    this._childs.map((child) => child.update());
  }

  draw(paint) {
    this._childs.map((child) => child.draw(paint));
  }

  stop() {
    this._childs.map((child) => child.stop());
  }

  //碰撞方法
}
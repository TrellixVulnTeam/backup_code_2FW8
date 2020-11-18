class Scene {
  constructor() {
    this._objects = [];
  }

  /**
   * 
   * @param {gSprite} obj 
   */
  addObject(obj) {
    this._objects.push(obj);
  }

  /**
   * 
   * @param {gSprite} obj 
   */
  removeObject(obj) {
    const index = this._objects.indexOf(obj);
    if (index > -1) {
      this._objects.splice(index, 1);
      return true;
    }

    return false;
  }

  //周期
  start() {
    this._objects.map((obj) => obj.start());
  }

  update() {
    this._objects.map((obj) => obj.update());
    this._objects.map((obj) => obj.draw());
  }

  stop() {
    this._objects.map((obj) => obj.stop());
  }

}
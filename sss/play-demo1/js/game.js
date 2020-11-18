class Game {
  /**
   * 
   * @param {Scene} scene 
   */
  constructor(scene) {
    this._scene = scene
  }

  start() {
    
  }

  update() {
    this._scene.update();
  }

  /**
   * 设置场景
   * @param {Scene} scene 
   */
  set Scene(scene) {
    if (!!this.scene) {
      this._scene.stop();
    }

    this._scene = scene;
    this._scene.start();
  }
}
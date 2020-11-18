class SceneManager {
  private static _instance:SceneManager = null
  private root: egret.DisplayObjectContainer
  private currScene: eui.UIComponent
  static get Instance() {
    if (SceneManager._instance === null) {
      SceneManager._instance = new SceneManager()
    }
    return SceneManager._instance
  }

  public setRoot(root: egret.DisplayObjectContainer) {
    this.root = root
  }

  public changeScene(scene: eui.UIComponent) {
    if (!this.root) {
      return
    }

    if (!!this.currScene) {
      this.root.removeChild(this.currScene)
    }

    this.root.addChild(scene)
    this.currScene = scene
  }
}
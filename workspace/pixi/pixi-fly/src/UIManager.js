export default {
    _scene: null,
    _prevScene: [],
    show(newScene) {
        //移除旧场景
        if (this._scene) {
            this._prevScene.push(this._scene)
           
            this.close()
        }

        this._scene = newScene

        //若当前设置的场景为空,则返回
        if (!newScene) {
            return
        }

        app.stage.addChild(this._scene)
    },
    //关闭当前场景
    close() {
        if (this._scene) {
            app.stage.removeChild(this._scene)
            this._scene.stop()
            this._scene = null
        }
    }
}
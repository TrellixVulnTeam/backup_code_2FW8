var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var SceneManager = (function () {
    function SceneManager() {
    }
    Object.defineProperty(SceneManager, "Instance", {
        get: function () {
            if (SceneManager._instance === null) {
                SceneManager._instance = new SceneManager();
            }
            return SceneManager._instance;
        },
        enumerable: true,
        configurable: true
    });
    SceneManager.prototype.setRoot = function (root) {
        this.root = root;
    };
    SceneManager.prototype.changeScene = function (scene) {
        if (!this.root) {
            return;
        }
        if (!!this.currScene) {
            this.root.removeChild(this.currScene);
        }
        this.root.addChild(scene);
        this.currScene = scene;
    };
    SceneManager._instance = null;
    return SceneManager;
}());
__reflect(SceneManager.prototype, "SceneManager");

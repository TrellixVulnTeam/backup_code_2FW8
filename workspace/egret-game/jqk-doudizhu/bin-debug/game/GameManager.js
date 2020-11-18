var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var GameManager = (function () {
    function GameManager() {
        this.username = "";
    }
    Object.defineProperty(GameManager, "Instance", {
        get: function () {
            if (GameManager._instance === null) {
                GameManager._instance = new GameManager();
            }
            return GameManager._instance;
        },
        enumerable: true,
        configurable: true
    });
    GameManager._instance = null;
    return GameManager;
}());
__reflect(GameManager.prototype, "GameManager");

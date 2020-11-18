var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var __extends = this && this.__extends || function __extends(t, e) { 
 function r() { 
 this.constructor = t;
}
for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i]);
r.prototype = e.prototype, t.prototype = new r();
};
var TableScene = (function (_super) {
    __extends(TableScene, _super);
    function TableScene() {
        var _this = _super.call(this) || this;
        _this.skinName = 'resource/eui_skins/game/TableSkin.exml';
        _this.abc.text = "load complete";
        return _this;
    }
    return TableScene;
}(eui.Component));
__reflect(TableScene.prototype, "TableScene", ["eui.UIComponent", "egret.DisplayObject"]);
//# sourceMappingURL=TableScene.js.map
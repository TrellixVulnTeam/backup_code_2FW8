/**Created by the LayaAirIDE,do not modify.*/
package ui.alert {
	import laya.ui.*;
	import laya.display.*; 

	public class CreateBuildAlertUI extends Dialog {
		public var btn_ok:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":500,"x":132,"width":869,"skin":"common/speakbg.png","height":242,"sizeGrid":"30,28,55,134"}},{"type":"Image","props":{"y":791,"x":82,"skin":"alert/abb.png"}},{"type":"UIButton","props":{"y":1084,"x":388,"width":327,"var":"btn_ok","skin":"common/uibtn_greenbuttom.png","label":"","height":161,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":9,"x":54,"width":218,"text":"确定","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":131,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":1281,"x":390,"width":327,"skin":"common/uibtn_redbuttom.png","name":"cancel","label":"","height":161,"sizeGrid":"41,36,41,38"},"child":[{"type":"Label","props":{"y":5,"x":58,"width":218,"text":"取消","styleSkin":"comp/label.png","strokeColor":"#ff5c44","stroke":6,"height":131,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":1473,"x":387,"width":327,"skin":"common/uibtn_greenbuttom.png","label":"","height":161,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":7,"x":53,"width":218,"text":"嘿嘿","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":131,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
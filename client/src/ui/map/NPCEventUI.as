/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class NPCEventUI extends Dialog {
		public var animLayer:Image;
		public var txt_message:Label;
		public var btn_ok:UIButton;
		public var lab_ok:Label;
		public var btn_cancel:UIButton;
		public var lab_cancel:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":574,"x":164,"width":775,"skin":"common/speakbg.png","height":206,"sizeGrid":"30,28,55,134"}},{"type":"Image","props":{"y":792,"x":152,"var":"animLayer","skin":"map/npc_1.png"}},{"type":"Label","props":{"y":603,"x":195,"width":712,"var":"txt_message","styleSkin":"comp/label.png","height":123,"fontSize":50,"font":"Microsoft YaHei","color":"#00777d","bold":false}},{"type":"UIButton","props":{"y":1167,"x":317,"width":440,"var":"btn_ok","skin":"common/uibtn_greenbuttom.png","label":"","height":175,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":17,"x":-99,"width":637,"var":"lab_ok","text":"好的！","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":116,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","align":"center"}}]},{"type":"UIButton","props":{"y":1427,"x":317,"width":440,"var":"btn_cancel","skin":"common/redbuttom.png","label":"","height":175,"sizeGrid":"38,36,42,37"},"child":[{"type":"Label","props":{"y":17,"x":-80,"width":600,"var":"lab_cancel","text":"再见！","styleSkin":"comp/label.png","strokeColor":"#ce1a1a","stroke":6,"height":119,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
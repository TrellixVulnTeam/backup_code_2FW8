/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopItemUI extends View {
		public var btn_kd:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1024,"height":511},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"estate/shopbg.jpg"}},{"type":"UIButton","props":{"y":229,"x":351,"var":"btn_kd","skin":"common/uibtn_bg.png","label":"开店","sizeGrid":"33,98,44,98"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 
	import laya.html.dom.HTMLDivElement;

	public class FloatTextItemUI extends View {
		public var gText:HTMLDivElement;
		public var ico:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":952,"height":75},"child":[{"type":"Image","props":{"y":0,"x":252,"width":448,"skin":"common/tips.png","sizeGrid":"0,0,0,0","height":75}},{"type":"HTMLDivElement","props":{"y":0,"x":0,"width":953,"var":"gText","styleSkin":"comp/html.png","innerHTML":"htmlText","height":74}},{"type":"Image","props":{"y":14,"x":256,"width":50,"var":"ico","skin":"common/ico_money.png","height":50}}]};
		override protected function createChildren():void {
			View.regComponent("HTMLDivElement",HTMLDivElement);
			super.createChildren();
			createView(uiView);

		}

	}
}
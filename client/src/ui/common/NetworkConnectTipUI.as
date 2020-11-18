/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 

	public class NetworkConnectTipUI extends Dialog {
		public var ico_cycle:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1280,"height":800},"child":[{"type":"Image","props":{"y":368,"x":640,"var":"ico_cycle","skin":"common/ump_main_progressbar.png","anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":455,"x":450,"width":386,"text":"网络连接中，请耐心等待...","styleSkin":"comp/label.png","height":32,"fontSize":32,"color":"#694123","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
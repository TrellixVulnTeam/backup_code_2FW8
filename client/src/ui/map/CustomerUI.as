/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class CustomerUI extends View {
		public var img_body:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":50,"height":0},"child":[{"type":"Image","props":{"y":-125,"x":-50,"var":"img_body","skin":"map/customer_1.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
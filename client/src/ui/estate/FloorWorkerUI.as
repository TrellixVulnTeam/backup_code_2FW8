/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class FloorWorkerUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":110,"height":104},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"map/customer_1.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
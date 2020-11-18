/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class DiceUI extends View {
		public var dicebg:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":140,"height":140},"child":[{"type":"Image","props":{"y":-78,"x":-79,"var":"dicebg","skin":"map/dice/dice_1.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
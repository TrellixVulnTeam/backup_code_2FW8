/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame {
	import laya.ui.*;
	import laya.display.*; 

	public class TreasureUI extends View {
		public var balloon:Image;
		public var treasure:Image;
		public var show_img:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":105,"height":299},"child":[{"type":"Image","props":{"var":"balloon","top":0,"skin":"map/minigame/balloon.png","left":0}},{"type":"Image","props":{"var":"treasure","skin":"map/minigame/treasure_101.png","left":0,"bottom":0}},{"type":"Image","props":{"y":38,"x":20,"width":64,"var":"show_img","skin":"map/minigame/block5.png","height":64}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
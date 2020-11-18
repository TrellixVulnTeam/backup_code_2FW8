/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame {
	import laya.ui.*;
	import laya.display.*; 

	public class StackBlockUI extends View {
		public var body:Box;
		public var middle:Image;
		public var floor:Image;
		public var background:Image;
		public var cont_block:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Box","props":{"y":-4907,"x":-341,"var":"body"}},{"type":"Image","props":{"y":-5619,"x":-363,"var":"middle","skin":"map/minigame/MiddleBody.png","scaleY":1.59,"scaleX":1.59}},{"type":"Image","props":{"y":-4897,"x":-343,"var":"floor","skin":"map/minigame/floorbody.png","scaleY":1.59,"scaleX":1.59}},{"type":"Image","props":{"y":-268,"x":386,"var":"background","skin":"map/minigame/BackgroundBody.png","scaleY":1.59,"scaleX":1.59}},{"type":"Box","props":{"y":1659,"x":540,"width":0,"var":"cont_block","height":0}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
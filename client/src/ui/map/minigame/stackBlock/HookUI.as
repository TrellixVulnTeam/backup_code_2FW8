/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame.stackBlock {
	import laya.ui.*;
	import laya.display.*; 

	public class HookUI extends View {
		public var blockPos:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1,"height":839},"child":[{"type":"Image","props":{"y":0,"x":-20,"width":45,"skin":"map/minigame/hook.png","height":745}},{"type":"Box","props":{"y":739,"x":1,"var":"blockPos"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
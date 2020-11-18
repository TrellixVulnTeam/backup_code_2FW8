/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame.stackBlock {
	import laya.ui.*;
	import laya.display.*; 

	public class BlockUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":70,"x":70,"width":140,"height":132,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":130,"x":71,"skin":"map/minigame/block2.png","anchorY":1,"anchorX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
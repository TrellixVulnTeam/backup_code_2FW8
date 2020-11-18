/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame {
	import laya.ui.*;
	import laya.display.*; 

	public class RollLotteryUI extends Dialog {
		public var btn_rand:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1000},"child":[{"type":"Image","props":{"y":0,"x":-260,"skin":"map/minigame/bg_rolllottery.jpg"}},{"type":"UIButton","props":{"y":683,"x":408,"var":"btn_rand","skin":"map/minigame/uibtn_start.png","label":""}},{"type":"Image","props":{"y":342,"x":169,"skin":"map/minigame/num_mask.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 

	public class RewardItem2UI extends View {
		public var ico_reward:Image;
		public var txt_num:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":208,"height":226},"child":[{"type":"Image","props":{"y":4,"x":11,"skin":"common/item2.png"}},{"type":"Image","props":{"y":35,"x":26,"var":"ico_reward","skin":"mailbox/01.png","scaleY":0.9,"scaleX":0.9}},{"type":"Label","props":{"y":172,"x":132,"var":"txt_num","text":"999k","styleSkin":"comp/label.png","fontSize":25,"color":"#ffffff"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
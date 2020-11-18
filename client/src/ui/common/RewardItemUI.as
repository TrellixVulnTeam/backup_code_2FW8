/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 

	public class RewardItemUI extends View {
		public var ico_reward:Image;
		public var txt_num:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":160,"height":157},"child":[{"type":"Image","props":{"y":-2,"x":-2,"skin":"common/item2.png"}},{"type":"Image","props":{"y":79,"x":78,"var":"ico_reward","anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":120,"x":53,"width":92,"var":"txt_num","text":"999k","styleSkin":"comp/label.png","height":25,"fontSize":25,"color":"#ffffff","align":"right"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
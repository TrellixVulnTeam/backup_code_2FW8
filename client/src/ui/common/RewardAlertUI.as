/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 

	public class RewardAlertUI extends Dialog {
		public var bg:Image;
		public var label_tips:Label;
		public var list_reward:List;
		public var img_fail:Image;
		public var img_win:Image;
		public var img_fail_1:Image;
		public var label_win:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":924,"height":594},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"bg","skin":"common/tips1.png"}},{"type":"Label","props":{"y":531,"x":318,"width":288,"var":"label_tips","text":"點擊任意位置關閉","styleSkin":"comp/label.png","height":48,"fontSize":36,"color":"#bababa"}},{"type":"List","props":{"y":232,"x":395,"var":"list_reward","spaceX":20}},{"type":"Image","props":{"y":30,"x":379,"var":"img_fail","skin":"mining/fight/fail.png"}},{"type":"Image","props":{"y":32,"x":382,"var":"img_win","skin":"mining/fight/win.png"}},{"type":"Image","props":{"y":30,"x":377,"var":"img_fail_1","skin":"mining/fight/失.png"}},{"type":"Image","props":{"y":36,"x":325,"var":"label_win","skin":"store/text1.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
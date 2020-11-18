/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopTypeItemUI extends View {
		public var ico_shopType:Image;
		public var txt_name:Label;
		public var ico_shopAttr:Image;
		public var txt_income:Label;
		public var ico_unlock:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":200},"child":[{"type":"Image","props":{"y":100,"x":75,"var":"ico_shopType","skin":"estate/st6.png","anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":86,"x":278,"width":164,"var":"txt_name","text":"热狗店","styleSkin":"comp/label.png","height":45,"fontSize":40,"color":"#00777d","bold":true}},{"type":"Image","props":{"y":76,"x":191,"var":"ico_shopAttr","skin":"common/power.png"}},{"type":"Image","props":{"y":63,"x":695,"skin":"common/ico_money.png"}},{"type":"Label","props":{"y":84,"x":805,"width":167,"var":"txt_income","text":"3万/小时","styleSkin":"comp/label.png","height":42,"fontSize":40,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":54,"x":89,"var":"ico_unlock","skin":"common/unlocked.png"}},{"type":"Image","props":{"y":186,"x":12,"skin":"common/line.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
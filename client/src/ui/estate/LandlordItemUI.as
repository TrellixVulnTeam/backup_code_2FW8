/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class LandlordItemUI extends View {
		public var ico_house:Image;
		public var txt_name:Label;
		public var txt_value:Label;
		public var txt_income:Label;
		public var shopNum:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":50,"x":86,"width":1000,"height":252},"child":[{"type":"Image","props":{"y":-15,"x":15,"width":183,"skin":"common/itembg1.png","height":180,"sizeGrid":"75,69,87,79"}},{"type":"Image","props":{"y":-22,"x":220,"width":68,"var":"ico_house","skin":"common/ico_building1.png","height":75}},{"type":"Label","props":{"y":-28,"x":308,"width":245,"var":"txt_name","text":"融侨中心","styleSkin":"comp/label.png","height":78,"fontSize":60,"color":"#00777d","bold":true}},{"type":"Label","props":{"y":116,"x":229,"width":69,"text":"价值：","styleSkin":"comp/label.png","height":32,"fontSize":35,"color":"#00777d","bold":true},"child":[{"type":"Label","props":{"y":0,"x":145,"width":78,"var":"txt_value","text":"18万","styleSkin":"comp/label.png","height":32,"fontSize":35,"color":"#0090ff","bold":true}},{"type":"Image","props":{"y":2,"x":91,"width":45,"skin":"common/ico_xjb.png","height":41}},{"type":"Label","props":{"y":2,"x":225,"width":53,"text":"/天","styleSkin":"comp/label.png","height":40,"fontSize":35,"color":"#00777d","bold":true}}]},{"type":"Label","props":{"y":61,"x":229,"width":105,"text":"收入：","styleSkin":"comp/label.png","height":50,"fontSize":35,"color":"#00777d","bold":true},"child":[{"type":"Image","props":{"y":-3,"x":91,"width":49,"skin":"common/ico_money.png","height":48}},{"type":"Label","props":{"y":0,"x":145,"width":81,"var":"txt_income","text":"18万","styleSkin":"comp/label.png","height":32,"fontSize":35,"color":"#37cb0a","bold":true}},{"type":"Label","props":{"y":1,"x":222,"width":57,"text":"/天","styleSkin":"comp/label.png","height":38,"fontSize":35,"color":"#00777d","bold":true}}]},{"type":"Label","props":{"y":118,"x":754,"width":43,"var":"shopNum","text":"4","styleSkin":"comp/label.png","height":32,"fontSize":35,"color":"#00777d","bold":true}},{"type":"Label","props":{"y":116,"x":639,"width":91,"text":"店铺：","styleSkin":"comp/label.png","height":39,"fontSize":35,"color":"#00777d","bold":true}},{"type":"Image","props":{"y":28,"x":58,"width":97,"skin":"common/building1.png","height":109}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class EstateItemUI extends View {
		public var ico_house:Image;
		public var txt_name:Label;
		public var box_rent:Box;
		public var txt_rent:Label;
		public var box_value:Box;
		public var txt_value:Label;
		public var txt_income:Label;
		public var txt_shopNum:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":50,"x":86,"width":1000,"height":252},"child":[{"type":"Image","props":{"y":-15,"x":15,"width":183,"skin":"common/itembg1.png","height":180,"sizeGrid":"75,69,87,79"}},{"type":"Image","props":{"y":-22,"x":220,"width":68,"var":"ico_house","skin":"common/ico_building1.png","height":75}},{"type":"Label","props":{"y":-28,"x":308,"width":245,"var":"txt_name","text":"融侨中心","styleSkin":"comp/label.png","height":78,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Box","props":{"y":116,"x":229,"var":"box_rent"},"child":[{"type":"Label","props":{"y":1,"x":0,"width":69,"text":"租金：","styleSkin":"comp/label.png","height":48,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":0,"x":161,"width":149,"var":"txt_rent","text":"18万/天","styleSkin":"comp/label.png","height":48,"fontSize":35,"font":"Microsoft YaHei","bold":true}}]},{"type":"Box","props":{"y":116,"x":229,"var":"box_value"},"child":[{"type":"Label","props":{"y":0,"x":0,"width":69,"text":"价值：","styleSkin":"comp/label.png","height":48,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":0,"x":160,"width":81,"var":"txt_value","text":"18万","styleSkin":"comp/label.png","height":44,"fontSize":35,"font":"Microsoft YaHei","color":"#0090ff","bold":true}},{"type":"Label","props":{"y":-1,"x":240,"width":105,"text":"/天","styleSkin":"comp/label.png","height":50,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}}]},{"type":"Label","props":{"y":62,"x":229,"width":105,"text":"收入：","styleSkin":"comp/label.png","height":50,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":57,"x":471,"width":63,"text":"/天","styleSkin":"comp/label.png","height":50,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":61,"x":387,"width":75,"var":"txt_income","text":"18万","styleSkin":"comp/label.png","height":42,"fontSize":35,"font":"Microsoft YaHei","color":"#37cb0a","bold":true}},{"type":"Label","props":{"y":57,"x":639,"width":109,"text":"明天：","styleSkin":"comp/label.png","height":44,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":118,"x":754,"width":149,"var":"txt_shopNum","text":4,"styleSkin":"comp/label.png","height":40,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":116,"x":639,"width":100,"text":"店铺：","styleSkin":"comp/label.png","height":54,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Image","props":{"y":28,"x":58,"width":97,"skin":"common/building1.png","height":109}},{"type":"Image","props":{"y":122,"x":336,"width":45,"skin":"common/ico_xjb.png","height":41}},{"type":"Image","props":{"y":60,"x":334,"width":49,"skin":"common/ico_money.png","height":48}},{"type":"Image","props":{"y":196,"x":-87,"width":1000,"skin":"common/line.png","height":5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
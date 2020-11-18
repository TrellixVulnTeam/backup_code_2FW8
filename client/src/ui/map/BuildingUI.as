/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class BuildingUI extends View {
		public var txt_name:Label;
		public var icon:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":180,"height":160},"child":[{"type":"Label","props":{"y":89,"x":0,"width":180,"var":"txt_name","valign":"middle","text":"奥卡姆奥卡姆","styleSkin":"comp/label.png","overflow":"scroll","height":78,"fontSize":34,"color":"#bc7473","align":"center"}},{"type":"Image","props":{"y":-23,"x":49,"width":82,"var":"icon","skin":"map/building/1001_1.png","height":126}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
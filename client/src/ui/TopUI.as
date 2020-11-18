/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class TopUI extends View {
		public var txt_userName:Label;
		public var txt_lv:Label;
		public var txt_diamond:Label;
		public var txt_money:Label;
		public var txt_power:Label;
		public var ico_sex:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":100},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"common/textbg2.png","height":116,"sizeGrid":"0,12,0,12"}},{"type":"Label","props":{"y":-100,"x":327,"width":241,"var":"txt_userName","text":"45588","styleSkin":"comp/label.png","height":57,"fontSize":50,"color":"#121111"}},{"type":"Label","props":{"y":32,"x":120,"width":140,"var":"txt_lv","text":"Lv.99","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":49,"fontSize":40,"color":"#ffffff"}},{"type":"Label","props":{"y":32,"x":330,"width":152,"var":"txt_diamond","text":"99999","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":48,"fontSize":40,"color":"#ffffff"}},{"type":"Label","props":{"y":32,"x":595,"width":190,"var":"txt_money","text":"99999999","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":48,"fontSize":40,"color":"#ffffff"}},{"type":"Label","props":{"y":32,"x":911,"width":193,"var":"txt_power","text":"99999","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":52,"fontSize":40,"color":"#ffffff"}},{"type":"Image","props":{"y":32,"x":114,"width":27,"visible":false,"var":"ico_sex","skin":"common/male.png","height":44}},{"type":"Image","props":{"y":20,"x":242,"skin":"common/ico_xjb.png"}},{"type":"Image","props":{"y":9,"x":490,"skin":"common/ico_money.png"}},{"type":"Image","props":{"y":8,"x":806,"skin":"common/coinpile.png"}},{"type":"Image","props":{"y":11,"x":22,"skin":"map/portrait.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
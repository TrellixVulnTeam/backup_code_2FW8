/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class HouseChargeTipUI extends View {
		public var txt_money:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":466,"height":133},"child":[{"type":"Image","props":{"y":-72,"x":0,"width":466,"skin":"common/itembg6.png","height":263,"sizeGrid":"105,51,103,135"}},{"type":"Label","props":{"y":-26,"x":68,"wordWrap":true,"width":362,"valign":"middle","text":"走到其他玩家的房产","styleSkin":"comp/label.png","strokeColor":"#00797f","height":80,"fontSize":35,"color":"#00777d","bold":true}},{"type":"Image","props":{"y":56,"x":106,"skin":"common/ico_money.png"}},{"type":"Label","props":{"y":79,"x":215,"width":141,"var":"txt_money","text":"-200","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":3,"height":44,"fontSize":45,"color":"#ef4545"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class SimpleAlertUI extends Dialog {
		public var txt_info:Text;
		public var btn_cancel:UIButton;
		public var btn_ok:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"y":-100,"x":0,"width":955,"height":625},"child":[{"type":"Image","props":{"y":0,"x":0,"width":956,"skin":"common/itembg3.png","height":625,"sizeGrid":"33,40,47,42"}},{"type":"Text","props":{"y":178,"x":84,"wordWrap":true,"width":785,"var":"txt_info","text":"人夫地人","height":222,"fontSize":60,"color":"#00777d","align":"center"}},{"type":"UIButton","props":{"y":410,"x":320,"width":333,"var":"btn_cancel","skin":"common/uibtn_redbuttom.png","height":137,"sizeGrid":"41,36,41,38"},"child":[{"type":"Label","props":{"y":34,"x":107,"width":119,"text":"取消","styleSkin":"comp/label.png","strokeColor":"#ce1a1a","stroke":6,"height":68,"fontSize":60,"color":"#ffffff"}}]},{"type":"UIButton","props":{"y":410,"x":320,"width":333,"var":"btn_ok","skin":"common/uibtn_greenbuttom.png","label":"","height":137,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":33,"x":107,"width":129,"text":"确定","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":69,"fontSize":60,"color":"#ffffff","align":"center"}}]},{"type":"Image","props":{"y":7,"x":10,"width":936,"skin":"common/textbg.png","height":148,"sizeGrid":"43,51,57,58"},"child":[{"type":"Label","props":{"y":24,"x":392,"width":168,"text":"提示","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":85,"fontSize":80,"color":"#ffffff"}}]}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.common {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class SimpleAlert2UI extends Dialog {
		public var txt_info:Text;
		public var txt_alertinfo:Text;
		public var btn_shop:UIButton;
		public var btn_charge:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":954,"height":625},"child":[{"type":"Image","props":{"y":0,"x":0,"width":956,"skin":"common/itembg3.png","height":626,"sizeGrid":"33,40,47,42"}},{"type":"Text","props":{"y":186,"x":100,"wordWrap":true,"width":747,"var":"txt_info","text":"发生地质","height":246,"fontSize":60,"color":"#00777d","align":"center"}},{"type":"Text","props":{"y":656,"x":113,"wordWrap":true,"width":747,"visible":false,"var":"txt_alertinfo","text":"ps:","height":142,"fontSize":42,"color":"#ff0000"}},{"type":"UIButton","props":{"y":410,"x":320,"width":333,"var":"btn_shop","skin":"common/uibtn_bluebuttom.png","label":"","height":137,"sizeGrid":"44,38,42,35"},"child":[{"type":"Label","props":{"y":34,"x":47,"width":253,"text":"前往商店","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":71,"fontSize":60,"color":"#ffffff"}}]},{"type":"UIButton","props":{"y":410,"x":320,"width":333,"var":"btn_charge","skin":"common/uibtn_bluebuttom.png","label":"","height":137,"sizeGrid":"44,38,42,35"},"child":[{"type":"Label","props":{"y":34,"x":47,"width":252,"text":"我要充值","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":76,"fontSize":60,"color":"#ffffff","align":"center"}}]},{"type":"Image","props":{"y":7,"x":5,"width":946,"skin":"common/textbg.png","height":148,"sizeGrid":"43,51,57,58"}},{"type":"Image","props":{"y":14,"x":400,"skin":"common/text2.png"}},{"type":"Label","props":{"y":12,"x":363,"width":219,"text":"员工","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":107,"fontSize":100,"color":"#ffffff"}},{"type":"UIButton","props":{"y":28,"x":835,"width":90,"skin":"common/uibtn_close.png","name":"close","label":"","height":90}}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}
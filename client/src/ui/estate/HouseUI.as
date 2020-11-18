/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class HouseUI extends View {
		public var list:List;
		public var btn_close:UIButton;
		public var txt_name:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":116,"x":0,"width":1080,"skin":"common/roof.png","height":270}},{"type":"List","props":{"y":1,"x":0,"width":1080,"var":"list","vScrollBarSkin":"comp/vscroll.png","height":1699}},{"type":"UIButton","props":{"y":117,"x":24,"var":"btn_close","skin":"common/uibtn_back.png","label":""}},{"type":"Image","props":{"y":114,"x":132,"width":93,"skin":"common/ico_resident.png","height":77}},{"type":"Label","props":{"y":134,"x":239,"width":186,"var":"txt_name","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":59,"fontSize":50,"color":"#00777d","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
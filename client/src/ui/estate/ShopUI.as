/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopUI extends View {
		public var list:List;
		public var btn_close:UIButton;
		public var txt_name:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"List","props":{"y":-3,"x":0,"width":1080,"var":"list","vScrollBarSkin":"comp/vscroll.png","height":1703}},{"type":"UIButton","props":{"y":140,"x":46,"var":"btn_close","skin":"common/uibtn_back.png","label":""}},{"type":"Image","props":{"y":139,"x":171,"width":66,"skin":"common/ico_building1.png","height":77}},{"type":"Label","props":{"y":152,"x":266,"width":146,"var":"txt_name","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":55,"fontSize":60,"color":"#00777d","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
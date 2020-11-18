/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class CreateBuildUI extends Dialog {
		public var btn_create:UIButton;
		public var txt_cost:Label;
		public var btn_close:UIButton;
		public var list:List;
		public var ico_build:Image;
		public var txt_name:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1920,"alpha":0},"child":[{"type":"Image","props":{"y":254,"x":80,"width":913,"skin":"common/winbg5.png","height":1414,"sizeGrid":"72,63,71,65"}},{"type":"Image","props":{"y":256,"x":88,"width":897,"skin":"common/winbg6.png","height":148,"sizeGrid":"45,51,52,55"}},{"type":"UIButton","props":{"y":1404,"width":514,"var":"btn_create","skin":"common/uibtn_bg.png","sizeGrid":"33,98,44,98","labelSize":60,"height":191,"centerX":3},"child":[{"type":"Image","props":{"y":3,"x":-2,"width":514,"skin":"common/uibtn_greenbuttom.png","height":195,"sizeGrid":"50,50,50,50"}},{"type":"Label","props":{"y":18,"x":222,"width":148,"var":"txt_cost","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":40,"fontSize":60}},{"type":"Label","props":{"y":84,"x":152,"width":224,"text":"创建","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":84,"fontSize":80,"color":"#ffffff","bold":true,"align":"center"}},{"type":"Image","props":{"y":14,"x":132,"skin":"common/ico_xjb.png"}}]},{"type":"UIButton","props":{"y":280,"x":856,"var":"btn_close","skin":"common/uibtn_close.png","label":""}},{"type":"List","props":{"y":545,"x":161,"width":766,"var":"list","vScrollBarSkin":"comp/vscroll.png","spaceY":60,"spaceX":60,"selectedIndex":0,"repeatX":2,"height":784}},{"type":"Image","props":{"y":454,"x":374,"width":66,"var":"ico_build","skin":"common/ico_building1.png","height":77}},{"type":"Label","props":{"y":273,"x":336,"width":408,"text":"创建房产","styleSkin":"comp/label.png","height":132,"fontSize":100,"color":"#ffffff","bold":true,"align":"center"}},{"type":"Label","props":{"y":434,"x":277,"var":"txt_name","styleSkin":"comp/label.png","strokeColor":"#000000","height":55,"fontSize":60,"color":"#00777d","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopTypeSelectUI extends View {
		public var btn_close:UIButton;
		public var list:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"common/winbg5.png","height":1920,"sizeGrid":"72,63,71,65"}},{"type":"Image","props":{"y":115,"x":0,"width":1080,"skin":"common/itembg5.png","height":182,"sizeGrid":"80,17,91,16"},"child":[{"type":"Label","props":{"y":28,"x":335,"width":420,"text":"选择类型","styleSkin":"comp/label.png","strokeColor":"#666040","stroke":6,"height":106,"fontSize":100,"color":"#ffffff","bold":true}}]},{"type":"UIButton","props":{"y":162,"x":57,"var":"btn_close","skin":"common/uibtn_back.png","label":""}},{"type":"List","props":{"y":315,"x":13,"width":1029,"var":"list","vScrollBarSkin":"comp/vscroll.png","height":1404}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
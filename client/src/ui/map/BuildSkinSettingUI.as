/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class BuildSkinSettingUI extends View {
		public var list:List;
		public var btn_close:UIButton;
		public var txt_cost:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"List","props":{"y":277,"x":205,"width":670,"var":"list","vScrollBarSkin":"comp/vscroll.png","repeatX":2,"height":956}},{"type":"UIButton","props":{"y":29,"x":41,"var":"btn_close","skin":"common/uibtn_close.png","label":""}},{"type":"UIButton","props":{"y":1285,"x":391,"skin":"common/uibtn_bg.png","label":"","sizeGrid":"33,98,44,98"},"child":[{"type":"Image","props":{"y":16,"x":34,"skin":"common/ico_xjb.png"}},{"type":"Label","props":{"y":20,"x":110,"width":148,"var":"txt_cost","styleSkin":"comp/label.png","height":40,"fontSize":32}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
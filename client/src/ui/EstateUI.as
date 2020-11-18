/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class EstateUI extends View {
		public var btn_close:UIButton;
		public var tab:Tab;
		public var viewStack:ViewStack;
		public var list_shop:List;
		public var list_landlord:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":268,"x":0,"width":1083,"skin":"common/winbg5.png","height":1653,"sizeGrid":"72,63,71,65"}},{"type":"Image","props":{"y":-3,"x":0,"width":1081,"skin":"common/pagebg.png","height":270,"sizeGrid":"12,14,13,10"}},{"type":"UIButton","props":{"y":165,"x":54,"width":99,"var":"btn_close","skin":"common/uibtn_back.png","label":"","height":70}},{"type":"Tab","props":{"y":129,"x":218,"width":729,"var":"tab","skin":"index/page.png","selectedIndex":0,"height":172,"sizeGrid":"29,43,5,48"},"child":[{"type":"Button","props":{"y":17,"x":0,"width":404,"stateNum":2,"skin":"index/page.png","name":"item0","labelSize":80,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","label":"店铺","sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":0,"x":404,"width":397,"stateNum":2,"skin":"index/page.png","name":"item1","labelSize":80,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","label":"出租中","height":140,"sizeGrid":"29,43,5,48"}}]},{"type":"ViewStack","props":{"y":308,"x":19,"width":1043,"var":"viewStack","height":1442},"child":[{"type":"List","props":{"y":-14,"x":14,"width":1029,"var":"list_shop","vScrollBarSkin":"comp/vscroll.png","name":"item0","height":1348}},{"type":"List","props":{"y":-14,"x":14,"width":1029,"var":"list_landlord","vScrollBarSkin":"comp/vscroll.png","name":"item1","height":1348}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
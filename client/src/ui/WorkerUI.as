/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class WorkerUI extends View {
		public var btn_close:UIButton;
		public var list:List;
		public var tab:Tab;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":382,"x":0,"width":1080,"skin":"common/winbg5.png","height":1537,"sizeGrid":"72,63,71,65"}},{"type":"Image","props":{"y":-2,"x":0,"width":1080,"skin":"common/pagebg.png","height":417,"sizeGrid":"12,14,13,10"}},{"type":"UIButton","props":{"y":163,"x":55,"width":96,"var":"btn_close","skin":"common/uibtn_back.png","label":"","height":70}},{"type":"List","props":{"y":403,"x":31,"width":1029,"var":"list","vScrollBarSkin":"comp/vscroll.png","height":1380}},{"type":"Label","props":{"y":157,"x":439,"width":223,"text":"员工","styleSkin":"comp/label.png","strokeColor":"#675b41","stroke":6,"height":128,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true}},{"type":"UIButton","props":{"y":158,"x":885,"width":176,"skin":"common/uibtn_greenbuttom.png","labelSize":80,"height":135,"sizeGrid":"50,50,50,50"},"child":[{"type":"Image","props":{"y":26,"x":49,"width":78,"skin":"common/add.png","height":80}}]},{"type":"Tab","props":{"y":311,"x":0,"width":1080,"var":"tab","selectedIndex":0,"height":103},"child":[{"type":"Button","props":{"y":-20,"x":0,"width":180,"stateNum":2,"skin":"index/page.png","name":"item0","labelSize":60,"labelPadding":"0","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","labelBold":false,"label":"品质","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":-19,"x":180,"width":180,"stateNum":2,"skin":"index/page.png","name":"item1","labelSize":60,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":-19,"x":360,"width":180,"stateNum":2,"skin":"index/page.png","name":"item2","labelSize":60,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":-19,"x":540,"width":180,"stateNum":2,"skin":"index/page.png","name":"item3","labelSize":60,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":-19,"x":720,"width":180,"stateNum":2,"skin":"index/page.png","name":"item4","labelSize":60,"labelPadding":"-7","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Button","props":{"y":-19,"x":900,"width":180,"stateNum":2,"skin":"index/page.png","name":"item5","labelSize":60,"labelPadding":"0","labelFont":"Microsoft YaHei","labelColors":"#9c895f,#00777d","label":"工作","height":124,"sizeGrid":"29,43,5,48"}},{"type":"Image","props":{"y":30,"x":235,"skin":"common/power.png"}},{"type":"Image","props":{"y":30,"x":595,"skin":"common/agile.png"}},{"type":"Image","props":{"y":30,"x":413,"skin":"common/intelligence.png"}},{"type":"Image","props":{"y":35,"x":771,"skin":"common/charm.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
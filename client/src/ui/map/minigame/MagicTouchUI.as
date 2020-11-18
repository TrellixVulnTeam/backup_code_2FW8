/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame {
	import laya.ui.*;
	import laya.display.*; 

	public class MagicTouchUI extends View {
		public var btn_continue:Image;
		public var btn_pause:Image;
		public var btn_close:UIButton;
		public var timer_lab:Label;
		public var score_lab:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"mouseThrough":false,"height":1920},"child":[{"type":"Image","props":{"y":4,"x":0,"width":1080,"skin":"map/minigame/u0.png","height":1920}},{"type":"Image","props":{"y":21,"x":23,"width":174,"var":"btn_continue","skin":"map/minigame/u61.png","height":159}},{"type":"Image","props":{"y":15,"x":20,"width":175,"var":"btn_pause","skin":"map/minigame/u=1008120483,2091004177&fm=27&gp=0.jpg","height":177}},{"type":"UIButton","props":{"y":17,"x":930,"var":"btn_close","skin":"common/uibtn_close.png","label":""}},{"type":"Label","props":{"y":1507,"x":941,"var":"timer_lab","text":"20","fontSize":96,"color":"#ffffff","align":"right"}},{"type":"Image","props":{"y":1511,"x":56,"width":130,"skin":"map/minigame/diamond.png","height":100},"child":[{"type":"Label","props":{"y":-4,"x":150,"var":"score_lab","text":"0","fontSize":96,"color":"#ffffff","align":"left"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
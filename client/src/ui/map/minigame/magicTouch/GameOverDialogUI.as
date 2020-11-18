/**Created by the LayaAirIDE,do not modify.*/
package ui.map.minigame.magicTouch {
	import laya.ui.*;
	import laya.display.*; 

	public class GameOverDialogUI extends Dialog {
		public var video_money_lab:Label;
		public var play_video_btn:Button;
		public var normal_money_lab:Label;
		public var get_normal_btn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"map/minigame/alpha.png","hitTestPrior":true,"height":1920}},{"type":"Box","props":{"y":659,"x":177},"child":[{"type":"Label","props":{"y":21,"x":308,"text":"奖励","fontSize":52,"color":"#000000"}},{"type":"Image","props":{"y":151,"x":137,"width":446,"skin":"map/minigame/border.png","sizeGrid":"4,6,10,6","name":"video","height":121},"child":[{"type":"Image","props":{"y":23,"x":14,"width":150,"skin":"map/minigame/money.png","height":72}},{"type":"Label","props":{"y":37,"x":159,"var":"video_money_lab","text":"00000","fontSize":32,"color":"#00ff1e","align":"left"}},{"type":"Button","props":{"y":8,"x":325,"width":96,"var":"play_video_btn","stateNum":1,"skin":"map/minigame/u61.png","height":96}}]},{"type":"Image","props":{"y":317,"x":137,"width":446,"sizeGrid":"4,6,10,6","name":"normal","height":121},"child":[{"type":"Image","props":{"y":18,"x":9,"width":150,"skin":"map/minigame/money.png","height":72}},{"type":"Label","props":{"y":32,"x":158,"var":"normal_money_lab","text":"00000","fontSize":32,"color":"#11f12c","align":"left"}},{"type":"Button","props":{"y":47,"x":314,"var":"get_normal_btn","stateNum":1,"skin":"map/minigame/hand.png"}}]},{"type":"Rect","props":{"y":0,"x":0,"width":726,"lineWidth":1,"height":602,"fillColor":"#ffffff"}},{"type":"Rect","props":{"y":0,"x":0,"width":720,"lineWidth":1,"height":100,"fillColor":"#f2f2f2"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
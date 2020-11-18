/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class ActorUI extends View {
		public var img_body:Image;
		public var ico_buff:Image;
		public var box_speak:Box;
		public var ico_face:Image;
		public var txt_msg:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":50,"height":0},"child":[{"type":"Image","props":{"y":-125,"x":-50,"visible":false,"var":"img_body","skin":"map/npc_1.png"}},{"type":"Image","props":{"y":-358,"x":-29,"width":100,"visible":false,"var":"ico_buff","skin":"map/godbuff8.png","height":94}},{"type":"Box","props":{"y":-349,"x":-149,"visible":false,"var":"box_speak"},"child":[{"type":"Image","props":{"y":-39,"x":90,"width":559,"skin":"common/speakbg.png","height":219,"sizeGrid":"30,28,55,134"}},{"type":"Image","props":{"y":31,"x":124,"var":"ico_face","skin":"map/emoji2.png"}},{"type":"Label","props":{"y":-11,"x":206,"width":408,"var":"txt_msg","valign":"middle","text":"label","styleSkin":"comp/label.png","height":135,"fontSize":50,"color":"#00777d","align":"left"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
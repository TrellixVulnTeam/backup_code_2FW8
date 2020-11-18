/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class LoginPanelUI extends View {
		public var bg:Image;
		public var box_loading:Box;
		public var btn_start:UIButton;
		public var progressbar:Box;
		public var img_progress:Image;
		public var txt_progress:Label;
		public var box_login:Box;
		public var txt_userName:TextInput;
		public var btn_login:Button;
		public var txt_loc:TextInput;
		public var txt_version:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":0,"x":0,"width":1080,"height":1920},"child":[{"type":"Image","props":{"width":1080,"var":"bg","skin":"createRole/background.png","height":1920,"centerY":0,"centerX":0}},{"type":"Box","props":{"x":158,"width":764,"var":"box_loading","height":121,"centerY":101},"child":[{"type":"Image","props":{"y":-473,"x":55,"skin":"loading/CP-ZH-PNG.png"}},{"type":"UIButton","props":{"y":81,"x":237,"var":"btn_start","skin":"loading/uibtn_start.png","label":""}},{"type":"Box","props":{"y":0,"x":0,"var":"progressbar"},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"loading/loadbg.png"}},{"type":"Image","props":{"y":31,"x":14,"var":"img_progress","skin":"loading/loadpro.png"}},{"type":"Label","props":{"y":43,"x":334,"width":96,"var":"txt_progress","text":"40%","styleSkin":"comp/label.png","height":26,"fontSize":30,"color":"#060606","align":"center"}},{"type":"Label","props":{"y":93,"x":54,"width":660,"text":"正在加載遊戲資源，請耐心等待……","styleSkin":"comp/label.png","height":47,"fontSize":40,"color":"#f8f0ef","align":"center"}}]}]},{"type":"Box","props":{"x":240,"var":"box_login","centerY":227},"child":[{"type":"Label","props":{"y":74,"x":-19,"text":"用戶名：","styleSkin":"comp/label.png","fontSize":60,"color":"#ffffff"}},{"type":"TextInput","props":{"y":66,"x":208,"width":392,"var":"txt_userName","skin":"comp/textinput.png","height":68,"fontSize":40}},{"type":"Button","props":{"y":203,"x":233,"width":198,"var":"btn_login","skin":"comp/button.png","labelSize":40,"label":"登錄","height":61}},{"type":"Image","props":{"y":-534,"x":-31,"skin":"loading/CP-ZH-PNG.png"}},{"type":"TextInput","props":{"y":-76,"x":209,"width":392,"var":"txt_loc","skin":"comp/textinput.png","restrict":"0-9.,","height":68,"fontSize":40}},{"type":"Label","props":{"y":-73,"x":-26,"text":"坐标：","styleSkin":"comp/label.png","fontSize":60,"color":"#ffffff"}}]},{"type":"Label","props":{"y":1751,"x":708,"width":345,"var":"txt_version","text":"version:0.95662","styleSkin":"comp/label.png","height":60,"fontSize":45,"color":"#ffffff"}},{"type":"Image","props":{"y":1516,"x":0,"width":1080,"skin":"createRole/cloudbg.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
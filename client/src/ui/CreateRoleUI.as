/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class CreateRoleUI extends View {
		public var btn_close:UIButton;
		public var btn_ok:UIButton;
		public var ico_sex:Image;
		public var txt_name:TextInput;
		public var btn_dice:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920,"disabled":false},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"createRole/background.png","height":1920}},{"type":"UIButton","props":{"y":47,"x":52,"visible":false,"var":"btn_close","skin":"common/uibtn_close.png","label":""}},{"type":"UIButton","props":{"y":1313,"x":323,"width":434,"var":"btn_ok","skin":"common/uibtn_ok.png","label":"","height":176},"child":[{"type":"Image","props":{"y":0,"x":0,"width":427,"skin":"common/uibtn_greenbuttom.png","height":167,"sizeGrid":"50,50,50,50"}},{"type":"Label","props":{"y":27,"x":14,"width":412,"text":"创建","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":110,"fontSize":100,"color":"#ffffff","bold":true,"align":"center"}}]},{"type":"Image","props":{"y":1222,"x":-593,"visible":false,"var":"ico_sex","skin":"common/male.png"}},{"type":"Image","props":{"y":1510,"x":0,"skin":"createRole/cloudbg.png"}},{"type":"TextInput","props":{"y":1176,"x":295,"width":387,"var":"txt_name","skin":"comp/textinput.png","height":92,"fontSize":70,"align":"center"}},{"type":"UIButton","props":{"y":1154,"x":742,"var":"btn_dice","skin":"createRole/uibtn_dice.png","label":""}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
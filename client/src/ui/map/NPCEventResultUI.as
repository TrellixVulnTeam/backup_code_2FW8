/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class NPCEventResultUI extends Dialog {
		public var txt_result:Label;
		public var box_res:Box;
		public var box_money:Box;
		public var txt_money:Label;
		public var box_exp:Box;
		public var txt_exp:Label;
		public var box_power:Box;
		public var txt_power:Label;
		public var box_diamond:Box;
		public var txt_diamond:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":339,"x":0,"width":1080,"skin":"common/itembg3.png","height":961,"sizeGrid":"33,40,47,42"}},{"type":"Image","props":{"y":365,"x":30,"width":1020,"skin":"map/fate/1.jpg","height":657}},{"type":"Image","props":{"y":1052,"x":39,"width":1005,"skin":"common/itembg1.png","height":199,"sizeGrid":"75,69,87,79"}},{"type":"Label","props":{"y":1093,"x":93,"width":537,"var":"txt_result","styleSkin":"comp/label.png","height":114,"fontSize":50,"font":"SimHei","color":"#00777d","bold":true}},{"type":"UIButton","props":{"y":1376,"x":353,"width":391,"skin":"common/uibtn_greenbuttom.png","name":"ok","height":163,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":8,"x":126,"width":174,"text":"好！","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":126,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true}}]},{"type":"Box","props":{"y":1090,"x":737,"width":331,"var":"box_res","height":301},"child":[{"type":"Box","props":{"y":73,"x":0,"width":258,"var":"box_money","height":79},"child":[{"type":"Label","props":{"y":9,"x":110,"width":148,"var":"txt_money","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":51,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"skin":"common/ico_money.png"}}]},{"type":"Box","props":{"y":-6,"x":0,"var":"box_exp"},"child":[{"type":"Label","props":{"y":15,"x":110,"width":151,"var":"txt_exp","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":55,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":0,"x":0,"skin":"common/exp.png"}}]},{"type":"Box","props":{"y":142,"x":0,"var":"box_power"},"child":[{"type":"Label","props":{"y":15,"x":110,"width":151,"var":"txt_power","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":58,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":9,"x":14,"skin":"common/physicalpower.png"}}]},{"type":"Box","props":{"y":229,"x":0,"var":"box_diamond"},"child":[{"type":"Label","props":{"y":6,"x":110,"width":157,"var":"txt_diamond","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":58,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":9,"x":8,"skin":"common/ico_xjb.png"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
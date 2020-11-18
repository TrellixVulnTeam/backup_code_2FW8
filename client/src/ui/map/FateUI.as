/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class FateUI extends Dialog {
		public var img_fate:Image;
		public var txt_msg:Label;
		public var box_res:Box;
		public var box_money:Box;
		public var txt_money:Label;
		public var box_exp:Box;
		public var txt_exp:Label;
		public var box_power:Box;
		public var txt_power:Label;
		public var box_diamond:Box;
		public var txt_diamond:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1080,"height":1203},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"common/itembg3.png","height":961,"sizeGrid":"33,40,47,42"}},{"type":"Image","props":{"y":30,"x":31,"width":1020,"var":"img_fate","skin":"map/fate/1.jpg","height":657}},{"type":"UIButton","props":{"y":1040,"x":347,"width":391,"skin":"common/uibtn_greenbuttom.png","name":"ok","label":"","height":163,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":23,"x":99,"width":209,"text":"好的","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":109,"fontSize":100,"color":"#ffffff","align":"center"}}]},{"type":"Image","props":{"y":712,"x":40,"width":1005,"skin":"common/itembg1.png","height":199,"sizeGrid":"75,69,87,79"}},{"type":"Label","props":{"y":763,"x":94,"wordWrap":true,"width":532,"var":"txt_msg","styleSkin":"comp/label.png","height":110,"fontSize":50,"color":"#00777d","bold":true}},{"type":"Box","props":{"y":745,"x":742,"width":331,"var":"box_res","height":301},"child":[{"type":"Box","props":{"y":80,"x":0,"var":"box_money"},"child":[{"type":"Label","props":{"y":5,"x":115,"width":150,"var":"txt_money","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":49,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":-5,"x":0,"skin":"common/ico_money.png"}}]},{"type":"Box","props":{"y":0,"x":0,"var":"box_exp"},"child":[{"type":"Label","props":{"y":12,"x":113,"width":149,"var":"txt_exp","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":48,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":-6,"x":0,"skin":"common/exp.png"}}]},{"type":"Box","props":{"y":150,"x":0,"var":"box_power"},"child":[{"type":"Label","props":{"y":9,"x":115,"width":149,"var":"txt_power","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":51,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":3,"x":12,"skin":"common/physicalpower.png"}}]},{"type":"Box","props":{"y":232,"x":0,"var":"box_diamond"},"child":[{"type":"Label","props":{"y":4,"x":116,"width":151,"var":"txt_diamond","text":"+5000","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":57,"fontSize":50,"color":"#2d980d","bold":true}},{"type":"Image","props":{"y":10,"x":9,"skin":"common/ico_xjb.png"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
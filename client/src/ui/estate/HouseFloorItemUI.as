/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class HouseFloorItemUI extends View {
		public var box_top:Box;
		public var btn_add:UIButton;
		public var box_floor:Box;
		public var btn_gainMoney:UIButton;
		public var img_jlm:Image;
		public var txt_floorInfo:Label;
		public var txt_hostName:Label;
		public var btn_setting:UIButton;
		public var btn_rz:UIButton;
		public var box_progress:Box;
		public var progress:ProgressBar;
		public var txt_time:Label;
		public var txt_floor:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":401},"child":[{"type":"Box","props":{"y":0,"x":0,"var":"box_top"},"child":[{"type":"UIButton","props":{"y":71,"x":320,"var":"btn_add","skin":"common/uibtn_greenbuttom.png","label":"增加楼层","sizeGrid":"50,50,50,50"}}]},{"type":"Box","props":{"y":-1,"x":0,"var":"box_floor"},"child":[{"type":"Image","props":{"skin":"estate/floorbg.jpg"}},{"type":"UIButton","props":{"y":68,"x":109,"width":176,"var":"btn_gainMoney","skin":"common/speakbg.png","height":129,"sizeGrid":"30,28,55,134"},"child":[{"type":"Image","props":{"y":19,"x":36,"skin":"common/ico_money.png"}}]},{"type":"Image","props":{"x":25,"width":1027,"var":"img_jlm","skin":"estate/jlm.png","height":286,"sizeGrid":"0,2,0,2"}},{"type":"Image","props":{"y":287,"width":1080,"skin":"common/sxtd.png","height":115,"sizeGrid":"4,6,12,4"}},{"type":"Label","props":{"y":6,"x":82,"width":204,"var":"txt_floorInfo","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":46,"fontSize":35,"font":"Microsoft YaHei","color":"#ffffff"}},{"type":"Label","props":{"y":354,"x":30,"width":204,"var":"txt_hostName","styleSkin":"comp/label.png","height":32,"fontSize":32}},{"type":"UIButton","props":{"y":295,"x":972,"width":94,"var":"btn_setting","skin":"common/uibtn_greenbuttom.png","height":94,"sizeGrid":"50,50,50,50"},"child":[{"type":"Image","props":{"y":20,"x":20,"skin":"comp/设置图标.png"}}]},{"type":"UIButton","props":{"y":98,"x":393,"width":333,"visible":false,"var":"btn_rz","skin":"common/uibtn_greenbuttom.png","height":137,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":12,"x":83,"width":169,"text":"入住","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":104,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","align":"center"}}]},{"type":"Box","props":{"y":308,"x":327,"var":"box_progress"},"child":[{"type":"ProgressBar","props":{"y":11,"x":114,"width":267,"var":"progress","value":0.3,"skin":"comp/progress.png","height":42,"sizeGrid":"0,15,0,15"},"child":[{"type":"Label","props":{"y":2,"x":53,"width":157,"var":"txt_time","text":"10时50分","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":32,"fontSize":35,"color":"#ffffff","align":"center"}}]},{"type":"Image","props":{"skin":"common/ico_money.png"}}]},{"type":"Label","props":{"y":87,"x":922,"width":100,"var":"txt_floor","styleSkin":"comp/label.png","strokeColor":"#223b71","stroke":3,"height":42,"fontSize":50,"color":"#f11d19","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
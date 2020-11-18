/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopFloorItemUI extends View {
		public var box_top:Box;
		public var btn_add:UIButton;
		public var box_floor:Box;
		public var txt_floorInfo:Label;
		public var btn_gainMoney:UIButton;
		public var img_head:UIButton;
		public var img_jlm:Image;
		public var txt_hostName:Label;
		public var btn_kd:UIButton;
		public var box_progress:Box;
		public var progress:ProgressBar;
		public var txt_time:Label;
		public var btn_setting:UIButton;
		public var txt_floor:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":401},"child":[{"type":"Box","props":{"y":0,"x":0,"var":"box_top"},"child":[{"type":"UIButton","props":{"y":71,"x":320,"var":"btn_add","skin":"common/uibtn_greenbuttom.png","label":"增加楼层","sizeGrid":"50,50,50,50"}}]},{"type":"Box","props":{"y":0,"x":0,"var":"box_floor"},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1080,"skin":"estate/shopbg.jpg","mouseEnabled":true,"height":286}},{"type":"Image","props":{"y":22,"x":466,"width":233,"skin":"common/buildingnamebg.png","height":62,"sizeGrid":"0,29,0,29"},"child":[{"type":"Label","props":{"y":6,"x":-2,"width":238,"var":"txt_floorInfo","text":"彩票店","styleSkin":"comp/label.png","height":51,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","align":"center"}}]},{"type":"UIButton","props":{"y":110,"x":206,"width":176,"var":"btn_gainMoney","skin":"common/speakbg.png","height":129,"sizeGrid":"30,28,55,134"},"child":[{"type":"Image","props":{"y":21,"x":38,"skin":"common/ico_money.png"}}]},{"type":"UIButton","props":{"y":105,"x":42,"width":150,"var":"img_head","skin":"common/uibtn_greenbuttom.png","label":"","height":120,"sizeGrid":"50,50,50,50"},"child":[{"type":"Image","props":{"y":28,"x":45,"width":60,"visible":false,"skin":"common/add.png","height":60}}]},{"type":"Image","props":{"y":-1,"x":25,"width":1027,"var":"img_jlm","skin":"estate/jlm.png","height":286,"sizeGrid":"0,2,0,2"}},{"type":"Image","props":{"y":286,"x":0,"width":1080,"skin":"common/sxtd.png","height":115,"sizeGrid":"4,6,12,4"}},{"type":"Label","props":{"y":314,"x":33,"width":204,"var":"txt_hostName","text":"员工名字","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":48,"fontSize":35,"font":"Microsoft YaHei","color":"#ffffff","bold":true}},{"type":"UIButton","props":{"y":85,"x":414,"width":333,"var":"btn_kd","skin":"common/uibtn_greenbuttom.png","height":137,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":9,"x":68,"width":204,"text":"开店","styleSkin":"comp/label.png","strokeColor":"#2d980f","stroke":6,"height":103,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"Box","props":{"y":307,"x":341,"var":"box_progress"},"child":[{"type":"ProgressBar","props":{"y":10,"x":119,"width":267,"var":"progress","value":0.3,"skin":"comp/progress.png","height":42,"sizeGrid":"0,15,0,15"},"child":[{"type":"Label","props":{"y":1,"x":42,"width":157,"var":"txt_time","text":"10时50分","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":4,"height":32,"fontSize":35,"color":"#ffffff","align":"center"}}]},{"type":"Image","props":{"skin":"common/ico_money.png"}}]},{"type":"UIButton","props":{"y":292,"x":963,"width":94,"var":"btn_setting","skin":"common/uibtn_greenbuttom.png","height":94,"sizeGrid":"50,50,50,50"},"child":[{"type":"Image","props":{"y":18,"x":21,"skin":"comp/设置图标.png"}}]},{"type":"Label","props":{"y":86,"x":922,"width":100,"var":"txt_floor","styleSkin":"comp/label.png","strokeColor":"#223b71","stroke":3,"height":42,"fontSize":50,"color":"#f11d19","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class EstateHandleUI extends Dialog {
		public var bg:Image;
		public var txt_title:Label;
		public var box_content:Box;
		public var box_landlord:Box;
		public var txt_landlord:Label;
		public var box_tenant:Box;
		public var txt_tenant:Label;
		public var box_sellPrice:Box;
		public var txt_sellPrice:Label;
		public var box_rentPrice:Box;
		public var txt_rentPrice:Label;
		public var box_btns:Box;
		public var btn_rescission:UIButton;
		public var btn_closeShop:UIButton;
		public var btn_move:UIButton;
		public var btn_rent:UIButton;
		public var txt_rentCost:Label;
		public var btn_modifyPrice:UIButton;
		public var btn_buy:UIButton;
		public var txt_buyCost:Label;
		public var btn_growup:UIButton;
		public var txt_upcost:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":906,"height":1092},"child":[{"type":"Image","props":{"y":0,"x":0,"width":906,"var":"bg","skin":"common/winbg5.png","height":1092,"sizeGrid":"72,63,71,65"}},{"type":"Image","props":{"y":8,"x":10,"width":886,"skin":"common/winbg6.png","height":148,"sizeGrid":"45,51,52,55"}},{"type":"Label","props":{"y":11,"x":20,"width":870,"var":"txt_title","text":"简易住房","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":126,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","align":"center"}},{"type":"UIButton","props":{"y":23,"x":778,"width":94,"skin":"common/uibtn_close.png","name":"close","label":"","height":94}},{"type":"Image","props":{"y":193,"x":135,"width":658,"skin":"common/itembg1.png","height":237,"sizeGrid":"75,69,87,79"}},{"type":"Box","props":{"y":221,"x":266,"var":"box_content"},"child":[{"type":"Box","props":{"y":0,"x":0,"width":396,"var":"box_landlord","height":84},"child":[{"type":"Label","props":{"y":9,"x":21,"width":147,"text":"房东：","styleSkin":"comp/label.png","height":78,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":10,"x":199,"width":186,"var":"txt_landlord","styleSkin":"comp/label.png","height":80,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}}]},{"type":"Box","props":{"y":113,"x":25,"width":366,"var":"box_tenant","height":70},"child":[{"type":"Label","props":{"y":0,"x":0,"width":180,"text":"租户：","styleSkin":"comp/label.png","height":78,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Label","props":{"y":0,"x":172,"width":186,"var":"txt_tenant","styleSkin":"comp/label.png","height":89,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}}]},{"type":"Box","props":{"y":241,"x":51,"var":"box_sellPrice"},"child":[{"type":"Label","props":{"text":"售价","styleSkin":"comp/label.png","color":"#f8f6f6","fontSize":32}},{"type":"Label","props":{"y":1,"x":94,"width":186,"var":"txt_sellPrice","text":"房东","styleSkin":"comp/label.png","height":32,"color":"#f8f6f6","fontSize":32}}]},{"type":"Box","props":{"y":295,"x":51,"var":"box_rentPrice"},"child":[{"type":"Label","props":{"text":"租金","styleSkin":"comp/label.png","color":"#f8f6f6","fontSize":32}},{"type":"Label","props":{"y":1,"x":94,"width":186,"var":"txt_rentPrice","text":"房东","styleSkin":"comp/label.png","height":32,"color":"#f8f6f6","fontSize":32}}]}]},{"type":"Box","props":{"y":518,"x":240,"var":"box_btns"},"child":[{"type":"UIButton","props":{"y":867,"x":-29,"width":516,"var":"btn_rescission","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":35,"x":170,"width":183,"text":"解约","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":125,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":1085,"x":-27,"width":516,"var":"btn_closeShop","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":35,"x":101,"width":332,"text":"关闭店铺","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":112,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":1308,"x":-29,"width":516,"var":"btn_move","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":36,"x":170,"width":185,"text":"搬迁","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":112,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":212,"x":-33,"width":516,"var":"btn_rent","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":65,"x":176,"width":189,"var":"txt_rentCost","text":"租用","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":110,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}},{"type":"Image","props":{"y":13,"x":120,"skin":"common/ico_money.png"}},{"type":"Label","props":{"y":5,"x":232,"width":133,"text":"-1万","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":77,"fontSize":60,"font":"Microsoft YaHei","color":"#c40000","bold":true}}]},{"type":"UIButton","props":{"y":429,"x":-32,"width":516,"var":"btn_modifyPrice","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":39,"x":97,"width":332,"text":"修改售价","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":112,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"y":652,"x":-32,"width":516,"var":"btn_buy","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":3,"x":231,"width":133,"var":"txt_buyCost","text":"-1万","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":81,"fontSize":60,"font":"Microsoft YaHei","color":"#c40000","bold":true}},{"type":"Label","props":{"y":67,"x":175,"width":173,"text":"购买","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":106,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}},{"type":"Image","props":{"y":12,"x":146,"skin":"common/ico_xjb.png"}}]},{"type":"UIButton","props":{"y":0,"x":-36,"width":516,"var":"btn_growup","skin":"common/uibtn_greenbuttom.png","height":191,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":65,"x":176,"width":189,"text":"升级","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":110,"fontSize":80,"font":"Microsoft YaHei","color":"#ffffff","bold":true,"align":"center"}},{"type":"Image","props":{"y":13,"x":120,"skin":"common/ico_money.png"}},{"type":"Label","props":{"y":5,"x":232,"width":133,"var":"txt_upcost","text":"-1万","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":77,"fontSize":60,"font":"Microsoft YaHei","color":"#c40000","bold":true}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
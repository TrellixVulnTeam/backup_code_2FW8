/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class MapUI extends View {
		public var box_dice:Box;
		public var btn_go:Image;
		public var txt_leftPoints:Sprite;
		public var progress_power:Image;
		public var txt_city:Label;
		public var btn_search:Image;
		public var scrollbg:Image;
		public var btn_1:UIButton;
		public var btn_2:UIButton;
		public var btn_3:UIButton;
		public var btn_5:UIButton;
		public var btn_4:UIButton;
		public var btn_6:UIButton;
		public var btn_7:UIButton;
		public var btn_8:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1080,"height":1920},"child":[{"type":"Box","props":{"y":1521,"x":0,"width":1080,"var":"box_dice","height":235},"child":[{"type":"Image","props":{"y":-132,"var":"btn_go","skin":"map/dice/dicebg.png","centerX":-2}},{"type":"Image","props":{"y":-109,"x":431,"skin":"map/dice/dicebg1.png"}},{"type":"Sprite","props":{"y":-341,"x":525,"width":30,"var":"txt_leftPoints","height":193}},{"type":"Image","props":{"y":-128,"x":411,"var":"progress_power","skin":"map/dice/powerprogressbar.png"}},{"type":"Label","props":{"y":234,"x":22,"width":248,"var":"txt_city","text":"福州","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":4,"height":62,"fontSize":50,"color":"#00777d"}},{"type":"Image","props":{"y":25,"x":2,"width":146,"skin":"map/mapmenubg50%.png","height":182,"alpha":50,"sizeGrid":"32,33,31,12"}},{"type":"Image","props":{"y":63,"x":25,"var":"btn_search","skin":"map/scope.png"}}]},{"type":"Image","props":{"y":116,"x":70,"var":"scrollbg","skin":"common/text4.png"}},{"type":"Box","props":{"y":229,"x":107,"visible":false},"child":[{"type":"UIButton","props":{"y":3,"x":6,"var":"btn_1","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":153,"var":"btn_2","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":303,"x":2,"var":"btn_3","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":602,"x":1,"var":"btn_5","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":452,"x":1,"var":"btn_4","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"x":147,"var":"btn_6","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":156,"x":148,"var":"btn_7","skin":"common/uibtn_add.png","label":""}},{"type":"UIButton","props":{"y":309,"x":148,"var":"btn_8","skin":"common/uibtn_add.png","label":""}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class ModifySellPriceUI extends Dialog {
		public var btn_add:UIButton;
		public var btn_min:UIButton;
		public var btn_ok:UIButton;
		public var txt_modifyPrice:Label;
		public var txt_cost:Label;
		public var txt_price:Label;
		public var slider:HSlider;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"y":16,"x":77,"width":1080,"height":1920},"child":[{"type":"Image","props":{"y":396,"x":67,"width":920,"skin":"common/winbg5.png","height":1019,"sizeGrid":"72,63,71,65"}},{"type":"UIButton","props":{"y":848,"x":828,"var":"btn_add","skin":"common/uibtn_xxx.png","label":""}},{"type":"UIButton","props":{"y":841,"x":173,"width":84,"var":"btn_min","skin":"common/uibtn_xxx.png","label":"","height":92},"child":[{"type":"Image","props":{"y":38,"x":17,"skin":"common/min.png"}},{"type":"Image","props":{"y":25,"x":671,"skin":"common/add.png"}}]},{"type":"UIButton","props":{"y":1008,"x":278,"width":516,"var":"btn_ok","skin":"common/uibtn_greenbuttom.png","height":196,"sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":84,"x":172,"width":175,"var":"txt_modifyPrice","text":"修改","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":92,"fontSize":80,"color":"#ffffff","bold":true,"align":"center"}},{"type":"Image","props":{"y":22,"x":141,"skin":"common/ico_xjb.png"}},{"type":"Label","props":{"y":10,"x":226,"width":175,"var":"txt_cost","styleSkin":"comp/label.png","strokeColor":"#ffffff","stroke":6,"height":78,"fontSize":60,"font":"Microsoft YaHei","color":"#400000"}}]},{"type":"Image","props":{"y":407,"x":77,"width":900,"skin":"common/winbg6.png","height":152,"sizeGrid":"45,51,52,55"}},{"type":"Label","props":{"y":407,"x":333,"width":420,"text":"修改价格","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"height":133,"fontSize":100,"font":"Microsoft YaHei","color":"#ffffff","bold":true}},{"type":"UIButton","props":{"y":435,"x":856,"width":90,"skin":"common/uibtn_close.png","name":"close","label":"","height":90}},{"type":"Image","props":{"y":607,"x":217,"width":658,"skin":"common/itembg1.png","height":180,"sizeGrid":"75,69,87,79"}},{"type":"Label","props":{"y":656,"x":328,"width":178,"text":"价格：","styleSkin":"comp/label.png","height":78,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d"}},{"type":"Label","props":{"y":661,"x":584,"width":136,"var":"txt_price","styleSkin":"comp/label.png","height":74,"fontSize":60,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"Image","props":{"y":671,"x":493,"skin":"common/ico_xjb.png"}},{"type":"HSlider","props":{"y":881,"x":309,"width":468,"var":"slider","tick":0.05,"skin":"common/hslider_2.png","min":1,"max":2,"height":57}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
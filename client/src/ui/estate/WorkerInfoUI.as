/**Created by the LayaAirIDE,do not modify.*/
package ui.estate {
	import laya.ui.*;
	import laya.display.*; 

	public class WorkerInfoUI extends Dialog {
		public var txt_level:Label;
		public var txt_name:Label;
		public var txt_power:Label;
		public var txt_intelligence:Label;
		public var txt_agile:Label;
		public var txt_charm:Label;
		public var box_buttons:Box;
		public var btn_sg:UIButton;
		public var btn_zm:UIButton;
		public var btn_change:UIButton;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":913,"height":1021},"child":[{"type":"Image","props":{"y":-2,"x":-7,"width":920,"skin":"common/winbg5.png","height":1023,"sizeGrid":"72,63,71,65"}},{"type":"Label","props":{"y":192,"x":468,"var":"txt_level","text":"LV.1","styleSkin":"comp/label.png","fontSize":60,"color":"#00777d","bold":true},"child":[{"type":"ProgressBar","props":{"y":7,"x":134,"width":263,"skin":"comp/progress.png","height":48,"sizeGrid":"0,15,0,15"}}]},{"type":"Image","props":{"y":7,"x":2,"width":900,"skin":"common/textbg.png","height":158,"sizeGrid":"43,51,57,58"},"child":[{"type":"Label","props":{"y":19,"x":315,"width":320,"var":"txt_name","text":"草帽哥","styleSkin":"comp/label.png","strokeColor":"#00777d","stroke":6,"pivotX":-2,"height":107,"fontSize":100,"color":"#ffffff","bold":true}},{"type":"Image","props":{"y":43,"x":23,"width":69,"skin":"map/emoji1.png","height":64}},{"type":"ProgressBar","props":{"y":59,"x":103,"width":178,"skin":"comp/greenprogress.png","height":35,"sizeGrid":"0,19,0,16"}},{"type":"UIButton","props":{"y":29,"x":776,"skin":"common/uibtn_close.png","name":"close","label":""}}]},{"type":"Image","props":{"y":186,"x":47,"width":354,"skin":"estate/atb（big）.png","height":354},"child":[{"type":"ProgressBar","props":{"y":373,"x":15,"width":327,"skin":"comp/lifeprogress.png","height":36,"sizeGrid":"5,23,5,20"}}]},{"type":"Image","props":{"y":268,"x":463,"skin":"common/power.png"},"child":[{"type":"Label","props":{"y":10,"x":100,"var":"txt_power","text":"150","styleSkin":"comp/label.png","fontSize":38,"color":"#c40000","bold":true}}]},{"type":"Image","props":{"y":348,"x":463,"skin":"common/intelligence.png"},"child":[{"type":"Label","props":{"y":10,"x":100,"var":"txt_intelligence","text":"23","styleSkin":"comp/label.png","fontSize":38,"color":"#0090ff","bold":true}}]},{"type":"Image","props":{"y":428,"x":463,"skin":"common/agile.png"},"child":[{"type":"Label","props":{"y":10,"x":100,"var":"txt_agile","text":"82","styleSkin":"comp/label.png","fontSize":38,"color":"#37cb0a","bold":true}}]},{"type":"Image","props":{"y":508,"x":463,"skin":"common/charm.png"},"child":[{"type":"Label","props":{"y":10,"x":100,"var":"txt_charm","text":"99","styleSkin":"comp/label.png","fontSize":38,"color":"#ff85f2","bold":true}}]},{"type":"Box","props":{"y":693,"x":232,"var":"box_buttons"},"child":[{"type":"UIButton","props":{"x":2,"var":"btn_sg","skin":"common/uibtn_greenbuttom.png","sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":30,"x":120,"width":206,"text":"上岗","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"pivotX":-2,"height":107,"fontSize":100,"color":"#ffffff","bold":true}}]},{"type":"UIButton","props":{"var":"btn_zm","skin":"common/uibtn_greenbuttom.png","sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":30,"x":116,"width":219,"text":"招募","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"pivotX":-2,"height":107,"fontSize":100,"color":"#ffffff","bold":true,"align":"center"}}]},{"type":"UIButton","props":{"var":"btn_change","skin":"common/uibtn_greenbuttom.png","sizeGrid":"50,50,50,50"},"child":[{"type":"Label","props":{"y":30,"x":16,"width":219,"text":"更换员工","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"pivotX":-2,"height":107,"fontSize":100,"color":"#ffffff","bold":true,"align":"center"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.worker {
	import laya.ui.*;
	import laya.display.*; 

	public class WorkerItemUI extends View {
		public var txt_name:Label;
		public var txt_level:Label;
		public var txt_power:Label;
		public var txt_intelligence:Label;
		public var txt_agile:Label;
		public var txt_charm:Label;
		public var txt_shop:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1086,"height":160},"child":[{"type":"Image","props":{"y":9,"x":3,"skin":"estate/atb（small）.png"}},{"type":"Label","props":{"y":24,"x":156,"width":503,"var":"txt_name","text":"特不靠谱的啊","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":79,"fontSize":54,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"ProgressBar","props":{"y":140,"x":7,"width":125,"skin":"comp/lifeprogress.png","height":25,"sizeGrid":"5,23,5,20"}},{"type":"Label","props":{"y":101,"x":157,"width":108,"var":"txt_level","text":"Lv10","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":51,"fontSize":35,"font":"Microsoft YaHei","color":"#00777d","bold":true}},{"type":"ProgressBar","props":{"y":108,"x":254,"width":235,"skin":"comp/progress.png","height":30,"sizeGrid":"0,15,0,15"}},{"type":"Image","props":{"y":21,"x":510,"skin":"common/power.png"}},{"type":"Image","props":{"y":94,"x":510,"skin":"common/agile.png"}},{"type":"Image","props":{"y":94,"x":677,"skin":"common/charm.png"}},{"type":"Image","props":{"y":21,"x":678,"skin":"common/intelligence.png"}},{"type":"Label","props":{"y":20,"x":590,"width":82,"var":"txt_power","text":"2","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":51,"fontSize":38,"font":"Microsoft YaHei","color":"#400000","bold":true}},{"type":"Label","props":{"y":25,"x":763,"width":108,"var":"txt_intelligence","text":"45","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":51,"fontSize":38,"font":"Microsoft YaHei","color":"#0090ff","bold":true}},{"type":"Label","props":{"y":92,"x":591,"width":89,"var":"txt_agile","text":"37","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":51,"fontSize":38,"font":"Microsoft YaHei","color":"#37cb0a","bold":true}},{"type":"Label","props":{"y":90,"x":764,"width":108,"var":"txt_charm","text":"2","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":0,"height":51,"fontSize":38,"font":"Microsoft YaHei","color":"#ff85f2","bold":true}},{"type":"Label","props":{"y":56,"x":886,"width":191,"var":"txt_shop","styleSkin":"comp/label.png","height":52,"color":"#de1511","fontSize":32}},{"type":"Image","props":{"y":188,"x":16,"skin":"common/line.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
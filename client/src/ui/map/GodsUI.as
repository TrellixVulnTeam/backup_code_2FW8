/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class GodsUI extends Dialog {
		public var txt_msg:Label;
		public var npcLayer:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":490,"height":965},"child":[{"type":"UIButton","props":{"y":687,"x":25,"width":445,"skin":"common/uibtn_greenbuttom.png","name":"ok","height":173,"sizeGrid":"50,50,50,50"}},{"type":"Box","props":{"y":0,"x":0,"width":490,"height":630},"child":[{"type":"Image","props":{"y":124,"x":0,"width":490,"skin":"common/speakbg.png","name":"dialog","height":218,"sizeGrid":"30,28,55,134"},"child":[{"type":"Label","props":{"y":22,"x":27,"wordWrap":true,"width":295,"var":"txt_msg","valign":"middle","styleSkin":"comp/label.png","height":51,"fontSize":50,"color":"#00777d","bold":true,"align":"center"}}]},{"type":"Box","props":{"y":407,"x":175,"width":128,"var":"npcLayer","height":172}}]},{"type":"Label","props":{"y":722,"x":149,"width":210,"text":"好的","styleSkin":"comp/label.png","strokeColor":"#2d980d","stroke":6,"height":107,"fontSize":100,"color":"#ffffff","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class BuildingSkinItemUI extends View {
		public var icon:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":352,"height":349},"child":[{"type":"Image","props":{"y":10,"x":-8,"skin":"common/itembg7.png","sizeGrid":"116,60,62,60"}},{"type":"Image","props":{"y":10,"x":-8,"width":368,"skin":"common/itembg6.png","name":"selectBox","height":368,"sizeGrid":"105,51,103,135"}},{"type":"Image","props":{"y":194,"x":176,"width":82,"var":"icon","skin":"map/building/1001_1.png","height":126,"anchorY":0.5,"anchorX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
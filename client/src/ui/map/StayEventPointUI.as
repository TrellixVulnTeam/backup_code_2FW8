/**Created by the LayaAirIDE,do not modify.*/
package ui.map {
	import laya.ui.*;
	import laya.display.*; 

	public class StayEventPointUI extends View {
		public var icon:Image;
		public var txt_pos:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":50,"x":50,"width":100,"height":100,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":50,"x":50,"var":"icon","skin":"map/sp0.png","anchorY":0.5,"anchorX":0.5,"alpha":0.5}},{"type":"Label","props":{"y":-14,"x":-24,"width":147,"var":"txt_pos","styleSkin":"comp/label.png","height":46,"fontSize":20,"color":"#6289cf","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
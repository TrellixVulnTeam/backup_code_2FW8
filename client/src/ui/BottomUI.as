/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BottomUI extends View {
		public var tab:Tab;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1082,"height":216},"child":[{"type":"Tab","props":{"y":0,"x":0,"var":"tab"},"child":[{"type":"Button","props":{"y":0,"x":217,"stateNum":2,"skin":"index/goods.png","name":"item2"}},{"type":"Button","props":{"y":0,"x":865,"stateNum":2,"skin":"index/information.png","name":"item4"}},{"type":"Button","props":{"y":0,"x":433,"stateNum":2,"skin":"index/map.png","name":"item0"}},{"type":"Button","props":{"y":0,"x":649,"stateNum":2,"skin":"index/market.png","name":"item3"}},{"type":"Button","props":{"y":0,"x":1,"stateNum":2,"skin":"index/house property.png","name":"item1"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
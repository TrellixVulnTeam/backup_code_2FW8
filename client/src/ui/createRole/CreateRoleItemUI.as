/**Created by the LayaAirIDE,do not modify.*/
package ui.createRole {
	import laya.ui.*;
	import laya.display.*; 

	public class CreateRoleItemUI extends View {
		public var img_bottom:Image;
		public var img_role:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":143,"height":193},"child":[{"type":"Image","props":{"y":2,"x":-145,"var":"img_bottom","skin":"createRole/cloud2.png"}},{"type":"Image","props":{"y":-216,"x":-176,"width":319,"var":"img_role","skin":"createRole/role1.png","height":313}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
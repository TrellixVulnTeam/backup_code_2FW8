package game.view.createRole
{
	import com.cong.utils.FilterUtils;

	import laya.ui.Image;

	import ui.createRole.CreateRoleItemUI;

	public class RoleItem extends Object3D
	{
		private var _type:int;
		private var _selected:Boolean;
		private var ui:CreateRoleItemUI = new CreateRoleItemUI();
		public function RoleItem(type:int)
		{
			_type = type;
			ui.img_role.skin = "createRole/role" + type + ".png";
			addChild(ui);
		}

		public function get type():int
		{
			return _type;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected){
				ui.img_bottom.filters = [FilterUtils.getHighLightFilter()];
			}else{
				ui.img_bottom.filters = [];
			}
		}
	}
}

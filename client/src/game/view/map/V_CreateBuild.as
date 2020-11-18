package game.view.map
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.UITool;

	import game.config.ConfigHouseSkin;

	import game.config.ConfigHouseType;
	import game.constants.CONST_EVENT;
	import game.controller.C_Map;
	import game.data.D_Game;
	import game.data.house.BuildInfo;
	import game.view.V_Top;

	import laya.display.Text;

	import laya.events.Event;

	import ui.map.BuildingSkinItemUI;

	import ui.map.CreateBuildUI;

	public class V_CreateBuild extends CreateBuildUI implements IView
	{
		public function V_CreateBuild()
		{
			super();
			UITool.initList(list,BuildSkinItem);
			txt_name.overflow = Text.VISIBLE;
		}

		private static var _instance:V_CreateBuild;
		public static function get instance():V_CreateBuild
		{
			if (null == _instance)
			{
				_instance = new V_CreateBuild();
			}
			return _instance;
		}

		public function onShow():void
		{
		}

		public function onHide():void
		{
		}

		private var _data:Object;
		private var cost:int;
		public function setBuildData(data:BuildInfo){
			_data = data;
			var typeArr:Array = data.typeCode.split("|");
			for (var i:int = 0; i < typeArr.length; i++)
			{
				var buildType:Object = ConfigHouseType.getHouseCfgByType(typeArr[i]);
				if(buildType){
					break;
				}
			}
			list.dataSource = ConfigHouseSkin.getSkinList(buildType.TypeName,data.level);
			list.selectedIndex = 0;
			cost = buildType.CHMoney;
			txt_cost.text = cost.toString();
			txt_name.text = data.name;
			txt_name.x = (width - txt_name.displayWidth)/2;
			ico_build.x = txt_name.x - ico_build.width - 10;
		}

		public function addAllListeners():void
		{
			btn_close.on(Event.CLICK,this,onClose);
			btn_create.on(Event.CLICK,this,createHandler);
			EventCenter.ins.on(CONST_EVENT.CREATE_BUILDING_SUCCESS,this,setBuildSkin);
		}

		private function setBuildSkin():void
		{
			UIManager.instance.removePopUpWindow(this);
			D_Game.instance.updateDiamond(-cost);
			V_Top.instance.updateUserRes();
			C_Map.instance.setBuildSKin(_data.id,list.selectedItem.SkinId);
		}

		private function createHandler():void
		{
			C_Map.instance.createBuild(_data.id);
			//todo 扣钱
		}

		private function onClose():void
		{
			UIManager.instance.removePopUpWindow(this);
		}

		public function removeAllListeners():void
		{
			btn_close.off(Event.CLICK,this,onClose);
			btn_create.off(Event.CLICK,this,createHandler);
			EventCenter.ins.off(CONST_EVENT.CREATE_BUILDING_SUCCESS,this,setBuildSkin);
		}
	}
}

package game.view.map
{
	import com.cong.managers.UIManager;
	import com.cong.utils.StringUtil;

	import game.config.ConfigHouseSkin;

	import game.constants.CONST_BUILD_TYPE;
	import game.constants.CONST_FILE;
	import game.controller.C_UI;
	import game.data.house.BuildInfo;

	import laya.events.Event;

	import ui.map.BuildingUI;

	public class Building extends BuildingUI
	{
		private var _data:BuildInfo;

		public function Building(data:BuildInfo)
		{
			_data = data;
			
			txt_name.text = StringUtil.formatStr(30,data.name);
			if(!data.skinId){
				data.skinId =  ConfigHouseSkin.getSkinList(_data.type,data.level)[0].SkinId;
			}
			icon.skin = CONST_FILE.getBuildIcon(data.skinId, data.level);
			if (!data.isCreated)
			{
				this.gray = true;
			}
			on(Event.MOUSE_DOWN, this, onMouseDown);
			on(Event.CLICK, this, onClick);
		}

		private var _mouseX:Number;
		private var _mouseY:Number;

		private function onMouseDown():void
		{
			_mouseX = Laya.stage.mouseX;
			_mouseY = Laya.stage.mouseY;
		}

		private function onClick(e:Event):void
		{
			if (Math.abs(Laya.stage.mouseX - _mouseX) < 5 && Math.abs(Laya.stage.mouseY - _mouseY) < 5)
			{
				if (!data.isCreated)
				{
//					Alert.show(Language.CREATE_BUILD_TIP,2,Handler.create(this,createBuild));
					V_CreateBuild.instance.setBuildData(_data);
					UIManager.instance.popUpWindow(V_CreateBuild.instance);
				} else
				{
					switch (_data.type)
					{
						case CONST_BUILD_TYPE.SHOP:
							C_UI.instance.showShop(_data);
							break;
						case CONST_BUILD_TYPE.HOUSE:
							C_UI.instance.showHouse(_data);
							break;
					}
				}
			}
		}

		public function get data():BuildInfo
		{
			return _data;
		}

		public function setSkin(id:int)
		{
			_data.skinId = id;
		}

		public function set data(value:BuildInfo):void
		{
			_data = value;
			txt_name.text = StringUtil.formatStr(30,data.name);
			if (!data.isCreated)
			{
				this.gray = true;
			} else
			{
				this.gray = false;
			}
		}
	}
}

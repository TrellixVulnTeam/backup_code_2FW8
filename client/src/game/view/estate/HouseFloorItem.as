package game.view.estate
{
	import com.cong.display.TextureFont;
	import com.cong.managers.UIManager;
	import com.cong.utils.TextUtil;

	import game.config.ConfigEstateType;
	import game.config.ConfigHouseType;
	import game.constants.CONST_FILE;

	import game.controller.C_House;
	import game.data.D_Estate;

	import game.data.D_Game;
	import game.data.house.FloorInfo;
	import game.data.vo.UserInfo;
	import game.str.Language;

	import laya.events.Event;

	import ui.estate.HouseFloorItemUI;

	/**
	 * 房产楼层展示
	 */
	public class HouseFloorItem extends HouseFloorItemUI
	{
		private var _floorInfo:FloorInfo;

		public function HouseFloorItem()
		{
			super();
			on(Event.UNDISPLAY,this,removeListeners);
			on(Event.DISPLAY, this, addListeners);
		}

		private function addListeners():void
		{
			btn_add.on(Event.CLICK,this,addHandler);
		}

		private function removeListeners():void
		{
			btn_gainMoney.off(Event.CLICK, this, gainMoneyHandler);
			btn_gainMoney.off(Event.CLICK, this, gainMoneyHandler);
			btn_rz.off(Event.CLICK, this, rzHandler);
			Laya.timer.clear(this, countDownHandler);
			btn_add.off(Event.CLICK,this,addHandler);
		}

		private function addHandler():void
		{
			C_House.instance.operHouseFloor(11,D_Estate.instance.operBuild.id);
		}

		private function settingHandler():void
		{
			if (_floorInfo)
			{
				V_EstateHandle.instance.setFloorInfo(2, _floorInfo);
				UIManager.instance.popUpWindow(V_EstateHandle.instance);
			}
		}

		private var seconds:int;

		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (value)
			{
				_floorInfo = value as FloorInfo;
				if(_floorInfo.id==0){
					box_floor.visible = false;
					box_top.visible = true;
					return;
				}else{
					box_floor.visible = true;
					box_top.visible = false;
				}
				var userInfo:UserInfo = D_Game.instance.userInfo;
				txt_floor.text = _floorInfo.id.toString();
				if ((_floorInfo.landlordId == userInfo.userId && _floorInfo.tenantId == 0 && _floorInfo.LZId == 0) || (_floorInfo.tenantId == userInfo.userId && _floorInfo.LZId == 0))
				{
					if (D_Game.instance.userInfo.houseId == "") btn_rz.visible = true;
					else
						btn_rz.visible = false;
				} else
				{
					btn_rz.visible = false;
				}
				if(_floorInfo.LZId){
					txt_floorInfo.text = TextUtil.conectParam(Language.HOUSE_NAME, [_floorInfo.level,  ConfigEstateType.getHouseType(_floorInfo.level).Name]);
					txt_hostName.text = _floorInfo.LZName;
					img_jlm.visible = false;
				}else{
					txt_floorInfo.text = txt_hostName.text = "";
					img_jlm.visible = true;
				}
				if (_floorInfo.LZId != 0 && _floorInfo.LZId != userInfo.userId && _floorInfo.landlordId == userInfo.userId)
				{
					box_progress.visible = true;
					seconds = D_Game.instance.timestamp - _floorInfo.lastGainTime_rent;
					countDownHandler();
					Laya.timer.loop(1000, this, countDownHandler);
				} else
				{
					btn_gainMoney.visible = false;
					box_progress.visible = false;
				}
				btn_rz.on(Event.CLICK, this, rzHandler);
				btn_gainMoney.on(Event.CLICK, this, gainMoneyHandler);
				btn_setting.on(Event.CLICK, this, settingHandler);
			} 
		}

		private function countDownHandler():void
		{
			if (seconds >= D_Game.instance.gainEstateMoneyGap)
			{
				btn_gainMoney.visible = true;
				progress.value = 1;
				txt_time.text = Math.floor(D_Game.instance.gainEstateMoneyGap / 3600) + Language.SHI + Math.floor((D_Game.instance.gainEstateMoneyGap % 3600) / 60) + Language.FEN;
				Laya.timer.clear(this, countDownHandler);
			} else
			{
				btn_gainMoney.visible = false;
				progress.value = seconds / D_Game.instance.gainEstateMoneyGap;
				if (seconds < 3600)
				{
					txt_time.text = Math.floor(seconds / 60) + Language.FEN + Math.floor(seconds % 60) + Language.MIAO;
				}else{
					txt_time.text = Math.floor(seconds / 3600) + Language.SHI + Math.floor((seconds % 3600) / 60) + Language.FEN;
				}
			}
			seconds++;
		}

		private function gainMoneyHandler():void
		{
			C_House.instance.operHouseFloor(9, V_House.instance.buildInfo.id, _floorInfo.id, 0, 0);
		}

		private function rzHandler():void
		{
			C_House.instance.operHouseFloor(5, V_House.instance.buildInfo.id, _floorInfo.id, 0, 0);
		}
	}
}

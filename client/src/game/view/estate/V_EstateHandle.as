package game.view.estate
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.LayoutUtil;

	import game.config.ConfigEstateType;
	import game.config.ConfigShopGrowUp;
	import game.config.ConfigWorkerGrowUp;

	import game.constants.CONST_EVENT;
	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.D_Estate;
	import game.data.D_Game;
	import game.data.house.FloorInfo;
	import game.data.vo.UserInfo;
	import game.str.Language;

	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Handler;

	import ui.estate.EstateHandleUI;

	/**
	 * 房产操作（包括商业跟住宅）
	 */
	public class V_EstateHandle extends EstateHandleUI implements IView
	{
		public function V_EstateHandle()
		{
			super();
			box_btns.autoSize = true;
		}

		private static var _instance:V_EstateHandle;
		private var floorInfo:FloorInfo;
		private var type:int = 1;  //1商业 2住宅

		public static function get instance():V_EstateHandle
		{
			if (null == _instance)
			{
				_instance = new V_EstateHandle();
			}
			return _instance;
		}

		public function onShow():void
		{
			if (type == 1)
			{
				if (floorInfo.shopType)
				{
					txt_title.text = ConfigEstateType.getHouseType(floorInfo.shopType).Name;
				} else
				{
					txt_title.text = Language.UNOPENED;
				}
			} else
			{
				txt_title.text = ConfigEstateType.getHouseType(floorInfo.level).Name;
			}
			var numChildren:int = box_content.numChildren;
			for (var i:int = 0; i < numChildren; i++)
			{
				(box_content.getChildAt(i) as Sprite).visible = false;
			}
			numChildren = box_btns.numChildren;
			for (var i:int = 0; i < numChildren; i++)
			{
				(box_btns.getChildAt(i) as Sprite).visible = false;
			}
			var userInfo:UserInfo = D_Game.instance.userInfo;
			if (floorInfo.landlordId != userInfo.userId && floorInfo.tenantId == 0)
			{
				//其他玩家 或 系统，未出租房产 设置
				btn_buy.visible = true;
				if (floorInfo.LZId == 0) btn_rent.visible = true;
				box_landlord.visible = true;
			} else if (floorInfo.landlordId != userInfo.userId && floorInfo.tenantId != userInfo.userId && floorInfo.LZId != userInfo.userId && floorInfo.LZId != 0)
			{
				//主角 未购买，其他玩家经营中
				box_landlord.visible = true;
				box_tenant.visible = true;
				btn_buy.visible = true;
			} else if (floorInfo.landlordId == userInfo.userId && floorInfo.LZId == userInfo.userId)
			{
				//主角 已购买，已入住 设置
				if (type == 1) btn_closeShop.visible = true;
				btn_move.visible = true;
				box_landlord.visible = true;
			} else if (floorInfo.landlordId != userInfo.userId && floorInfo.tenantId == userInfo.userId)
			{
				//主角 未购买，已租用，未入住 设置
				box_landlord.visible = true;
				box_tenant.visible = true;
				btn_buy.visible = true;
				if (floorInfo.LZId == userInfo.userId)
				{
					if (type == 1) btn_closeShop.visible = true;
					btn_move.visible = true;
				}
			} else if (floorInfo.landlordId == userInfo.userId && floorInfo.LZId == 0)
			{
				//主角 已购买，未入住 设置
				box_landlord.visible = true;
				box_sellPrice.visible = true;
				btn_modifyPrice.visible = true;
				txt_sellPrice.text = floorInfo.sellMoney.toString();
			} else if (floorInfo.LZId == userInfo.userId && floorInfo.landlordId != userInfo.userId)
			{
				//主角 已租用，主角 已入住 未购买
				btn_buy.visible = true;
				if (type == 1) btn_closeShop.visible = true;
				btn_move.visible = true;
			} else if (floorInfo.landlordId != userInfo.userId && floorInfo.tenantId != userInfo.userId && floorInfo.tenantId != 0)
			{
				//其他玩家经营中 设置
				box_landlord.visible = true;
				box_tenant.visible = true;
				btn_buy.visible = true;
			} else if (floorInfo.landlordId == userInfo.userId && floorInfo.tenantId != userInfo.userId && floorInfo.tenantId != 0)
			{
				//主角 已购买，已出租 设置
				box_tenant.visible = true;
				box_landlord.visible = true;
				box_sellPrice.visible = true;
				box_rentPrice.visible = true;
				btn_modifyPrice.visible = true;
				btn_rescission.visible = true;
			}
			if (floorInfo.LZId == userInfo.userId && floorInfo.shopType)
			{
				btn_growup.visible = true;
				txt_upcost.text = ConfigShopGrowUp.getDataByLv(floorInfo.level).ExpOrMoney.toString();
			}
			txt_landlord.text = floorInfo.landlordName;
			txt_tenant.text = floorInfo.tenantName;
			txt_sellPrice.text = floorInfo.sellMoney.toString();
			txt_rentPrice.text = (floorInfo.buyMoney * 100).toString() + "/" + Language.TIAN;
			txt_rentCost.text = Math.floor(floorInfo.buyMoney * 100).toString() + "/" + Language.TIAN;
			txt_buyCost.text = floorInfo.sellMoney.toString();
			callLater(function () {
				LayoutUtil.layoutVBox(box_content, 20);
				LayoutUtil.layoutVBox(box_btns, 20);
				bg.height = box_btns.y + box_btns.height + 20;
			})
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_buy.on(Event.CLICK, this, operHandler);
			btn_rent.on(Event.CLICK, this, operHandler);
			btn_modifyPrice.on(Event.CLICK, this, operHandler);
			btn_rescission.on(Event.CLICK, this, operHandler);
			btn_closeShop.on(Event.CLICK, this, operHandler);
			btn_move.on(Event.CLICK, this, operHandler);
			EventCenter.ins.on(CONST_EVENT.MODIFY_ESTATE_PRICE, this, onSellPriceChange);
			btn_growup.on(Event.CLICK, this, operHandler);
		}

		private function onSellPriceChange(obj:Object):void
		{
			txt_sellPrice.text = obj.sellMoney.toString();
		}

		private function operHandler(e:Event):void
		{
			var buildId:String = D_Estate.instance.operBuild.id;
			switch (e.currentTarget)
			{
				case btn_buy:
					C_UI.instance.alert(Language.BUY_ESTATE_TIP, 2, Handler.create(this, function () {
						if (D_Game.instance.diamonds < floorInfo.sellMoney)
						{
							C_UI.instance.alert(Language.DIAMOND_NOT_ENOUGH);
							return;
						}
						C_House.instance.operHouseFloor(2, buildId, floorInfo.id, floorInfo.sellMoney);
					}))
					break;
				case btn_rent:
					//玩家已入住
					if (type == 2 && D_Game.instance.ylz)
					{
						C_UI.instance.alert(Language.MOVE_HOUSE_TIP, 2, Handler.create(this, function () {
							if (D_Game.instance.money < Math.floor(floorInfo.buyMoney * 100) * 2)
							{
								C_UI.instance.alert(Language.MONEY_NOT_ENOUGH);
								return;
							}
							C_House.instance.operHouseFloor(3, buildId, floorInfo.id);
						}))
						return;
					}
					C_UI.instance.alert(Language.RENT_SHOP_TIP, 2, Handler.create(this, function () {
						if (D_Game.instance.money < Math.floor(floorInfo.buyMoney * 100))
						{
							C_UI.instance.alert(Language.MONEY_NOT_ENOUGH);
							return;
						}
						C_House.instance.operHouseFloor(3, buildId, floorInfo.id);
					}));
					break;
				case btn_modifyPrice:
					V_ModifySellPrice.instance.floorInfo = floorInfo;
					UIManager.instance.popUpWindow(V_ModifySellPrice.instance);
					break;
				case btn_rescission:
					C_House.instance.operHouseFloor(4, buildId, floorInfo.id);
					//解约
					break;
				case btn_closeShop:
					C_House.instance.operHouseFloor(7, buildId, floorInfo.id, 0, floorInfo.shopType);
					break;
				case btn_move:
					break;
				case btn_growup:
					ConfigWorkerGrowUp.getGrowUpByLevel(floorInfo.level)
					if (D_Game.instance.money < ConfigShopGrowUp.getDataByLv(floorInfo.level).ExpOrMoney)
					{
						C_UI.instance.alert(Language.MONEY_NOT_ENOUGH);
					}else{
						C_House.instance.operHouseFloor(12, D_Estate.instance.operBuild.id, floorInfo.id);
					}
					break;
			}
		}

		public function removeAllListeners():void
		{
			btn_buy.off(Event.CLICK, this, operHandler);
			btn_rent.off(Event.CLICK, this, operHandler);
			btn_modifyPrice.off(Event.CLICK, this, operHandler);
			btn_rescission.off(Event.CLICK, this, operHandler);
			btn_closeShop.off(Event.CLICK, this, operHandler);
			btn_move.off(Event.CLICK, this, operHandler);
			EventCenter.ins.off(CONST_EVENT.MODIFY_ESTATE_PRICE, this, onSellPriceChange);
		}


		public function setFloorInfo(type:int, floorInfo:FloorInfo):void
		{
			this.type = type;
			this.floorInfo = floorInfo;
		}
	}
}

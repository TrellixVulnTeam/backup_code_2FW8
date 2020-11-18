package game.view.estate
{
	import com.cong.display.TextureFont;
	import com.cong.events.EventCenter;
	import com.cong.managers.UIManager;
	import com.cong.utils.TextUtil;

	import game.config.ConfigEstateType;
	import game.constants.CONST_EVENT;
	import game.constants.CONST_FILE;
	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.D_Estate;
	import game.data.D_Game;
	import game.data.estate.CustomerInfo;
	import game.data.house.FloorInfo;
	import game.data.vo.UserInfo;
	import game.str.Language;

	import laya.events.Event;

	import ui.estate.ShopFloorItemUI;

	/**
	 * 商业楼层展示
	 */
	public class ShopFloorItem extends ShopFloorItemUI
	{
		private var floorInfo:FloorInfo;
		private var worker:FloorWorker = new FloorWorker();

		public function ShopFloorItem()
		{
			super();
			on(Event.UNDISPLAY, this, removeListeners);
			on(Event.DISPLAY, this, addListeners);
		}

		private function addListeners():void
		{
			EventCenter.ins.on(CONST_EVENT.SG_WORKER_SUCCESS, this, sgSussess);
			btn_add.on(Event.CLICK,this,addHandler);
		}

		private function addHandler():void
		{
			C_House.instance.operHouseFloor(11,D_Estate.instance.operBuild.id);
		}

		private function sgSussess(obj:Object):void
		{
			if(obj.floorId == floorInfo.id){
				img_head.visible = false;
				addChild(worker);
				floorInfo.workerId = obj.id;
				worker.on(Event.CLICK, this, showWorkerInfo);
			}
		}

		//员工上岗
		private function onWorkerSg():void
		{
			img_head.off(Event.CLICK, this, showWorkers);
		}

		private function removeListeners():void
		{
			btn_kd.off(Event.CLICK, this, kdHandler);
			btn_gainMoney.off(Event.CLICK, this, gainMoneyHandler);
			Laya.timer.clear(this, countDownHandler);
			EventCenter.ins.off(CONST_EVENT.SHOW_FLOOR_CUSTOMERS, this, showFloorCustomers);
			img_head.off(Event.CLICK, this, showWorkers);
			btn_add.off(Event.CLICK,this,addHandler);
		}

		private function showWorkers():void
		{
			D_Estate.instance.selectFloorId = floorInfo.id;
			C_UI.instance.showWorkers(false);
		}

		private var seconds:int;

		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			for (var i:int = 0; i < customerArr.length; i++)
			{
				customerArr[i].removeSelf();
			}
			customerArr.length = 0;

			if (value)
			{
				img_head.visible = false;
				btn_gainMoney.visible = false;
				worker.removeSelf();
				floorInfo = value as FloorInfo;
				if(floorInfo.id==0){
					box_floor.visible = false;
					box_top.visible = true;
					return;
				}else{
					box_floor.visible = true;
					box_top.visible = false;
				}
				var userInfo:UserInfo = D_Game.instance.userInfo;
				txt_floor.text = floorInfo.id.toString();
				if ((floorInfo.landlordId == userInfo.userId && floorInfo.tenantId == 0 && floorInfo.LZId == 0) || (floorInfo.tenantId == userInfo.userId && floorInfo.LZId == 0))
				{
					btn_kd.visible = true;
				} else
				{
					btn_kd.visible = false;
				}
				if (floorInfo.shopType)
				{
					txt_floorInfo.text = TextUtil.conectParam(Language.HOUSE_NAME, [floorInfo.level, ConfigEstateType.getHouseType(floorInfo.shopType).Name]);
					txt_hostName.text = floorInfo.LZName;
					img_jlm.visible = false;
				} else
				{
					txt_floorInfo.text = txt_hostName.text = "";
					img_jlm.visible = true;
				}
				btn_setting.on(Event.CLICK, this, settingHandler);
				if (floorInfo.LZId == userInfo.userId)
				{
					//经营店铺倒计时
					box_progress.visible = true;
					seconds = D_Game.instance.timestamp - floorInfo.lastGainTime;
					countDownHandler();
					Laya.timer.loop(1000, this, countDownHandler);
					if (!floorInfo.customers)
					{
						C_House.instance.getFloorCustomers(D_Estate.instance.operBuild.id, floorInfo.id);
						EventCenter.ins.on(CONST_EVENT.SHOW_FLOOR_CUSTOMERS, this, showFloorCustomers);
						EventCenter.ins.on(CONST_EVENT.ADD_CUSTOMER_BEST, this, addCustomerBest);
					} else
					{
						showFloorCustomers(floorInfo);
					}
					if (!floorInfo.workerId)
					{
						img_head.visible = true;
						img_head.on(Event.CLICK, this, showWorkers);
					} else
					{
						img_head.visible = false;
						addChild(worker);
						worker.on(Event.CLICK, this, showWorkerInfo);
					}
				} else if (floorInfo.LZId != 0 && floorInfo.LZId != userInfo.userId && floorInfo.landlordId == userInfo.userId)
				{
					//出租倒计时
					box_progress.visible = true;
					seconds = D_Game.instance.timestamp - floorInfo.lastGainTime_rent;
					countDownHandler();
					Laya.timer.loop(1000, this, countDownHandler);
				} else
				{
					box_progress.visible = false;
				}
				btn_kd.on(Event.CLICK, this, kdHandler);
				btn_gainMoney.on(Event.CLICK, this, gainMoneyHandler);
			}
		}

		private function addCustomerBest(obj:Object):void
		{
			for (var i:int = 0; i < customerArr.length; i++)
			{
				if (customerArr[i].data.type == obj.id)
				{
					customerArr[i].removeSelf();
					customerArr.splice(i,1);
					floorInfo.customers.splice(i,1);
					break;
				}
			}
		}

		private var customerArr:Array = new Array();

		private function showFloorCustomers(obj:Object):void
		{
			floorInfo.customers = obj.customers;
			for (var i:int = 0; i < floorInfo.customers.length; i++)
			{
				var cInfo:CustomerInfo = floorInfo.customers[i];
				var customer:FloorCustomer = new FloorCustomer(cInfo);
				customer.x = i * 50 + 500;
				addChild(customer);
				customerArr.push(customer);
				if (cInfo.bestValue < cInfo.bestLimit)
				{
					customer.bestIcon.on(Event.CLICK, this, function (e:Event) {
						e.stopPropagation();
						var tar:FloorCustomer = e.currentTarget.parent as FloorCustomer;
						C_House.instance.addCustomerBest(D_Estate.instance.operBuild.id, floorInfo.id, tar.data.type);
						tar.data.bestValue++;
						if(tar.data.bestValue == cInfo.bestLimit){
							V_WorkerInfo.instance.setCustomerInfo(tar.data);
							D_Estate.instance.selectFloorId = floorInfo.id;
							UIManager.instance.popUpWindow(V_WorkerInfo.instance);
						}
					});
				}
				customer.on(Event.CLICK, this, function (e:Event) {
					var tar:FloorCustomer = e.currentTarget as FloorCustomer;
					V_WorkerInfo.instance.setCustomerInfo(tar.data);
					D_Estate.instance.selectFloorId = floorInfo.id;
					UIManager.instance.popUpWindow(V_WorkerInfo.instance);
				});
				if (cInfo.bestValue == 0)
				{
					//新顾客
				}
			}
		}

		private function showWorkerInfo():void
		{
			V_WorkerInfo.instance.setWorkerId(floorInfo.LZId, floorInfo.workerId);
			D_Estate.instance.selectFloorId = floorInfo.id;
			UIManager.instance.popUpWindow(V_WorkerInfo.instance);
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
				} else
				{
					txt_time.text = Math.floor(seconds / 3600) + Language.SHI + Math.floor((seconds % 3600) / 60) + Language.FEN;
				}
			}
			seconds++;
		}

		private function gainMoneyHandler():void
		{
			var gainType:int = (floorInfo.LZId == D_Game.instance.userInfo.userId ? 8 : 9);
			C_House.instance.operHouseFloor(gainType, D_Estate.instance.operBuild.id, floorInfo.id, 0, floorInfo.shopType);
		}

		private function settingHandler():void
		{
			V_EstateHandle.instance.setFloorInfo(1, floorInfo);
			UIManager.instance.popUpWindow(V_EstateHandle.instance);
		}

		private function kdHandler():void
		{
			V_ShopSelectType.instance.shopInfo = floorInfo;
			UIManager.instance.showPanel(V_ShopSelectType.instance);
		}
	}
}

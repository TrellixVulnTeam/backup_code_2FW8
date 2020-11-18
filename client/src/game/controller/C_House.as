package game.controller
{
	import com.cong.events.EventCenter;
	import com.cong.managers.FloatTextManager;
	import com.cong.net.Network;

	import game.constants.CONST_CMD;
	import game.constants.CONST_EVENT;
	import game.str.Language;

	public class C_House
	{
		public function C_House()
		{
			Network.addHandler(this, CONST_CMD.GET_HOUSE_INFO_RET, getHouseInfoRet);
			Network.addHandler(this, CONST_CMD.HOUSE_FLOOR_OPER_RET, operHouseFloorRet);
			Network.addHandler(this, CONST_CMD.GET_FLOOR_CUSTOMERS_RET, getFloorCustomersRet);
			Network.addHandler(this, CONST_CMD.ADD_CUSTOMER_BEST_RET, addCustomerBestRet);
			Network.addHandler(this, CONST_CMD.GET_WORKERS_RET, getWorkersRet);
			Network.addHandler(this, CONST_CMD.GET_WORKER_INFO_RET, getWorkerInfoRet);
			Network.addHandler(this, CONST_CMD.OPER_WORKER_RET, operWorkerRet);
		}

		private function getWorkerInfoRet(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SHOW_WORKER_INFO, obj);
		}

		public function getWorkerInfo(userId:int, workerId:int):void
		{
			Network.send(CONST_CMD.GET_WORKER_INFO, {userId: userId, workerId: workerId});
		}

		private function getWorkersRet(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SHOW_WORKERS, obj);
		}

		public function getWorkers()
		{
			Network.send(CONST_CMD.GET_WORKERS);
		}

		public function getFloorCustomers(houseId:String, floorId:int)
		{
			Network.send(CONST_CMD.GET_FLOOR_CUSTOMERS, {houseId: houseId, floorId: floorId});
		}

		private function getFloorCustomersRet(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SHOW_FLOOR_CUSTOMERS, obj);
		}

		private var operQueue:Array = new Array();

		public function addCustomerBest(houseId:String, floorId:int, id:int):void
		{
			var param:Object = {houseId: houseId, floorId: floorId, id: id};
			operQueue.push(param)
			Network.send(CONST_CMD.ADD_CUSTOMER_BEST, param);
		}

		private function addCustomerBestRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.ADD_CUSTOMER_BEST, operQueue.shift());
			} else
			{
				C_UI.instance.alert(Language.ADD_BEST_FAIL);
			}
		}

		/**
		 *  操作类型 1=招募 2=上岗
		 * @param type
		 * @param id  顾客ID/员工ID
		 * @param houseId 房产ID
		 * @param floorId 楼层
		 */
		private var operedWorker:Object;

		public function operWorker(type:int, id:int, houseId:String = "", floorId:int = 0):void
		{
			operedWorker = {type: type, id: id, houseId: houseId, floorId: floorId};
			Network.send(CONST_CMD.OPER_WORKER, operedWorker);
		}

		private function operWorkerRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				if (operedWorker.type == 1)
				{
					FloatTextManager.showCenter(Language.ZM_SUCCESS);
					EventCenter.ins.event(CONST_EVENT.ZM_WORKER_SUCCESS, operedWorker);
				} else if (operedWorker.type == 2)
				{
					EventCenter.ins.event(CONST_EVENT.SG_WORKER_SUCCESS, operedWorker);
				}
			} else
			{
				C_UI.instance.alert(Language.OPER_ERROR);
			}
		}


		private static var _instance:C_House;
		public static function get instance():C_House
		{
			if (null == _instance)
			{
				_instance = new C_House();
			}
			return _instance;
		}

		/**
		 * 获取房产楼层信息
		 * @param houseId
		 */
		public function getHouseInfo(houseId):void
		{
			Network.send(CONST_CMD.GET_HOUSE_INFO, {houseId: houseId});
		}

		private function getHouseInfoRet(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SHOW_HOUSE_FLOOR, obj);
		}

		/**
		 * 房产楼层操作
		 * @param operType    1=修改卖出价格 2=购买楼层 3=租住楼层 4=解除租住楼层 5=入住（只能住宅楼）6=开店 7=关闭店铺 8=提取开店收益 9=提取租房收益 10=点赞  11增加楼层   12=店铺升级
		 * @param houseId     房产ID
		 * @param floorId     房产楼层id
		 */
		private var operObj:Object;

		public function operHouseFloor(operType:int, houseId:String, floorId:int=0, sellMoney:int = 0, shopType:int = 0):void
		{
			operObj = {
				operType: operType, houseId: houseId, floorId: floorId, sellMoney: sellMoney, shopType: shopType
			};
			Network.send(CONST_CMD.HOUSE_FLOOR_OPER, operObj);
		}

		private function operHouseFloorRet(obj:Object):void
		{
			//0=成功 1=钱不够 2=一周只能修改一次 3=上传数据不对 4=入住只能是住宅楼 5=操作类型不对 6=价格已变化 7=已被人入住 8=出售价格不对 9=不是房东或者租房 10=不能购买自已的房产 11=已被租住 12=没有人租住
			/// 13=用户等级开店数量限制 14=开店铺类型未解锁 15=已开店 16=不是房东 17=收获时间末到 18=该房产不能开店 19=违约金不够 20=不能购买房东自住住房 21=入住的房子才能点赞 22=点赞超过次数 23=每天只能点赞一次
			if (obj.code == 0)
			{
				switch (operObj.operType)
				{
					case 1:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.MODIFY_ESTATE_PRICE, operObj]);
						break;
					case 2:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.BUY_ESTATE_FLOOR, operObj]);
						FloatTextManager.showCenter(Language.BUY_SSTATE_SUCCESS);
						break;
					case 3:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.RENT_ESTATE_SUCCESS, operObj]);
						break;
					case 4:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.OVER_RENT, operObj]);
						break;
					case 5:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.ENTER_FLOOR, operObj]);
						break;
					case 6:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.OPEN_SHOP, operObj]);
						break;
					case 7:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.CLOSE_SHOP, operObj]);
						break;
					case 8:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.GAIN_SHOP_INCOME, operObj]);
						break;
					case 9:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.GAIN_RENT_INCOME, operObj]);
						break;
					case 10:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.ADD_BEST, operObj]);
						break;
					case 11:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.ADD_FLOOR, operObj]);
						break;
					case 12:
						EventCenter.ins.event(CONST_EVENT.ESTATE_HANDLE, [CONST_EVENT.ESTATE_GROW_UP, operObj]);
						FloatTextManager.showCenter(Language.GROWUP_SUCCESS);
						break;
				}
			} else
			{
				C_UI.instance.alert(Language.ERRCODE_5020[obj.code]);
			}
		}
	}
}

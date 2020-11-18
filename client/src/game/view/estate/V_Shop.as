package game.view.estate
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.TextUtil;
	import com.cong.utils.UITool;

	import game.config.ConfigShopGrowUp;

	import game.config.ConfigWorkerGrowUp;

	import game.constants.CONST_EVENT;
	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.D_Estate;
	import game.data.D_Game;
	import game.data.house.BuildInfoBase;
	import game.data.house.FloorInfo;
	import game.data.vo.UserInfo;
	import game.str.Language;
	import game.view.V_Top;

	import laya.events.Event;

	import ui.estate.ShopUI;

	/**
	 * 商场
	 */
	public class V_Shop extends ShopUI implements IView
	{
		public var fromMap:Boolean;   //是否从地图打开
		public function V_Shop()
		{
			super();
			UITool.initList(list, ShopFloorItem);
		}

		private static var _instance:V_Shop;

		public static function get instance():V_Shop
		{
			if (null == _instance)
			{
				_instance = new V_Shop();
			}
			return _instance;
		}

		public function onShow():void
		{
			C_House.instance.getHouseInfo(D_Estate.instance.operBuild.id);
			txt_name.text = TextUtil.conectParam(Language.HOUSE_NAME, [D_Estate.instance.operBuild.level, D_Estate.instance.operBuild.name]);
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_close.on(Event.CLICK, this, closeHandler);
			EventCenter.ins.on(CONST_EVENT.SHOW_HOUSE_FLOOR, this, getHouseInfoRet);
			EventCenter.ins.on(CONST_EVENT.ESTATE_HANDLE, this, operHandler);
		}

		private function operHandler(type:String, operObj:Object):void
		{
			var userInfo:UserInfo = D_Game.instance.userInfo;
			var item:FloorInfo = list.getItem(list.length - operObj.floorId) as FloorInfo;
			switch (type)
			{
				case CONST_EVENT.MODIFY_ESTATE_PRICE:
					//todo  修改售价
					item.sellMoney = operObj.sellMoney;
					list.setItem(list.length - operObj.floorId, item);
					break;
				case CONST_EVENT.BUY_ESTATE_FLOOR:
					item.landlordId = userInfo.userId;
					item.landlordName = userInfo.nickName;
					if (item.LZId) item.lastGainTime_rent = D_Game.instance.timestamp;
					list.setItem(list.length - operObj.floorId, item);

					D_Game.instance.updateDiamond(-item.sellMoney);
					V_Top.instance.updateUserRes();
					UIManager.instance.removePopUpWindow(V_EstateHandle.instance);
					break;
				case CONST_EVENT.RENT_ESTATE_SUCCESS:
					item.tenantId = userInfo.userId;
					item.tenantName = userInfo.nickName;
					list.setItem(list.length - operObj.floorId, item);

					D_Game.instance.updateMoney(-Math.floor(item.buyMoney * 100));
					V_Top.instance.updateUserRes();
					UIManager.instance.removePopUpWindow(V_EstateHandle.instance);
					break;
				case CONST_EVENT.OVER_RENT:
					item.tenantId = 0;
					item.tenantName = "";
					list.setItem(list.length - operObj.floorId, item);
					UIManager.instance.removePopUpWindow(V_EstateHandle.instance);
					break;
				case CONST_EVENT.ENTER_FLOOR:
					break;
				case CONST_EVENT.OPEN_SHOP:
					item.LZId = userInfo.userId;
					item.LZName = userInfo.nickName;
					item.shopType = operObj.shopType;
					item.lastGainTime = D_Game.instance.timestamp;
					list.setItem(list.length - operObj.floorId, item);
					UIManager.instance.removePanel(V_ShopSelectType.instance);
					break;
				case CONST_EVENT.CLOSE_SHOP:
					item.LZId = 0;
					item.LZName = "";
					item.shopType = 0;
					list.setItem(list.length - operObj.floorId, item);
					UIManager.instance.removePopUpWindow(V_EstateHandle.instance);
					break;
				case CONST_EVENT.GAIN_SHOP_INCOME:
					item.lastGainTime = D_Game.instance.timestamp;
					list.setItem(list.length - operObj.floorId, item);
					break;
				case CONST_EVENT.GAIN_RENT_INCOME:
					item.lastGainTime_rent = D_Game.instance.timestamp;
					list.setItem(list.length - operObj.floorId, item);
					break;
				case CONST_EVENT.ADD_BEST:
					break;
				case CONST_EVENT.ADD_FLOOR:
					var floorInfo:FloorInfo = new FloorInfo();
					floorInfo.landlordId = userInfo.userId;
					floorInfo.id = list.length;
					list.addItemAt(floorInfo,1);
					break;
				case CONST_EVENT.ESTATE_GROW_UP:
					D_Game.instance.updateMoney(-ConfigShopGrowUp.getDataByLv(floorInfo.level).ExpOrMoney);
					V_Top.instance.updateUserRes();
					UIManager.instance.removePopUpWindow(V_EstateHandle.instance);
					item.level++;
					list.setItem(list.length - operObj.floorId, item);
					break;
			}
		}

		private function getHouseInfoRet(obj:Object):void
		{
			obj.floors.push(new FloorInfo());
			list.dataSource = obj.floors.reverse();
			list.scrollTo(obj.floors.length);
		}

		public function removeAllListeners():void
		{
			btn_close.off(Event.CLICK, this, closeHandler);
			EventCenter.ins.off(CONST_EVENT.SHOW_HOUSE_FLOOR, this, getHouseInfoRet);
			EventCenter.ins.off(CONST_EVENT.ESTATE_HANDLE, this, operHandler);
		}

		private function closeHandler():void
		{
			if (fromMap) C_UI.instance.backToHome(); else UIManager.instance.removePanel(this);
		}
	}
}

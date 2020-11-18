package game.view
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.utils.UITool;

	import game.constants.CONST_EVENT;
	import game.controller.C_UI;
	import game.controller.C_User;
	import game.view.estate.LandlordItem;
	import game.view.estate.EstateItem;

	import laya.events.Event;
	import laya.utils.Handler;

	import ui.EstateUI;

	public class V_Estate extends EstateUI implements IView
	{
		public function V_Estate()
		{
			UITool.initList(list_shop,EstateItem);
			UITool.initList(list_landlord,LandlordItem);
			tab.selectHandler=new Handler(this,onSelecte);
		}

		private static var _instance:V_Estate;
		public static function get instance():V_Estate
		{
			if (null == _instance)
			{
				_instance = new V_Estate();
			}
			return _instance;
		}

		public function onShow():void
		{
			list_shop.scrollTo(0);
			list_landlord.scrollTo(0);
			viewStack.selectedIndex = 0;
			C_User.instance.getHouseList();
		}

		public function onHide():void
		{
		}

		private function closeHandler():void
		{
			C_UI.instance.backToHome();
		}

		public function addAllListeners():void
		{
			btn_close.on(Event.CLICK,this,closeHandler);
			EventCenter.ins.on(CONST_EVENT.SHOW_HOUSE_LIST,this,showHouseList);
		}

		private function onSelecte(index:int):void
		{
			viewStack.selectedIndex = index;
		}

		private function showHouseList(obj:Object):void
		{
			list_shop.dataSource = obj.shops;
			list_landlord.dataSource = obj.czHouse;
		}

		public function removeAllListeners():void
		{
			btn_close.off(Event.CLICK,this,closeHandler);
			EventCenter.ins.off(CONST_EVENT.SHOW_HOUSE_LIST,this,showHouseList);
		}
	}
}

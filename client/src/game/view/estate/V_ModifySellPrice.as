package game.view.estate
{
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;

	import game.controller.C_House;
	import game.data.D_Estate;

	import game.data.house.FloorInfo;

	import laya.events.Event;
	import laya.utils.Handler;

	import ui.estate.ModifySellPriceUI;

	public class V_ModifySellPrice extends ModifySellPriceUI implements IView
	{
		public var floorInfo:FloorInfo;
		public function V_ModifySellPrice()
		{
			super();
			slider.showLabel = false;
		}

		private static var _instance:V_ModifySellPrice;
		private var sellMoney:int;
		public static function get instance():V_ModifySellPrice
		{
			if (null == _instance)
			{
				_instance = new V_ModifySellPrice();
			}
			return _instance;
		}

		public function onShow():void
		{
			sellMoney = floorInfo.sellMoney;
			txt_price.text = floorInfo.sellMoney.toString();
			slider.value = floorInfo.sellMoney/floorInfo.buyMoney;
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_ok.on(Event.CLICK,this,okHandler);
			btn_add.on(Event.CLICK,this,addHandler);
			btn_min.on(Event.CLICK,this,minHandler);
			slider.changeHandler = new Handler(this,onChange);
		}

		private function onChange():Function
		{
			txt_cost.text = Math.ceil(sellMoney*0.001).toString();
			sellMoney = Math.round(floorInfo.buyMoney*slider.value);
			txt_price.text = sellMoney.toString();
		}

		private function minHandler():void
		{
			if(slider.value>1){
				slider.value -= 0.05;
			}
		}

		private function addHandler():void
		{
			if(slider.value<2){
				slider.value += 0.05;
			}
		}

		private function okHandler():void
		{
			UIManager.instance.removePopUpWindow(this);
			if(sellMoney!=floorInfo.sellMoney){
				C_House.instance.operHouseFloor(1,D_Estate.instance.operBuild.id,floorInfo.id,sellMoney);
			}
		}

		public function removeAllListeners():void
		{
		}
	}
}

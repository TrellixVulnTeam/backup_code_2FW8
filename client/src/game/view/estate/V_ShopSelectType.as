package game.view.estate
{
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.UITool;

	import game.config.ConfigEstateType;
	import game.data.house.FloorInfo;

	import laya.events.Event;

	import ui.estate.ShopTypeItemUI;

	import ui.estate.ShopTypeSelectUI;

	public class V_ShopSelectType extends ShopTypeSelectUI implements IView
	{
		public var shopInfo:FloorInfo;
		public function V_ShopSelectType()
		{
			super();
			UITool.initList(list,ShopTypeItem);
		}

		private static var _instance:V_ShopSelectType;
		public static function get instance():V_ShopSelectType
		{
			if (null == _instance)
			{
				_instance = new V_ShopSelectType();
			}
			return _instance;
		}

		public function onShow():void
		{
			list.dataSource = ConfigEstateType.getShopTypes();
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_close.on(Event.CLICK,this,closeHandler);
		}

		public function removeAllListeners():void
		{
			btn_close.off(Event.CLICK,this,closeHandler);
		}

		private function closeHandler():void
		{
			UIManager.instance.removePanel(this);
		}
	}
}

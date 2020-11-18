package game.config
{
	public class ConfigShopGrowUp
	{
		public function ConfigShopGrowUp()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getDataByLv(lv:int):Object{
			return _data[lv];
		}
	}
}

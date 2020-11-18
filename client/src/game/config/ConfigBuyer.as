package game.config
{
	public class ConfigBuyer
	{
		public function ConfigBuyer()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getBuyerById(id:int):Object{
			return _data[id];
		}
	}
}

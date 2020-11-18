package game.config
{
	public class ConfigWorkerGrowUp
	{
		public function ConfigWorkerGrowUp()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getGrowUpByLevel(level:int):Object{
			return _data[level];
		}
	}
}

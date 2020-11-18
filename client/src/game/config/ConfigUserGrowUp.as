package game.config
{
	public class ConfigUserGrowUp
	{
		public function ConfigUserGrowUp()
		{

		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getGrowData(lv:int){
			return _data[lv];
		}
	}
}

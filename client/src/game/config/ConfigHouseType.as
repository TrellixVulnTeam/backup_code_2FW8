package game.config
{
	public class ConfigHouseType
	{
		public function ConfigHouseType()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
			_data = data;
		}

		public static function getHouseCfgByType(typeCode:String){
			if(typeCode.length==5){typeCode = "0" + typeCode}
			return _data[typeCode];
		}
	}
}

package game.config
{
	public class ConfigEstateType
	{
		public function ConfigEstateType()
		{
		}

		private static var _data:Object;
		private static var _shopTypes:Array;
		private static var _houseType:Array;

		public static function init(data:Object):void
		{
			_data = data;
		}

		public static function getShopTypes():Array
		{
			if (!_shopTypes)
			{
				_shopTypes = [];
				for each (var obj:Object in _data)
				{
					if (obj.Attribute)
					{
						_shopTypes.push(obj);
					}
				}
			}
			return _shopTypes;
		}

		public static function getHouseTypes():Array
		{
			if (!_houseType)
			{
				_houseType = [];
				for each (var obj:Object in _data)
				{
					if (!obj.Attribute)
					{
						_houseType.push(obj);
					}
				}
				return _houseType;
			}
		}

		public static function getHouseType(id:int):Object{
			return _data[id];
		}
	}
}

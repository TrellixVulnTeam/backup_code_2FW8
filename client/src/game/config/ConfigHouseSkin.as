package game.config
{
	public class ConfigHouseSkin
	{
		public function ConfigHouseSkin()
		{
		}
		private static var _data:Array;
		public static function init(data:Array):void
		{
		    _data = data;
		}

		public static function getSkinList(type:String,lv:int):Array{
			var arr:Array =[];
			for (var i:int = 0; i < _data.length; i++)
			{
				if(_data[i].HouseTypeName == type&&_data[i].SkinLv == lv){
					arr.push(_data[i]);
				}
			}
			return arr;
		}
	}
}

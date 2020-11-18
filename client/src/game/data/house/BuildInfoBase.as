package game.data.house
{
	import game.config.ConfigHouseType;

	public class BuildInfoBase
	{
		/// id
		public var id:String = "";
		/// 类型编码
		public var typeCode:String = "";
		/// 名称
		public var name:String = "";
		/// 等级
		public var level:int = 1;
		public function BuildInfoBase()
		{
		}

		public function get type():String
		{
			if (ConfigHouseType.getHouseCfgByType(typeCode))
			{
				return ConfigHouseType.getHouseCfgByType(typeCode).TypeName;
			}
			return "";
		}
	}
}

package game.data
{
	import game.data.house.BuildInfoBase;

	public class D_Estate
	{
		public var selectFloorId:int;
		public function D_Estate()
		{
		}

		private static var _instance:D_Estate;
		public static function get instance():D_Estate
		{
			if (null == _instance)
			{
				_instance = new D_Estate();
			}
			return _instance;
		}

		public var operBuild:BuildInfoBase;
	}
}

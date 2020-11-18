package game.data
{
	import laya.utils.Dictionary;

	public class D_Map
	{
		public function D_Map()
		{
		}

		private static var _instance:D_Map;
		public static function get instance():D_Map
		{
			if (null == _instance)
			{
				_instance = new D_Map();
			}
			return _instance;
		}

		public var  navRoutes:Dictionary = new Dictionary();   //导航点

	}
}

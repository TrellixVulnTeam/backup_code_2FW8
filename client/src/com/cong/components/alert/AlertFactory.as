package com.cong.components.alert
{
	import laya.utils.Handler;
	import laya.utils.Pool;

	/**
	 * @author chencong
	 */
	public class AlertFactory
	{
		private static var _instance:AlertFactory;

		public function AlertFactory()
		{
		}

		public static function getInstanceByType(type:int):*
		{
			switch (type)
			{
				case 1:
					var alert:SystemConfirmAlert = Pool.getItem("SystemConfirmAlert");
					if (!alert)
					{
						alert = new SystemConfirmAlert();
					}
					return alert;
				case 2:
					var alert:SimpleSystemAlert = Pool.getItem("SimpleSystemAlert");
					if (!alert)
					{
						alert = new SimpleSystemAlert();
					}
					return alert;
//				case 3:
//					return Pool.getItemByClass("TodayNotAgainAlert", TodayNotAgainAlert);
			}
		}

		static private function get instance():AlertFactory
		{
			if (_instance == null)
			{
				_instance = new AlertFactory();
			}
			return _instance;
		}

	}
}

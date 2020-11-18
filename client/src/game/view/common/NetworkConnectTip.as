package game.view.common
{
	import com.cong.interfaces.IView;

	import ui.common.NetworkConnectTipUI;

	public class NetworkConnectTip extends NetworkConnectTipUI implements IView
	{
		public function NetworkConnectTip()
		{
			super();
		}

		private static var _instance:NetworkConnectTip;
		public static function get instance():NetworkConnectTip
		{
			if (null == _instance)
			{
				_instance = new NetworkConnectTip();
			}
			return _instance;
		}

		public function onShow():void
		{
		}

		private function cycleHandler():void
		{
			ico_cycle.rotation-=3;
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			Laya.timer.frameLoop(1,this,cycleHandler);
		}

		public function removeAllListeners():void
		{
			Laya.timer.clear(this,cycleHandler);
		}
	}
}

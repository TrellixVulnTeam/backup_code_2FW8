package game.view
{
	import game.controller.C_UI;

	import laya.events.Event;
	import laya.utils.Handler;

	import ui.BottomUI;

	public class V_Bottom extends BottomUI
	{
		public function V_Bottom()
		{
			super();
			y = Laya.stage.height - height;
			tab.selectedIndex = 0;
			tab.selectHandler = new Handler(this, tabHandler);
		}

		private function tabHandler():void
		{
			switch (tab.selectedIndex)
			{
				case 0:
					C_UI.instance.showMap();
					break;
				case 1:
					C_UI.instance.showEstate();
					break;
				case 2:
					C_UI.instance.showWorkers();
					break;
				case 3:
					break;
				case 4:
					break;
			}
		}

		public function showMap(){
			tab.selectedIndex = 0;
		}

		public function showWorker(){
			tab.selectedIndex = 2;
		}

		private static var _instance:V_Bottom;
		public static function get instance():V_Bottom
		{
			if (null == _instance)
			{
				_instance = new V_Bottom();
			}
			return _instance;
		}
	}
}

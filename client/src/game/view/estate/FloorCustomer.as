package game.view.estate
{
	import game.data.estate.CustomerInfo;

	import laya.display.Sprite;

	import ui.estate.CustomerUI;

	public class FloorCustomer extends CustomerUI
	{
		private var _data:CustomerInfo;
		public var bestIcon:Sprite;
		public function FloorCustomer(data:CustomerInfo)
		{
			_data = data;
			bestIcon = new Sprite();
			bestIcon.graphics.drawRect(0, 0, 50, 100, "#ff0000");
			bestIcon.size(50, 100);
			addChild(bestIcon);
		}

		public function get data():CustomerInfo
		{
			return _data;
		}

		public function set data(value:CustomerInfo):void
		{
			_data = value;
		}
	}
}

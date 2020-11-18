package game.config
{
	import game.data.map.StayEvent;

	public class ConfigStayEvent
	{
		public function ConfigStayEvent()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getEvent(id:int):StayEvent{
			var stayEvent:StayEvent = new StayEvent();
			stayEvent.id = _data[id + ""]["ID"];
			stayEvent.secondType =_data[id + ""]["SecondType"];
			stayEvent.type = _data[id + ""]["Type"];
			stayEvent.power = _data[id + ""]["PowerValue"];
			stayEvent.name = _data[id + ""]["Name"];
			stayEvent.money = _data[id + ""]["Money"];
			stayEvent.exp = _data[id + ""]["Exp"];
			stayEvent.stepNum = _data[id + ""]["StepNum"];
			stayEvent.diamond = _data[id + ""]["Diamonds"];
			stayEvent.content = _data[id + ""]["content"];
			return stayEvent;
		}
	}
}

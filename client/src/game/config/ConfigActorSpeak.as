package game.config
{
	import game.data.D_Game;

	public class ConfigActorSpeak
	{
		public function ConfigActorSpeak()
		{
		}

		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function getSpeak(val:int):Object
		{
			var lvcoe:Number = ConfigUserGrowUp.getGrowData(D_Game.instance.userInfo.level).LevelCoefficient;
			val=Math.floor(val/lvcoe);
			for each (var obj:Object in _data)
			{
				if(val>=obj.Low&&val<=obj.High){
					var rand:int = Math.floor(Math.random()*obj.Talk.length);
					obj.msg = obj.Talk[rand];
					return obj;
				}
			}
		}
	}
}

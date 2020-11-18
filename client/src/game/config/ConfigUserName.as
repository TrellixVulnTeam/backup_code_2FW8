package game.config
{
	public class ConfigUserName
	{
		public function ConfigUserName()
		{
		}
		private static var _data:Object;
		public static function init(data:Object):void
		{
		    _data = data;
		}

		public static function randName(sex:int):String{
			var rand:int = Math.floor(Math.random()*_data.Surname.length);
			var firstName:String = _data.Surname[rand];
			var secondName:String = "";
			if(sex == 1){
				rand =  Math.floor(Math.random()*_data.ManName.length);
				secondName = _data.ManName[rand];
			}else{
				rand =  Math.floor(Math.random()*_data.WomanName.length);
				secondName = _data.WomanName[rand];
			}
			return firstName+secondName;
		}
	}
}

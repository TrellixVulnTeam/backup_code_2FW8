package game.config
{
	public class ConfigDisableWords
	{
		public function ConfigDisableWords()
		{
		}

		private static var _data:Array;
		public static function init(data:Array):void
		{
		    _data = data;
		}

		public static function isDisableWord(word:String):Boolean
		{
			for (var i:int = 0; i < _data.length; i++)
			{
				if(word.indexOf(_data[i])!=-1){
					return true;
				}
			}
			return false;
		}
	}
}

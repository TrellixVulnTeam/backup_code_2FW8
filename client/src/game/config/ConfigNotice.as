package game.config
{
	public class ConfigNotice
	{
		public function ConfigNotice()
		{
		}

		private static var list:Array;

		public static function init(data:Object)
		{
			list = data as Array;
			return list;
		}

		public static function getRandNotice(){
			var arr:Array = [];
			for (var i:int = 0; i < list.length; i++)
			{
				if(list[i].type == 1){
					arr.push(list[i]);
				}
			}
			var ranIndex:int = Math.round(Math.random()*(arr.length-1));
			return arr[ranIndex].content;
		}
	}
}

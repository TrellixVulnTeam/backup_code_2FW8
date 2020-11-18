package game.data.map
{
	public class StayEvent
	{
		public var id:int;
		public var type:int;  // 类型
		public var secondType:int   //小类
		public var name:String    //事件名称
		public var power:int;
		public var money:int;
		public var exp:int;
		public var diamond:int;
		public var stepNum:int;    //持续步数
		public var content:Object;
		public function StayEvent()
		{
		}
	}
}

package game.data.estate
{
	/**
	 * 员工
	 */
	public class WorkerInfo extends BuyerBase
	{
		public var exp:int;
		public var houseId:String="";
		public var floorId:int;
		public var level:int = 1;
		public var sgTime:String = "";
		public var shopType:int;
		public function WorkerInfo()
		{
		}
	}
}

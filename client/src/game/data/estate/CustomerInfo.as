package game.data.estate
{
	/**
	 * 顾客
	 */
	public class CustomerInfo extends BuyerBase
	{
		public var bestValue:int;   //满意度
		public var bestLimit:int;
		public var rewordType:int = 0;
		public var rewordValue:int = 0;
		//满意度上限
		public function CustomerInfo()
		{
		}
	}
}

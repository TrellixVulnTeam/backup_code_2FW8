package game.data.estate
{
	public class BuyerBase
	{
		public var id:int;
		public var type:int;
		public var name:String;
		public var quality:int;  //品质
		public var qualityCoefficient:Number = 0; //品质系数
		public var power:int;  //基础力量
		public var intelligence:int;  //基础智力
		public var agile:int;   //基础敏捷
		public var charm:int;   //基础魅力
		public function BuyerBase()
		{
		}
	}
}

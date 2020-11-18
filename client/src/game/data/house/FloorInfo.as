package game.data.house
{
	import game.data.estate.CustomerInfo;

	public class FloorInfo
	{
		/// 楼层id
		public var id:int = 0;
		/// 楼层等级
		public var level:int = 1;
		/// 所有者id
		public var landlordId:int = 0;
		/// 房东名称
		public var landlordName:String = "";
		/// 承租者id
		public var tenantId:int = 0;
		/// 租户名称
		public var tenantName:String = "";
		/// 入住者id
		public var LZId = 0;
		/// 入住者名称
		public var LZName:String = "";
		/// 购买价格（钻石）
		public var buyMoney:int = 0;
		/// 卖出价格(钻石)
		public var sellMoney:int = 0;
		/// 更改出售价格时间
//		public var UPSMDate:String = "";
		public var shopType:int;     //店铺类型
		public var lastGainTime:int;   //上一次提取房产店铺收入时间
		public var lastGainTime_rent:Number;         /// 用户提取租房收入时间
		public var customers:Vector.<CustomerInfo>;
		public var workerId:int = 0;
		public function FloorInfo()
		{
		}
	}
}

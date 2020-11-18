package game.data.vo
{
	public class UserInfo
	{
		/// 玩家昵称
		public var nickName:String = "";
		/// 玩家头象
		public var userImg:int = 1;
		/// 姓别 1男 2女
		public var sex:int = 0;
		/// 经验
		public var exp:int = 0;
		/// 级别
		public var level:int = 1;
		/// 签名
		public var signature:String = "";
		/// 年龄
		public var age:int = 0;
		/// 省份
		public var province:String = "";
		/// 城市
		public var city:String = "";
		/// 好友数量
		public var friendsNum:int = 0;
		/// 人气值
		public var popularity:int = 0;
		/// 房产总价值
		public var totalHouseValue:int = 0;
		/// 房产数量
		public var houseNum:int = 0;
		/// 累计分红
		public var totalBonus:int = 0;
		/// 昨日分红
		public var yestodayBonus:int = 0;
		/// 钻石
		public var diamonds:int = 0;
		/// 钞票
		public var money:int = 0;
		/// 当前X坐标
		public var xPoint:Number = 0;
		/// 当前Y坐标
		public var yPoint:Number = 0;
		/// 体力值
		public var power:int = 0;
		/// 更新体力值时间点
		public var refreshPowerTime:int;
		/// 停留点与xy坐标点距离
		public var initEventIndex:int;
		public var godState:String = "";
		public var addBestList:Array = new Array();
		/// 用户id
		public var userId:int;
		public var houseId:String = "";   //住房id
		public var floorId:int;
		public var toPointX:Number = 0;
		public var toPointY:Number = 0;

		//住房楼层

		public function UserInfo()
		{
		}
	}
}

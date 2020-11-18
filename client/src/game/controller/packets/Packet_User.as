package game.controller.packets
{
	import com.cong.utils.StringUtil;

	import game.data.D_Game;
	import game.data.house.CZInfo;
	import game.data.house.EstateInfo;

	import game.data.vo.UserInfo;

	import laya.utils.Browser;

	import laya.utils.Byte;

	public class Packet_User
	{
		public function Packet_User()
		{
		}

		/**
		 *             /// 用户角色类型 1=男2=女3=男4=女
		 public int UserType = 0;
		 /// 1=Android;2=IOS;
		 public int ConnectType = 0;
		 /// 客户端设备号
		 public string DeviceCode = "";
		 /// 第三方令牌(自身带类型，如@facebook)
		 public string ThirdId = "";
		 /// 用于验证ThirdId的附加验证码
		 public string SessionKey = "";
		 */
		public static function Login(obj:Object, byte:Byte):void
		{
			byte.writeByte(1);
			byte.writeUTFString(obj.userid);
			byte.writeUTFString("");
			byte.writeUTFString("");
		}

		public static function LoginRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			/// Client登录令牌
			obj.token = byte.readUTFString();
			/// 目标GS地址
			obj.serverIP = byte.readUTFString();
			/// 目标GS守护端口
			obj.port = byte.getInt32();
			return obj;
		}


		/**
		 *
		 1000
		 token验证登陆
		 /// 登录token
		 public string token = "";
		 /// 当前X坐标
		 public float CurrentXPoint = 0;
		 /// 当前Y坐标
		 public float CurrentYPoint = 0;
		 */
		public static function accessToken(obj:Object, byte:Byte)
		{
			byte.writeUTFString(obj.token);
//			byte.writeFloat64(obj.lng);
//			byte.writeFloat64(obj.lat);
			byte.writeInt32(obj.lng*1000000);
			byte.writeInt32(obj.lat*1000000);
			console.log(obj.lng*1000000,obj.lat*1000000);
		}

		/**
		 2000
		 登录应答
		 /// 用户ID
		 public int Code = 0;
		 /// 令牌
		 public string Token = "";
		 /// 是否第一次登陆(如果第一次登陆进行取名操作)
		 public int isfirstlogin = 0;
		 */
		public static function accessTokenRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.uid = byte.getInt32();
			obj.token = byte.getString();
			obj.isfirstlogin = byte.getByte();
			return obj;
		}

		/**
		 * 5001 修改用户信息
		 /// 操作类型 1=修改用户性别和头像 2=用户昵称
		 public int OperCode = 0;
		 /// 用户角色类型 1=男2=女3=男4=女
		 public byte UserType = 0;
		 /// 用户昵称（20长度）
		 public string NikeName = "";
		 */
		public static function modifyUserInfo(obj:Object, byte:Byte)
		{
			byte.writeInt32(obj.OperCode);
			byte.writeByte(obj.UserType);
			byte.writeUTFString(obj.NikeName);
		}

		/**
		 * 5002登录应答
		 /// 状态码 0=成功 1=失败
		 public int Code = 0;
		 * @param byte
		 * @return
		 */
		public static function modifyUserInfoRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.getInt32();
			return obj;
		}

		/**
		 * 5006 用户信息
		 /// 玩家昵称
		 public string NikName = "";
		 /// 玩家头象
		 public int UserImg = 0;
		 /// 姓别 1男 2女
		 public int Sex = 0;
		 /// 经验
		 public int Exp = 0;
		 /// 级别
		 public int Level = 1;
		 /// 签名
		 public string Signature = "";
		 /// 年龄
		 public int Age = 0;
		 /// 省份
		 public string Province = "";
		 /// 城市
		 public string City = "";
		 /// 好友数量
		 public int FriendsNum = 0;
		 /// 人气值
		 public int PopularityValue = 0;
		 /// 房产总价值
		 public int TotalHouseValue = 0;
		 /// 房产数量
		 public int HouseNum = 0;
		 /// 累计分红
		 public int TotalBonus = 0;
		 /// 昨日分红
		 public int YestodayBonus = 0;
		 /// 钻石
		 public int Diamonds = 0;
		 /// 钞票
		 public int Money = 0;
		 /// 当前X坐标
		 public double CurrentXPoint = 0;
		 /// 当前Y坐标
		 public double CurrentYPoint = 0;
		 /// 体力值
		 public int PowerValue = 0;
		 /// 更新体力值时间点
		 public string RefreshPowerValueTime = "";
		 */
		public static function getUserInfoRet(byte:Byte):Object
		{
			var userInfo:UserInfo = new UserInfo();
			userInfo.nickName = byte.getUTFString();
			userInfo.userImg = byte.getInt32();
			userInfo.sex = byte.getInt32();
			userInfo.exp = byte.getInt32();
			userInfo.level = byte.getInt32();
			userInfo.signature = byte.getUTFString();
			userInfo.age = byte.getInt32();
			userInfo.province = byte.getUTFString();
			userInfo.city = byte.getUTFString();
			userInfo.friendsNum = byte.getInt32();
			userInfo.popularity = byte.getInt32();
			userInfo.totalHouseValue = byte.getInt32();
			userInfo.houseNum = byte.getInt32();
			userInfo.totalBonus = byte.getInt32();
			userInfo.yestodayBonus = byte.getInt32();
			userInfo.diamonds = byte.getInt32();
			userInfo.money = byte.getInt32();
			userInfo.xPoint = byte.getFloat64();
			userInfo.yPoint = byte.getFloat64();
			userInfo.power = byte.getInt32();
			userInfo.refreshPowerTime = StringUtil.stringToTime(byte.getUTFString());
			D_Game.instance.startTime = Browser.now();
			D_Game.instance.loginTime = StringUtil.stringToTime(byte.getUTFString());
			userInfo.initEventIndex = byte.getInt32();
			userInfo.godState = byte.getUTFString();
			D_Game.instance.gainEstateMoneyGap = byte.getInt32() * 3600;
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				userInfo.addBestList.push(byte.getInt32());
			}
			userInfo.userId = byte.getInt32();
			userInfo.houseId = byte.getUTFString();
			userInfo.floorId = byte.getInt32();
			userInfo.toPointX = byte.getFloat64();
			userInfo.toPointY = byte.getFloat64();
			return userInfo;
		}

		/**
		 * 返回用户房产列表
		 /// 商铺列表
		 public List<EstateInfo> ShopList = new List<EstateInfo>();
		 /// 出租列表
		 public List<CZInfo> CZList = new List<CZInfo>();
		 * @param byte
		 * @return
		 */
		public static function getHouseListRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.shops = new Array();
			obj.czHouse = new Array();
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var houseInfo:EstateInfo = new EstateInfo();
				houseInfo.id = byte.getUTFString();
				houseInfo.typeCode = byte.getUTFString();
				houseInfo.name = byte.getUTFString();
				houseInfo.level = byte.getInt32();
				houseInfo.income = byte.getInt32();
				houseInfo.value = byte.getInt32();
				houseInfo.rent = byte.getInt32();
				houseInfo.shopNum = byte.getInt32();
				obj.shops.push(houseInfo);
			}
			len = byte.getUint16();
			for (i = 0; i < len; i++)
			{
				var czInfo:CZInfo = new CZInfo();
				czInfo.id = byte.getUTFString();
				czInfo.typeCode = byte.getUTFString();
				czInfo.name = byte.getUTFString();
				czInfo.level = byte.getInt32();
				czInfo.income = byte.getInt32();
				czInfo.value = byte.getInt32();
				czInfo.czNum = byte.getInt32();
				czInfo.totalNum = byte.getInt32();
				obj.czHouse.push(czInfo);
			}
			return obj;
		}

//		public static function modsssifyUserInfo(obj:Object, byte:Byte)
//		{
//			byte.writeUTFString("ffffffffffffffffffffffffffffffffhjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjdfedddddddddddddddddddddddddddddddddddddddddddddddddddrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
//		}
	}
}

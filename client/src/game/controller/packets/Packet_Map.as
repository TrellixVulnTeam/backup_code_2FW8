package game.controller.packets
{
	import com.cong.utils.StringUtil;

	import game.data.house.BuildInfo;

	import laya.utils.Byte;
	import laya.utils.Dictionary;

	public class Packet_Map
	{
		public function Packet_Map()
		{
		}

		/**
		 * 5003
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
		public static function getMapInfo(obj:Object, byte:Byte):void
		{
//			byte.writeFloat64(obj.centerX);
//			byte.writeFloat64(obj.centerY);
			byte.writeInt32(obj.centerX*1000000);
			byte.writeInt32(obj.centerY*1000000);
			console.log(obj.centerX*1000000,obj.centerY*1000000);
		}


		/**
		 * 5004返回地图路径
		 */
		public static function getMapInfoRet_part5004(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.centerX = byte.getFloat64();
			obj.centerY = byte.getFloat64();
			obj.startX = byte.getFloat64();
			obj.startY = byte.getFloat64();
			obj.endX = byte.getFloat64();
			obj.endY = byte.getFloat64();
			obj.routeStr = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				obj.routeStr.push(byte.getUTFString());
			}
			return obj;
		}


		/**
		 * 5009返回地图建筑点
		 */
		public static function getMapInfoRet_part5009(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.centerX = byte.getFloat64();
			obj.centerY = byte.getFloat64();
			obj.builds = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var buildInfo:BuildInfo = new BuildInfo();
				buildInfo.id = byte.getUTFString();
				buildInfo.name = byte.getUTFString();
				byte.getUTFString();
				buildInfo.typeCode = byte.getUTFString();
				if (buildInfo.typeCode.length == 5)
				{
					buildInfo.typeCode = "0" + buildInfo.typeCode;
				}
				buildInfo.xPos = byte.getFloat64();
				buildInfo.yPos = byte.getFloat64();
				buildInfo.isCreated = byte.getByte();
				buildInfo.skinId = byte.getInt32();
				obj.builds.push(buildInfo);
			}
			return obj;
		}

		public static function getMapInfoRet_part5010(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.events = new Dictionary();
			var len = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var key:String = byte.getUTFString();
//				var elen:int = byte.getUint16();
//				var value:Array = new Array();
//				for (var j:int = 0; j < elen; j++)
//				{
//					value.push(byte.getInt32());
//				}
				var valueStr:String = byte.getUTFString();
				var value:Array = [];
				if(valueStr!=""){
					value = valueStr.split(";");
				}
				obj.events.set(key, value);
			}
			return obj;
		}

		public static function getMapInfoRet_part5040(byte:Byte):Object
		{
			var obj = new Object();
			obj.players = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var player:Object = {};
				player.userId = byte.getInt32();
				player.name = byte.getUTFString();
				player.userImg = byte.getInt32();
				player.sex = byte.getInt32();
				player.level = byte.getInt32();
				player.startX=byte.getFloat64();
				player.startY = byte.getFloat64();
				player.startEventIndex = byte.getInt32();
				player.endX=byte.getFloat64();
				player.endY = byte.getFloat64();
				obj.players.push(player);
			}
			return obj;
		}

		/**
		 * 5007 丢骰子
		 /// <summary>
		 /// 当前X坐标位置
		 /// </summary>
		 public int CurrentXPoint = 0;
		 /// <summary>
		 /// 当前Y坐标位置
		 /// </summary>
		 public int CurrentYPoint = 0;
		 */
		public static function castDice(obj:Object, byte:Byte):void
		{
			byte.writeInt32(obj.xPoint*1000000);
			byte.writeInt32(obj.yPoint*1000000);
		}

		/**
		 * 5008返回丢骰子状态
		 /// 0=成功 1=失败(体力值不够) 2=钱不够
		 public byte Code = 0;
		 /// 点数
		 public int PointNum = 0;
		 /// 当前体力值
		 public int CurrentPowerValue = 0;
		 /// 更新体力值时间点
		 public string RefreshPowerValueTime = "";
		 /// 返回当前地图路线两点间事件id
		 public List<MTPSEInfo> CurrentWalkRouteList = new List<MTPSEInfo>();
		 /// 停留点事件Id
		 public int EventID = 0;
		 /// 产生的体力点
		 public int PowerValue = 0;
		 /// 产生费用
		 public int Money = 0;
		 /// 产生的经验
		 public int Exp = 0;
		 /// 产生的钻石
		 public int Diamonds = 0;
		 /// 神灵状态（事件状态,剩余步数）
		 public string GodsState = "";
		 /// 停止点
		 public int StopNum = 0;

		 */
		public static function castDiceRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.pointNum = byte.getInt32();
			obj.curPower = byte.getInt32();
			obj.refreshPowerTime = StringUtil.stringToTime(byte.getUTFString());
			obj.walkRoute = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var MTPSEInfo = new Object();
				MTPSEInfo.TwoPointStr = byte.getUTFString();
//				MTPSEInfo.events = [];
//				var slen:int = byte.getUint16();
//				for (var j:int = 0; j < slen; j++)
//				{
//					MTPSEInfo.events.push(byte.getInt32());
//				}
				var eventStr:String = byte.getUTFString();
				var events:Array = [];
				if(eventStr!=""){
					events = eventStr.split(";");
				}
				MTPSEInfo.events = events;
				obj.walkRoute.push(MTPSEInfo);
			}
			obj.eventId = byte.getInt32();
			obj.power = byte.getInt32();
			obj.money = byte.getInt32();
			obj.exp = byte.getInt32();
			obj.diamonds = byte.getInt32();
			obj.godState = byte.getUTFString();
			obj.stayIndex = byte.getInt32();
			return obj;
		}


		/**
		 * 5008返回丢骰子状态
		 /// 0=成功 1=失败(体力值不够)
		 public byte Code = 0;
		 /// 点数
		 public int PointNum = 0;
		 /// 体力值
		 public int PowerValue = 0;
		 /// 更新体力值时间点
		 public string RefreshPowerValueTime = "";
		 /// 用户行走路线
		 public string CurrentWalkRoute = "";
		 */
		public static function createBuilding(obj:Object, byte:Byte):void
		{
			byte.writeUTFString(obj.id);
		}

		/**
		 * 5008返回丢骰子状态
		 /// 0=成功 1=失败(体力值不够)
		 public byte Code = 0;
		 /// 点数
		 public int PointNum = 0;
		 /// 体力值
		 public int PowerValue = 0;
		 /// 更新体力值时间点
		 public string RefreshPowerValueTime = "";
		 /// 用户行走路线
		 public string CurrentWalkRoute = "";
		 */
		public static function createBuildingRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			return obj;
		}

		//5013 设置建筑外观
		public static function setBuildSkin(obj:Object, byte:Byte):void
		{
			byte.writeUTFString(obj.id);
			byte.writeInt32(obj.skinId);
		}

		//5014返回设置建筑外观状态
		public static function csetBuildSkinRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			return obj;
		}

		//5021 NPC特殊事件后续选择
		/// 选择结果 0=是，1=否
		public static function npcEventSelect(obj:Object, byte:Byte):void
		{
			byte.writeInt32(obj.select);
		}

		/**
		 * 5022 返回NPC特殊事件后续选择结果
		 /// 0=成功 1=无后续事件选择 2=上传数据有误
		 public byte Code = 0;
		 /// 当前体力值
		 public int CurrentPowerValue = 0;
		 /// 更新体力值时间点
		 public string RefreshPowerValueTime = "";
		 /// 停留点事件Id
		 public int EventID = 0;
		 /// 产生的体力点
		 public int PowerValue = 0;
		 /// 产生费用
		 public int Money = 0;
		 /// 产生的经验
		 public int Exp = 0;
		 /// 产生的钻石
		 public int Diamonds = 0;
		 * @param byte
		 * @return
		 */
		public static function npcEventSelectRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.curPower = byte.getInt32();
			obj.refreshPowerTime = StringUtil.stringToTime(byte.getUTFString());
			obj.eventId = byte.getInt32();
			obj.power = byte.getInt32();
			obj.money = byte.getInt32();
			obj.exp = byte.getInt32();
			obj.diamonds = byte.getInt32();
			return obj;
		}

		/**
		 * 5028 返回重新定位位置信息

		 /// <summary>
		 /// 0=成功 1=不进行处理
		 /// </summary>
		 public byte Code = 0;
		 /// <summary>
		 /// 起点X坐标
		 /// </summary>
		 public double StartXPoint = 0;
		 /// <summary>
		 /// 起点Y坐标
		 /// </summary>
		 public double StartYPoint = 0;
		 /// <summary>
		 /// 终点X坐标
		 /// </summary>
		 public double EndXPoint = 0;
		 /// <summary>
		 /// 终点Y坐标
		 /// </summary>
		 public double EndYPoint = 0;
		 /// <summary>
		 /// 当前X坐标
		 /// </summary>
		 public double CurrentXPoint = 0;
		 /// <summary>
		 /// 当前Y坐标
		 /// </summary>
		 public double CurrentYPoint = 0;
		 /// <summary>
		 /// 停留点位置
		 /// </summary>
		 public int StopEventNum = 0;
		 */
		public static function relocationRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.readByte();
			obj.startX = byte.getFloat64();
			obj.startY = byte.getFloat64();
			obj.endX = byte.getFloat64();
			obj.endY = byte.getFloat64();
			obj.xPoint = byte.getFloat64();
			obj.yPoint = byte.getFloat64();
			obj.eventIndex = byte.getInt32();
			obj.toPointX = byte.getFloat64();
			obj.toPointY = byte.getFloat64();
			return obj;
		}

		/**
		 * 5039 下发当前地图玩家活动数据
		 /// <summary>
		 /// 用户id
		 /// </summary>
		 public int UserId = 0;
		 /// <summary>
		 /// 起始X坐标
		 /// </summary>
		 public double StartXPoint = 0;
		 /// <summary>
		 /// 起始Y坐标
		 /// </summary>
		 public double StartYPoint = 0;
		 /// <summary>
		 /// 起始停留点
		 /// </summary>
		 public int StartStopEventPoint = 0;
		 /// <summary>
		 /// 终点X坐标
		 /// </summary>
		 public double EndXPoint = 0;
		 /// <summary>
		 /// 终点Y坐标
		 /// </summary>
		 public double EndYPoint = 0;
		 /// <summary>
		 /// 终点停留点
		 /// </summary>
		 public int EndStopEventPoint = 0;
		 * @param byte
		 * @return
		 */
		public static function  syncOtherPlayer(byte:Byte):Object
		{
			var obj:Object = {};
			obj.userId = byte.getInt32();
			obj.startX=byte.getFloat64();
			obj.startY = byte.getFloat64();
			obj.startEventIndex = byte.getInt32();
			obj.endX=byte.getFloat64();
			obj.endY = byte.getFloat64();
			obj.endEventIndex = byte.getInt32();
			obj.walkRoute = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var MTPSEInfo = new Object();
				MTPSEInfo.TwoPointStr = byte.getUTFString();
//				MTPSEInfo.events = [];
//				var slen:int = byte.getUint16();
//				for (var j:int = 0; j < slen; j++)
//				{
//					MTPSEInfo.events.push(byte.getInt32());
//				}
				var eventStr:String = byte.getUTFString();
				var events:Array = [];
				if(eventStr!=""){
					events = eventStr.split(",");
				}
				MTPSEInfo.events = events;
				obj.walkRoute.push(MTPSEInfo);
			}
			return obj;
		}
	}
}

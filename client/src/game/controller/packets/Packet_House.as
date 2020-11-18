package game.controller.packets
{
	import com.cong.utils.StringUtil;

	import game.config.ConfigBuyer;

	import game.data.estate.CustomerInfo;
	import game.data.estate.WorkerInfo;
	import game.data.house.FloorInfo;

	import laya.utils.Byte;

	public class Packet_House
	{
		public function Packet_House()
		{
		}

		/**
		 *5017 取房产楼层信息
		 /// 房产ID
		 public string HouseId = "";
		 */
		public static function getHouseFloorInfo(obj:Object, byte:Byte)
		{
			byte.writeUTFString(obj.houseId);
		}

		/**
		 * 5018 返回房产楼层信息
		 /// 房产楼层信息
		 public List<HInfo> HouseFloorObj = new List<HInfo>();
		 */
		public static function getHouseFloorInfoRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.floors = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var floor:FloorInfo = new FloorInfo();
				floor.id = byte.getInt32();
				floor.level = byte.getInt32();
				floor.landlordId = byte.getInt32();
				floor.landlordName = byte.getUTFString();
				floor.tenantId = byte.getInt32();
				floor.tenantName = byte.getUTFString();
				floor.LZId = byte.getInt32();
				floor.LZName = byte.getUTFString();
				floor.buyMoney = byte.getInt32();
				floor.sellMoney = byte.getInt32();
//				floor.UPSMDate = byte.getUTFString();
				floor.shopType = byte.getInt32();
				floor.lastGainTime = StringUtil.stringToTime(byte.getUTFString());
				floor.lastGainTime_rent = StringUtil.stringToTime(byte.getUTFString());
				floor.workerId = byte.getInt32();
				if (floor.shopType)
				{
					if (floor.tenantId) floor.LZId = floor.tenantId; else floor.LZId = floor.landlordId;
				}
				obj.floors.push(floor);
			}
			return obj;
		}

		/**
		 * 5019 房产楼层操作
		 ///1=修改卖出价格 2=购买楼层 3=租住楼层 4=解除租住楼层 5=入住（只能住宅楼）
		 public int Operation = 0;
		 /// 房产ID
		 public string HouseId = "";
		 /// 房产楼层id
		 public int FloorId = 0;
		 /// 卖出价格
		 public int SellMoney = 0;
		 /// 开店铺类型ID
		 public int ShopTypeID = 0;
		 */
		public static function operHouseFloor(obj:Object, byte:Byte)
		{
			byte.writeInt32(obj.operType);
			byte.writeUTFString(obj.houseId);
			byte.writeInt32(obj.floorId);
			byte.writeInt32(obj.sellMoney);
			byte.writeInt32(obj.shopType);
		}

		/**
		 * 5020 返回房产楼层操作状态
		 /// 0=成功 1=钱不够 2=一周只能修改一次 3=上传数据不对 4=入住只能是住宅楼 5=操作类型不对 6=价格已变化 7=已被人入住 8=出售价格不对
		 public int Code = 0;
		 */
		public static function operHouseFloorRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.getInt32();
			return obj;
		}

		/**
		 * 5029 取顾客列表
		 /// 取房产ID
		 public string HouseID = "";
		 /// 楼层ID
		 public int FloorID = 0;
		 */
		public static function getFloorCusotmers(obj:Object, byte:Byte)
		{
			byte.writeUTFString(obj.houseId);
			byte.writeInt32(obj.floorId);
		}

		/**
		 * 5030 返回顾客列表
		 /// 刷新顾客时间
		 public string AddBestTime = "";
		 /// 顾客列表
		 public List<BuyerInfo> BuyerList = new List<BuyerInfo>();
		 */
		public static function getFloorCustomersRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.refreshTime = byte.getUTFString();
			obj.customers = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var customer:CustomerInfo = new CustomerInfo();
//				customer.id = byte.getInt32();
				customer.type = byte.getInt32();
				customer.rewordType = byte.getInt32();
				if(customer.rewordType == 0){
					customer.bestValue = byte.getInt32();
				}else{
					customer.rewordValue = byte.getInt32();
				}
				var config:Object = ConfigBuyer.getBuyerById(customer.type);
				if(config){
					customer.power = config.Power;
					customer.intelligence = config.Intelligence;
					customer.agile = config.Agile;
					customer.charm = config.Charm;
					customer.name = config.Name;
					customer.quality = config.Quality;
					customer.qualityCoefficient = config.QualityCoefficient;
					customer.bestLimit = config.BestLimit;
				}
				obj.customers.push(customer);
			}
			return obj;
		}

		/**
		 * 5031 顾客满意度更新

		 /// 顾客ID
		 public int ID = 0;
		 */
		public static function addCustomerBest(obj:Object, byte:Byte)
		{
			byte.writeUTFString(obj.houseId);
			byte.writeInt32(obj.floorId);
			byte.writeInt32(obj.id);
		}

		/**
		 * 5032 返回顾客满意度更新
		 /// 0=成功 1=失败
		 public byte Code = 0;
		 */
		public static function addCustomerBestRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.getByte();
			return obj;
		}

		/**
		 /// 操作类型 1=招募 2=上岗
		 public int OperType = 0;
		 /// 顾客ID/员工ID
		 public int ID = 0;
		 /// 取房产ID
		 public string HouseID = "";
		 /// 楼层ID
		 public int FloorID = 0;
		 */
		public static function operWorker(obj:Object, byte:Byte)
		{
			byte.writeInt32(obj.type);
			byte.writeInt32(obj.id);
			byte.writeUTFString(obj.houseId);
			byte.writeInt32(obj.floorId);
		}

		/**
		 * 5034 返回员工操作状态

		 /// 0=成功 1=失败
		 public byte Code = 0;
		 */
		public static function operWorkerRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.code = byte.getByte();
			return obj;
		}


		/**
		 * 5036员工列表
		 * public List<StaffInfo> StaffList = new List<StaffInfo>();
		 */
			public static function getWorkersRet(byte:Byte):Object
		{
			var obj:Object = new Object();
			obj.workers = [];
			var len:int = byte.getUint16();
			for (var i:int = 0; i < len; i++)
			{
				var worker:WorkerInfo = new WorkerInfo();
				worker.type = byte.getInt32();
				worker.exp = byte.getInt32();
//				worker.houseId = byte.getUTFString();
//				worker.floorId = byte.getInt32();
				worker.sgTime = byte.getUTFString();
				worker.shopType = byte.getInt32();
				var config:Object = ConfigBuyer.getBuyerById(worker.type);
				worker.power = config.Power;
				worker.intelligence = config.Intelligence;
				worker.agile = config.Agile;
				worker.charm = config.Charm;
				worker.name = config.Name;
				worker.quality = config.Quality;
				worker.qualityCoefficient = config.QualityCoefficient;
				obj.workers.push(worker);
			}
			return obj;
		}

		/**
		 * 5037 取员工信息
		 /// 楼层所有者ID
		 public int UserID = 0;
		 /// 员工ID
		 public int StaffID = 0;
		 */
		public static function getWorkerInfo(obj:Object, byte:Byte)
		{
			byte.writeInt32(obj.userId);
			byte.writeInt32(obj.workerId);
		}

		public static function getWorkerInfoRet(byte:Byte):WorkerInfo
		{
			var worker:WorkerInfo = new WorkerInfo();
			worker.type = byte.getInt32();
			worker.exp =  byte.getInt32();
			var config:Object = ConfigBuyer.getBuyerById(worker.type);
			worker.power = config.Power;
			worker.intelligence = config.Intelligence;
			worker.agile = config.Agile;
			worker.charm = config.Charm;
			worker.name = config.Name;
			worker.quality = config.Quality;
			worker.qualityCoefficient = config.QualityCoefficient;
			return worker;
		}
	}
}

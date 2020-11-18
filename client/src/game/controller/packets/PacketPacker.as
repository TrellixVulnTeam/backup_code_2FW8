package game.controller.packets
{
	import com.cong.net.SocketPacket;
	import com.cong.utils.CacheManager;
	import com.cong.utils.Console;

	import game.constants.CONST_CMD;
	import game.controller.packets.Packet_House;

	public class PacketPacker
	{
		private static var _sPackFunctions:Object;

//		private static var _sPackSnsFunctions:Object;

		private static function registerPackFunctions():void
		{
			_sPackFunctions = {};
			//帐号服务器
			_sPackFunctions[CONST_CMD.USER_LOGIN] = Packet_User.Login;
			_sPackFunctions[CONST_CMD.ACCESS_TOKEN] = Packet_User.accessToken;
			_sPackFunctions[CONST_CMD.GET_MAPINFO] = Packet_Map.getMapInfo;
			_sPackFunctions[CONST_CMD.MODIFY_USER_INFO] = Packet_User.modifyUserInfo;
			_sPackFunctions[CONST_CMD.CREATE_BUILDING] = Packet_Map.createBuilding;
			_sPackFunctions[CONST_CMD.SET_BUILD_SKIN] = Packet_Map.setBuildSkin;
			_sPackFunctions[CONST_CMD.GET_HOUSE_INFO] = Packet_House.getHouseFloorInfo;
			_sPackFunctions[CONST_CMD.HOUSE_FLOOR_OPER] = Packet_House.operHouseFloor;
			_sPackFunctions[CONST_CMD.NPC_EVENT_SELECT] = Packet_Map.npcEventSelect;
			_sPackFunctions[CONST_CMD.GET_FLOOR_CUSTOMERS] = Packet_House.getFloorCusotmers;
			_sPackFunctions[CONST_CMD.ADD_CUSTOMER_BEST]= Packet_House.addCustomerBest;
			_sPackFunctions[CONST_CMD.OPER_WORKER]= Packet_House.operWorker;
			_sPackFunctions[CONST_CMD.GET_WORKER_INFO]= Packet_House.getWorkerInfo;
			_sPackFunctions[CONST_CMD.CAST_DICE] = Packet_Map.castDice;


//			/****************小游戏****************/
			_sPackFunctions[CONST_CMD.MINI_GAME_DATA] = Packet_Minigame.miniGameData;
			_sPackFunctions[CONST_CMD.GET_MINI_GAME_REWARD] = Packet_Minigame.getMiniGameReward;
//			_sPackFunctions[CONST_CMD.MOVE_ACTOR] = Packet_Map.moveActor;
		}

		/**<在C_XXX单例 内注册发送到服务器 的打包函数>*/
		public static function registerPackFun(msgId:int, packFun:Function):void
		{
			if (null == _sPackFunctions)
			{
				registerPackFunctions();
			}
			_sPackFunctions[msgId] = packFun;
		}

		public static function pack(id_:uint, data_:Object = null):SocketPacket
		{
			if (null == _sPackFunctions)
			{
				registerPackFunctions();
			}
			var packet:SocketPacket = CacheManager.instance.create(SocketPacket);
			packet.clear();
			packet.initData();
			console.log(JSON.stringify(data_));
			_sPackFunctions[id_](data_, packet.data);
//			while(packet.data.length%4!=0)
//			{
//				packet.data.writeByte(0);
//			}
			return packet;
		}
	}
}

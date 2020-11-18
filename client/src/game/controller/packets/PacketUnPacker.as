package game.controller.packets
{
	import game.constants.CONST_CMD;

	import laya.utils.Byte;

	/**
	 * 解包处理器
	 */
	public class PacketUnPacker
	{
		private static var _sUnpackFunctions:Object;

		private static function registerUnpackFunctions():void
		{
			_sUnpackFunctions={};
			_sUnpackFunctions[CONST_CMD.LOGIN_RET] = Packet_User.LoginRet;
			_sUnpackFunctions[CONST_CMD.ACCESS_TOKEN_RET] = Packet_User.accessTokenRet;
			_sUnpackFunctions[CONST_CMD.GET_MAPINFO_RET_PART5004] = Packet_Map.getMapInfoRet_part5004;
			_sUnpackFunctions[CONST_CMD.GET_MAPINFO_RET_PART5009] = Packet_Map.getMapInfoRet_part5009;
			_sUnpackFunctions[CONST_CMD.GET_MAPINFO_RET_PART5010] = Packet_Map.getMapInfoRet_part5010;
			_sUnpackFunctions[CONST_CMD.GET_MAPINFO_RET_PART5040] = Packet_Map.getMapInfoRet_part5040;
			_sUnpackFunctions[CONST_CMD.MODIFY_USER_INFO_RET] = Packet_User.modifyUserInfoRet;
			_sUnpackFunctions[CONST_CMD.GET_USER_INFO_RET] = Packet_User.getUserInfoRet;
			_sUnpackFunctions[CONST_CMD.CAST_DICE_RET] = Packet_Map.castDiceRet;
			_sUnpackFunctions[CONST_CMD.CREATE_BUILDING_RET] = Packet_Map.createBuildingRet;
			_sUnpackFunctions[CONST_CMD.SET_BUILD_SKIN_RET] = Packet_Map.csetBuildSkinRet;
			_sUnpackFunctions[CONST_CMD.GET_USER_HOUSE_LIST_RET] = Packet_User.getHouseListRet;
			_sUnpackFunctions[CONST_CMD.GET_HOUSE_INFO_RET] = Packet_House.getHouseFloorInfoRet;
			_sUnpackFunctions[CONST_CMD.HOUSE_FLOOR_OPER_RET] = Packet_House.operHouseFloorRet;
			_sUnpackFunctions[CONST_CMD.NPC_EVENT_SELECT_RET] = Packet_Map.npcEventSelectRet;
			_sUnpackFunctions[CONST_CMD.GET_FLOOR_CUSTOMERS_RET] = Packet_House.getFloorCustomersRet;
			_sUnpackFunctions[CONST_CMD.ADD_CUSTOMER_BEST_RET]= Packet_House.addCustomerBestRet;
			_sUnpackFunctions[CONST_CMD.OPER_WORKER_RET]= Packet_House.operWorkerRet;
			_sUnpackFunctions[CONST_CMD.GET_WORKERS_RET]= Packet_House.getWorkersRet;
			_sUnpackFunctions[CONST_CMD.GET_WORKER_INFO_RET]= Packet_House.getWorkerInfoRet;
			_sUnpackFunctions[CONST_CMD.RELOCATION_RET]= Packet_Map.relocationRet;
			_sUnpackFunctions[CONST_CMD.SYNC_OTHER_PLAYER] = Packet_Map.syncOtherPlayer;
			/****************小游戏****************/
			_sUnpackFunctions[CONST_CMD.MINI_GAME_DATA_RET] = Packet_Minigame.miniGameDataRet;
			_sUnpackFunctions[CONST_CMD.GET_MINI_GAME_REWARD_RET] = Packet_Minigame.getMiniGameRewardRet;

//			_sUnpackFunctions[CONST_CMD.MOVE_ACTOR_RET] = Packet_Map.moveActorRet;
		}

		public static function registerUnPackFun(msgId:int, unPackFun:Function):void
		{
			if (null == _sUnpackFunctions)
			{
				registerUnpackFunctions();
			}
			_sUnpackFunctions[msgId]=unPackFun;
		}

		/**
		 * 解包
		 * @param	id_ 消息id
		 * @param	bytes_ 消息数据
		 * @return  解包的结果
		 */
		public static function unpack(id_:uint, bytes_:Byte=null):Object
		{
			//var timer1:Number = Browser.now();
			if (null == _sUnpackFunctions)
			{
				registerUnpackFunctions();
			}

			if (null == bytes_ || bytes_.bytesAvailable <= 0)
			{
				return null;
			}

			if (!_sUnpackFunctions.hasOwnProperty(id_.toString()))
			{
				if (1 == bytes_.bytesAvailable)
				{
					return {"ret": bytes_.getUint8()};
				}
				else
				{
					return null;
				}
			}

			var obj:Object=_sUnpackFunctions[id_](bytes_);
			return obj;
		}

	}
}

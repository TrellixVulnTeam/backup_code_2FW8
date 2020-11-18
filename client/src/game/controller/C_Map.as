package game.controller
{
	import com.cong.events.EventCenter;
	import com.cong.net.HttpRequestExt;
	import com.cong.net.Network;
	import com.cong.utils.Console;

	import game.config.ConfigServer;
	import game.constants.CONST_CMD;
	import game.constants.CONST_CMD;
	import game.constants.CONST_EVENT;
	import game.data.D_Game;
	import game.data.D_Map;
	import game.str.Language;

	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.utils.Dictionary;
	import laya.utils.Handler;

	public class C_Map
	{
		public function C_Map()
		{
			Network.addHandler(this, CONST_CMD.GET_MAPINFO_RET_PART5004, getMapRouteRet);
			Network.addHandler(this, CONST_CMD.GET_MAPINFO_RET_PART5009, getMapBuildsRet);
			Network.addHandler(this, CONST_CMD.GET_MAPINFO_RET_PART5010, getMapStayPointRet);
			Network.addHandler(this, CONST_CMD.GET_MAPINFO_RET_PART5040,syncOtherPlayers);
			Network.addHandler(this, CONST_CMD.CAST_DICE_RET, castDiceRet);
			Network.addHandler(this, CONST_CMD.CREATE_BUILDING, createBuild);
			Network.addHandler(this, CONST_CMD.CREATE_BUILDING_RET, createBuildingRet);
			Network.addHandler(this, CONST_CMD.SET_BUILD_SKIN_RET, setBuildSkinRet);
			Network.addHandler(this, CONST_CMD.NPC_EVENT_SELECT_RET, selectNPCEventRet);
			Network.addHandler(this, CONST_CMD.RELOCATION_RET,relocationRet);
//			Network.addHandler(this,CONST_CMD.MOVE_ACTOR_RET,moveActorRet);
			Network.addHandler(this, CONST_CMD.SYNC_OTHER_PLAYER,syncOtherPlayer);
		}

		private function syncOtherPlayers(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SYNC_OTHER_PLAYERS,obj);
		}

		private function syncOtherPlayer(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SYNC_OTHER_PLAYER,obj);
		}

		private function setBuildSkinRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.UPDATE_BUILD_INFO, {buildId: _buildId, skinId: _skinId});
			} else if (obj.code == 1)
			{
				C_UI.instance.alert(Language.PERMISSIONS_LIMIT);
			} else if (obj.code == 2)
			{
				C_UI.instance.alert(Language.BUILD_NO_CREATEED);
			} else if (obj.code == 3)
			{
				C_UI.instance.alert(Language.DIAMOND_NOT_ENOUGH);
			}
		}

		private var _buildId:String;
		private var _skinId:int;

		public function setBuildSKin(buildId:String, skinId:int):void
		{
			_buildId = buildId;
			_skinId = skinId;
			Network.send(CONST_CMD.SET_BUILD_SKIN, {id: buildId, skinId: skinId});
		}

		public function createBuild(id:String):void
		{
			Network.send(CONST_CMD.CREATE_BUILDING, {id: id});
		}

		private function createBuildingRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.CREATE_BUILDING_SUCCESS);
			} else if (obj.code == 1)
			{
				C_UI.instance.alert(Language.BUILD_NOTEXIST);
			} else if (obj.code == 2)
			{
				C_UI.instance.alert(Language.BUILD_ALREADY_CREATED);
			} else if (obj.code == 3)
			{
				C_UI.instance.alert(Language.DIAMOND_NOT_ENOUGH);
			} else if (obj.code == 4)
			{
				C_UI.instance.alert(Language.CONFIG_ERROR);
			}
		}

		private function getMapRouteRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.SET_MAP_ROUTE, obj);
			}
		}


		private function castDiceRet(obj:Object):void
		{
			if (!obj.code)
			{
				D_Game.instance.updatePower(obj.power);
				D_Game.instance.updateMoney(obj.money);
				D_Game.instance.updateExp(obj.exp);
				D_Game.instance.updateDiamond(obj.diamonds);
				EventCenter.ins.event(CONST_EVENT.CAST_DICE_RET, obj);
			}else if (obj.code == 1)
			{
				C_UI.instance.alert(Language.POWER_NET_ENOUGH);
			} else if (obj.code == 2)
			{
				C_UI.instance.alert(Language.MONEY_NOT_ENOUGH);
			}
		}

		private static var _instance:C_Map;
		public static function get instance():C_Map
		{
			if (null == _instance)
			{
				_instance = new C_Map();
			}
			return _instance;
		}

		public function getPath(oriLng:Number, oriLat:Number, desLng:Number, desLat:Number, callback:Handler):void
		{
			var http:HttpRequest = new HttpRequest();
			http.once(Event.COMPLETE, this, function (data) {
				var obj:Object = JSON.parse(data);
				if (obj["route"])
				{
					callback.runWith([obj["route"]["paths"][0]["steps"]]);
				}
			});
			http.send("https://restapi.amap.com/v3/direction/walking?origin=" + oriLng + "," + oriLat + "&destination=" + desLng + "," + desLat + "&key=473c96d84e105e419d76068d9a3a4926");
		}

		public function getMapInfo(centerX:Number, centerY:Number):void
		{
			Network.send(CONST_CMD.GET_MAPINFO, {centerX: centerX, centerY: centerY});
		}

		public function refreshMapInfo()
		{
			var center = __JS__("getMapCenter()");
			getMapInfo(center.lng, center.lat);
		}

		private function getMapBuildsRet(obj:Object):void
		{
			if (obj.code == 0)
			{
//				D_Game.instance.bu
				EventCenter.ins.event(CONST_EVENT.SET_MAP_BUILDS, obj);
			}
		}

		private function getMapStayPointRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.SET_MAP_STAY_POINT, obj);
			}
		}

		public function castDice(xPoint:Number,yPoint:Number):void
		{
			Network.send(CONST_CMD.CAST_DICE,{xPoint:xPoint,yPoint:yPoint});
		}

//		public function moveActor(xPos:Number,yPos:Number):void
//		{
//			Network.send(CONST_CMD.MOVE_ACTOR,{xPos:xPos,yPos:yPos});
//		}

		private function moveActorRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				EventCenter.ins.event(CONST_EVENT.UPDATE_USER_RES, obj.power);
				EventCenter.ins.event(CONST_EVENT.MOVE_ACTOR_RET, obj);
			}
		}

		//http获取导航路线
		private var backCount:int = 0;
		public function getMapNavRoutes_http(routeArr:Array, callback:Handler = null)
		{
			//防止多次同时请求
			if (backCount)
			{
				return;
			}
			var navRoutes:Dictionary = new Dictionary();
			for (var i:int = 0; i < routeArr.length; i++)
			{
				getNavRote(routeArr[i]);
			}
			function getNavRote(routeStr:String):void
			{
				var param:Object = {RouteStr: routeStr};
				new HttpRequestExt().request(ConfigServer.httpAddr + "/default.aspx?RouteStr=" + routeStr, param, Handler.create(this, function (arr:Array) {
					for (var i:int = 0; i < arr.length; i++)
					{
						var key:String = arr[i].TwoPointStr;
						var polyLen:int = arr[i].Rute.length;
						var polyline:String = "";
						for (var j:int = 0; j < polyLen; j++)
						{
							if (j == 0)
							{
								polyline = key.split("|")[0] + ";";
							}
							polyline += arr[i].Rute[j] + ";";
							if (j == polyLen - 1)
							{
								polyline += key.split("|")[1];
							}
						}
						D_Map.instance.navRoutes.set(key, polyline);
						navRoutes.set(key,polyline);
					}
					backCount++;
					if (backCount == routeArr.length)
					{
						if (!callback)
						{
							console.log(navRoutes);
							EventCenter.ins.event(CONST_EVENT.SET_MAP_NAVROUTES, navRoutes);
						} else
						{
							callback.runWith(D_Map.instance.navRoutes);
						}
						backCount = 0;
					}
				}));
			}
		}

		/// 选择结果 0=是，1=否
		public function selectNPCEvent(select:int){
			Network.send(CONST_CMD.NPC_EVENT_SELECT,{select:select});
		}

		private function selectNPCEventRet(obj:Object){
			if (!obj.code)
			{
				D_Game.instance.updatePower(obj.power);
				D_Game.instance.updateMoney(obj.money);
				D_Game.instance.updateExp(obj.exp);
				D_Game.instance.updateDiamond(obj.diamonds);
				EventCenter.ins.event(CONST_EVENT.UPDATE_USER_RES);
				EventCenter.ins.event(CONST_EVENT.NPC_EVENT_RESULT,obj);
			} else
			{
				C_UI.instance.alert(Language.ERRCODE_5022[obj.code]);
			}
		}

		public function relocation(){
			Network.send(CONST_CMD.RELOCATION);
		}

		private function relocationRet(obj:Object){
			if(obj.code == 0){
				EventCenter.ins.event(CONST_EVENT.RELOCATION,obj);
			}else{
				console.log("不进行处理重定位")
			}
		}
	}
}

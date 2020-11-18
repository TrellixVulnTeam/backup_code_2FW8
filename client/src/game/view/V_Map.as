package game.view
{
	import com.cong.components.HScrollText;
	import com.cong.display.TextureFont;
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.GraphicsUtil;

	import game.config.ConfigNotice;
	import game.constants.CONST_EVENT;
	import game.constants.CONST_FILE;
	import game.controller.C_Map;
	import game.controller.C_UI;
	import game.controller.C_User;
	import game.data.D_Game;
	import game.data.D_Map;
	import game.data.vo.UserInfo;
	import game.view.map.Dice;
	import game.view.map.MapLayer;
	import game.view.map.minigame.V_MagicTouch;
	import game.view.map.minigame.V_RollLottery;
	import game.view.map.minigame.V_StackBlock;

	import laya.events.Event;
	import laya.utils.ClassUtils;
	import laya.utils.Dictionary;
	import laya.utils.Dragging;

	import ui.MapUI;

	public class V_Map extends MapUI implements IView
	{
		private var dragIng:Dragging;
		private var dice:Dice;
		private var mapInited:Boolean = false;  //地图是否初始化完毕
		private var scrollText:HScrollText;      //滚动播放公告
		//用来记录地图累计偏移
		public var mapOrigX:Number;
		public var mapOrigY:Number;

		public function V_Map()
		{
			map = new MapLayer(width, Laya.stage.height);
			dice = new Dice();
			dice.x = Laya.stage.width / 2;
//			dice.visible = false;
			box_dice.addChild(dice);
			box_dice.y = Laya.stage.height - 300 - box_dice.height;
			addChildAt(map, 0);
			dragIng = new Dragging();
//			__JS__("loadMap()");
			C_User.instance.getUserInfo();
//			setMapEnabld();

			scrollText = new HScrollText(900);
			scrollText.scrollbg = scrollbg;
			scrollText.y = scrollbg.y + 10;
			scrollText.x = (Laya.stage.width - 900) / 2;
			scrollText.pushText(ConfigNotice.getRandNotice());
			addChild(scrollText);
		}

		public function showCityName(obj){
			V_Map.instance.txt_city.text = obj.city.slice(0,-1);
		}

		private function pushRanAnno():void
		{
			scrollText.pushText(ConfigNotice.getRandNotice());
		}

		override public function set visible(value:Boolean):void
		{
		}

		private static var _instance:V_Map;
		public static function get instance():V_Map
		{
			if (!_instance)
			{
				_instance = new V_Map();
			}
			return _instance;
		}

		private var map:MapLayer;

		public function setMapBuilds(obj:Object):void
		{
			map.setBuildingData(obj.builds);
		}


		private var _mapX:Number;
		private var _mapY:Number;

		private function onMouseDown():void
		{
			_mapX = map.x;
			_mapY = map.y;
			dragIng.start(map, null, true, 0, 0, null, false);
		}

		private function onDragMove(e:Event):void
		{
			var offsetX:Number = map.x - _mapX;
			var offsetY:Number = map.y - _mapY;
			_mapX = map.x;
			_mapY = map.y;
			moveMapBy(offsetX, offsetY);
			if (Math.abs(map.x - mapOrigX) >= Laya.stage.height * 0.5 || Math.abs(map.y - mapOrigY) >= Laya.stage.height * 0.5)
			{
				refreshMapInfo();
			}
		}

		public function moveMapBy(offsetX:Number, offsetY:Number, refreshMap:Boolean = true)
		{
			if (Math.abs(map.x - mapOrigX) >= Laya.stage.height || Math.abs(map.y - mapOrigY) >= Laya.stage.height)
			{
				if (refreshMap) refreshMapInfo();
			}
			__JS__("moveMapBy(offsetX*D_Game.clientScale,offsetY*D_Game.clientScale)");
		}

		public function moveMapTo(offsetX:Number, offsetY:Number)
		{
			__JS__("moveMapTo(offsetX*D_Game.clientScale,offsetY*D_Game.clientScale)");
		}

		public function setMapCenter(lng:Number, lat:Number):void
		{
			__JS__("setCenter(lng,lat)");
		}

		private function zoomMap()
		{
//			var timer:CTimer = new CTimer(300, 10, Handler.create(this, setZoom, null, false));
//			timer.start();
		}

		private function setZoom():void
		{
			__JS__("zoomOut()");
		}

		public function onShow():void
		{
			if (mapInited) setMapEnabld();
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_1.on(Event.CLICK, this, oclick1);
			btn_2.on(Event.CLICK, this, oclick2);
			btn_3.on(Event.CLICK, this, oclick3);
			btn_4.on(Event.CLICK, this, oclick4);
			btn_5.on(Event.CLICK, this, oclick5);
			btn_6.on(Event.CLICK, this, oclick6);
			btn_7.on(Event.CLICK, this, oclick7);
			btn_8.on(Event.CLICK, this, oclick8);
			btn_search.on(Event.CLICK, this, oclick9);
			EventCenter.ins.on(CONST_EVENT.SET_MAP_ROUTE, this, setMapRoute);
			EventCenter.ins.on(CONST_EVENT.SET_MAP_BUILDS, this, setMapBuilds);
			EventCenter.ins.on(CONST_EVENT.SET_MAP_STAY_POINT, this, setMapStayPoint);
			EventCenter.ins.on(CONST_EVENT.SET_MAP_NAVROUTES, this, setMapNavRoutes);
			EventCenter.ins.on(CONST_EVENT.SYNC_OTHER_PLAYERS, this, syncOtherPlayers);
			EventCenter.ins.on(CONST_EVENT.SYNC_OTHER_PLAYER, this, syncOtherPlayer);
			EventCenter.ins.on(CONST_EVENT.CAST_DICE_RET, this, castDiceRet);
//			EventCenter.ins.on(CONST_EVENT.MOVE_ACTOR_RET,this,moveActorRet);
			EventCenter.ins.on(CONST_EVENT.GET_USER_INFO_RET, this, getUserInfoRet);
			EventCenter.ins.on(CONST_EVENT.UPDATE_USER_INFO, this, updateUserInfo);
			EventCenter.ins.on(CONST_EVENT.CREATE_BUILDING_SUCCESS, this, refreshMapInfo);
			EventCenter.ins.on(CONST_EVENT.UPDATE_BUILD_INFO, this, updateBuildInfo);
			EventCenter.ins.on(CONST_EVENT.EVENT_HANDLE_COM, this, showActorSpeak);
			map.on("move_complete", this, moveActorCom);
			map.on("move_step", this, moveActorStep);
			EventCenter.ins.on(CONST_EVENT.RELOCATION, this, onRelocation);
			Laya.timer.loop(30000, this, pushRanAnno);
			scrollText.run();
		}

		private function showActorSpeak():void
		{
			map.showSpeak();
		}

		private var autoDice:Boolean = false;
		private function oclick9():Function
		{
			autoDice=!autoDice;
		}

		private function syncOtherPlayer(obj:Object):void
		{
			map.setOtherPlayer2(obj);
		}

		private var otherPlayers:Array;
		private function syncOtherPlayers(obj:Object):void
		{
			otherPlayers = obj.players;
		}

		private function onRelocation(obj:Object):void
		{
			map.setStartAndEnd(obj.startX, obj.startY, obj.endX, obj.endY);
			map.reposCenter(obj.xPoint, obj.yPoint);
			map.setEventIndex(obj.toPointX,obj.toPointY,obj.eventIndex);
			moveActorCom();
		}

		private function updateUserInfo():void
		{
			console.log("updateUserInfo");
			map.actor.type = D_Game.instance.userInfo.userImg;
		}

		private function moveActorStep():void
		{
			TextureFont.drawText(CONST_FILE.getNumFont("num2"), map.pointNum.toString(), txt_leftPoints, 0, 0, "center", txt_leftPoints.width, 2);
		}

		private function setMapStayPoint(obj:Object):void
		{
			map.setStayPoint(obj.events);
			if (routeArr.length)
			{
				var reqArr:Array = [];
				for (var i:int = 0; i < routeArr.length; i++)
				{
					var splitarr:Array = routeArr[i].split("|");
					for (var j:int = 0; j < splitarr.length - 1; j++)
					{
						if (!D_Map.instance.navRoutes.get(splitarr[j] + "|" + splitarr[j + 1]))
						{
							reqArr.push(splitarr[j] + "|" + splitarr[j + 1]);
						}
					}
				}
				if (reqArr.length) C_Map.instance.getMapNavRoutes_http(reqArr); else setMapNavRoutes(new Dictionary());
			}
		}

		private function updateBuildInfo(obj:Object):void
		{
			map.updateBuildInfo(obj);
		}

		private function refreshMapInfo():void
		{
			C_Map.instance.refreshMapInfo();
			mapOrigX = map.x;
			mapOrigY = map.y;
		}

		//地图路径返回
		private var routeArr:Array;

		private function setMapRoute(obj:Object):void
		{
			map.setStartAndEnd(obj.startX, obj.startY, obj.endX, obj.endY);
			routeArr = obj.routeStr;
		}

		private function onDragEnd(e:Event):void
		{

		}

		//设置地图导航数据
		private function setMapNavRoutes(navRoutes:Dictionary):void
		{
			map.setNavRouteData(navRoutes);
			map.setOtherPlayers(otherPlayers);
			//移到停留点
			var userInfo:UserInfo = D_Game.instance.userInfo;
			if (userInfo.initEventIndex)
			{
				map.setEventIndex(userInfo.toPointX,userInfo.toPointY,userInfo.initEventIndex);
				userInfo.initEventIndex = 0;
				refreshMapInfo();
			}
			setMapEnabld();
			if (!mapInited) mapInited = true;
		}

		private var isWalking = false;

		private function setMapEnabld()
		{
			if (!isWalking)
			{
				this.on(Event.MOUSE_DOWN, this, onMouseDown);
				dice.on(Event.CLICK, this, castDice);
				dice.disabled = false;
				dice.on(Event.COMPLETE, this, dicePlayCom);
				map.on(Event.DRAG_MOVE, this, onDragMove);
				map.on(Event.DRAG_END, this, onDragEnd);
				map.on(Event.DRAG_START, this, onDragStart);
				map.mouseEnabled = true;
			}
		}

		private function onDragStart():void
		{
			if (isNaN(mapOrigX))
			{
				mapOrigX = map.x;
				mapOrigY = map.y;
			}
		}

		private function getUserInfoRet(userInfo:UserInfo):void
		{
			map.moveCenter(userInfo.xPoint, userInfo.yPoint);
			__JS__("getCity(this.showCityName)");
			if (userInfo.godState != "") map.actor.addBuffer(userInfo.godState.split(",")[0]);
			V_Top.instance.setUserInfo(userInfo);
			C_Map.instance.getMapInfo(userInfo.xPoint, userInfo.yPoint);
			if (!userInfo.sex)
			{
				C_UI.instance.showCreateRole();
			}
		}

		private function moveActorCom():void
		{
			isWalking = false;
			setMapEnabld();
			if (Math.abs(map.x - mapOrigX) >= Laya.stage.height * 0.5 || Math.abs(map.y - mapOrigY) >= Laya.stage.height * 0.5)
			{
				refreshMapInfo();
			}
			EventCenter.ins.event(CONST_EVENT.UPDATE_USER_RES);
			TextureFont.drawText(CONST_FILE.getNumFont("num2"), "0", txt_leftPoints, 0, 0, "center", txt_leftPoints.width, 2);
			if(autoDice){
				castDice();
			}
		}

		private function oclick8():void
		{
			UIManager.instance.showPanel(V_StackBlock.instance);
		}

		private function oclick7():void
		{
			UIManager.instance.popUpWindow(new V_RollLottery());
		}

		private function oclick6():void
		{
			UIManager.instance.showPanel(new V_MagicTouch());
		}

		private function oclick4():void
		{
			C_UI.instance.showMarket();
		}

		private function oclick5():void
		{
			C_UI.instance.showEstate();
		}

		private function oclick3():void
		{
		}

		private function oclick2():void
		{
			C_UI.instance.showNews();
		}

		private function oclick1():void
		{
//			C_UI.instance.showBuff();c_hou
			C_UI.instance.showCreateRole();
		}

		private function dicePlayCom():void
		{
			Laya.timer.once(1000, this, hideDice);
			if (walkData.pointNum == 0)
			{
				setMapEnabld();
			} else
			{
				TextureFont.drawText(CONST_FILE.getNumFont("num2"), walkData.pointNum.toString(), txt_leftPoints, 0, 0, "center", txt_leftPoints.width, 2);
				map.movePath();
			}
		}

		private var walkData:Object;
		private function castDiceRet(obj:Object):void
		{
			dice.castDice(obj.pointNum);
			walkData = obj;
			map.walkData = walkData;
			refreshMapInfo();
		}

		private function hideDice():void
		{
			if (!dice.isPlaying)
			{
//				dice.visible = false;
			}
		}

		//投掷骰子
		private function castDice():void
		{
			dice.visible = true;
			Laya.timer.clear(dice, hideDice);
			this.off(Event.MOUSE_DOWN, this, onMouseDown);
			map.mouseEnabled = false;
			map.off(Event.DRAG_MOVE, this, onDragMove);
			dragIng.stop();
			dice.off(Event.CLICK, this, castDice);
			dice.disabled = true;
			isWalking = true;
			var center = __JS__("getMapCenter()");
			C_Map.instance.castDice(center.lng, center.lat);
		}

		public function removeAllListeners():void
		{
//			EventCenter.ins.off(CONST_EVENT.GET_USER_INFO_RET, this, getUserInfoRet);
			EventCenter.ins.on(CONST_EVENT.EVENT_HANDLE_COM, this, showActorSpeak);
			this.off(Event.MOUSE_DOWN, this, onMouseDown);
			map.off(Event.DRAG_MOVE, this, onDragMove);
			Laya.stage.off(Event.MOUSE_MOVE, this, onDragMove);
//			dice.off(Event.COMPLETE, this, dicePlayCom);
			dice.off(Event.CLICK, this, castDice);
			Laya.timer.clear(this, pushRanAnno);
			scrollText.stop();
		}
	}
}

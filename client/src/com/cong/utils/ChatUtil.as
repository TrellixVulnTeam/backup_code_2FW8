package com.cong.utils
{
import cong.utils.*;
	import flash.display.DisplayObject;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	import laya.events.Event;
	import laya.maths.Point;

	public class ChatUtil
	{

		public static const PRIVATE_MAGIC:String = "                                               ";
		public static const PRIVATE_MAGIC_LEN:int = 46;
		public static const COLON:String = "： ";
		public static const MINHSYS:int = 40;
		public static const MINHOUT:int = 130;
		public static const MINWSYS:int = 335;
		public static const MINWOUT:int = 280;
		public static const MAXHOUT:int = 400;
		public static const MAXWSYS:int = 800;
		public static const MAXWOUT:int = 800;
		public static const _DEBUG_RANGE:Boolean = false;
		public static const DEFAULT_MSG:String = "CHAT_PANEL_DEFAULT";
		public static const DEFAULT_IPUT:String = "CHAT_PANEL_INPUT_DEFAULT";
		public static const DEFAULT_GENTLE:String = "CHAT_PANEL_INPUT_QINGYU";
		public static const UN_KNOW:String = "CHAT_C_UNKNOW";
		public static const WORLD_TALK_NEED_LEVEL:int = 50;
		public static const UNION_TALK_NEED_LEVEL:int = 48;
		public static const NORMAL_TALK_NEED_LEVEL:int = 48;
		public static const MAX_INPUT_SIZE:int = 100;
		public static const WINDOW_MAX_INPUT_SIZE:int = 200;
		public static const CHAT_TALK_NEED_LEVEL:int = 48;
		public static const MAX_NAME_SIZE:int = 20;
		public static const MAX_CHATWINDOW_AMOUNT:int = 5;
		public static const MAX_CHAT_RECORD:int = 100;
		public static const LAST_PRIVATE_NUM:int = 5;
		public static const LAST_INFO_NUM:int = 5;
		public static const CHUANYIN_INFO_NUM:int = 4;
		public static const CHUANYIN_LEVEL:int = 55;
		public static const CHAT_PANEL_POSX:int = 42;
		public static const MAX_LINE_ALL:int = 70;
		public static const MAX_LINE_WORLD:int = 50;
		public static const MAX_LINE_FACTION:int = 40;
		public static const MAX_LINE_TEAM:int = 30;
		public static const MAX_LINE_PRIVATE_MAX:int = 1000;
		public static const MAX_LINE_PRIVATE:int = 20;
		public static const HINT_TIME_STEP:int = 600;
		public static const MAX_LINE_SYSTEM:int = 20;
		public static const MAX_LINE_TRADE:int = 30;
		public static const MAX_LINE_NORMAL:int = 20;
		public static const MAX_LINE_CHUANYIN:int = 20;
		public static const ChatCoolDown:Array = [5000, 15000, 15000, 5000, 5000, 5000, 15000, 0, 15000];
		private static const _chatTypeName:Vector.<String> = Vector.<String>(["CHAT_TYPE_ALL", "CHAT_TYPE_WORLD", "CHAT_TYPE_UNION", "CHAT_TYPE_NORMAL", "CHAT_TYPE_GUILD", "CHAT_TYPE_TEAM", "CHAT_TYPE_CHUANYIN", "CHAT_TYPE_SYSTEM", "CHAT_TYPE_TRADE", "CHAT_TYPE_NOW", "CHAT_TYPE_PRIVATE", "PM"]);
		public static const VIPFLAG:String = "     ";
		public static const IMGTYPE_VIP:int = 0;
		public static const QQLVFLAG:String = "     ";
		public static const QQYEARFLAG:String = "     ";
		public static const IMGTYPE_QQVIP:int = 1;
		public static const IMGTYPE_QQYEAR:int = 2;
		public static const GMFLAG:String = "[GM]";
		public static const CHAT_TYPE_NOW_NAMES:String = "CHAT_TYPE_NOW_NAMES";
		public static const CHUANYIN_HOLD_TIME:int = 30;
		public static const CHUANYIN_SIZE:int = 33;
		public static const CHUANYIN_DIS:int = 10;
		public static const CHUANYIN_VDIS:int = 1;
		public static const QINGBOSS_MAR:String = "        ";
		public static const BOSS_KING:String = "CHAT_T_KING";
		public static const BOSS_QUEEN:String = "CHAT_T_HOU";
		public static const BOSS_WB:String = "CHAT_T_BANG";
		public static const BOSS_WSCZ:String = "CHAT_T_WSCZ";
		public static const BOSS_WANGBANG:String = "BOSS_WANGBANG";
		private static const BOSS_YS:String = "CHAT_T_YUSHI";
		private static const BOSS_MALE_LOVER:String = "CHAT_T_QINHOU";
		private static const BOSS_FEMALE_LOVER:String = "CHAT_T_WHOU";
		public static const ITEM_REPLACE:String = "{goods}";
		public static const TITLE_REPLACE:String = "{$@title@$}";
		public static const LINK_PARAMS:String = "|";
		public static const CHAT_POP_MAX_SIZE:int = 240;

		public static var CHAT_COLORS:Vector.<uint>;
		public static var CHAT_COLORSTR:Vector.<String>;
		private static var talkerTypeHash:HashMap;
		public static var INPUT_POS_X:int = 5;
		public static var INPUT_POS_Y:int = 5;
		public static var INPUT_W:int = 192;
		public static var INPUT_H:int = 42;
		private static var s_sheet:StyleSheet = null;
		public static var NOUNION_INDEX:int = -999;
		public static var FACE_SIZE:int = 18;
		public static var FACE_HALF_SIZE:int = 12;
		public static var FACE_AMOUNT:int = 35;
		public static var DIAMOND_AMOUNT:int = 10;
		public static var MOOD_MAX_LEN:int = 35;
		public static var NAME_COLOR:String = "#cc9957";
		private static var chanelSystem:String = "CHAT_TYPE_SYSTEM";

		private static function initColorUint():void
		{
			CHAT_COLORS = new Vector.<uint>();
			CHAT_COLORS.push(14604487, 14594343, 15892446, 14604487, 2269504, 3645139, 15034896, 14425347, 14315734);
		}

		private static function initColorStr():void
		{
			CHAT_COLORSTR = new Vector.<String>();
			CHAT_COLORSTR.push("#ded8c7", "#deb127", "#f27fde", "#ded8c7", "#22a140", "#379ed3", "#e56a10", "#dc1d03", "#da70d6");
		}

		private static function initTalkerTypeHash():HashMap
		{
			var _local_1:HashMap = new HashMap();
			_local_1.put(1, {"name": getCHint("CHAT_T_KING"), "color": "#a64df9"});
			_local_1.put(2, {"name": getCHint("CHAT_T_HOU"), "color": "#a64df9"});
			_local_1.put(3, {"name": getCHint("CHAT_T_WSCZ"), "color": "#508cd2"});
			_local_1.put(4, {"name": getCHint("BOSS_WANGBANG"), "color": "#508cd2"});
			_local_1.put(5, {"name": getCHint("CHAT_T_YUSHI"), "color": "#508cd2"});
			_local_1.put(6, {"name": getCHint("CHAT_T_BANG"), "color": "#3bde1b"});
			_local_1.put(101, {"name": getCHint("CHAT_T_QINHOU"), "color": "#d863d8"});
			_local_1.put(102, {"name": getCHint("CHAT_T_WHOU"), "color": "#d863d8"});
			return (_local_1);
		}

		public static function checkGetTalkerType(info:String):*
		{
			var _local_4:int;
			if (talkerTypeHash == null)
			{
				talkerTypeHash = initTalkerTypeHash();
			}

			var _local_2:Array = talkerTypeHash.values();
			var _local_3:int = _local_2.length;
			while (_local_4 < _local_3)
			{
				if (info.indexOf(_local_2[_local_4].name) == 0)
				{
					return (_local_2[_local_4]);
				}

				_local_4++;
			}

			return (null);
		}

		public static function getTalkChannelName(id:int):String
		{
			if (id < chatTypeName.length)
			{
				return (getCHint(chatTypeName[id]));
			}

			return (getCHint("CHAT_C_UNKNOW"));
		}

		public static function getTalkChannelPrefix(id:int):String
		{
//            if (id == 11){
//                return ("[PM]");
//            };
//            if (id == 9){
//                return ((("[" + Mgr.chatMgr.getNowChannelName()) + "]"));
//            };
//            if (id < chatTypeName.length){
//                return ((("[" + getCHint(chatTypeName[id])) + "]"));
//            };
//            return ((("[" + getCHint("CHAT_C_UNKNOW")) + "]"));
			return ""
		}

		public static function getMonsterChatHead(id:int):String
		{
			return (TextUtil.getHtmlStr((("[" + getCHint("RESURRECTIONPANELEXT_MONSTER")) + "]"), getTalkChannelColorStr(id)));
		}

		public static function getTalkChannelPrefixHtml(id:int):String
		{
			return (TextUtil.getHtmlStr(getTalkChannelPrefix(id), getTalkChannelColorStr(id)));
		}

		public static function getTalkChannelColor(id:int):uint
		{
			if (CHAT_COLORS == null)
			{
				initColorUint();
			}

			if (id < CHAT_COLORS.length)
			{
				return (CHAT_COLORS[id]);
			}

			return (14604487);
		}

		public static function getTalkChannelColorStr(id:int):String
		{
			if (CHAT_COLORSTR == null)
			{
				initColorStr();
			}

			if (id < CHAT_COLORSTR.length)
			{
				return (CHAT_COLORSTR[id]);
			}

			return ("#ded8c7");
		}

		public static function getTalkInfoChannelType(info:String):int
		{
			var _local_3:String = null;
			var _local_4:int;
			var _local_2:int = ChatUtil.chatTypeName.length;
			while (_local_4 < _local_2)
			{
				_local_3 = ChatUtil.getTalkChannelPrefix(_local_4);
				if (info.indexOf(_local_3) == 0)
				{
					return (_local_4);
				}

				_local_4++;
			}

			return (-1);
		}

		public static function getTextToTalkChannel(info:String):int
		{
			var _local_2:String = null;
			if (info.length > 2)
			{
				_local_2 = info.substr(0, 2);
				if (_local_2 == "!@")
				{
					return (1);
				}

				if (_local_2 == "/")
				{
					return (10);
				}

				if (_local_2 == "!!")
				{
					return (5);
				}

				if (_local_2 == "!~")
				{
					return (4);
				}

				if (_local_2 == "!#")
				{
					return (6);
				}

			}

			if (info.length > 1)
			{
				_local_2 = info.substr(0, 1);
				if (_local_2 == "!")
				{
					return (3);
				}

			}

			return (-1);
		}

		public static function getDefLinkStyle():StyleSheet
		{
			if (s_sheet == null)
			{
				s_sheet = new StyleSheet();
				s_sheet.setStyle("a:link", {"textDecoration": "underline", "fontSize": "12"});
				s_sheet.setStyle("a:hover", {
					"textDecoration": "underline",
					"color": "#ee2211",
					"display": "block",
					"fontSize": "12"
				});
				s_sheet.setStyle("a:active", {"textDecoration": "underline", "fontSize": "12"});
			}

			return (s_sheet);
		}

		public static function doLinkStr(info:String):void
		{
//            var _local_2:Number;
//            var _local_6 = null;
//            var _local_3:int;
//            var _local_8 = null;
//            if ((((info == null)) || ((info == "")))){
//                return;
//            };
//            var _local_5:int;
//            var _local_4:Array = info.split(LINK_PARAMS);
//            var _local_7:int = parseInt(_local_4.shift());
//            switch (_local_7){
//                case 1:
//                    if (_local_4.length >= 3){
//                        _local_5 = _local_4[2];
//                        if (_local_5 == 0){
//                            _local_2 = _local_4[0];
//                            if (_local_2 == Mgr.mainPlayer.id){
//                                Mgr.uiMgr.showHidePanelByType(PlayerPanelExt);
//                            }
//                            else {
//                                Mgr.otherHeroMgr.reqMsgReqOtherHero(_local_2);
//                            };
//                        }
//                        else {
//                            if (_local_5 == 1){
//                                Mgr.acvieMenuMgr.showMenu(_local_4[0], null, _local_4[1]);
//                            };
//                        };
//                    };
//                    return;
//                case 2:
//                    if (_local_4.length >= 3){
//                        _local_5 = _local_4[0];
//                        _local_6 = Mgr.mapMgr.getMapVo(_local_5);
//                        if (_local_6 != null){
//                            Mgr.findPathMgr.startFindPath(_local_5, new Point(_local_4[1], _local_4[2]));
//                        }
//                        else {
//                            (Console.traceDebug("地图不存在！"));
//                        };
//                    };
//                    return;
//                case 3:
//                    if (_local_4.length >= 2){
//                        Mgr.chatMgr.showFixItemTips(_local_4[0], _local_4[1]);
//                    };
//                    return;
//                case 25:
//                    if (_local_4.length >= 2){
//                        Mgr.guildMgr.showGuildItemTips(_local_4[0], _local_4[1]);
//                    };
//                    return;
//                case 4:
//                    if (_local_4.length >= 3){
//                        _local_3 = _local_4[2];
//                        if (_local_3 == 0){
//                            (_local_3 == Mgr.mapMgr.curSceneId);
//                        };
//                        _local_8 = (Mgr.objMgr.getObjectV(_local_4[3]) as BasePlayerV);
//                        if (_local_8 != null){
//                            Mgr.curTargetHeadMgr.setFocus(_local_8);
//                        }
//                        else {
//                            Mgr.hintMgr.addFloatingTextInfo(getCHint("CHAT_CLICK_OUTSEE"), 5);
//                        };
//                    };
//                    return;
//                case 19:
//                    Mgr.stallsMgr.showBuyPanelFromChat(_local_4[4], _local_4[5], _local_4[0], _local_4[1], _local_4[2], Mgr.chatMgr.getTradeItem(_local_4[3]), _local_4[6]);
//                    return;
//                case 21:
//                    Mgr.chatMgr.runtoTheMap(_local_4[0], _local_4[1], _local_4[2], _local_4[3]);
//                    return;
//                case 22:
//                    Mgr.copyMixMgr.joinOneTeamFromChat(_local_4[0]);
//                    return;
//                case 16:
//                    if (_local_4.length >= 1){
//                        GlobalFunction.openUrl(_local_4[0]);
//                    };
//                    return;
//                case 23:
//                    if (_local_4.length >= 1){
//                        Mgr.chatMgr.clickChatFunHandler(_local_4);
//                    };
//                    return;
//                case 24:
//                    if (_local_4.length >= 1){
//                        Mgr.chatMgr.showTitleFixTips(_local_4[0], _local_4[1], _local_4[2], _local_4[3]);
//                    };
//                    return;
//            };
		}

		public static function createNameLink(nameInfo:String, chaterID:Number, dd:int = 0, sInfo:String = null):String
		{
			var _local_6:String = nameInfo;
			if (sInfo != null)
			{
				_local_6 = sInfo;
			}

			if (chaterID <= 0)
			{
				return (TextUtil.getHtmlStr(_local_6, "#e59507"));
			}

			var _local_5:String = "LookPlayer" + LINK_PARAMS + chaterID + LINK_PARAMS + nameInfo + LINK_PARAMS + dd.toString();
			return (TextUtil.getHtmlStr(TextUtil.createLinkStr(_local_5, _local_6), "#e59507"));
		}

		public static function createMapLink(mapID:int, px:Number, py:Number, line:int = -1):String
		{
//            var _local_7:String = getCHint("CHAT_UNKNOW_MAPID");
//            var _local_6:MapVO = Mgr.mapMgr.getMapVo(mapID);
//            if (_local_6 != null){
//                _local_7 = (("[" + _local_6.sceneName) + "]");
//            };
//            if (line > 0){
//                _local_7 = (_local_7 + (line + getCHint("TEAM_LINE_STR")));
//            };
//            _local_7 = (_local_7 + ((((((" " + getCHint("CHAT_M_POS")) + "(") + px) + "，") + py) + ")"));
//            var _local_8:String = (((((((2).toString() + LINK_PARAMS) + mapID) + LINK_PARAMS) + px) + LINK_PARAMS) + py);
//            if (line > 0){
//                _local_8 = (_local_8 + (LINK_PARAMS + line));
//            };
//            var _local_5:String = TextUtil.createLinkStr(_local_8, _local_7);
//            return (TextUtil.getHtmlStr(_local_5, "#3bde1b"));
			return ""
		}

		public static function createHeroPosLink(mapName:String, mapID:int, px:int, py:int, pLine:int):String
		{
			var _local_8:String = (((((((((21).toString() + LINK_PARAMS) + mapID) + LINK_PARAMS) + px) + LINK_PARAMS) + py) + LINK_PARAMS) + pLine);
			var _local_6:String = (((((mapName + "[") + px) + ",") + py) + "]");
			var _local_7:String = TextUtil.createLinkStr(_local_8, _local_6);
			return ((TextUtil.getHtmlStr(_local_7, "#508cd2") + "#chatFly"));
		}

		private static function createItemLink(itemName:String, itemInfo:String):String
		{
			var _local_4:String = (((3).toString() + LINK_PARAMS) + itemInfo);
			var _local_3:String = "<u>";
			_local_3 = (_local_3 + (((('<A HREF="event:' + _local_4) + '">[') + itemName) + "] </A>"));
			return ((_local_3 + "</u>"));
		}

		public static function createItemLinkInput(itemNameStr:String, idInfo:String, index:int):String
		{
			var _local_5:String = (((((3).toString() + LINK_PARAMS) + idInfo) + LINK_PARAMS) + index.toString());
			var _local_4:String = (((('<A HREF="event:' + _local_5) + '">[') + itemNameStr) + "] </A>");
			return (_local_4);
		}

		public static function createGuildItemLink(itemNameStr:String, idInfo:String, index:int):String
		{
			var _local_5:String = (((((25).toString() + LINK_PARAMS) + idInfo) + LINK_PARAMS) + index.toString());
			var _local_4:String = (((('<A HREF="event:' + _local_5) + '">[') + itemNameStr) + "] </A>");
			return (_local_4);
		}

		public static function createTitleLinkInput(itemNameStr:String, id:int, hasGot:Boolean, ownerName:String, isForShow:Boolean = false):String
		{
			var _local_7:String = (((((((((24).toString() + LINK_PARAMS) + id) + LINK_PARAMS) + itemNameStr) + LINK_PARAMS) + ((hasGot) ? "1" : "0")) + LINK_PARAMS) + ownerName);
			var _local_6:String = "";
			_local_6 = (_local_6 + "<u>");
			if (!isForShow)
			{
				_local_6 = (_local_6 + (((('<A HREF="event:' + _local_7) + '">[') + itemNameStr) + "] </A>"));
			} else
			{
				_local_6 = (_local_6 + (((('<A HREF="event:' + _local_7) + '">【') + itemNameStr) + "】 </A>"));
			}

			_local_6 = (_local_6 + "</u>");
			return (_local_6);
		}

		public static function createNetLink(showName:String, showUrl:String):String
		{
			showUrl = (((16).toString() + LINK_PARAMS) + showUrl);
			return ((((('<A HREF="event:' + showUrl) + '">') + showName) + "</A>"));
		}

		public static function createTradeBuyLink(itemType:int, price:int, amount:int, itemID:Number, sellerID:Number, stallsID:Number, sellerName:String):String
		{
			var _local_8:String = (((((((((((((((19).toString() + LINK_PARAMS) + itemType) + LINK_PARAMS) + price) + LINK_PARAMS) + amount) + LINK_PARAMS) + itemID) + LINK_PARAMS) + sellerID) + LINK_PARAMS) + stallsID) + LINK_PARAMS) + sellerName);
			var _local_9:String = (((((('<A HREF="event:' + _local_8) + '">') + "<u>") + TextUtil.getHtmlStr((("[" + getCHint("STALLS_BUY")) + "]"), "#3bde1b")) + "</u>") + "</A>");
			return (_local_9);
		}

		public static function createTradeInfoLink(showName:String, showUrl:String):String
		{
			showUrl = (((20).toString() + LINK_PARAMS) + showUrl);
			return ((((('<A HREF="event:' + showUrl) + '">') + showName) + "</A>"));
		}

		public static function createCopyJoinLink(info:String, teamInfo:String):String
		{
			var _local_3:String = (((22).toString() + LINK_PARAMS) + teamInfo);
			return ((((('<A HREF="event:' + _local_3) + '">') + TextUtil.getHtmlStr((" " + info), "#3bde1b", 12, true, "", false, true)) + "</A>"));
		}

		public static function createChatFunLink(funName:String, funType:String, funColor:String, linkList:Array):String
		{
			var _local_8:int;
			var _local_7:String = "";
			var _local_6:int = linkList.length;
			_local_8 = 0;
			while (_local_8 < _local_6)
			{
				_local_7 = (_local_7 + (LINK_PARAMS + linkList[_local_8]));
				_local_8++;
			}

			var _local_5:String = (((23 + LINK_PARAMS) + funType) + _local_7);
			return ((((('<A HREF="event:' + _local_5) + '">') + TextUtil.getHtmlStr((" " + funName), funColor, 12, false, "", false, true)) + "</A>"));
		}

		public static function createVIPPointLink(vipPoint:int, vipPoint2:int):String
		{
			var _local_4:String = (((((15).toString() + LINK_PARAMS) + vipPoint.toString()) + LINK_PARAMS) + vipPoint2.toString());
			return (((((('<u><A HREF="event:' + _local_4) + '">') + "VIP") + "</A>") + "</u>"));
		}

		public static function createGuideLink(gdObj:Object):String
		{
			var _local_2:String = "";
			var _local_3:String = "";
			switch (gdObj.idx)
			{
				case 1:
				case 2:
					_local_2 = (((((15).toString() + LINK_PARAMS) + gdObj.viplv.toString()) + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = "VIP";
					break;
				case 3:
					_local_2 = (((100).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_HORSE");
					break;
				case 4:
					_local_2 = (((101).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_STONE");
					break;
				case 5:
					_local_2 = (((101).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_JSTONE");
					break;
				case 6:
					_local_2 = (((115).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_HSTONE");
					break;
				case 7:
				case 21:
					_local_2 = (((102).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_EQUIP");
					break;
				case 8:
					break;
				case 9:
					_local_2 = (((103).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_HUN");
					break;
				case 10:
					_local_2 = (((107).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GET");
					break;
				case 11:
					_local_2 = (((104).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_PITCH");
					break;
				case 13:
					_local_2 = (((106).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_JIHUO");
					break;
				case 15:
				case 24:
				case 26:
					_local_2 = (((108).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GET");
					break;
				case 16:
				case 25:
				case 27:
					_local_2 = (((109).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GET");
					break;
				case 17:
					_local_2 = (((110).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_FNTASK");
					break;
				case 19:
					_local_2 = (((112).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_FKTASK");
					break;
				case 20:
					_local_2 = (((114).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GET");
					break;
				case 22:
					_local_2 = (((104).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GPEQUIP");
					break;
				case 23:
					_local_2 = (((116).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_GET");
					break;
				case 28:
					_local_2 = (((117).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_DEQUIP");
					break;
				case 29:
					_local_2 = (((118).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_UPHORSE");
					break;
				case 30:
					_local_2 = (((119).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = getCHint("CHAT_UP_PRIZE");
					break;
				case 31:
					_local_2 = (((120).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_DETAIL"));
					break;
				case 32:
					_local_2 = (((121).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_JOIN"));
					break;
				case 34:
					_local_2 = (((18).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_JHJJ"));
					break;
				case 35:
					_local_2 = (((122).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_JSBX"));
					break;
				case 36:
					_local_2 = (((18).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_TPJJ"));
					break;
				case 37:
					_local_2 = (((123).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_JMLD"));
					break;
				case 38:
					_local_2 = (((124).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_AQ"));
					break;
				case 39:
					_local_2 = (((125).toString() + LINK_PARAMS) + gdObj.idx.toString());
					_local_3 = LanUtil.getLanStr(getCHint("CHAT_UP_JJAQ"));
			}

			return (TextUtil.createLinkStr(_local_2, _local_3));
		}

		public static function replaceItemToGoods(info:String, itemName:String, isOpposite:Boolean = false):String
		{
			var _local_5:String = null;
			if (isOpposite)
			{
				return (info.replace("{goods}", itemName));
			}

			var _local_4:int = info.indexOf(itemName);
			if (info.charAt((_local_4 - 1)) == "[")
			{
				_local_5 = (info.slice(0, (_local_4 - 1)) + itemName);
			} else
			{
				_local_5 = (info.slice(0, _local_4) + itemName);
			}

			if (info.charAt((_local_4 + itemName.length)) == "]")
			{
				_local_5 = (_local_5 + info.slice(((_local_4 + itemName.length) + 1)));
			} else
			{
				_local_5 = (_local_5 + info.slice((_local_4 + itemName.length)));
			}

			_local_5 = _local_5.replace(itemName, "{goods}");
			return (_local_5);
		}

		public static function createMsgInfoWithItem(msg:String, goodsList:Vector.<S_Item>):String
		{
			var _local_4:S_Item;
			var _local_5:String = null;
			var _local_3:String;
			if (goodsList == null)
			{
				return (msg);
			}

			var _local_7:int = goodsList.length;
			if (_local_7 == 0)
			{
				return (msg);
			}

			var _local_8:int;
			while (_local_8 < _local_7)
			{
				_local_4 = goodsList[_local_8];
//                _local_5 = ((_local_4.itemId + LINK_PARAMS) + _local_4.index);
				_local_3 = createItemLink(_local_4.name, _local_5);

//                _local_6 = TextUtil.numToHtmlC(HtmlUtil.getItemNamecolor(_local_4.quality));
//                _local_3 = TextUtil.getHtmlStr(_local_3, _local_6);
				_local_3 = HtmlUtil.getQualityColor(_local_4.quality, _local_3);
				msg = replaceItemToGoods(msg, _local_3, true);
				_local_8++;
			}

			return (msg);
		}

		public static function replaceTitleToSend(info:String, titleName:String, sendCode:String):String
		{
			var _local_5:String = null;
			var _local_4:int = info.indexOf(titleName);
			if (_local_4 < 0)
			{
				return (info);
			}

			if (info.charAt((_local_4 - 1)) == "[")
			{
				_local_5 = (info.slice(0, (_local_4 - 1)) + titleName);
			} else
			{
				_local_5 = (info.slice(0, _local_4) + titleName);
			}

			if (info.charAt((_local_4 + titleName.length)) == "]")
			{
				_local_5 = (_local_5 + info.slice(((_local_4 + titleName.length) + 1)));
			} else
			{
				_local_5 = (_local_5 + info.slice((_local_4 + titleName.length)));
			}

			_local_5 = _local_5.replace(titleName, (("{$@title@$}" + sendCode) + "{$@title@$}"));
			return (_local_5);
		}

		public static function getTalkMsgName(talkInfo:String):Object
		{
			var _local_10:String = null;
			var _local_5:int;
			var _local_6:int;
			var _local_7:int;
			var _local_4:*;
			var _local_3:String = (("[" + getCHint(chanelSystem)) + "]");
			var _local_2:Object = {};
			_local_2.str = "";
			var _local_8:int;
			var _local_9:int;
			while (_local_9 <= 8)
			{
				_local_10 = getTalkChannelPrefix(_local_9);
				_local_6 = talkInfo.indexOf(_local_10);
				if ((((_local_6 == 0)) && (!((_local_10 == _local_3)))))
				{
					_local_5 = _local_10.length;
					_local_2.begin = _local_5;
					_local_2.mbegin = _local_5;
					talkInfo = talkInfo.substr(_local_5);
					_local_8 = (_local_8 + _local_5);
					_local_7 = talkInfo.indexOf("：");
					if (_local_7 != -1)
					{
						_local_5 = (_local_7 + _local_8);
						_local_2.end = _local_5;
						_local_2.mend = _local_5;
						talkInfo = talkInfo.substr(0, _local_7);
						_local_4 = ChatUtil.checkGetTalkerType(talkInfo);
						if (_local_4 != null)
						{
							_local_5 = _local_4.name.length;
							talkInfo = talkInfo.replace(_local_4.name, "");
							_local_2.begin = (_local_2.begin + _local_5);
							_local_2.mbegin = (_local_2.mbegin + _local_5);
						}

						_local_2.str = clearSpace(talkInfo);
						break;
					}

				}

				_local_9++;
			}

			return (_local_2);
		}

		public static function getDataInfo():String
		{
			var _local_1:Date = new Date();
			var _local_2:String = "";
			_local_2 = (_local_2 + (_local_1.fullYear + "-"));
			_local_2 = (_local_2 + (getLT((_local_1.month + 1)) + "-"));
			_local_2 = (_local_2 + (getLT(_local_1.date) + "   "));
			return ((_local_2 + ((getLT(_local_1.hours) + ":") + getLT(_local_1.minutes))));
		}

		private static function getLT(d:int):String
		{
			if (d < 10)
			{
				return (("0" + d));
			}
			return d + "";
		}

		public static function clearSpaceEnter(info:String):String
		{
			return (clearEnter(clearSpace(info)));
		}

		public static function clearSpace(info:String):String
		{
			var _local_2:RegExp = /^\s*/g;
			var _local_3:RegExp = /\s*$/g;
			return (info.replace(_local_2, "").replace(_local_3, ""));
		}

		public static function clearEnter(info:String):String
		{
			return (info.split("\n").join(""));
		}

		private static function getCHint(key:String):String
		{
//            return (Mgr.textConfig.getStaticStr(key).content);
			return key;
		}

		public static function get chatTypeName():Vector.<String>
		{
			return (_chatTypeName);
		}

		public static function addShowMouseClickSign(btn:DisplayObject):void
		{
			btn.on("mouseOver", this, showClickMouse);
			btn.on("mouseOut", this, showNormalMouse);
		}

		private static function showClickMouse(e:Event = null):void
		{
			MouseIconManager.showClick();
		}

		private static function showNormalMouse(e:Event = null):void
		{
//            Mgr.mouseMgr.cursor = "normal";
			MouseIconManager.showNormal();
		}

		public static function getChatAmount(type:int):int
		{
			switch (type)
			{
				case 0:
					return (70);
				case 1:
				case 2:
					return (50);
				case 4:
					return (40);
				case 5:
					return (30);
				case 7:
					return (20);
				case 8:
					return (30);
				case 3:
					return (20);
				case 6:
					return (20);
				default:
					return (20);
			}

		}

//		public static function getRichRext(rWidth:int, rHeight:int, txtType:String="input"):RichTextArea
//		{
//			var _local_8=null;
//			var _local_7=null;
//			var _local_9:int;
//			var _local_4:RichTextArea=new RichTextArea(rWidth, rHeight);
//			var _local_5:XML=new XML("<root></root>");
//			var _local_6:int=(FACE_AMOUNT + 1);
//			_local_9=1;
//			while (_local_9 < _local_6)
//			{
//				_local_7=(((_local_9) < 10) ? ("0" + _local_9) : _local_9);
//				_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + ("face" + _local_9)) + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + ("#" + _local_7)) + '"')) + "/>"));
//				_local_5=_local_5.appendChild(_local_8);
//				_local_9++;
//			}
//			;
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatVip") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatVip") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_9=0;
//			while (_local_9 < DIAMOND_AMOUNT)
//			{
//				_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + ("chatDiamond" + _local_9)) + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + ("#chatDiamond" + _local_9)) + '"')) + "/>"));
//				_local_5=_local_5.appendChild(_local_8);
//				_local_9++;
//			}
//			;
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatPosFoot") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatPosFoot") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatFly") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatFly") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatKing") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatKing") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatQueen") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatQueen") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatWushuang") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatWushuang") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatWang") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatWang") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatInstructor") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatInstructor") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_8=new (XML)((((((("<icon iconUrl = " + (('"' + "chatBaiduVIP") + '"')) + " iconType = ") + (('"' + "movieClip") + '"')) + " iconStr = ") + (('"' + "#chatBaiduVIP") + '"')) + "/>"));
//			_local_5=_local_5.appendChild(_local_8);
//			_local_4.configXML=_local_5;
//			_local_4.textField.wordWrap=true;
//			_local_4.textField.multiline=true;
//			_local_4.textField.border=false;
//			_local_4.textField.type=txtType;
//			_local_4.defaultTextFormat=getRichTxtFormat(14604487);
//			_local_4.setDefaultFormat();
//			return (_local_4);
//		}

		public static function getRichTxtFormat(rColor:uint, size:int = 12):TextFormat
		{
			var _local_3:TextFormat = new TextFormat();
			_local_3.size = size;
			_local_3.letterSpacing = 1;
			_local_3.leading = 2;
			_local_3.color = rColor;
			return (_local_3);
		}

		public static function getChatStyleSheet():StyleSheet
		{
			var _local_1:StyleSheet = new StyleSheet();
			_local_1.setStyle("a:link", {"textDecoration": "underline", "fontSize": "12"});
			_local_1.setStyle("a:hover", {
				"textDecoration": "underline",
				"color": "#ee2211",
				"display": "block",
				"fontSize": "12"
			});
			_local_1.setStyle("a:active", {"textDecoration": "underline", "fontSize": "12"});
			return (_local_1);
		}

		public static function getFaceAmount(info:String):int
		{
			var _local_4:int;
			var _local_2:int;
			var _local_6:String = info;
			var _local_3:String = "#";
			var _local_5:int = _local_6.indexOf(_local_3);
			while (_local_5 > -1)
			{
				_local_4 = _local_6.charCodeAt(++_local_5);
				if (((!(isNaN(_local_4))) && ((_local_4 <= FACE_AMOUNT))))
				{
					_local_6 = _local_6.substr(_local_5);
					_local_5 = _local_6.indexOf(_local_3);
					_local_2++;
				}

			}

			return (_local_2);
		}

		public static function getPointFromChatInfo(info:String, index:int):Point
		{
			var _local_4:String;
			var _local_5:int;
			info = TextUtil.removeHTMLTag(info);
			_local_5 = (index - 1);
			while (_local_5 >= 0)
			{
				if (info.charAt(_local_5) == "[")
				{
					_local_4 = info.substring((_local_5 + 1), (index - 1));
					break;
				}

				_local_5--;
			}

			var _local_3:Array = _local_4.split(",");
			return (new Point(_local_3[0], _local_3[1]));
		}

		public static function getFaceWidth(info:String, isHalf:Boolean = false):int
		{
			var _local_3:int = (getFaceAmount(info) * FACE_SIZE);
			return (((isHalf) ? (_local_3 >> 1) : _local_3));
		}

	}
}

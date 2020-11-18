package com.cong.externals
{
import cong.externals.*;
	public class JSRequester
	{
		public static var _sIsTencentChecked:Boolean = false;
		public static var _sIsTencent:Boolean = false;
		
		private static var _isChatLvLimti:Object;
//		private static var _getPf:Object;
//		private static var _getSubPf:Object;
//		private static var _getPfkey:Object;
		private static var _clientDirectoryHost:Object;
		private static var _clientDirectoryPort:Object;
//		private static var _getServerId:Object;
//		private static var _getUsername:String;
//		private static var _getGamekey:String;
//		private static var _getCdn:String;
		private static var _IS_RELEASE:Object;
//		private static var _IS_GAMELOADING:Object;
//		private static var _isFCM:Object;
//		private static var _getWanClient:String;
//		private static var _getYY_FM:String;
//		private static var _getXunlei_FM:String;
		private static var _autoAFKTime:int  = -1;
		private static var _autoAFKLevel:int = -1;
//		private static var _hasWeiduan:Object;
		private static var _chatNumLevel:int = -1;
//		private static var _getTimeStamp:Number =-1;
//		private static var _getPartnerId:int = -1;
//		private static var _getSign:String;
//		private static var _getIsAdult:int=-1;
//		private static var _openQzoneScore:Object;
//		private static var _qzoneScoreUrl:String;
//		private static var _openQQHuangZuan:Object;
//		private static var _qqHuangZuanUrl:String;
//		private static var _url37LingPai:String;
//		private static var _urlPPSGift:String;
//		private static var _url7K7KGift:String;
//		private static var _open7K7KGift:Object;
//		private static var _isAutoTask:Object;
//		private static var _urlQQMGJDonghua:String;
//		private static var _TGP_getDownloadUrl:String;
//		private static var _urlDownLoadQQGuanJia:String;
//		private static var _TGP_launchGuideUrl:String;
//		private static var _urlQQMGJManhua:String;
//		private static var _openMHJDingZhi:Object;
//		private static var _openQQGuanJia:Object;
//		private static var _openTGP:Object;
//		private static var _getClientUrl:String;
		private static var _recvChatLevel:int= -1;
//		private static var _isTGPServer:Object;
//		private static var _getLoginSrc:String;
//		private static var _openNameServerActivity:Object;
//		private static var _openQQShuJiaChouJiang:Object;
//		private static var _playerReturnDesc:String;
//		private static var _openYYChoujiangqiandao:Object;
//		private static var _urlYYChoujiangqiandao:String;
//		private static var _urlLeduNiTiWoGai:String;
		
		public static function call(functionName_:String, params_:Array=null):*
		{
			if (ExternalInterface.available)
			{
				var p:Array=[];
				p.push(functionName_);
				if (null != params_)
				{
					p=p.concat(params_);
				}
				var result:*=ExternalInterface.call.apply(null, p);
				var valueStr:String="";
				if (params_ != null)
				{
					for (var i:int=0; i < params_.length; i++)
					{
						if (params_[i] != null)
						{
							valueStr+=params_[i].toString() + ",";
						}
						else
						{
							valueStr+="null" + ",";
						}
					}

					valueStr=valueStr.substr(0, valueStr.length - 1);
				}
				trace(String("调用JS方法：" + functionName_ + "（" + valueStr + "）" + ",返回结果：" + result));
				return result;
			}
		}
		
//		public static function openUrlPay():void
//		{
//			if(ExternalInterface.available)
//			{
//				navigateToURL((call("openUrlPay")),"_blank");
//			}
//			else
//			{
//				FloatTextManager.showMouse(Language_zh_TW.RECHARGE_NOT_OPEN);
//			}
//		}
		
		public static function isChatLvLimti():Boolean
		{
			if(_isChatLvLimti == null)
			{
				if(ExternalInterface.available)
				{
					_isChatLvLimti = call("chatCondition");
				}
				else
				{
					_isChatLvLimti = false;
				}
			}
			
			return _isChatLvLimti;
		}

//		/**
//		 *调用这个方法可以获得玩家的openkey。
//		 * @return
//		 *
//		 */
//		public static function getPf():String
//		{
//			if(_getPf == null)
//			{
//				if (ExternalInterface.available)
//				{
//					_getPf=call("getPf");
//				}
//				else
//				{
//					_getPf = "";
//				}
//			}
//
//			return String(_getPf);
//		}
//
//		/**
//		 *调用这个方法可以获得玩家的子openkey。
//		 * @return
//		 *
//		 */
//		public static function getSubPf():String
//		{
//			if(_getSubPf == null)
//			{
//				if (ExternalInterface.available)
//				{
//					_getSubPf=call("getSubPf");
//				}
//				else
//				{
//					_getSubPf = "";
//				}
//			}
//
//			return String(_getSubPf);
//		}
//
//		/**
//		 * 调用这个方法可以获得玩家的pfkey
//		 * @return
//		 *
//		 */
//		public static function getPfkey():String
//		{
//			if(_getPfkey == null)
//			{
//				if (ExternalInterface.available)
//				{
//					_getPfkey=call("getPfkey");
//					if(_getPfkey == "undefined" || _getPfkey==null)
//					{
//						_getPfkey = "";
//					}
//				}
//				else
//				{
//					_getPfkey =  "";
//				}
//			}
//
//
//			return String(_getPfkey);
//		}

		/**
		 * 获得服务器IP
		 * @return
		 *
		 */
		public static function ClientDirectoryHost():String
		{
			if(_clientDirectoryHost==null)
			{
				if (ExternalInterface.available)
				{
					_clientDirectoryHost=call("getServerIp");
				}
				else
				{
					_clientDirectoryHost = "192.168.1.101";
				}
			}
			
			return String(_clientDirectoryHost);
		}

		/**
		 *调用JS获得端口号
		 * @return
		 *
		 */
		public static function clientDirectoryPort():String
		{
			if(_clientDirectoryPort == null)
			{
				if (ExternalInterface.available)
				{
					_clientDirectoryPort=call("ClientDirectoryPort");
				}
				else
				{
					_clientDirectoryPort = "8002";
				}
			}
			
			
			return String(_clientDirectoryPort);
		}

//		public static function applyJavaScriptAlert(str_:String):void
//		{
//			if (ExternalInterface.available)
//			{
//				call("JsAlert", [str_]);
//			}
//		}
		
//		/**
//		 *防沉迷
//		 * @return
//		 *
//		 */
//		public static function getPreventWallow():Number
//		{
//			if (ExternalInterface.available)
//			{
//				Dd.add("防沉迷的值为fcm====" + call("fcm"));
//				return 1;
//				return call("fcm");
//			}
//
//			return 1;
//		}
//
//		/**
//		 *从JS中获得服务器编号
//		 * @return
//		 *
//		 */
//		public static function getServerId():Object
//		{
//			if(_getServerId==null)
//			{
//				if (ExternalInterface.available)
//				{
//					_getServerId = call("getServerId");
//				}
//				else
//				{
//					_getServerId = "1";
//				}
//			}
//
//			return String(_getServerId);
//		}
//
//		public static function getUsername():String
//		{
//			if(_getUsername==null||_getUsername == "")
//			{
//				if (ExternalInterface.available)
//				{
//					_getUsername =  call("getUsername");
//				}
//				else
//				{
//					_getUsername = "test10";
//				}
//			}
//
//
//			return _getUsername;
//		}
//
//		public static function getGamekey():String
//		{
//			if(_getGamekey==null||_getGamekey == "")
//			{
//				if (ExternalInterface.available)
//				{
//					_getGamekey = call("getGamekey");
//				}
//				else
//				{
//					_getGamekey = "";
//				}
//			}
//
//			return _getGamekey;
//		}
//
//		public static function refreshCurrentWeb():void
//		{
//			if (ExternalInterface.available)
//			{
//				ExternalInterface.call("eval", "location.reload();");
//			}
//		}
//
//		public static function openMHJ():void
//		{
//
//			if (ExternalInterface.available)
//			{
//				navigateToURL((call("openUrlMHJ")),"_blank");
//			}
//		}
//
//		public static function openBBS():void
//		{
////			call("openUrlBBS");
//			if (ExternalInterface.available)
//			{
//				navigateToURL((call("openUrlBBS")),"_blank");
//			}
//		}
//
//		public static function openGM():void
//		{
////			call("openUrlGM");
//			if (ExternalInterface.available)
//			{
//				navigateToURL((call("openUrlGM")),"_blank");
//			}
//		}
//
//		/**
//		 *js读取cdn路径
//		 * @return
//		 *
//		 */
//		public static function getCdnUrl():String
//		{
//			if(_getCdn==null||_getCdn=="")
//			{
//				if (ExternalInterface.available)
//				{
//					_getCdn =  call("getCdn");
//				}
//				else
//				{
//					_getCdn = "";
//				}
//			}
//
//
//			return _getCdn;
//		}
		
		 
			
//		IS_RELEASE = true;
//		IS_GAMELOADING = true;		
//		useStarling =0;
//		isOpenCC = false;
//		isVlogin = false;
//		IS_JS_READ_IP_PORT = true;
//		IS_JS_READ_ACCOUNT=true;
//		IS_JS_READ_SERVERID=true;
//		IS_JS_READ_CHECK_KEY =true;
//		IS_CLIENT_CHECK_ACCOUNT = false;
			
		
		public static function IS_RELEASE():Boolean
		{
			if(_IS_RELEASE==null)
			{
				if (ExternalInterface.available)
				{
					_IS_RELEASE =  call("IS_RELEASE");
				}
				else
				{
					_IS_RELEASE  =false;
				}
			}
			return _IS_RELEASE;
		}
			
//		public static function IS_GAMELOADING():Boolean
//		{
//			if(_IS_GAMELOADING == null)
//			{
//				if (ExternalInterface.available)
//				{
//					_IS_GAMELOADING = call("IS_GAMELOADING");
//				}
//				else
//				{
//					_IS_GAMELOADING = false;
//				}
//			}
//
//			return _IS_GAMELOADING;
//		}
//
//		public static function useStarling():Boolean
//		{
//			if (ExternalInterface.available)
//			{
//				return call("useStarling");
//			}
//			return false;
//		}
//		public static function isOpenCC():Boolean
//		{
//			if (ExternalInterface.available)
//			{
//				return call("isOpenCC");
//			}
//			return false;
//		}
		public static function isVlogin():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("isVlogin");
			}
			return true;
		}	
		
		public static function IS_JS_READ_IP_PORT():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("IS_JS_READ_IP_PORT");
			}
			return false;
		}
		
		public static function IS_JS_READ_ACCOUNT():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("IS_JS_READ_ACCOUNT");
			}
			return false;
		}
		
//		public static function openMobileReward():Boolean
//		{
//			if (ExternalInterface.available)
//			{
//				return call("openMobileReward");
//			}
//			return IS_RELEASE() == false;
//		}
		
		public static function IS_JS_READ_SERVERID():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("IS_JS_READ_SERVERID");
			}
			return false;
		}

		public static function IS_JS_READ_CHECK_KEY():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("IS_JS_READ_CHECK_KEY");
			}
			return false;
		}
		
		public static function IS_CLIENT_CHECK_ACCOUNT():Boolean
		{
			if (ExternalInterface.available)
			{
				return call("IS_CLIENT_CHECK_ACCOUNT");
			}
			return false;
		}
	}
}

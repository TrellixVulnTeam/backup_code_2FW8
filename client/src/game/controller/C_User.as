package game.controller
{
	import com.cong.components.Alert;
	import com.cong.events.EventCenter;
	import com.cong.net.Network;
	import com.cong.utils.Console;

	import game.config.ConfigServer;
	import game.constants.CONST_CMD;
	import game.constants.CONST_EVENT;
	import game.data.D_Game;
	import game.data.vo.UserInfo;
	import game.str.Language;

	import laya.net.LocalStorage;
	import laya.utils.Handler;

	public class C_User
	{
		public function C_User()
		{
			Network.addHandler(this,CONST_CMD.LOGIN_RET,loginRet);
			Network.addHandler(this,CONST_CMD.ACCESS_TOKEN_RET,accessTokenRet);
			Network.addHandler(this,CONST_CMD.MODIFY_USER_INFO_RET,modifyUserInfoRet);
			Network.addHandler(this,CONST_CMD.GET_USER_INFO_RET,getUserInfoRet);
			Network.addHandler(this,CONST_CMD.GET_USER_HOUSE_LIST_RET,getHouseListRet);
		}

		private function getUserInfoRet(obj:UserInfo):void
		{
			D_Game.instance.userInfo = obj;
			EventCenter.ins.event(CONST_EVENT.GET_USER_INFO_RET,obj);
		}

		private function modifyUserInfoRet(obj:Object):void
		{
			if(obj.code == 0){
				EventCenter.ins.event(CONST_EVENT.MODIFY_USER_INFO_RET,obj);
			}else if(obj.code == 1){
				C_UI.instance.alert(Language.MODIFY_USER_INFO_FAILD);
			}
		}

		private static var _instance:C_User;
		public static function get instance():C_User
		{
			if (null == _instance)
			{
				_instance = new C_User();
			}
			return _instance;
		}

		private var un:String;
		public function login(un:String){
			this.un = un;
			Network.send(CONST_CMD.USER_LOGIN,{userid:un});
		}

		private var serverInfo:Object;
		private function loginRet(obj:Object):void
		{
			LocalStorage.setItem("un",un);
			serverInfo = obj;
			Network.send(CONST_CMD.LOGIN_SUCCESS);
			Network.connectServer(obj.serverIP,obj.port, new Handler(this, onConnectGameServer), Network.onConnectionBreak, Network.onConnectionOutTime, Network.onConnectionIOError, Network.onConnectionSecurityError, Network.onReceivePacket);
		}

		public var lng:Number = 0;
		public var lat:Number = 0;
		private function onConnectGameServer():void
		{
//			var center = __JS__("getMapCenter()");
//			lng = center.lng;
//			lat = center.lat;
			Network.keepHeartAlive();
			if(lng&&lng){
				Network.send(CONST_CMD.ACCESS_TOKEN,{token:serverInfo.token,lng:lng,lat:lat});
			}else{
				Laya.timer.once(200,this,function () {
					var center = __JS__("getMapCenter()");
					Network.send(CONST_CMD.ACCESS_TOKEN,{token:serverInfo.token,lng:center.lng,lat:center.lat});
				})
			}
		}

		private function accessTokenRet(obj:Object):void
		{
			console.log(obj.isfirstlogin);
			if(obj.uid<=0){
				Alert.show(Language.USER_NO_EXIST);
			}else{
				EventCenter.ins.event(CONST_EVENT.LOGIN_SUCCESS,obj);
			}
		}

		public function connectAccountServer(onConnect:Handler):void
		{
			Network.connectServer(ConfigServer.host, ConfigServer.port, onConnect, Network.onConnectionBreak, Network.onConnectionOutTime, Network.onConnectionIOError, Network.onConnectionSecurityError, Network.onReceivePacket);
		}

		/**
		 * 修改用户信息
		 * @param OperCode 1=修改用户性别和头像 2=用户昵称
		 * @param UserType  1=男2=女3=男4=女
		 * @param NikeName
		 */
		public function modifyUserInfo(OperCode:int,UserType :int,NikeName:String = ""){
			Network.send(CONST_CMD.MODIFY_USER_INFO,{OperCode:OperCode,UserType:UserType,NikeName:NikeName});
		}

		public function getUserInfo():void
		{
			Network.send(CONST_CMD.GET_USER_INFO);
		}

		//获取用户房产列表
		public function getHouseList(){
			Network.send(CONST_CMD.GET_USER_HOUSE_LIST);
		}

		private function getHouseListRet(obj:Object):void
		{
			EventCenter.ins.event(CONST_EVENT.SHOW_HOUSE_LIST,obj);
		}
	}
}

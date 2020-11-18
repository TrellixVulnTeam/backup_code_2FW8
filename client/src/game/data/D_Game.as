/**
 * Created by chencong on 2017/5/24.
 */
package game.data
{
	import game.data.vo.UserInfo;

	import laya.utils.Browser;
	import laya.utils.Dictionary;

	public class D_Game
	{
		private static var _instance:D_Game;
		public var userInfo:UserInfo = new UserInfo();
		public var token:String;
		public var music_on:Boolean = true;
		public var sound_on:Boolean = true;
		public var isLeader:Boolean;
		public var isPlatform:Boolean;
		public var offlineMsg:Object;
		public var navRoutes:Dictionary;
		public var builds:Array;
		public var gainEstateMoneyGap:int;  //收获时间间隔（秒）
		private  var serverTime:Number;   //时间戳（秒数）


		public static function get instance():D_Game
		{
			if (null == _instance)
			{
				_instance = new D_Game();
			}
			return _instance;
		}

		public static function get clientScale():Number{
			if (Browser.onPC) {
				return Laya.stage.clientScaleX;
			}else{
				return Browser.clientWidth / Laya.stage.width;
			}
		}

		public static const bottomHeight:int = 210;
		public static const topHeight:int = 330;

		public var startTime:int;
		public var loginTime:int;

		/**
		 * 服务器日期
		 */
		public function get time():Date{
			return new Date(loginTime*1000 + Browser.now() - startTime);
		}

		/**
		 * 服务器时间戳  单位：秒
		 */
		public function get timestamp():int{
			return loginTime + Math.floor((Browser.now() - startTime)/1000);
		}

		public function updatePower(power:int):void
		{
			userInfo.power += power;
		}

		public function updateMoney(money:int):void
		{
			userInfo.money += money;
		}

		public function updateExp(exp:int):void
		{
			userInfo.exp += exp;
		}

		public function updateDiamond(diamonds:*):void
		{
			userInfo.diamonds += diamonds;
		}

		public function get diamonds():int{
			return userInfo.diamonds;
		}

		public function get money():int{
			return userInfo.money;
		}

		public function get ylz():Boolean{
			if(userInfo.houseId&&userInfo.floorId)
			    return true;
			else
				return false;
		}
	}
}

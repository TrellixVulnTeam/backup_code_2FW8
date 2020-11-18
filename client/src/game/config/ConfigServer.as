package game.config
{
	import com.cong.net.HttpRequestExt;

	import laya.net.URL;

	public class ConfigServer
	{
		public function ConfigServer()
		{
		}
		private static var _data:Object;
		public static function init(obj:Object):void
		{
			_data = obj;
		}

		public static function getVersion():String{
			return _data.version;
		}

		public static function get host():String{
			return _data.server.ip;
		}

		public static function get port():int{
			return _data.server.port;
		}

		public static function get httpAddr():int{
			return _data.http.addr;
		}
	}
}

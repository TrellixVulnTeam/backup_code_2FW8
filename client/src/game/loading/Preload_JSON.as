package game.loading
{
	import com.cong.utils.Console;

	import game.config.GameConfig;
	import game.constants.CONST_FILE;

import laya.net.Loader;

import laya.utils.Handler;

	public class Preload_JSON
	{
		private var _configUrlList:Array;
		private var _onComplete:Handler;

		public function Preload_JSON()
		{
		}

		private static var _instance:Preload_JSON;
		public static function get instance():Preload_JSON
		{
			if (null == _instance)
			{
				_instance = new Preload_JSON();
			}
			return _instance;
		}

		public function start(onComplete_:Handler):void
		{
			_onComplete = onComplete_;
			Laya.loader.load(CONST_FILE.config_json, Handler.create(this, onConfigLoaded), null,Loader.JSON);
		}

		private function onConfigLoaded(obj:Object):void
		{
			GameConfig.initData(getFileName(CONST_FILE.config_json), obj);
			_configUrlList = GameConfig.getConfigList();
			console.log("GameConfig: 开始加载配置：");
			startLoadConfig();
		}

		private function startLoadConfig():void
		{
			if (_configUrlList.length > 0)
			{
				var url:String = _configUrlList.pop();
				Laya.loader.load(url, Handler.create(this, onLoadConfigComplete, [url]), null,Loader.JSON);
			} else
			{
				complete();
			}
		}

		private function onLoadConfigComplete(url:String,obj:Object ):void
		{
//			try
//			{
				GameConfig.initData(getFileName(url), obj);
				startLoadConfig();
//			} catch (er:Error)
//			{
//				trace(url + " 配置格式错误");
//			}
		}

		private function complete():void
		{
			if (null != _onComplete)
			{
				_onComplete.run();
				_onComplete = null;
			}
		}

		public function getFileName(url:String):String
		{
			var name:String = "";
			var arr_:Array = url.split("/");
			if (arr_.length <= 1)
			{
				arr_.length = 0;
				arr_ = url.split("\\");
			}

			if (arr_.length > 1)
			{
				var nameArr:Array = arr_[arr_.length - 1].toString().split(".");
				if (nameArr.length > 1)
				{
					name = nameArr[0];
				}
			}
			return name;
		}
	}
}
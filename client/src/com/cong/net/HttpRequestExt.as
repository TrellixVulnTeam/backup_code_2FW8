package com.cong.net
{
	import com.cong.components.Alert;
	import com.cong.events.EventCenter;
	import com.cong.utils.TextUtil;

	import game.str.Language;

	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.net.URL;
	import laya.utils.Handler;

	public class HttpRequestExt extends HttpRequest
	{
		private var _callBack:Handler;

		public function HttpRequestExt()
		{
			super();
		}

		public function request(url:String, data:* = null, callBack:Handler = null, method:String = "get", responseType:String = "text", accessToken:Boolean = true)
		{
			//once(Event.PROGRESS, this, onHttpRequestProgress);
			_callBack = callBack;
			once(Event.COMPLETE, this, onHttpRequestComplete);
			once(Event.ERROR, this, onHttpRequestError);
			var dataStr:String;
			if(method=="post"){
				dataStr = JSON.stringify(data);
			}
//			var headers:Array;
//			if (!accessToken)
//			{
//				headers = ["Content-Type", "application/json"];
//			} else
//			{
//				headers = ["Content-Type", "application/json", "Authorization", "bearer " + D_Game.instance.token];
//			}
			send(url, dataStr, method, responseType);
		}

		private function onHttpRequestComplete()
		{
			if (_callBack)
			{
				var obj:Object = JSON.parse(this.data);
				if(obj is Array){
					_callBack.runWith([obj]);
				}else{
					_callBack.runWith(obj);
				}
			}
		}

		private function onHttpRequestError():void
		{
			Alert.show(Language.REQUEST_ERROR);
		}
	}
}

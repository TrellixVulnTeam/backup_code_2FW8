package com.cong.components.alert
{
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Pool;

	import ui.common.SimpleAlertUI;

	/**
	 * @author chencong(只有确定按钮)
	 */
	public class SystemConfirmAlert extends SimpleAlertUI  implements IAlert
	{
		private var _message:String;
		private var _handler:Handler;
		public function SystemConfirmAlert()
		{
			btn_ok.clickSound = "cancel";
			btn_ok.on(Event.CLICK, this, okHandler);
			closeHandler = Handler.create(this,recycle,null,false);
		}

		private function recycle():void
		{
			Pool.recover("SystemConfirmAlert",this);
		}

		private function okHandler():void
		{
			if(_handler){
				_handler.run();
			}
			close();
		}

		public function get message():String
		{
			return _message;
		}

		public function set message(message:String):void
		{
			_message = message;
			txt_info.text = _message;
		}

		public function set handler(value:Handler):void
		{
			_handler = value;
		}
	}
}

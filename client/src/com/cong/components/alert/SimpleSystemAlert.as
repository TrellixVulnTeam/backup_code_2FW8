package com.cong.components.alert
{
	import com.cong.components.Alert;

	import game.constants.CONST_FILE;
	import game.data.D_Game;

	import laya.events.Event;
	import laya.media.SoundManager;
	import laya.utils.Handler;
	import laya.utils.Pool;

	import ui.common.SimpleAlert2UI;

	import ui.common.SimpleAlertUI;

	/**
	 * @author chencong (确定和取消按钮)
	 */
	public class SimpleSystemAlert extends SimpleAlertUI implements IAlert
	{
		private var _message:String;
		private var _handler:Handler;

		public function SimpleSystemAlert(handler:Handler = null)
		{
			_handler = handler;
			btn_ok.clickSound = "agree";
			btn_cancel.clickSound = "cancel";
			btn_ok.on(Event.CLICK, this, okHandler);
			btn_cancel.on(Event.CLICK, this, cancelHandler);

			btn_ok.visible = true;
			btn_cancel.visible = true;
			btn_cancel.x = 177;
			btn_ok.x = 499;
			closeHandler = Handler.create(this,recycle,null,false);
		}

		private function recycle():void
		{
			Pool.recover("SimpleSystemAlert",this);
		}

		private function cancelHandler():void
		{
			close();
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

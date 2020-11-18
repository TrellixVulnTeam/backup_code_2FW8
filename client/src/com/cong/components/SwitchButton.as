package com.cong.components
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class SwitchButton
	{
		private var bg_off:Image;
		private var bg_on:Image;
		private var txt_status:Label;
		private var bar:Image;

		private var _status:int;
		private var _handler:Handler;
		private var _skin:Box;

		//1开  0关
		public function SwitchButton(skin:Box, handler:Handler)
		{
			_skin = skin;
			_handler = handler;
			bg_off = skin.getChildByName("bg_off") as Image;
			bg_on = skin.getChildByName("bg_on") as Image;
			txt_status = skin.getChildByName("txt_status") as Label;
			bar = skin.getChildByName("bar") as Image;
			status = 1;
			addListeners();
		}

		public function addListeners():void
		{
			_skin.on(Event.CLICK,this,changeStatus);
		}

		public function removeListeners():void
		{
			_skin.off(Event.CLICK,this,changeStatus);
		}

		private function changeStatus():void
		{
			if(_status){
				_status = 0;
			}else{
				_status = 1;
			}
			if(_status){
				Tween.to(bar,{x:bg_on.width-3-bar.width},100,null,Handler.create(this,function () {
					bg_on.visible = true;
					bg_off.visible = false;
				}));
				Tween.to(txt_status,{x:20},100,null,Handler.create(this,function () {
					txt_status.text = "ON";
				}));
			}else{
				Tween.to(bar,{x:3},100,null,Handler.create(this,function () {
					bg_on.visible = false;
					bg_off.visible = true;
				}));
				Tween.to(txt_status,{x:96},100,null,Handler.create(this,function () {
					txt_status.text = "OFF";
				}));
			}
			if(_handler)
				_handler.runWith(_status);
		}

		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			if(_status == value){
				return;
			}
			_status = value;
			if(_status){
				txt_status.x = 20;
				bar.x = bg_on.width-3-bar.width;
				bg_on.visible = true;
				bg_off.visible = false;
				txt_status.text = "ON";
			}else{
				bar.x = 3;
				txt_status.x = 96;
				bg_on.visible = false;
				bg_off.visible = true;
				txt_status.text = "OFF";
			}
		}
	}
}

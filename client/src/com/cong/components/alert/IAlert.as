package com.cong.components.alert
{
	import laya.utils.Handler;

	/**
	 * @author chencong
	 */
	public interface IAlert
	{
		function set message(value:String):void;
		function get message():String;
		function set handler(value:Handler):void
	}
}

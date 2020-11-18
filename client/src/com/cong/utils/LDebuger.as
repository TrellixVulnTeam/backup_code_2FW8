package com.cong.utils
{

	import flash.display.DisplayObject;

	/**
	 * @author QLS
	 *2011-5-15  ����10:04:02
	 */
	public class LDebuger extends Object
	{
		private static var _enable:Boolean = true;
		private static var _sysEnable:Boolean = true;

		public function LDebuger()
		{
		}

		public static function init(base:Object, address:String = "127.0.0.1"):void
		{
			MonsterDebugger.initialize(base, address);
		}

		public static function mtrace(object:*, label:String = "", color:int = 0, caller:* = null, person:String = "qls", depth:int = 5):void
		{
			if (_enable)
			{
				MonsterDebugger.trace(caller, object, person, label, color, depth);
			}
			if (_sysEnable)
			{
				trace(label + ": " + object);
			}
		}


		public static function breakpoint(caller:Object, id:String = "Loockback_breakpoint"):void
		{
			MonsterDebugger.breakpoint(caller, id);
		}


		public static function inspect(object:*):void
		{
			MonsterDebugger.inspect(object);
		}

		public static function log(...args):void
		{
			MonsterDebugger.log.apply(undefined, args);
		}


		public static function snapshot(object:DisplayObject, label:String = "", caller:* = null, person:String = "qls"):void
		{
			MonsterDebugger.snapshot(caller, object, person, label);
		}


		public static function clear():void
		{
			MonsterDebugger.clear();
		}

		static public function get enable():Boolean
		{
			return _enable;
		}

		static public function set enable(enable:Boolean):void
		{
			_enable = enable;
			MonsterDebugger.enabled = _enable;
		}

		static public function set sysEnable(sysEnable:Boolean):void
		{
			_sysEnable = sysEnable;
		}

		static public function get sysEnable():Boolean
		{
			return _sysEnable;
		}
	}
}

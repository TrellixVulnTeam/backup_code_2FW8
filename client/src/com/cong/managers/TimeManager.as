package com.cong.managers
{
	public class TimeManager
	{
		/**
		 * 以指定的时间间隔触发某一函数
		 * <br><b>注意：同一个Function无法重复添加</b>
		 * @param interval_ 间隔，毫秒数
		 * @param callback_ 回调函数
		 * @param param_ 回调函数的参数列表
		 * @param count_  回调函数的调用次数，若为0则无限次调用
		 * 
		 */		
		public static function addCallback(caller:*, interval_:int, callback_:Function, param_:Array=null, count_:uint=0):void
		{
			if(count_ == 1) Laya.timer.once(interval_, caller, callback_, param_);
			else Laya.timer.loop(interval_, caller, callback_, param_);
		}
		
		/**
		 * 移除以时间间隔触发的函数 
		 * @param callback_ 需移除的函数
		 * 
		 */		
		public static function removeCallback(caller:*, callback_:Function):void
		{
			Laya.timer.clear(caller, callback_);
		}
	}
}
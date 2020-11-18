/**
 * @Author: chencong
 * @Date: ${DATE} ${TIME}
 */
package com.cong.utils
{
	import laya.utils.Handler;

	public class CTimer
	{
		private var _callFun:Handler;

		//在计时器完成时调用
		private var _complete:Handler;
		private var _repeatCount:int;
		private var _delay:Number;
		private var _currentCount:int;
		public function CTimer(delay:Number, repeatCount:int, callFun:Handler, complete:Handler)
		{
			_delay = delay;
			_callFun = callFun;
			_repeatCount = repeatCount
			_complete = complete;
			_currentCount = 0;
		}

		public function start(){
			Laya.timer.loop(delay,this,onTimer);
		}

		public function stop(){
			Laya.timer.clear(this,onTimer);
		}

		public function repeat(){
			_currentCount = 0;
			Laya.timer.loop(delay,this,onTimer);
		}

		private function onTimer():void
		{
			_currentCount++;
			_callFun.run();
			if(_repeatCount!=0){
				if(_currentCount==repeatCount){
					Laya.timer.clear(this,onTimer);

					//计时器完成,回调complete
					_complete.run();
				}
			}
		}

		public function get repeatCount():int
		{
			return _repeatCount;
		}

		public function get delay():Number
		{
			return _delay;
		}

		public function get currentCount():int
		{
			return _currentCount;
		}

		//剩余时间
		public function get haveTime():int {
			return repeatCount - currentCount;
		}
	}
}

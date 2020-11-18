package com.cong.utils.tweenUtil
{
	import com.cong.utils.ColerFilterUtil;

	import laya.display.Sprite;

	public class WarnColorEff
	{
		private var _target:Sprite;
		private var count:int;
		public function WarnColorEff(target:Sprite)
		{
			_target = target;
		}

		public function run(){
			Laya.timer.loop(200,this,changeColor);
		}

		private function changeColor():void
		{
			count++;
			if(count%2==1){
				_target.filters = [ColerFilterUtil.getRedFilter()];
			}else{
				_target.filters = [];
			}
		}

		public function stop(){
			_target.filters = [];
			Laya.timer.clear(this,changeColor);
		}
	}
}

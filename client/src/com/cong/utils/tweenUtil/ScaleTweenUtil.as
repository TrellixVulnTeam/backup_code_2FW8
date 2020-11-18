package com.cong.utils.tweenUtil
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * alpha 与  scaleX，scaleX 缓动
	 * @author xuwei
	 * 创建时间：2014-11-14 上午11:30:00
	 *
	 */
	public class ScaleTweenUtil
	{
		private static var _instance:ScaleTweenUtil;
		public static function get instance():ScaleTweenUtil
		{
			if (_instance == null)
			{
				_instance = new ScaleTweenUtil();
			}
			return _instance;
		}

		private var _tweenList:HashMap;
		private var _TimeOutIdList:HashMap;

		public function ScaleTweenUtil()
		{
			_tweenList = new HashMap();
			_TimeOutIdList = new HashMap();
		}

		/**
		 * 动荡闪烁的动画
		 * @param object_  动画对象
		 * @param duration_ 动画播放的时间
		 * @param scaleX
		 * @param scaleY
		 * @param alpha
		 * @param repeat   循环次数 （-1是无限次）
		 * @param repeatDelay  （每次循环中的延迟时间：时间单位是秒）
		 * @return
		 *
		 */
		public function addScaleTween(object_:DisplayObjectContainer, duration_:Number = 1, scaleX:Number = 1, scaleY:Number = 2, alpha:Number = 1, repeat:int = -1, repeatDelay:Number = 1):Boolean
		{
			if (object_ == null || !TweenMax.getTweensOf(object_).length == 0)
			{
				return false;
			}

			var params:Object = new Object();
			params["alpha"] = alpha;
			params["scaleX"] = scaleX;
			params["scaleY"] = scaleY;
			params["onComplete"] = onRepeatCallback;
			params["onCompleteParams"] = [object_, duration_, scaleX, scaleY, alpha, repeat, repeatDelay];
			var tweenMax:TweenMax = TweenMax.to(object_, duration_, params);
			_tweenList.put(object_, tweenMax);
			return true;
		}

		public function remove(object_:DisplayObject):void
		{
			if (_TimeOutIdList.getValue(object_) != null)
			{
				FrameDispatcher.clearTimeout(_TimeOutIdList.getValue(object_));
				_TimeOutIdList.remove(object_);
			}

			var tweenMax:TweenMax = _tweenList.getValue(object_);
			if (tweenMax != null)
			{
				tweenMax.kill();
				_tweenList.remove(object_);
			}
		}

		/**
		 *检查是否已经有这个缓动效果
		 * @param object_
		 * @return
		 *
		 */
		public function contions(object_:DisplayObject):Boolean
		{
			var tweenMax:TweenMax = _tweenList.getValue(object_);
			if (tweenMax != null)
			{
				return true;
			}
			return false;
		}

		/**
		 * 动画结束回调
		 */
		private function onRepeatCallback(object_:DisplayObjectContainer, duration_:Number = 1, scaleX:Number = 1, scaleY:Number = 2, alpha:Number = 1, repeat:int = -1, repeatDelay:Number = 1):void
		{

			object_.cacheAsBitmap = false;
			object_.cacheAsBitmap = true;
			remove(object_);
			object_.alpha = 1;
			object_.scaleX = 1;
			object_.scaleY = 1;

			if (repeat > 0)
			{
				repeat--;
			}
			//var param_:Array = [object_, duration_,scaleX,scaleY, alpha, repeat, repeatDelay];
			if (repeat != 0)
			{
				var timeOutId:int = FrameDispatcher.setTimeout(addScaleTween, 1500, object_, duration_, scaleX, scaleY, alpha, repeat, repeatDelay);
				_TimeOutIdList.put(object_, timeOutId);
			}
		}

	}
}
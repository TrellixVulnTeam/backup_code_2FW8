package  com.cong.utils
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	public class BreatheTweenUtil
	{
		private static var _instance:BreatheTweenUtil;

		public static function get instance():BreatheTweenUtil
		{
			if (_instance == null)
			{
				_instance = new BreatheTweenUtil();
			}
			return _instance;
		}

		private var _tweenList:Vector.<TweenMax>;

		public function BreatheTweenUtil()
		{
			this._tweenList = new Vector.<TweenMax>();
		}

		/**
		 *给指定对象添加一个呼吸滤镜
		 * @param object_
		 * @param color_  原值16767241
		 * @param blurValue_  原值 4
		 * @param duration_
		 * @param repeat_
		 * @param inner_
		 * @return
		 *
		 */
		public function add(object_:DisplayObject, color_:uint = 0xfffd00, blurValue_:int = 5, duration_:Number = 1, repeat_:int = -1, inner_:Boolean = false):Boolean
		{
			if (object_ == null || !TweenMax.getTweensOf(object_).length == 0)
			{
				return false;
			}

			var glowFilter:GlowFilter = new GlowFilter();
			glowFilter.color = color_;
			glowFilter.blurX = 0;
			glowFilter.blurY = 0;
			glowFilter.strength = 1.8;
			glowFilter.quality = BitmapFilterQuality.HIGH;
			glowFilter.inner = inner_;
			glowFilter.alpha = 0.8;
			object_.filters = [glowFilter];
			var params:Object = new Object();
			params["glowFilter"] = {
				"blurX": blurValue_, "blurY": blurValue_
			};
			params["yoyo"] = true;
			params["repeat"] = repeat_;
			params["onComplete"] = remove;
			params["onCompleteParams"] = [object_];
			var tweenMax:TweenMax = TweenMax.to(object_, duration_, params);
			this._tweenList.push(tweenMax);
			return true;

		}

		public function remove(object_:DisplayObject):void
		{
			var tweenMaxArr:Array = TweenMax.getTweensOf(object_);
			var index:int = 0;
			while (index < tweenMaxArr.length)
			{
				var tweenMaxIndex:int = _tweenList.indexOf(tweenMaxArr[index]);
				if (tweenMaxIndex >= 0)
				{
					_tweenList[tweenMaxIndex].kill();
					_tweenList.splice(tweenMaxIndex, 1);
				}
				index++;
			}

			if (object_)
			{
				object_.filters = null;
			}
		}

		/**
		 *检查是否添加了呼吸效果
		 * @param object_
		 * @return
		 *
		 */
		public function contions(object_:DisplayObject):Boolean
		{
			var index:int;
			while (index < this._tweenList.length)
			{
				if (this._tweenList[index].target == object_)
				{
					return (true);
				}
				index++;
			}
			return false;
		}
	}
}
package com.cong.utils.tweenUtil
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import laya.display.Sprite;
	import laya.maths.Point;

	/**
	 * 爆炸的效果动画
	 * @author xuwei
	 * 创建时间：2014-11-28 上午8:34:46
	 *
	 */
	public class ExplodeBallEff extends Sprite
	{
		private var _url:String;
		private var _callBackFunc:Function;
		private var _exploderTimer:Timer;
		private var _startPoint:Point;
		private var _endPoint:Point;
		private var _repetCount:int;
		private var _shapeCount:int;
		private var _imgWidth:int;
		private var _imgHeight:int;
		private var _delayT:int;
		private var _oncetime:Number = 1;
		private var _totalCount:int;

		/**
		 *
		 * @param url          资源的路径
		 * @param startPoint   开始点
		 * @param endPoint     结束点
		 * @param repetCount   重覆次数
		 * @param shapeCount   一次的精灵的个数
		 * @param imgWidth           宽
		 * @param imgHeight    高
		 * @param oncetime     一次动画的数据
		 *
		 */
		public function ExplodeBallEff(url:String, startPoint:Point, endPoint:Point, callBackFunc:Function = null, repetCount:int = 1, shapeCount:int = 4, imgWidth:int = 64, imgHeight:int = 64, oncetime:Number = 1)
		{
			_url = url;
			_callBackFunc = callBackFunc;
			_repetCount = repetCount;
			_shapeCount = shapeCount;
			_startPoint = startPoint;
			_endPoint = endPoint;
			_imgWidth = imgWidth;
			_imgHeight = imgHeight;
			_oncetime = oncetime;
			_totalCount = 0;
			_exploderTimer = new Timer(100, _repetCount);
		}

		public function set repetTime(time:int):void
		{
			_exploderTimer.stop();
			_totalCount = 0;
			removeEvent();
			_exploderTimer = new Timer(time, _repetCount);
		}

		public function show(delayTime:int = 0):void
		{
			FrameDispatcher.clearTimeout(delayTime);
			if (delayTime > 0)
			{
				_delayT = FrameDispatcher.setTimeout(start, delayTime);
			} else
			{
				start();
			}
			;
		}

		public function hide():void
		{
			removeEvent();
			_exploderTimer.stop();
			_exploderTimer.stop();
			_startPoint = null;
			_endPoint = null;
			_url = null;
			FrameDispatcher.clearTimeout(_delayT);
		}

		private function start():void
		{
			addEvent();
			_exploderTimer.reset();
			_exploderTimer.start();
		}

		private function addEvent():void
		{
			_exploderTimer.on("timer", this, onTimer);
			_exploderTimer.on("timerComplete", this, onComplete);
		}

		private function removeEvent():void
		{
			_exploderTimer.on("timer", this, onTimer);
			_exploderTimer.on("timerComplete", this, onComplete);
		}

		private function onComplete(evt:TimerEvent):void
		{
			removeEvent();
		}

		private function onTimer(evt:TimerEvent):void
		{
			evt = evt;
			_totalCount++;
			var shapeCount:int = (_shapeCount + (3 * Math.random()));
			while (shapeCount > 0)
			{
				var bmp:Bitmap = UIUtil.getAsynBitmap(_url);
				bmp.x = _startPoint.x;
				bmp.y = _startPoint.y;
				var scale:Number = (0.3 + (0.8 * Math.random()));
				var _local3:Number = scale;
				bmp.scaleY = _local3;
				bmp.scaleX = _local3;
				addChild(bmp);
				var middleX:int = ((_endPoint.x - 100) + (200 * Math.random()));
				var middleY:int = ((_endPoint.y - 150) + (200 * Math.random()));
				var tween:TweenMax = TweenMax.to(bmp, _oncetime, {
					"bezierThrough": [{
						"x": middleX, "y": middleY
					}, {
						"x": (_endPoint.x - ((_imgWidth * 0.5) * scale)),
						"y": (_endPoint.y - ((_imgHeight * 0.5) * scale))
					}], "ease": Linear.easeOut, "onComplete": function (_arg1:DisplayObject, _view:ExplodeBallEff):void
					{
						if (_arg1)
						{
							removeChild(_arg1);
							_arg1 = null;
							tween = null;
							//最后一次
							if (_totalCount >= _repetCount)
							{
								//最后一个（播放结束）
								if (numChildren == 0)
								{
									if (_callBackFunc != null)
									{
										_callBackFunc.apply(null, null);
									}

									if (null != _view && null != _view.parent)
									{
										_view.hide();
										_view.parent.removeChild(_view);
									}
								}
							}
						}
						;
					}, "onCompleteParams": [bmp, this]
				});
				shapeCount--;
			}
			;
		}
	}
}
package com.cong.components {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * 滚动条滑块位置发生变化后调度。
	 * @eventType laya.events.Event
	 */
	[Event(name = "change", type = "laya.events.Event")]
	/**
	 * 开始滑动。
	 * @eventType laya.events.Event
	 */
	[Event(name = "start", type = "laya.events.Event")]
	/**
	 * 结束滑动。
	 * @eventType laya.events.Event
	 */
	[Event(name = "end", type = "laya.events.Event")]

	/**
	 * <code>ScrollBar</code> 组件是一个滚动条组件。
	 * <p>当数据太多以至于显示区域无法容纳时，最终用户可以使用 <code>ScrollBar</code> 组件控制所显示的数据部分。</p>
	 * <p> 滚动条由四部分组成：两个箭头按钮、一个轨道和一个滑块。 </p>	 *
	 *
	 * @see laya.ui.HScrollBar
	 */
	public class ScrollMenu extends Component {
		/**滚动衰减系数*/
		public var rollRatio:Number = 0.95;
		/**滚动变化时回调，回传value参数。*/
		public var changeHandler:Handler;
		/**橡皮筋效果极限距离，0为没有橡皮筋效果。*/
		public var elasticDistance:Number = 0;
		/**橡皮筋回弹时间，单位为毫秒。*/
		public var elasticBackTime:Number = 500;

		/**@private */
		protected var _target:Sprite;
		/**@private */
		protected var _lastPoint:Point;
		/**@private */
		protected var _lastOffset:Number = 0;
		/**@private */
		protected var _checkElastic:Boolean = false;
		/**@private */
		protected var _isElastic:Boolean = false;
		/**@private */
		protected var _value:Number;
		/**@private */
		protected var _hide:Boolean = false;
		/**@private */
		protected var _clickOnly:Boolean = true;
		/**@private */
		protected var _offsets:Array;
		/**@private */
		protected var _touchScrollEnable:Boolean = UIConfig.touchScrollEnable;

		/**@private */
		protected var _repeat:int = 0;
		/**@private */
		private var items:Array;
		private var _itemRender:Class;
		private var _isVertical:Boolean;
		/**
		 * 创建一个新的 <code>ScrollBar</code> 实例。
		 * @param skin 皮肤资源地址。
		 */
		public function ScrollMenu(wid:int, hei, repeat:int, itemRender:Class, isVer:Boolean = false):void {
			_itemRender = itemRender;
			_isVertical = isVer;
			_repeat = repeat;
			width = wid;
			height = hei;
			this.max = 1;
		}

		/**@inheritDoc */
		override public function destroy(destroyChild:Boolean = true):void {
			stopScroll();
			super.destroy(destroyChild);
			changeHandler = null;
			_offsets = null;
		}
		/**
		 * 获取或设置表示当前滚动位置的数字。
		 */
		public function get value():Number {
			return _value;
		}

		public function set value(v:Number):void {
			if (v !== _value) {
				_value = v;
				if (!_isElastic) {
//					if (slider._value != v) {
//						slider._value = v;
//						slider.changeValue();
//					}
//					_value = slider._value;
				}
				event(Event.CHANGE);
				changeHandler && changeHandler.runWith(_value);
			}
		}

		/**
		 * 一个布尔值，指示滚动条是否为垂直滚动。如果值为true，则为垂直滚动，否则为水平滚动。
		 * <p>默认值为：true。</p>
		 */
		public function get isVertical():Boolean {
			return _isVertical;
		}

		public function set isVertical(value:Boolean):void {
			_isVertical = value;
		}

		/**@inheritDoc */
		override public function set dataSource(value:*):void {
			_dataSource = value;
			if (value is Number || value is String) this.value = Number(value);
			else super.dataSource = value;
		}

		/**
		 * <p>创建并添加控件子节点。</p>
		 * @internal 子类可在此函数内创建并添加子节点。
		 */
		override protected function createChildren():void {
			items = [];
			for (var i:int = 0; i < _dataSource.length; i++)
			{
				var item:* = new _itemRender(_dataSource[i]);
				if(!_isVertical){
					item.x = width/_repeat*i + width/2;
					if(_repeat%2==1){
						item.x -= width/_repeat/2;
					}
				}else{
					item.y = height/_repeat*i ;
					if(_repeat%2==1){
						item.y -= height/_repeat/2;
					}
				}
				addChild(item);
				items.push(item);
			}
			on(Event.MOUSE_DOWN, this, onTargetMouseDown);
		}

		/**@private */
		protected function onTargetMouseDown(e:Event):void {
			_clickOnly = true;
			_lastOffset = 0;
			_checkElastic = false;
			_lastPoint || (_lastPoint = new Point());
			_lastPoint.setTo(Laya.stage.mouseX, Laya.stage.mouseY);
			Laya.timer.clear(this, tweenMove);
			Tween.clearTween(this);
			Laya.stage.once(Event.MOUSE_UP, this, onStageMouseUp2);
			Laya.stage.once(Event.MOUSE_OUT, this, onStageMouseUp2);
			Laya.timer.frameLoop(1, this, loop);
		}

		/**@private */
		protected function loop():void {
			var mouseY:Number = Laya.stage.mouseY;
			var mouseX:Number = Laya.stage.mouseX;
			_lastOffset = isVertical ? (mouseY - _lastPoint.y) : (mouseX - _lastPoint.x);

			if (_clickOnly) {
				if (Math.abs(_lastOffset * (isVertical ? Laya.stage._canvasTransform.getScaleY() : Laya.stage._canvasTransform.getScaleX())) > 1) {
					_clickOnly = false;
					_offsets || (_offsets = []);
					_offsets.length = 0;
					_target.mouseEnabled = false;
					event(Event.START);
				} else return;
			}
			_offsets.push(_lastOffset);

			_lastPoint.x = mouseX;
			_lastPoint.y = mouseY;

			if (_lastOffset === 0) return;

			if (!this._checkElastic) {
				if (this.elasticDistance > 0) {
					if (!this._checkElastic && _lastOffset != 0) {
						if ((_lastOffset > 0 && _value <= min) || (_lastOffset < 0 && _value >= max)) {
							this._isElastic = true;
							this._checkElastic = true;
						} else {
							this._isElastic = false;
						}
					}
				} else {
					_checkElastic = true;
				}
			}
			if (this._isElastic) {
				if (_value <= min) {
					value -= _lastOffset * Math.max(0, (1 - ((min - _value) / elasticDistance)));
				} else if (_value >= max) {
					value -= _lastOffset * Math.max(0, (1 - ((_value - max) / elasticDistance)));
				}
			} else {
				value -= _lastOffset;
			}
		}

		/**@private */
		protected function onStageMouseUp2(e:Event):void {
			Laya.stage.off(Event.MOUSE_UP, this, onStageMouseUp2);
			Laya.stage.off(Event.MOUSE_OUT, this, onStageMouseUp2);
			Laya.timer.clear(this, loop);

			if (_clickOnly)
			{
				if(_value>=min&&_value<=max)
					return;
			}
			_target.mouseEnabled = true;

			if (this._isElastic) {
				if (_value < min) {
					Tween.to(this, {value: min}, elasticBackTime, Ease.sineOut, Handler.create(this, elasticOver));
				} else if (_value > max) {
					Tween.to(this, {value: max}, elasticBackTime, Ease.sineOut, Handler.create(this, elasticOver));
				}
			} else {
				if (!_offsets) return;
				//计算平均值
				if (_offsets.length < 1) {
					_offsets[0] = isVertical ? Laya.stage.mouseY - _lastPoint.y : Laya.stage.mouseX - _lastPoint.x;
				}
				var offset:Number = 0;
				var n:Number = Math.min(_offsets.length, 3);
				for (var i:int = 0; i < n; i++) {
					offset += _offsets[_offsets.length - 1 - i];
				}
				_lastOffset = offset / n;

				offset = Math.abs(_lastOffset);
				if (offset < 2) {
					event(Event.END);
					return;
				}
				if (offset > 60) _lastOffset = _lastOffset > 0 ? 60 : -60;
				var dis:int = Math.round(Math.abs(elasticDistance * (_lastOffset / 240)));
				Laya.timer.frameLoop(1, this, tweenMove, [dis]);
			}
		}

		/**@private */
		private function elasticOver():void {
			this._isElastic = false;
			event(Event.END);
		}

		/**@private */
		protected function tweenMove(maxDistance:Number):void {
			_lastOffset *= rollRatio;
			var tarSpeed:Number;
			if (maxDistance > 0) {
				if (_lastOffset > 0 && value <= min) {
					_isElastic = true;
					tarSpeed = -(min - maxDistance - value) * 0.5;
					if (_lastOffset > tarSpeed) _lastOffset = tarSpeed;
				} else if (_lastOffset < 0 && value >= max) {
					_isElastic = true;
					tarSpeed = -(max + maxDistance - value) * 0.5;
					if (_lastOffset < tarSpeed) _lastOffset = tarSpeed;
				}
			}

			value -= _lastOffset;
			//if (Math.abs(_lastOffset) < 1 || value == max || value == min)
			if (Math.abs(_lastOffset) < 1) {
				Laya.timer.clear(this, tweenMove);
				if (_isElastic) {
					if (_value < min) {
						Tween.to(this, {value: min}, elasticBackTime, Ease.sineOut, Handler.create(this, elasticOver));
					} else if (_value > max) {
						Tween.to(this, {value: max}, elasticBackTime, Ease.sineOut, Handler.create(this, elasticOver));
					} else {
						elasticOver();
					}
					return;
				}
				event(Event.END);
			}
		}

		/**@private */
		protected var _max:Number = 100;
		/**@private */
		protected var _min:Number = 0;

		/**
		 * 获取或设置表示最低位置的数字。 默认值为0。
		 */
		public function get min():Number {
			return _min;
		}

		public function set min(value:Number):void {
			if (_min != value) {
				_min = value;
			}
		}

		/**
		 * 获取或设置表示最高位置的数字。 默认值为100。
		 */
		public function get max():Number {
			return _max;
		}

		public function set max(value:Number):void {
			if (_max != value) {
				_max = value;
			}
		}

		/**
		 * 停止滑动。
		 */
		public function stopScroll():void {
			onStageMouseUp2(null);
			Laya.timer.clear(this, tweenMove);
			Tween.clearTween(this);
		}
	}
}
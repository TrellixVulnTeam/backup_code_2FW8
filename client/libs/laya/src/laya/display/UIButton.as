package laya.display
{
	import laya.events.Event;
	import laya.filters.ColorFilter;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class UIButton extends Component
	{
		private static const overColorMatrix:Array = [1.4, 0, 0, 0, 0, 0, 1.4, 0, 0, 0, 0, 0, 1.4, 0, 0, 0, 0, 0, 1, 0];
		private static const downColorMatrix:Array = [1, 0, 0, 0, 40, 0, 1, 0, 0, 40, 0, 0, 1, 0, 40, 0, 0, 0, 1, 0];
		private var disableColor:ColorFilter = new ColorFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0]);;
		private var overColor:ColorFilter = new ColorFilter(overColorMatrix);
		private var downColor:ColorFilter = new ColorFilter(downColorMatrix);
		//缩放时间，单位为
		private var _skin:String = null;
		private var _bmp:Image;
		private var _disable:Boolean;

		public function UIButton(skin:String = null)
		{
			_bmp = new Image();
			if (skin != null)
			{
				this.skin = skin;
			}
		}

		/**@inheritDoc */
		override protected function createChildren():void
		{
			addAllEventListener();
			callLater(rePos)
		}

		private function rePos():void
		{
			x += width/2;
			y+= height/2;
		}

		private function addAllEventListener():void
		{
			this.on(Event.MOUSE_DOWN, this, btnHandler);
			//添加鼠标抬起事件侦听。抬起时还原按钮。
			this.on(Event.MOUSE_UP, this, btnHandler);
			//添加鼠标离开事件侦听。离开时还原按钮。
			this.on(Event.ROLL_OUT, this, btnHandler);
			//this.on(Event.ROLL_OVER, this, btnHandler);
		}

		private function removeAllEventListener():void
		{
			this.off(Event.MOUSE_DOWN, this, btnHandler);
			//添加鼠标抬起事件侦听。抬起时还原按钮。
			this.off(Event.MOUSE_UP, this, btnHandler);
			//添加鼠标离开事件侦听。离开时还原按钮。
			this.off(Event.ROLL_OUT, this, btnHandler);
			//this.off(Event.ROLL_OVER, this, btnHandler);
		}

		/**
		 * <p>对象的皮肤资源地址。</p>
		 * 支持单态，两态和三态，用 <code>stateNum</code> 属性设置
		 *
		 * <p>对象的皮肤地址，以字符串表示。</p>
		 *
		 * @see #stateNum
		 * @return
		 */
		public function get skin():String
		{
			return _skin;
		}

		public function set skin(value:String):void
		{
			if (_skin != value)
			{
				_skin = value;
				_bmp.skin = _skin;
				addChildAt(_bmp, 0);
				anchorY = anchorX = 0.5;
			}
		}

		public var clickSound:String = "click2";
		private function btnHandler(e:Event):void
		{
			var mat:Array;
			switch (e.type)
			{
				case Event.ROLL_OVER:
//					mat = [1.5, 0, 0, 0, 10.5, //R
//						0, 1.5, 0, 0, 10.5, //G
//						0, 0, 1.5, 0, 10.5, //B
//						0, 0, 1.5, 0, 10.5, //B
//						0, 0, 0, 1, 0 //A
//					];
					filters = [overColor];
					break;
				case Event.ROLL_OUT:
					filters = [];
					break;
				case Event.CLICK:
					filters = [downColor];
					this.off(Event.CLICK, this, btnHandler);
					Tween.to(this, {
						scaleX: 1.2,
						scaleY: 1.2,
					}, 150, null, Handler.create(this, function () {
						Tween.to(this, {scaleX: 1, scaleY: 1}, 150,null,Handler.create(this,function () {
							this.on(Event.CLICK, this, btnHandler);
						}));
					}));
					break;
				case Event.MOUSE_UP:
					filters = [];
//					if(D_Game.instance.sound_on){
//						SoundManager.playSound(CONST_FILE.getSound(clickSound));
//					}
					break;
			}

		}

		/**@inheritDoc */
		override public function destroy(destroyChild:Boolean = true):void
		{
			super.destroy(destroyChild);
			_bmp.destroy();
			_bmp = null;
		}

		public function get disable():Boolean
		{
			return _disable;
		}

		public function set disable(value:Boolean):void
		{
			_disable = value;
			if (_disable)
			{
				filters = [disableColor];
				mouseEnabled = false;
				removeAllEventListener();
			} else
			{
				filters = [];
				mouseEnabled = true;
				addAllEventListener();
			}
		}

		/**
		 * @private
		 * 按钮上的文本。
		 */
		protected var _text:Text;

		/**
		 * 按钮的文本内容。
		 */
		public function get label():String
		{
			return _text ? _text.text : null;
		}

		/**@private */
		protected function createText():void
		{
			if (!_text)
			{
				_text = new Text();
				_text.overflow = Text.HIDDEN;
				_text.width = _bmp.width;
				_text.height = _bmp.height;
				_text.align = "center";
				_text.valign = "middle";
				_text.y = -5;
				_text.fontSize = 40;
				_text.color = "#ffffff";
			}
		}

		public function set label(value:String):void
		{
			if (!_text && !value) return;
			createText();
			if (_text.text != value)
			{
				value && !_text.displayedInStage && addChild(_text);
				_text.text = (value + "").replace(/\\n/g, "\n");
			}
		}

		/**
		 * 表示按钮文本标签的字体大小。
		 * @see laya.display.Text.fontSize()
		 */
		public function get labelSize():int
		{
			createText();
			return _text.fontSize;
		}

		public function set labelSize(value:int):void
		{
			createText();
			_text.fontSize = value;
		}

		protected var _autoSize:Boolean = true;

		/**@inheritDoc */
		override public function set width(value:Number):void
		{
			super.width = value;
			if (_autoSize)
			{
				_bmp.width = value;
				_text && (_text.width = value);
			}
		}

		/**@inheritDoc */
		override public function set height(value:Number):void
		{
			super.height = value;
			if (_autoSize)
			{
				_bmp.height = value;
				_text && (_text.height = value);
			}
		}

		/**
		 * <p>当前实例的位图 <code>AutoImage</code> 实例的有效缩放网格数据。</p>
		 * <p>数据格式："上边距,右边距,下边距,左边距,是否重复填充(值为0：不重复填充，1：重复填充)"，以逗号分隔。
		 * <ul><li>例如："4,4,4,4,1"</li></ul></p>
		 * @see laya.ui.AutoBitmap.sizeGrid
		 */
		public function get sizeGrid():String {
			if (_bmp.sizeGrid) return _bmp.sizeGrid;
			return null;
		}

		public function set sizeGrid(value:String):void {
			_bmp.sizeGrid = value;
		}
	}
}
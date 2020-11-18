package com.cong.components
{
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.html.dom.HTMLDivElement;
	import laya.ui.Image;
	import laya.ui.Label;

	public class HScrollText extends Sprite
	{
		private var _txt:HTMLDivElement;
		private var _text:String;

		public static const LEFT_TO_RIGHT:int = 1;
		public static const RIGHT_TO_LEFT:int = 2;
		private var _direct:int;
		private var _wid:int;
		private var _speed:Number;
		public static const SCROLL_END:String = "scroll_end";
		private var _textArr:Array = [];
		public var scrollbg:Image;

		public function HScrollText(wid:int, direct:int = RIGHT_TO_LEFT, speed:Number = 2)
		{
			super();
			_direct = direct;
			_wid = wid;
			_speed = speed;
			_txt = new HTMLDivElement();
			_txt.style.fontSize = 40;
			_txt.style.color = "#ffd97d";
//			_txt.overflow = Text.SCROLL;
			_txt.size(2040, 50);
			addChild(_txt);
			var mask:Sprite = new Sprite();
			mask.graphics.drawRect(0, 0, wid, 60, "#ff0000");
			this.mask = mask;
			mouseEnabled = false;
		}

		public function get text():String
		{
			return _text;
		}

		private function scrollText(value:String):void
		{
			_text = value;
			_txt.innerHTML = value;
			if (_direct == LEFT_TO_RIGHT)
			{
				_txt.x = -_txt.contextWidth;
			} else
			{
				_txt.x = _wid;
			}
			Laya.timer.loop(20, this, move);
		}

		public function pushText(txt:String)
		{
			_textArr.push(txt);
			run();
		}

		public function run()
		{
			if (_text == "")
			{
				if (_textArr.length)
				{
					var str:String = _textArr.shift();
					scrollText(str);
					if (scrollbg) scrollbg.visible = true;
				}

			} else
			{
				Laya.timer.loop(20, this, move);
				if (scrollbg) scrollbg.visible = true;
			}
		}

		private function move()
		{
			if (_direct == LEFT_TO_RIGHT)
			{
				_txt.x += _speed;
				if (_txt.x >= _txt.contextWidth)
				{
					_txt.x = -_wid;
					onScrollEnd();
				}
			} else
			{
				_txt.x -= _speed;
				if (_txt.x <= -_txt.contextWidth)
				{
					_txt.x = _wid;
					onScrollEnd();
				}
			}
		}

		private function onScrollEnd():void
		{
			event(SCROLL_END);
			_text = "";
			if (_textArr.length)
			{
				var str:String = _textArr.shift();
				scrollText(str);
			} else
			{
				stop();
				if (scrollbg) scrollbg.visible = false;
			}
		}

		public function stop()
		{

			Laya.timer.clear(this, move);
		}
	}
}

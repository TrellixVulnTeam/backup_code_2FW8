package com.cong.components
{
	import com.cong.managers.FloatTextManager;

	import game.constants.CONST_FILE;

	import laya.utils.Handler;
	import laya.utils.Tween;

	import ui.common.FloatTextItemUI;

	public class FloatingText extends FloatTextItemUI
	{
		private var _tm:Tween;
		private var _callFunction:Function;

		public function FloatingText(htmlortextstr:String, iconType:int = 0, _size:int = 45, _color:String = "#FF0000", callback:Function = null)
		{
			_callFunction = callback;
			gText.color = _color;
			gText.style.fontSize = _size;
			gText.innerHTML = htmlortextstr;
			gText.x = ((width - gText.contextWidth) >> 1);
			gText.y = ((height - gText.contextHeight) >> 1);

			if (iconType)
			{
				gText.x += ico.width / 2;
				ico.skin = CONST_FILE.getResIcon(iconType);
				ico.x = gText.x - ico.width;
			} else
			{
				ico.skin = null;
			}

			this.width = width;
			this.height = height;
			this.addChild(gText);
			this.beginShow();
			mouseEnabled = false;
		}

		public function showText(txt:String, iconType:int = 0):void
		{
			alpha = 1;
			gText.innerHTML = txt;
			gText.x = ((width - gText.contextWidth) >> 1);
			gText.y = ((height - gText.contextHeight) >> 1);
			if (iconType)
			{
				gText.x += ico.width / 2;
				ico.skin = CONST_FILE.getResIcon(iconType);
				ico.x = gText.x - ico.width;
			} else
			{
				ico.skin = null;
			}
			beginShow();
		}

		private var offsetY:int;
		private function beginShow():void
		{
			offsetY = (FloatTextManager.floatCount-1)*this.height;
			var obj:Object = {};
			x = (Laya.stage.width - this.width) / 2;
			y = (Laya.stage.height - this.height) / 2 - 50 + offsetY;
			alpha = 0;
			obj["y"] = y - 100;
			obj["alpha"] = 1;
			this._tm = Tween.to(this, obj, 500, null, Handler.create(this, this.showComplete));
		}

		private function showComplete():void
		{
			Laya.timer.once(600, this, this.hideShow);
		}

		private function hideShow():void
		{
			this._tm = Tween.to(this, {
				alpha: 0,
				y: (Laya.stage.height - this.height) / 2 - 200 + offsetY
			}, 500, null, Handler.create(this, hideComplete));
		}

		private function hideComplete():void
		{
			if (this._tm != null)
			{
				this._tm.pause();
				this._tm = null;
			}
			removeSelf();
			if (_callFunction != null)
			{
				_callFunction.apply(null, null);
			}
		}
	}
}


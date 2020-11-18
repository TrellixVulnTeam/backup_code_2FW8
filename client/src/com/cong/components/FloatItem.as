package com.cong.components
{
	import laya.display.Sprite;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class FloatItem
	{
		private var _tm:Tween;
		private var _callFunction:Handler;
		private var _view:Sprite;
		public function FloatItem(view:Sprite, callback:Handler = null)
		{
			_callFunction = callback;
			_view = view;
			view.mouseEnabled = false;
		}

		public function show():void
		{
			_view.alpha = 1;
			beginShow();
		}

		private function beginShow():void
		{
			var obj:Object = {};
			_view.x = (Laya.stage.width - _view.width) / 2;
			_view.y = (Laya.stage.height - _view.height) / 2 - 50;
			_view.alpha = 0;
			obj["y"] = _view.y - 100;
			obj["alpha"] = 1;
			this._tm = Tween.to(_view, obj, 500, null, Handler.create(this, this.showComplete));
		}

		private function showComplete():void
		{
			Laya.timer.once(600, this, this.hideShow);
		}

		private function hideShow():void
		{
			this._tm = Tween.to(_view, {
				alpha: 0,
				y: (Laya.stage.height - _view.height) / 2 - 200
			}, 500, null, Handler.create(this, hideComplete));
		}

		private function hideComplete():void
		{
			if (this._tm != null)
			{
				this._tm.pause();
				this._tm = null;
			}
			_view.removeSelf();
			if (_callFunction != null)
			{
				_callFunction.run();
			}
		}
	}
}

package com.cong.components
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class SimplePageSelector extends Sprite
	{
		public var curIndex:int;
		private var curPage:*;
		private var nextPage:*;
		private var _dataProvider:Array;
		private var _wid:Number;
		private var _hei:Number;
		private var startMouseX:Number;
		private var startMouseY:Number;
		public var pageEndHandler:Handler;
		private var _itemRender:Class;
		public var itemSelectHandler:Handler;

		public function SimplePageSelector(wid:Number, hei:Number, itemRender:Class, pageEndHandler:Handler, dp:Array = null)
		{
			width = _wid = wid;
			height = _hei = hei;
			_dataProvider = dp;
			_itemRender = itemRender;
			this.pageEndHandler = pageEndHandler;
			if (_dataProvider && _dataProvider.length)
			{
				curPage = new itemRender(dataProvider[curIndex]);
				addChild(curPage);
				on(Event.MOUSE_DOWN, this, onMuseDown);
			}
		}

		private var _delta:Number = 0;
		private var _lastTimer:Number = 0;

		private function onMuseDown():void
		{
			startMouseX = stage.mouseX;
			startMouseY = stage.mouseY;
			stage.on(Event.MOUSE_MOVE, this, onMuseMove);
			stage.on(Event.MOUSE_UP, this, pageEnd);
			stage.on(Event.MOUSE_OUT, this, pageEnd);
			_lastTimer = Browser.now();
		}

		private var flag:int = 0;     //1下一页，-1上一页
		private function onMuseMove():void
		{
			this.x = stage.mouseX - startMouseX;
			if (0 == curIndex && this.x >= 0)
			{
				this.x = (stage.mouseX - startMouseX) / 3;
				return;
			} else if (_dataProvider.length - 1 == curIndex && this.x <= 0)
			{
				this.x = (stage.mouseX - startMouseX) / 3;
				return;
			}
			if (!nextPage)
			{
				if (stage.mouseX - startMouseX > 0)
				{
					flag = 1;
					nextPage = new _itemRender(dataProvider[curIndex - 1]);
					nextPage.x = -_wid;
					addChild(nextPage);
				} else if (stage.mouseX - startMouseX < 0)
				{
					flag = -1;
					nextPage = new _itemRender(dataProvider[curIndex + 1]);
					nextPage.x = _wid;
					addChild(nextPage);
				}
			} else
			{
				if (flag == 1 && stage.mouseX - startMouseX < 0)
				{
					flag = -1;
					removeChild(nextPage);
					nextPage = new _itemRender(dataProvider[curIndex - 1]);
					nextPage.x = _wid;
					addChild(nextPage);
				} else if (flag == -1 && stage.mouseX - startMouseX > 0)
				{
					removeChild(nextPage);
					flag = 1;
					nextPage = new _itemRender(dataProvider[curIndex + 1]);
					nextPage.x = -_wid;
					addChild(nextPage);
				}
			}
		}

		private function pageEnd():void
		{
			off(Event.MOUSE_DOWN, this, onMuseDown);
			stage.off(Event.MOUSE_MOVE, this, onMuseMove);
			stage.off(Event.MOUSE_UP, this, pageEnd);
			stage.off(Event.MOUSE_OUT, this, pageEnd);
			_delta = Browser.now() - _lastTimer;
			if(Math.abs(stage.mouseX - startMouseX)==0||!nextPage){
				on(Event.MOUSE_DOWN, this, onMuseDown);
				return;
			}
			//下一页
			if (_dataProvider.length - 1 != curIndex && (stage.mouseX - startMouseX < -_wid / 2 || (stage.mouseX - startMouseX < 0 && _delta < 200)))
			{
				//mouseEnabled = false;
				Tween.clearTween(this);
				Tween.to(this, {x: -_wid}, 150, Ease.linearNone, Handler.create(this, function () {
					removeChild(curPage);
					curPage = nextPage;
					x = 0;
					curPage.x = 0;
					flag = 0;
					nextPage = null;
					curIndex++;
					mouseEnabled = true;
					if(btn_right&&curIndex==dataProvider.length-1){
						btn_right.visible = false;
					}
					if(btn_left&&curIndex!=0){
						btn_left.visible = true;
					}
					if (pageEndHandler)
					{
						pageEndHandler.runWith(curPage.data);
					}
					on(Event.MOUSE_DOWN, this, onMuseDown);
				}));

			} else if (0 != curIndex && (stage.mouseX - startMouseX > _wid / 2 || (stage.mouseX - startMouseX > 0 && _delta < 200)))
			{
				//mouseEnabled = false;
				Tween.clearTween(this);
				Tween.to(this, {x: _wid}, 150, Ease.linearNone, Handler.create(this, function () {
					removeChild(curPage);
					curPage = nextPage;
					x = 0;
					curPage.x = 0;
					flag = 0;
					nextPage = null;
					curIndex--;
					mouseEnabled = true;
					if(btn_left&&curIndex==0){
						btn_left.visible = false;
					}
					if(btn_right&&curIndex!=dataProvider.length-1){
						btn_right.visible = true;
					}
					if (pageEndHandler)
					{
						pageEndHandler.runWith(curPage.data);
					}
					on(Event.MOUSE_DOWN, this, onMuseDown);
				}));
			} else
			{
				//mouseEnabled = false;
				Tween.clearTween(this);
				Tween.to(this, {x: 0}, 150, Ease.linearNone, Handler.create(this, function () {
					removeChild(nextPage);
					x = 0;
					curPage.x = 0;
					flag = 0;
					nextPage = null;
					mouseEnabled = true;
					on(Event.MOUSE_DOWN, this, onMuseDown);
				}));
			}
		}

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			init();
			_dataProvider = value;
			if (_dataProvider && _dataProvider.length)
			{
				curPage =new _itemRender(dataProvider[curIndex]);
				addChild(curPage);
				on(Event.MOUSE_DOWN, this, onMuseDown);
			}
			if(btn_left&&curIndex==0){
				btn_left.visible = false;
			}
			if(curIndex == dataProvider.length-1){
				btn_right.visible = false;
			}
		}

		public function init(){
			curIndex = 0;
			btn_left&&(btn_left.visible = false);
			btn_right&&(btn_right.visible = true);
			if(curPage){
				curPage.removeSelf();
			}
			if(nextPage){
				nextPage.removeSelf();
			}
		}

		public function update()
		{
			curPage.array = dataProvider[curIndex];
		}

		public function get totalPage():int
		{
			return _dataProvider.length;
		}

		private var btn_left:Sprite;
		private var btn_right:Sprite
		public function setPageSelector(leftSkin:Sprite, rightSkin:Sprite){
			btn_left = leftSkin;
			btn_right = rightSkin;
			btn_left.on(Event.CLICK,this,leftHandler);
			btn_right.on(Event.CLICK,this,rightHandler);
		}

		private function rightHandler():void
		{
			nextPage = new _itemRender(dataProvider[curIndex + 1]);
			nextPage.x = -_wid;
			addChild(nextPage);
			mouseEnabled = false;
			btn_left.mouseEnabled = btn_right.mouseEnabled = false;
			Tween.clearTween(this);
			Tween.to(this, {x: -_wid}, 150, Ease.linearNone, Handler.create(this, function () {
				removeChild(curPage);
				curPage = nextPage;
				x = 0;
				curPage.x = 0;
				flag = 0;
				nextPage = null;
				curIndex++;
				mouseEnabled = true;
				btn_left.mouseEnabled = btn_right.mouseEnabled = true;
				if(btn_right&&curIndex==dataProvider.length-1){
					btn_right.visible = false;
				}
				if (pageEndHandler)
				{
					pageEndHandler.runWith(curPage.data);
				}
				if(curIndex == dataProvider.length-1){
					btn_right.visible = false;
				}
				if(btn_left&&curIndex!=0){
					btn_left.visible = true;
				}
			}));
		}

		private function leftHandler():void
		{
			nextPage = new _itemRender(dataProvider[curIndex - 1]);
			nextPage.x = -_wid;
			addChild(nextPage);
			mouseEnabled = false;
			btn_left.mouseEnabled = btn_right.mouseEnabled = false;
			Tween.clearTween(this);
			Tween.to(this, {x: _wid}, 150, Ease.linearNone, Handler.create(this, function () {
				removeChild(curPage);
				curPage = nextPage;
				x = 0;
				curPage.x = 0;
				flag = 0;
				nextPage = null;
				curIndex--;
				mouseEnabled = true;
				btn_left.mouseEnabled = btn_right.mouseEnabled = true;
				if(btn_left&&curIndex==0){
					btn_left.visible = false;
				}
				if(btn_right&&curIndex!=dataProvider.length-1){
					btn_right.visible = true;
				}
				if (pageEndHandler)
				{
					pageEndHandler.runWith(curPage.data);
				}
			}));
		}
	}
}

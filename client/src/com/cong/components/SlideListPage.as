package com.cong.components
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.List;
	import laya.utils.Browser;
	import laya.utils.Dictionary;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class SlideListPage extends Sprite
	{
		public var curPageIndex:int;
		private var _curPage:List;
		private var nextPage:List;
		private var _dataProvider:Array;
		private var _wid:Number;
		private var _hei:Number;
		private var _repeatX:int;
		private var _repeatY:int;
		private var startMouseX:Number;
		private var startMouseY:Number;
		public var pageEndHandler:Handler;
		private var _itemRender:Class;
		private var _renderHandler:Handler;
		public var itemSelectHandler:Handler;
		private var pages:Dictionary;

		public function SlideListPage(wid:Number, hei:Number, repeatX:int, repeatY:int, itemRender:Class, renderHandler:Handler, dp:Array = null)
		{
			width = _wid = wid;
			height = _hei = hei;
			_repeatX = repeatX;
			_repeatY = repeatY;
			_dataProvider = dp;
			_itemRender = itemRender;
			_renderHandler = renderHandler;
			if (_dataProvider)
			{
				dataProvider = _dataProvider;
			}
			on(Event.DISPLAY,this,onDisplay);
			on(Event.UNDISPLAY,this,onunDisplay);
		}

		private var _isMouseDown:Boolean;
		private function onunDisplay():void
		{
			off(Event.MOUSE_DOWN,this,setMouseDown);
			stage.off(Event.MOUSE_UP,this,setMouseUp);
		}

		private function setMouseUp():void
		{
			_isMouseDown = false;
		}

		private function setMouseDown():void
		{
			_isMouseDown = true;
		}

		private function onDisplay():void
		{
			_isMouseDown = false;
			on(Event.MOUSE_DOWN,this,setMouseDown);
			stage.on(Event.MOUSE_UP,this,setMouseUp);
		}

		private var _delta:Number = 0;
		private var _lastTimer:Number = 0;
		private function onMuseDown():void
		{
			startMouseX = stage.mouseX;
			startMouseY = stage.mouseY;
			stage.on(Event.MOUSE_MOVE, this, onMuseMove);
			_curPage.selectEnable = true;
			_lastTimer = Browser.now();
		}

		private var flag:int = 0;     //1下一页，-1上一页
		private function onMuseMove():void
		{
			if(!_isMouseDown){
				return;
			}
			if(startMouseX!=stage.mouseX||startMouseY!=stage.mouseY){
				_curPage.selectEnable = false;
			}
			stage.on(Event.MOUSE_UP, this, pageEnd);
			stage.on(Event.MOUSE_OUT, this, pageEnd);
			this.x = stage.mouseX - startMouseX;
			if (0 == curPageIndex && this.x >= 0)
			{
				this.x = (stage.mouseX - startMouseX)/3;
				return;
			} else if (_dataProvider.length - 1 == curPageIndex && this.x <= 0)
			{
				this.x = (stage.mouseX - startMouseX)/3;
				return;
			}
			if (!nextPage)
			{
				if (stage.mouseX - startMouseX > 0)
				{
					flag = 1;
					nextPage = createList(dataProvider[curPageIndex - 1]);
					nextPage.x = -_wid;
					addChild(nextPage);
				} else if (stage.mouseX - startMouseX < 0)
				{
					flag = -1;
					nextPage = createList(dataProvider[curPageIndex + 1]);
					nextPage.x = _wid;
					addChild(nextPage);
				}
			} else
			{
				if (flag == 1 && stage.mouseX - startMouseX < 0)
				{
					flag = -1;
					removeChild(nextPage);
					nextPage = createList(dataProvider[curPageIndex - 1]);
					nextPage.x = _wid;
					addChild(nextPage);
				} else if (flag == -1 && stage.mouseX - startMouseX > 0)
				{
					removeChild(nextPage);
					flag = 1;
					nextPage = createList(dataProvider[curPageIndex + 1]);
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
			//下一页
			if (_dataProvider.length - 1 != curPageIndex&&(stage.mouseX - startMouseX < -_wid / 2 || (stage.mouseX - startMouseX < 0 && _delta < 200)))
			{
				//mouseEnabled = false;
				Tween.to(this, {x: -_wid}, 300, Ease.linearNone, Handler.create(this, function () {
					removeChild(_curPage);
					_curPage = nextPage;
					x = 0;
					_curPage.x = 0;
					nextPage = null;
					curPageIndex++;
					mouseEnabled = true;
					if (pageEndHandler)
					{
						pageEndHandler.runWith(flag);
					}
					flag = 0;
					on(Event.MOUSE_DOWN, this, onMuseDown);
				}));

			} else if (0 != curPageIndex&&(stage.mouseX - startMouseX > _wid / 2 || (stage.mouseX - startMouseX > 0 && _delta < 200)))
			{
				//mouseEnabled = false;
				Tween.to(this, {x: _wid}, 300, Ease.linearNone, Handler.create(this, function () {
					removeChild(_curPage);
					_curPage = nextPage;
					x = 0;
					_curPage.x = 0;
					nextPage = null;
					curPageIndex--;
					mouseEnabled = true;
					if (pageEndHandler)
					{
						pageEndHandler.runWith(flag);
					}
					flag = 0;
					on(Event.MOUSE_DOWN, this, onMuseDown);
				}));
			} else
			{
				//mouseEnabled = false;
				Tween.to(this, {x: 0}, 300, Ease.linearNone, Handler.create(this, function () {
					removeChild(nextPage);
					x = 0;
					_curPage.x = 0;
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
			_dataProvider = value;
			curPageIndex = 0;
			pages = new Dictionary();
			if(_curPage){
				_curPage.removeSelf();
			}
			if(nextPage){
				nextPage.removeSelf();
			}
			if (_dataProvider && _dataProvider.length)
			{
				_curPage = createList(dataProvider[curPageIndex]);
				addChild(_curPage);
				on(Event.MOUSE_DOWN, this, onMuseDown);
			}
		}

		private var curSel:List;
		public function createList(data:Array)
		{
			if(pages.get(data)){
				return pages.get(data);
			}
			var page:List = new List();
			page.selectHandler = new Handler(this, function (index:int) {
				if(index!=-1){
					if (itemSelectHandler)
					{
						itemSelectHandler.runWith(page.selectedItem);
						if(curSel&&curSel!=page){
							curSel.selectedItem = null;
						}
						curSel = page;
					}
					stage.off(Event.MOUSE_MOVE, this, onMuseMove);
					stage.off(Event.MOUSE_UP, this, pageEnd);
					stage.off(Event.MOUSE_OUT, this, pageEnd);
				}
			});
			page.selectEnable = true;
			page.itemRender = _itemRender;
			page.renderHandler = _renderHandler;
			page.repeatX = _repeatX;
			page.repeatY = _repeatY;
			page.array = data;
			pages.set(data,page);
			return page;
		}

		public function get totalPage():int
		{
			return _dataProvider.length;
		}

		public function get pageSize(){
			return _repeatY*_repeatX;
		}


		public function get curPage():List
		{
			return _curPage;
		}

		public function gotoPageIndex(page:int,index:int){
			if(_curPage){
				_curPage.removeSelf();
			}
			if(nextPage){
				nextPage.removeSelf();
			}
			_curPage = createList(dataProvider[page]);
			_curPage.selectedIndex = index;
			curPageIndex = page;
			addChild(_curPage);
		}
	}
}

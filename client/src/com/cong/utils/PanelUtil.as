package com.cong.utils
{
	import laya.display.Sprite;
	import laya.events.EventDispatcher;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Dialog;
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class PanelUtil extends EventDispatcher
	{
		public function PanelUtil()
		{
		}

		private var splitImg:Image;
		private var foldH:int;

		private var topbg:Image = new Image();
		private var bottombg:Image = new Image();

		private var _isFold:Boolean = false;
		private var panel:Dialog;
		private var initHeight:Number;

		public static const UNFOLD_END:String = "UNFOLD_END";
		public static const FOLD_END:String = "FOLD_END";
		public function splitPanel(dialog:Dialog){
			this.panel = dialog;
			initHeight = panel.height;
			splitImg = panel.getChildByName("splitImg") as Image;
			var bg:Image = panel.getChildByName("bg") as Image;
			foldH = splitImg.height + 3;
			bg.removeSelf();
			topbg.graphics.fillTexture(Laya.loader.getRes(bg.skin), 0, 0, bg.width, splitImg.y + foldH);
			bottombg.graphics.fillTexture(Laya.loader.getRes(bg.skin), 0, 0, bg.width, bg.height - splitImg.y - foldH, "repeat", new Point(0, bg.height - splitImg.y - foldH));
			bottombg.y = splitImg.y;
			for (var i:int = 0; i < panel.numChildren; i++)
			{
				var child:Sprite = panel.getChildAt(i) as Sprite;
				if (child.y < (splitImg.y + foldH))
				{
					topbg.addChild(child);
				} else
				{
					child.y -= (splitImg.y + foldH);
					bottombg.addChild(child);
				}
				i--;
			}
			topbg.scrollRect = new Rectangle(0, -3, panel.width + 3, splitImg.y);
			panel.addChildAt(topbg, 0);
			panel.addChild(bottombg);
			this.panel.height = initHeight - splitImg.height;
		}

		public function fold(){
			if(!_isFold){
				Tween.to(bottombg, {y: splitImg.y}, 300, null);
				Tween.to(panel, {y: panel.y + splitImg.height/2}, 300, null);
				Tween.to(topbg.scrollRect, {height: splitImg.y}, 300,null,Handler.create(this,foldEnd));
				_isFold = true;
				this.panel.height = initHeight - splitImg.height;
			}
		}

		private function foldEnd():void
		{
			event(FOLD_END);
		}

		public function unfold(){
			if(_isFold){
				Tween.to(bottombg, {y: splitImg.y + foldH}, 300, null);
				Tween.to(panel, {y: panel.y - splitImg.height/2}, 300, null);
				Tween.to(topbg.scrollRect, {height: splitImg.y + foldH}, 300, null,Handler.create(this,unfoldEnd));
				_isFold = false;
				this.panel.height = initHeight;
			}
		}

		private function unfoldEnd():void
		{
			event(UNFOLD_END);
		}

		public function get isFold():Boolean
		{
			return _isFold;
		}

		public function set isFold(value:Boolean):void
		{
			_isFold = value;
			if(value){
				bottombg.y = splitImg.y;
				topbg.scrollRect.height =  splitImg.y;
				this.panel.height = initHeight - splitImg.height;
			}else{
				bottombg.y = splitImg.y + foldH;
				topbg.scrollRect.height = splitImg.y + foldH;
				this.panel.height = initHeight;
			}
		}
	}
}

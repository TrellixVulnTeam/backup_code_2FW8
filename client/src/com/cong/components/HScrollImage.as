package com.cong.components
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class HScrollImage extends Sprite
	{
		private var _wid:Number;
		private var _hei:Number;
		private var _images:Array;
		private var _imageIndex:int;
		private var _imageCnt:Sprite = new Sprite();
		private var _tweenCb:Handler;
		public function HScrollImage(wid:Number, hei:Number, tweenCb:Handler = null)
		{
			_wid = wid;
			_hei = hei;
			_tweenCb = tweenCb;
			addChild(_imageCnt);
			this.scrollRect = new Rectangle(0,0,wid,hei);
		}

		public function set images(arr:Array):void
		{
			_images = arr;
			for (var i:int = 0; i < arr.length; i++)
			{
				var image:Image = new Image(arr[i]);
				image.x = i*_wid;
				_imageCnt.addChild(image);
			}
			_imageIndex = 0 ;
		}

		public function run(){
			Laya.timer.loop(2000,this,scrollHandler);
		}

		private function scrollHandler():void
		{
			_imageIndex++;
			if(_imageIndex==_images.length){
				_imageIndex=0;
			}
			Tween.to(_imageCnt,{x:-_imageIndex*_wid},500,null,_tweenCb);
		}

		public function stop(){
			Laya.timer.clear(this,scrollHandler);
		}

		public function set imageIndex(value:int):void
		{
			_imageIndex = value;
			stop();
			Tween.clearTween(_imageCnt);
			Tween.to(_imageCnt,{x:-_imageIndex*_wid},500,null,new Handler(this,run));
		}

		public function get imageIndex():int
		{
			return _imageIndex;
		}
	}
}

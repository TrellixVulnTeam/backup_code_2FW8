package com.cong.components
{
	import com.cong.display.TextureFont;

	import game.constants.CONST_FILE;

	import laya.display.Sprite;

	public class FlashTitle extends Sprite
	{
		private var curIndex:int = 0;
		private var text:String = ".";
		private var cell:Array = [".", "工", "厂", "统", "计", "挖", "矿", "星", "球", "能", "源"];
		private var count:int;
		private var _title:String;
		private var _startIndex:int;
		private var _container:Sprite;

		public function FlashTitle(startIndex = 1)
		{
			_startIndex = startIndex;
		}

		private static var _instance:FlashTitle;
		public static function get instance():FlashTitle
		{
			if (null == _instance)
			{
				_instance = new FlashTitle();
			}
			return _instance;
		}

		private function drawText():void
		{
			if (count % 3 == 0)
			{
				var rand:int = parseInt(Math.random() * cell.length);
				text += cell[rand];
			} else if (count % 3 == 1)
			{
				var rand:int = parseInt(Math.random() * cell.length);
				text = text.slice(0, -1);
				text += cell[rand];
			} else
			{
				text = text.slice(0, -1);
				text += _title.charAt(curIndex);
				curIndex++;
				if (curIndex == _title.length)
				{
					Laya.timer.clear(this, drawText);
				}
			}
			count++;
			if(_container){
				TextureFont.drawText(CONST_FILE.getNumFont("title"), text, _container, 0, 0, "left", 158, 2);
			}else{
				TextureFont.drawText(CONST_FILE.getNumFont("title"), text, this, 0, 0, "left", 158, 2);
			}
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_container = null;
			if(_title!=value){
				count = 0;
				_title = value;
				curIndex = _startIndex;
				text = title.substr(0, _startIndex);
				Laya.timer.loop(50, this, drawText);
			}
		}

		public function drawTitle(cont:Sprite,value:String){
			_container = cont;
//			if(_title){
//				TextureFont.drawText(CONST_FILE.getNumFont("title"), _title, _container, 0, 0, "left", 158, 2);
//			}
			if(_title!=value){
				count = 0;
				_title = value;
				curIndex = _startIndex;
				text = title.substr(0, _startIndex);
				Laya.timer.loop(50, this, drawText);
			}
		}
	}
}

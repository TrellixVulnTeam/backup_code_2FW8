package game.view.map.minigame.magicTouch
{
	import ui.map.minigame.TreasureUI;

	public class TreasureItem extends TreasureUI
	{
		private var _id:int;
		//记录初始速度
		private var _startSpeed:Number;
		//当前下落速度
		private var speed:Number;
		private var _score:Number;

		//手势类型
		private var _type:int;
		private var _extra:Object;
		public function TreasureItem()
		{
			super();
		}

		//让宝箱下落
		public function down()
		{
			y += speed * Laya.timer.delta / 1000;
		}

		public function init(type:Number, id:Number, speed:Number, score:Number)
		{
			this.type = type;
			this._id = id;
			this.speed = speed;
			_startSpeed = speed;
			_score = score;
			_extra = null;

			//清除之前的事件
			Laya.timer.clear(this, addForce);
			Laya.timer.loop(1000, this, addForce);
		}

		public function get id():int
		{
			return _id;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
			//txt_index.text = _type.toString();
			//*根据手势类型show_img切换不同的skin
			show_img.skin = typeImgFullPath;
		}

		private function get typeImgFullPath():String
		{
			return "map/minigame/" + this._type + "_touchtype.png";
		}

		public function set ballonSkin(urlString:String):void
		{
			this.balloon.skin = "map/minigame/treasure_" + urlString + ".png";
		}

		public function set treasureSkin(urlString:String):void
		{
			this.treasure.skin = "map/minigame/treasure_" + urlString + ".png";;
		}

		//应用加速度
		private function addForce():void
		{
			speed += acceleSpeed;
		}

		//计算加速度
		private function get acceleSpeed():Number
		{
			return 1;
		}

		public function get score():Number
		{
			return _score;
		}

		public function setExtras(extra:Object)
		{
			if (_extra == null)
			{
				_extra = extra;
			}
			for (var key:String in extra)
			{
				_extra[key] = extra[key];
			}
		}
	}
}

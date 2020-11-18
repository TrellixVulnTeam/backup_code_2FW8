package game.view.map
{
	import ui.map.CustomerUI;

	public class Customer extends CustomerUI implements IRole
	{
		private var _path:Array;
		private var _pIndex:int;
		private var _speed:Number = 10;
		private var BACK_DELAY:int = 10000;
		private var _moving:Boolean = false;
		private var _isBack:Boolean = false; //是否回程
		public function Customer()
		{
			super();
		}

		public function get path():Array
		{
			return _path;
		}

		public function set path(value:Array):void
		{
			_path = value;
			_pIndex = 0;
			this.x = path[0];
			this.y = path[1];
			visible = false;
			_moving = false;
			Laya.timer.once(Math.random() * BACK_DELAY, this, movePath);
		}

		public function movePath():void
		{
			_moving = true;
		}

		public function update():void
		{
			if(_moving){
				var targetX:Number = path[_pIndex];
				// 路径节点X值
				var targetY:Number = path[_pIndex + 1];
				// 路径节点Y值
				var dx:Number = targetX - this.x;
				// 路径节点X 与 人物X值差值
				var dy:Number = targetY - this.y;
				// 路径节点Y 与 人物Y值差值
				var dist:Number = Math.sqrt(dx * dx + dy * dy);
				// 距离

				if (dist <= _speed) // 判断走步到位
				{
					_pIndex += 2;
					// 更新步数
					if (_pIndex >= path.length) // 步数等于路径，行走结束
					{
						path.reverse();
						for (var i:int = 0; i < path.length; i += 2)
						{
							var y:Number = path[i];
							var x:Number = path[i + 1];
							path[i] = x;
							path[i + 1] = y;
						}
						visible = false;
						_moving = false;
						_pIndex = 0;
						_isBack = !_isBack;
						Laya.timer.once(BACK_DELAY, this, function () {
							visible = true;
							_moving = true;
						})
					} else
					{
						update();
					}
				} else
				{
					this.x += dx / dist * _speed;
					this.y += dy / dist * _speed;
				}
			}
		}

		public function tip()
		{

		}

		public function get moving():Boolean
		{
			return _moving;
		}

		public function get isBack():Boolean
		{
			return _isBack;
		}

		public function set isBack(value:Boolean):void
		{
			_isBack = value;
		}
	}
}

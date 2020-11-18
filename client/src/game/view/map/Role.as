package game.view.map
{
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class Role extends Actor
	{
		private var _data:Object;
		private var _path:Array;
		private var _pIndex:int;
		private var _speed:Number = 5;

		public function Role(data:Object)
		{
			super();
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function get path():Array
		{
			return _path;
		}

		public function set path(value:Array):void
		{
			_path = value;
			_pIndex = 0;
			this.x = path[0].x;
			this.y = path[0].y;

			Laya.timer.frameLoop(1, this, moveRole);
			//移动开始,变更动画
			playWalk();
		}

		private function moveRole():void
		{
			if (path[_pIndex].isStartPoint)
			{
				tweenCenter(path[_pIndex].x, path[_pIndex].y);
				Laya.timer.clear(this, moveRole);
				return;
			}
			var targetX:Number = path[_pIndex].x;
			// 路径节点X值
			var targetY:Number = path[_pIndex].y;
			// 路径节点Y值
			var dx:Number = targetX - this.x;
			// 路径节点X 与 人物X值差值
			var dy:Number = targetY - this.y;
			// 路径节点Y 与 人物Y值差值
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			// 距离
			if (dist <= _speed) // 判断走步到位
			{
				_pIndex++;
				// 更新步数
				if (_pIndex >= path.length) // 步数等于路径，行走结束
				{
					_pIndex = 0;
					Laya.timer.clear(this, moveRole);
					//移动结束,变更动画
					playIdle();
				} else
				{
					if (path[_pIndex].x - path[_pIndex - 1].x >= 0)
					{
						skeleton.scaleX = -1;
					} else
					{
						skeleton.scaleX = 1;
					}
					moveRole();
				}
			} else
			{
				this.x += dx / dist * _speed;
				this.y += dy / dist * _speed;
			}
		}


		//缓动到地图中心位置
		public function tweenCenter(xPos:Number, yPos:Number)
		{
			Tween.to(this, {x: xPos, y: yPos}, 2000, null, new Handler(this, function () {
				_pIndex++;
				if (_pIndex < path.length) // 步数等于路径，行走结束
				{
					Laya.timer.frameLoop(1, this, moveRole);
				}
//					if (godState == "")
//					{
//						actor.removeBuffer();
//					} else
//					{
//						actor.addBuffer(godState.split(",")[0]);
//					}
//					//路过房产
//					if (_walkData.money)
//					{
//						actor.showSpeak(_walkData.money);
//					}
			}));
		}
	}
}

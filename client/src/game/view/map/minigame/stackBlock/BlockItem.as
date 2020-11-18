package game.view.map.minigame.stackBlock
{
	import game.view.map.minigame.V_StackBlock;

	import laya.maths.Point;
	import laya.ui.Box;

	import ui.map.minigame.stackBlock.BlockUI;

	public class BlockItem extends BlockUI
	{
		private var _g:Number = 1;
		private var _vy:Number = 12;
		private var _state:int = 1;   //1未释放   2释放中   3连接上  4掉落边缘
		private var _baseBlock:BlockItem;
		private var posX:Number;
		private var posY:Number;
		public static const BLOCK_HEI:Number = 132;

		public function BlockItem()
		{
		}

		public function release()
		{
			_state = 2;
		}

		public function join()
		{
			_state = 3;
		}

		public function update()
		{
			if (_state == 1)
			{
				this.x = posX;
				this.y = posY;
			}
			if (_state == 2)
			{
				_vy += _g;
				y += _vy;
				rotation *= 0.95;
				if (_baseBlock)
				{
					var lp:Point = (_baseBlock.parent as Box).globalToLocal(new Point(this.x, this.y));
					if (_baseBlock.y - lp.y - this.height <= _vy && _baseBlock.y - lp.y > 0)
					{
						if (Math.abs(lp.x - _baseBlock.x) < width * 0.65)
						{
							_state = 3;
							event("state_change");
							this.y = _baseBlock.y - this.height;
						} else if (Math.abs(lp.x - _baseBlock.x) >= width * 0.65 && Math.abs(lp.x - _baseBlock.x) <= width)
						{
							_state = 4;
							_vy = 0;
							event("dropEdge");
						}
					}
				} else
				{
					if (y >= V_StackBlock.instance.cont_block.y)
					{
						_state = 3;
						event("state_change");
						this.y = 0;
					}
				}

				if (this.y > Laya.stage.height)
				{
					event("dropEmpty");
				}
			}
			if (_state == 4)
			{
//				rotation += 5;
//				y+=_vy;
//				_vy += _g;
			}
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
		}

		public function setBaseBlock(block:BlockItem)
		{
			_baseBlock = block;
		}

		public function setPos(posX:Number, posY:Number)
		{
			this.posX = posX;
			this.posY = posY;
		}

		public function dispose():void
		{
			removeSelf();
		}
	}
}

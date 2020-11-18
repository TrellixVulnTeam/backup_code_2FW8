package com.cong.utils
{
	import laya.maths.Point;

	public class DirectionUtil
	{
		private static var DIR_ARRAY:Array = [[Direction.RIGHT, Direction.RIGHT_UP, Direction.UP], [Direction.LEFT, Direction.LEFT_UP, Direction.UP], [Direction.LEFT, Direction.LEFT_DOWN, Direction.DOWN], [Direction.RIGHT, Direction.RIGHT_DOWN, Direction.DOWN]];

		public static function GetDirection(p1:Point, p2:Point):int
		{
			if (p1 == null || p2 == null)
			{
				return (0);
			}
			return GetDirectionEx(p1.x, p1.y, p2.x, p2.y);
		}

		public static function GetDirectionEx(x1:int, y1:int, x2:int, y2:int):int
		{
			var _index:int;
			var _px:int = (x2 - x1);
			var _py:int = (y2 - y1);
			var _dirIndex:int = 1;
			if (Math.abs(_px) > Math.abs(_py))
			{
				_dirIndex = 0;
			} else
			{
				if (Math.abs(_px) < Math.abs(_py))
				{
					_dirIndex = 2;
				}
			}
			if (_px && _py)
			{
				_dirIndex = 1;
			}
			if (_py <= 0)
			{
				_index = (_px <= 0) ? 1 : 0;
			} else
			{
				_index = (_px <= 0) ? 2 : 3;
			}
			return DIR_ARRAY[_index][_dirIndex];
		}

	}
}
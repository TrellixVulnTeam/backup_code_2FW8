package com.cong.utils
{
	import flash.display.DisplayObject;

	/**
	 *游戏具体业务排序类
	 * @author luoAdministrator
	 *
	 */
	public class GameUtil_Sort
	{
		public function GameUtil_Sort()
		{

		}

		/**
		 *显示对象按照y排序
		 * @param a
		 * @param b
		 * @return
		 *
		 */
		public static function sortDisplayFun(a:DisplayObject, b:DisplayObject):Number
		{
			if (a.y < b.y)
			{
				return -1;
			} else if (a.y > b.y)
			{
				return 1;
			} else if (a.y == b.y)
			{
				if (a.name && b.name)
				{
					if (a.name < b.name)
					{
						return -1;
					} else if (a.name > b.name)
					{
						return 1;
					}
				}
			}
			return 0;
		}
	}
}
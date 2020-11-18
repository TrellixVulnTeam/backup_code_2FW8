package com.cong.utils
{
	import laya.filters.ColorFilter;

	public class ColerFilterUtil
	{
		public function ColerFilterUtil()
		{
		}

		private static var redFilter:ColorFilter;
		public static function getRedFilter():ColorFilter
		{
			if (redFilter == null)
			{
				var _local_1:Array = [1.5, 0, 0, 0, 120, 0, 0.4, 0, 0, 0, 0, 0, 0.3, 0, 0, 0, 0, 0, 1, 0];
				redFilter = new ColorFilter(_local_1);
			}
			return redFilter;
		}
	}
}

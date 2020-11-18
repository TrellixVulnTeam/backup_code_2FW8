package com.cong.utils
{
	/**
	 * 对象缓存管理类。由它删除的对象不会被清除，可以在被创建的时候重新使用。
	 *
	 *
	 */
	public class CacheManager
	{
		private static var _instance:CacheManager;
		static public function get instance():CacheManager
		{
			if (_instance == null)
			{
				_instance = new CacheManager();
			}
			return _instance;
		}

		public var dict:Object = new Object();

		public function CacheManager()
		{
			super();
		}

		/**
		 * 创建一个对象
		 *
		 * @return
		 *
		 */
		public function create(ref:Class):*
		{
			var list:Array = dict[ref];
			if (list)
			{
				var obj:* = list.pop();
				if (list.length == 0)
					delete dict[ref];
				return obj;
			} else
				return new ref();
		}

		/**
		 * 回收一个对象
		 *
		 * @return
		 *
		 */
		public function remove(obj:*):void
		{
			var ref:Class = obj.constructor as Class;
			if (!dict[ref])
				dict[ref] = [];
			(dict[ref] as Array).push(obj);
		}

		/**
		 * 清除缓存
		 *
		 * @return
		 *
		 */
		public function clear(ref:Class = null):*
		{
			if (ref == null)
				dict = new Object(); else
				delete dict[ref];
		}
	}
}
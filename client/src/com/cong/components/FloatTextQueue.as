package com.cong.components
{
	public class FloatTextQueue
	{
		public function FloatTextQueue()
		{
		}

		private static var _instance:FloatTextQueue;
		public static function get instance():FloatTextQueue
		{
			if (null == _instance)
			{
				_instance = new FloatTextQueue();
			}
			return _instance;
		}

		public function floatItems(){
			var item:FloatingText
		}
	}
}

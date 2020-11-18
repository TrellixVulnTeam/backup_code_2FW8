package com.cong.utils
{
	public class Uint32ToBinary
	{
		
		private var _value:uint;
		private var _arr:Vector.<int> = new Vector.<int>();
		public function Uint32ToBinary(value_:uint)
		{
			_value = value_;
			var str:String = _value.toString(2);
			if(str.length > 0)
			{
				for(var i:int = str.length - 1;i >=0;i--)
				{
					_arr.push(int(str.charAt(i)));
				}
			}
			
		}
//		public function ishasWeekGift():Boolean
//		{
//			for (var i:int = 1; i < _arr.length; i++)
//			{
//				if(_arr[i]==1)
//				{
//					return true;
//				}
//			}
//			return false;
//		}
		/**
		 * 
		 * @param index_ 0开始
		 * @return 默认返回0
		 * 
		 */
		public function getValue(index_:int):int
		{
			if(index_ < 0)
			{
				return 0;
			}
			if(index_ < _arr.length)
			{
				return _arr[index_];
			}
			return 0;
		}
		
		/**
		 * 设置第几项的值
		 * @param index_  第几项  0开始
		 * @param indexValue_  第几项的值
		 * 
		 */
		public function setValue(index_:int,indexValue_:int):void
		{
			while(index_ >= _arr.length)
			{
				_arr.push(0);
			}
			_arr[index_] = indexValue_;
		}
	}
}
package com.cong.utils
{
	/**
	 * ...
	 * @author weoweo
	 */

		// 二分插入排序 用以排序性能。
	public class Arrange
	{

		private var _arr:Array;
		private var _compareFun:Function;
		private var _key:String;
		private var _desending:Boolean = true;

		public function Arrange()
		{
			init();
		}

		private function init():void
		{
			_arr = [];
			_compareFun = compares;
		}

		public function get length():int
		{
			return _arr.length;
		}

		public function set desending(d:Boolean):void
		{
			this._desending = d;
		}

		public function enqueue(obj:Object):void
		{

			var len:int = _arr.length;
			if (len < 1)
			{
				_arr.push(obj);
				return;
			}

			var s:int = 0;
			var e:int = len - 1;

			while (len > 1)
			{

				var mid:int = s + len / 2;
				var result:int = _compareFun(obj, _arr[mid]);
				switch (result)
				{
					case -1:
						s = mid;
						break;
					case 0:
						_arr.splice(mid, 0, obj);
						return;
						break;
					case 1:
						e = mid;
						break;
				}
				len = e - s;
			}

			result = _compareFun(obj, _arr[s]);
			if (result == 1 || result == 0)
			{
				_arr.splice(s, 0, obj);
				return;
			}
			result = _compareFun(obj, _arr[e]);
			if (result == 1 || result == 0)
			{
				_arr.splice(e, 0, obj);
				return;
			} else
			{
				_arr.splice(e + 1, 0, obj);
			}

		}

		public function set key(k:String):void
		{
			if (k != null && k != "") this._key = k;
		}

		public function set compareWitchNum(b:Boolean):void
		{

			if (b)
			{
				_compareFun = cwitchNum;
			}
		}

		private function cwitchNum(n:Number, m:Number):int
		{

			var result:Number = n - m;
			if (!_desending) result *= -1;
			if (result < 0) return -1;
			if (result > 0) return 1;
			return 0;
		}

		private function compares(obja:Object, objB:Object):int
		{

			var result:Number = obja[_key] - objB[_key];
			if (!_desending) result *= -1;
			if (result < 0) return -1;
			if (result > 0) return 1;
			return 0;
		}

		public function dequeue():Object
		{

			return _arr.pop();
		}

		public function shift():Object
		{
			return _arr.shift();
		}

		public function get array():Array
		{
			return _arr;
		}

		public function clear():void
		{
			_arr = [];
		}

		public function rePlaceArr(arr:Array, des:Boolean = true, key:String = ""):Array
		{
			if (arr == null || arr.length < 2) return arr;
			if (key == null || key == "") _compareFun = cwitchNum;
			this.desending = des;
			clear();
			for each(var obj:Object in arr)
			{
				enqueue(obj);
			}
			arr = array;
			return arr;
		}

	}

}
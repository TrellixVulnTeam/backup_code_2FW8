package com.cong.utils
{
	public class HashMap
	{

		private var length:int;
		private var content:Object;

		public function HashMap()
		{
			this.length = 0;
			this.content = new Object();
		}

		public function size():int
		{
			return this.length;
		}

		public function isEmpty():Boolean
		{
			return (this.length == 0);
		}

		public function keys():Array
		{
			var key:*;
			var index:int;
			var arr:Array = new Array(this.length);
			for (key in this.content)
			{
				arr[index] = key;
				index++;
			}
			return arr;
		}

		public function eachKey(func_:Function, ...args):void
		{
			var key:*;
			for (key in this.content)
			{
				func_.apply(null, [key].concat(args));
			}
		}

		public function eachValue(func_:Function, ...args):void
		{
			var val:*;
			for each(val in this.content)
			{
				func_.apply(null, [val].concat(args));
			}
		}

		public function values():Array
		{
			var val:*;
			var index:int;
			var arr:Array = new Array(this.length);
			for each(val in this.content)
			{
				arr[index] = val;
				index++;
			}
			return arr;
		}

		public function containsValue(val_:*):Boolean
		{
			var val:*;
			for each (val in this.content)
			{
				if (val === val_)
				{
					return true;
				}
			}
			return false;
		}

		public function containsKey(key_:*):Boolean
		{
			if (this.content[key_] != undefined)
			{
				return true;
			}
			return false;
		}

		public function getValue(key_:*):*
		{
			var val:* = this.content[key_];
			if (val !== undefined)
			{
				return val;
			}
			return null;
		}

		public function getKey(val_:*):*
		{
			for (var key:String in content)
			{
				var value:* = content[key];
				if (value == val_)
				{
					return key;
				}
			}
			return null;
		}

		public function put(key_:*, val_:*):*
		{
			if (key_ == null)
			{
				//throw (new ArgumentError("cannot put a value with undefined or null key!"));
			}
			if (val_ == null)
			{
				return this.remove(key_);
			}
			if (!this.containsKey(key_))
			{
				this.length++;
			}
			var oldVal:* = this.getValue(key_);
			this.content[key_] = val_;
			return oldVal;
		}

		public function remove(key_:*):*
		{
			if (!this.containsKey(key_))
			{
				return null;
			}
			var oldVal:* = this.content[key_];
			delete this.content[key_];
			this.length--;
			return oldVal;
		}

		public function clear():void
		{
			this.length = 0;
			this.content = new Object();
		}

		public function clone():HashMap
		{
			var key:*;
			var newCopy:HashMap = new HashMap();
			for (key in this.content)
			{
				newCopy.put(key, this.content[key]);
			}
			return newCopy;
		}

		public function toString():String
		{
			var i:int;
			var ks:Array = this.keys();
			var vs:Array = this.values();
			var str:String = "HashMap Content:\n";
			while (i < ks.length)
			{
				str += (ks[i] + " -> " + vs[i] + "\n");
				i++;
			}
			return str;
		}


	}
} 


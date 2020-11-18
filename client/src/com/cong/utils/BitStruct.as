package com.cong.utils
{
	import laya.utils.Byte;

	public class BitStruct
	{
		private var Bit_String_Len:int = 255;
		private var valueByte:Array = [];

		public function BitStruct(len:int = 255)
		{
			Bit_String_Len = len;
		}

		public function unpack(bytes:Byte):void
		{
			var len:int = bytes.getUint16();
			if (len > Bit_String_Len)
			{
				throw new Error("超出设置 字节数");
			}
			valueByte.length = len;
			for (var i:int = 0; i < len; i++)
			{
				valueByte[i] = bytes.readByte();
			}
		}

		public function packBytes(bytes:Byte):void
		{
			bytes.writeShort(valueByte.length);
			for (var i:int = 0; i < valueByte.length; i++)
			{
				bytes.writeByte(valueByte[i] | (1 << 7));
			}
		}


		public function setValue(id:int, value:Boolean):Boolean
		{
			var index:int = id / 7;
			var index_lit:int = id % 7;
			if (index >= Bit_String_Len)
			{
				return false;
			}
			if (index + 1 > valueByte.length)
			{
//				valueByte.length=index + 1;
			}
			if (value)
			{
				valueByte[index] = valueByte[index] | (1 << index_lit);
			} else
			{
				valueByte[index] = valueByte[index] ^ (1 << index_lit);
			}

			return true;
		}

		public function getValue(id:int):Boolean
		{
			var index:int = id / 7;
			var index_lit:int = id % 7;
			if (index >= valueByte.length)
			{
				return false;
			}

			return Boolean(valueByte[index] & (1 << index_lit));
		}

		public function get bitNum():int
		{
			return valueByte.length * 7;
		}

	}
}

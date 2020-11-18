package com.cong.utils
{
	/**
	 * ...
	 * @author Fred
	 */
	public class ByteUtil 
	{
		/*public static function uncompressLayaByte(b:Byte):Byte
		{
			var ba:ByteArray = new ByteArray();
			var len:uint = b.bytesAvailable;
			for (var i:int = 0; i < len; i++) 
			{
				ba.writeByte(b.getUint8());
			}
			ba.uncompress();
			len = ba.bytesAvailable;
			b.clear();
			ba.pos = 0;
			for (i = 0; i < len; i++) 
			{
				b.writeByte(ba.readByte());
			}
			return b;
		}*/
		public static function uncompressArrayBuffer(b:*):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			ba.writeArrayBuffer(b);
			ba.uncompress();
			ba.pos = 0;
			return ba;
		}
	}

}
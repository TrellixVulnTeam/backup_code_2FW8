package com.cong.net
{
	import laya.utils.Byte;

	/**
	 * 通信包
	 */
	public class SocketPacket
	{
		//public var buffFrame:int;//包被缓存的帧数
		
		public var type:uint;
		public var data:Byte;
		
		public function SocketPacket(type_:uint=0, data_:Byte=null)
		{
			type = type_;
			data = data_;
		}
		/**
		 * 初始化数据
		 */
		public function initData():void
		{
			if (data == null) 
			{
				data = new Byte();
				data.endian = Byte.LITTLE_ENDIAN;
			}
			else 
			{
				//data.pos = 0;
				//data.length = 0;
				data.clear();
			}
			//data.endian = Endian.LITTLE_ENDIAN;
		}
		/**
		 * 清理操作
		 */
		public function clear():void 
		{
			if (data != null) 
			{
				//data.pos = 0;
				//data.length = 0;
				data.clear();
			}
			//buffFrame = 0;
		}
//		/**
//		 * 得到字节
//		 * @return
//		 */
//		public function getByte():uint
//		{
//			return data.getUint8();
//		}
//
//		public function getShort():uint
//		{
//			return data.getUint16();
//		}
//
//
//		public function getUInt64():UInt64
//		{
//			return UInt64.readBytes(data);
//		}
		public function writeByte(value:uint):void
		{
			data.writeByte(value);
		}
		
		public function writeUint16(value:uint):void 
		{
			data.writeUint16(value);
		}
		
//		public function writeInt(value:int):void
//		{
//			data.writeUint32(value);
//		}
//		public function writeInt2(value:int):void
//		{
//			data.writeInt32(value);
//		}
//
//		public function writeUInt64(value:Number):void
//		{
//			var temp:UInt64 = UInt64.readNumber(value);
//			temp.flush(data);
//		}
//		public function writeUTFString(value:String):void
//		{
//			data.writeUTFString(value);
//		}
	}
}
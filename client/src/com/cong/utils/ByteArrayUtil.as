package com.cong.utils
{
	import laya.utils.Byte;

	public class ByteArrayUtil
	{
		public static function flush(bytes_:Byte, content_:String, len:int = 0):void
		{
			var Byte:Byte = new Byte();
			if (len != 0) //定长
			{
				Byte.length = len;
				Byte.writeUTFBytes(content_);
				bytes_.writeBytes(Byte, 0, Byte.length);
			} else
			{ //变长

//				Byte.writeUTFBytes(content_);
//				bytes_.writeShort(Byte.length);
//				bytes_.writeBytes(Byte,0,Byte.length);			
				bytes_.writeUTF(content_);
			}
		}

		/**
		 *读取变长字符传（前面两个字节长度，后面是二进制流）
		 * @param bytes_
		 * @return
		 *
		 */
		public static function readString(bytes_:Byte):String
		{
			var str:String = "";
			var len:int = bytes_.getUint16();
			str = bytes_.readUTFBytes(len);
			return str;
		}

		/**
		 *读取字节流
		 * @param bytes_
		 * @return
		 *
		 */
		public static function readByte(bytes_:Byte):Array
		{
			var len:int = bytes_.getUint16();
			var byteDatas:Array = [];
			for (var i:int = 0; i < len; i++)
			{
				byteDatas.push(bytes_.readByte());
			}
			return byteDatas;
		}

		/**
		 *写入字节
		 * @param bytes_
		 * @return
		 *
		 */
		public static function writeToByte(bytes_:Byte, consten:Array, len:int = 0):void
		{
			var writeLen:int = len == 0 ? consten.length : len;
			bytes_.writeShort(writeLen);
			for (var i:int = 0; i < writeLen; i++)
			{
				bytes_.writeByte(consten[i]);
			}

		}


		public static function getDynamicAttribute(bytes_:Byte, data_:Object):void
		{
			var flagValue:uint = bytes_.getUint32();
			var numStr:String = flagValue.toString(2);
			var index:int = 0;
			for (var i:int = numStr.length - 1; i >= 0; i--)
			{
				var num:int = Number(numStr.charAt(i));
				switch (index)
				{
					case 0:
						if (num != 0)
						{
							data_["pow"] = bytes_.getUint32();
						}
						break;
					case 1:
						if (num != 0)
						{
							data_["def"] = bytes_.getUint32();
						}
						break;
					case 2:
						if (num != 0)
						{
							data_["hit"] = bytes_.getUint32();
						}
						break;
					case 3:
						if (num != 0)
						{
							data_["dodge"] = bytes_.getUint32();
						}
						break;
					case 4:
						if (num != 0)
						{
							data_["crit"] = bytes_.getUint32();
						}
						break;
					case 5:
						if (num != 0)
						{
							data_["toughness"] = bytes_.getUint32();
						}
						break;
					case 6:
						if (num != 0)
						{
							data_["maxHp"] = bytes_.getUint32();
						}
						break;
					case 7:
						if (num != 0)
						{
							data_["revivalatk"] = bytes_.getUint32();
						}
						break;
					case 8:
						if (num != 0)
						{
							data_["revivaldef"] = bytes_.getUint32();
						}
						break;
				}
				index++;
			}
		}

		/**
		 * 获取各个战斗力值
		 * */
		public static function getDynamicFighting(bytes_:Byte):HashMap
		{
			var combatNum:uint = bytes_.getUint16();

			var fightHashMap:HashMap = new HashMap();

			for (var i:int = 0; i < combatNum; i++)
			{
				var fightType:int = bytes_.getUint8();

				var fightValue:int = bytes_.getUint32();

				fightHashMap.put(fightType, fightValue);
			}

			return fightHashMap;

		}
	}
}

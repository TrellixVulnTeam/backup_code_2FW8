package com.cong.utils
{

	public class NumberUtils
	{
		public function NumberUtils()
		{
		}

		/**
		 * 取num的第多少位，1为true,0为false
		 * @param num
		 * @param bitIndex 0-31
		 * @return
		 *
		 */
		public static function getNumBit(num:uint, bitIndex:int):Boolean
		{
			return Boolean(num & (1 << (bitIndex)));
		}

		/**
		 *设置 一个正整数（num）第 bitIndex位的值为value
		 * @param num
		 * @param bitIndex 0-31
		 * @param value 0|1
		 *
		 */
		public static function setNumBit(num:uint, bitIndex:int, value:int):uint
		{
			return num | (value << (bitIndex));
		}
	}
}

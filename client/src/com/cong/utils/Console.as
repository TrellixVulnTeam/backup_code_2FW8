package com.cong.utils
{
	import laya.utils.Byte;

	public class Console
	{
		public function Console()
		{
		}

		/**
		 *游戏输出
		 *
		 */
		public static function log(...args):void
		{
			console.log(args);
		}


		public static function traceByte(byte_:Byte):void
		{
			var traceStr:String = "";
			for (var i:int = 0; i < byte_.length; i++)
			{
				traceStr += i + "|" + byte_[i].toString() + "\n";
				//				if((i!=0)&&(i % 10)==0)
				//				{
				//					traceStr+="\n";
				//				}				
			}
			console.log(traceStr);
		}

	}
}
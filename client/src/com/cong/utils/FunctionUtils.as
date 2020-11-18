package com.cong.utils
{

	public class FunctionUtils
	{
		public function FunctionUtils()
		{
		}

		public static function callFun(fun:Function, ...args):void
		{
			if (fun == null)
			{
				return;
			}
			if (fun.length)
			{
				fun.apply(null, args);
			} else
			{
				fun.apply();
			}
		}

	}
}

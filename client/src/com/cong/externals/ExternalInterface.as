package com.cong.externals
{
	/**
	 * ...
	 * @author Fred
	 */
	public class ExternalInterface 
	{
		
		public static function get available():Boolean
		{
			return true;
		}
		
		public static function call(functionName:String, ...rest):*
		{
			//var a:String = rest.join(",");
			return __JS__("this[functionName] ? this[functionName].apply(null, rest) : null");
		}
		
	}

}
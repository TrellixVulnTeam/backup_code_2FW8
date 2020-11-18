package com.cong.utils
{
	/**
	 * ...
	 * @author laya
	 */
	public class SortOn 
	{
		public static const CASEINSENSITIVE : uint = 1;
		public static const DESCENDING : uint = 2;
		public static const NUMERIC : uint = 16;
		public static const RETURNINDEXEDARRAY : uint = 8;
		public static const UNIQUESORT : uint = 4;
		
		public function SortOn() 
		{
			
		}
		
		private static function _sortonNameArray2_(array:Array, name:Array, options:int = 0):Array
		{
			var name0:String=name[0];
			var name1:String = name[1];
			var type:int = 1;
			if (options == (NUMERIC | DESCENDING)) type = -1;
			return array.sort( function (a:*, b:*):int 
			{
				if (b[name0]==a[name0])
				{
					return type * (a[name1] - b[name1]);
				}else 
					return type * (a[name0] - b[name0]);
			} );
		}

		private static function _sortonNameArray_(array:Array, name:Array, options:int = 0):Array
		{
			var name0:String = name[0];
			var type:int = 1;
			if (options == (NUMERIC | DESCENDING)) type = -1;
			return array.sort( function (a:*, b:*):int 
			{
				if (b[name0]==a[name0])
				{
					for (var i:int = 1, sz:int = name.length; i < sz; i++)
					{
						var tmp:String=name[i];
						if (b[tmp]!=a[tmp]) return type * (a[tmp] - b[tmp]);
					}
					return 0;
				}else 
					return type * (a[name0] - b[name0]);
			} );
		}
		
		public static function sortOn(array:Array, name:*, options:int=0):Array
		{
			//[IF-SCRIPT] if (name is Array) {if(name.length==0) return array;if(name.length==2) return _sortonNameArray2_(array,name,options);if(name.length>2) return _sortonNameArray_(array,name,options);name=name[0];}
			//[IF-SCRIPT] if (options == NUMERIC)	return array.sort( function (a:*, b:*):int { return a[name] - b[name]; } );
			//[IF-SCRIPT] if (options == (NUMERIC | DESCENDING))	return array.sort( function (a:*, b:*):int { return b[name] - a[name]; } );
			//[IF-SCRIPT] return array.sort( function (a,b) { return a[name]-b[name]; } );
			/*[IF-FLASH]*/ return array.sortOn(name, options);
		}
		
	}

}
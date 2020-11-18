package com.cong.utils
{
	import flash.net.LocalConnection;

	/**
	 *垃圾回收类
	 * @author luoAdministrator
	 *
	 */
	public class SystemGC
	{
		public function SystemGC()
		{

		}

		/**
		 * 强制垃圾回收
		 *
		 */
		public static function doGc():void
		{
			try
			{
				var conn1:LocalConnection = new LocalConnection();
				conn1.connect("testGc");
				var conn2:LocalConnection = new LocalConnection();
				conn2.connect("testGc");
			} catch (error:Error)
			{
				conn1 = null;
				conn2 = null;
			}
		}
	}
}
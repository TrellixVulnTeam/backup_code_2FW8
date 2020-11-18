package game.data.map
{
	public class MapHelper
	{
		public function MapHelper()
		{
		}

		/// <summary>
		/// 计算两点位置的距离，返回两点的距离，单位：公里或千米
		/// 该公式为GOOGLE提供，误差小于0.2米
		/// </summary>
		/// <param name="lat1">第一点纬度</param>
		/// <param name="lng1">第一点经度</param>
		/// <param name="lat2">第二点纬度</param>
		/// <param name="lng2">第二点经度</param>
		/// <returns>返回两点的距离，单位：米</returns>
		public static function GetDistance(lng1:Number,lat1:Number, lng2:Number , lat2:Number):int
		{
			//地球半径，单位米
			var radLat1:Number = Rad(lat1);
			var radLng1:Number = Rad(lng1);
			var radLat2:Number = Rad(lat2);
			var radLng2:Number = Rad(lng2);
			var a:Number = radLat1 - radLat2;
			var b:Number = radLng1 - radLng2;
			return Math.floor(2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2))) * 6378137);
		}

		/// 经纬度转化成弧度
		/// </summary>
		/// <param name="d"></param>
		/// <returns></returns>
		private static function Rad(d:Number):Number
		{
			return d * Math.PI / 180;
		}
	}
}

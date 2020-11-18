package game.data.map
{
	public class Location
	{
		public static function trans(lng:Number,lat:Number):Object
		{
			var obj:Object = {Q: lat, R: lng, lat: lat, lng: lng};
			return obj;
		}
	}
}

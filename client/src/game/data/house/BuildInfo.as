package game.data.house
{
	public class BuildInfo extends BuildInfoBase
	{

		/// 当前X坐标
		public var xPos:Number = 0;
		/// 当前Y坐标
		public var yPos:Number = 0;
		public var isCreated:Boolean;   //建筑是否被激活
		public var skinId:int;

		public function BuildInfo()
		{
		}

		public function getLocationStr():String
		{
			return xPos + "," + yPos;
		}
	}
}

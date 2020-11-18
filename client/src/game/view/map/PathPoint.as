package game.view.map
{
	public class PathPoint
	{
		public var isStayPoint:Boolean = false;            //是否停留点
		public var isStartPoint:Boolean = false;            //是否终点
		public var x:Number;
		public var y:Number;
		public function PathPoint(x:Number,y:Number,isStayPoint = false)
		{
			this.x = x;
			this.y = y;
			this.isStayPoint = isStayPoint;
		}
	}
}

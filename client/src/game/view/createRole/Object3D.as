package game.view.createRole
{
	import laya.display.Sprite;

	public class Object3D extends Sprite
	{
		public var xpos:Number = 0;
		public var ypos:Number = 0;
		public var zpos:Number = 0;

		public function Object3D()
		{
			super();
		}

		public function rotateX(angleX:Number):void
		{
			var cosX:Number = Math.cos(angleX);
			var sinX:Number = Math.sin(angleX);
			var y1:Number = ypos * cosX - zpos * sinX;
			var z1:Number = zpos * cosX + ypos * sinX;
			ypos = y1;
			zpos = z1;
		}

		public function rotateY(angleY:Number):void
		{
			var cosY:Number = Math.cos(angleY);
			var sinY:Number = Math.sin(angleY);
			var x1:Number = xpos * cosY - zpos * sinY;
			var z1:Number = zpos * cosY + xpos * sinY;
			xpos = x1;
			zpos = z1;
		}

		public function setPos(xpos:Number,ypos:Number,zpos:Number){
			this.xpos = xpos;
			this.ypos = ypos;
			this.zpos = zpos;
		}
	}
}

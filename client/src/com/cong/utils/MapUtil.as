package com.cong.utils
{
	import laya.maths.Point;

	public class MapUtil
	{

		public static const Base_Speed:int = 200;

		public static const dirAgale_16:Number = Math.PI / 16;
		public static const singleAngle:Number = 360 / 16;

//		private static const DOUBLE_PI:Number = Math.PI * 2;
//		private static const RAD_PER_DIR:Number = Math.PI / 4;
//		private static const RAD_PER_HALF_DIR:Number = Math.PI / 8;


		public static function direction(x1_:Number, y1_:Number, x2_:Number, y2_:Number):int
		{
			var radian:Number = angle(x1_, y1_, x2_, y2_);

			var angle_:Number = radian / Math.PI * 180;
			var dir:int = 0;
			if (angle_ >= -(7 * singleAngle) && angle_ <= -(5 * singleAngle))
			{
				dir = 7;
			} else if (angle_ > -(5 * singleAngle) && angle_ <= -(3 * singleAngle))
			{
				dir = 0;
			} else if (angle_ > -(3 * singleAngle) && angle_ <= -singleAngle)
			{
				dir = 1;
			} else if (angle_ > -singleAngle && angle_ <= singleAngle)
			{
				dir = 2;
			} else if (angle_ > singleAngle && angle_ <= (3 * singleAngle))
			{
				dir = 3;
			} else if (angle_ > (3 * singleAngle) && angle_ <= (5 * singleAngle))
			{
				dir = 4;
			} else if (angle_ > (5 * singleAngle) && angle_ <= (7 * singleAngle))
			{
				dir = 5;
			} else if (angle_ > (7 * singleAngle) || angle_ >= -(8 * singleAngle))
			{
				dir = 6;
			}

			return dir;
		}

		public static function angle(x1_:Number, y1_:Number, x2_:Number, y2_:Number):Number
		{
			var perx:Number = x2_ - x1_;
			var pery:Number = y2_ - y1_;
			var angle:Number = Math.atan2(-pery, perx);

			return angle;
		}

		public static function angle2(x1_:Number, y1_:Number, x2_:Number, y2_:Number):Number
		{
			var perx:Number = x2_ - x1_;
			var pery:Number = y2_ - y1_;
			var angle:Number = Math.atan2(pery, perx);

			return angle;
		}

		public static function getAngleByRadian(radian_:Number):Number
		{
			return radian_ * 180 / Math.PI;
		}

		private static const P1:Number = Math.PI / 8;
		private static const P2:Number = Math.PI / 8 * 3;
		private static const P3:Number = Math.PI / 8 * 5;
		private static const P4:Number = Math.PI / 8 * 7;
		//服务器端，弧度0是正下方向的y轴，逆时针方向增大(0-2PI)
		//客户端，朝向0是正下方向的y轴，逆时针方向增大（0-7)

		public static function orientToDirection(orient_:Number):uint
		{
			if (orient_ >= -P1 && orient_ <= P1)
			{
				return 0;
			} else if (orient_ >= P1 && orient_ <= P2)
			{
				return 1;
			} else if (orient_ >= P2 && orient_ <= P3)
			{
				return 2;
			} else if (orient_ >= P3 && orient_ <= P4)
			{
				return 3;
			} else if (orient_ >= P4 || orient_ <= -P4)
			{
				return 4;
			} else if (orient_ >= -P4 && orient_ <= -P3)
			{
				return 5;
			} else if (orient_ >= -P3 && orient_ <= -P2)
			{
				return 6;
			} else if (orient_ >= -P2 && orient_ <= -P1)
			{
				return 7;
			}
			return 0;
		}

		public static function directionToOrient(dir_:uint):Number
		{
			switch (dir_)
			{
				case 0:
					return 0;
				case 1:
					return Math.PI / 4;
				case 2:
					return Math.PI / 2;
				case 3:
					return Math.PI / 4 * 3;
				case 4:
					return Math.PI;
				case 5:
					return -Math.PI / 4 * 3;
				case 6:
					return -Math.PI / 2;
				case 7:
					return -Math.PI / 4;
			}
			return 0;
		}

		/**
		 *2点间的距离
		 * @param x1_
		 * @param y1
		 * @param x2_
		 * @param y2_
		 * @return
		 *
		 */
		public static function distance(x1_:Number, y1:Number, x2_:Number, y2_:Number):Number
		{
			var px:Number = x1_ - x2_;
			var py:Number = y1 - y2_;
			return Math.abs(Math.sqrt(px * px + py * py));
		}


		public static function distanceSQ(x1_:Number, y1_:Number, x2_:Number, y2:Number):uint
		{
			var px_:Number = x1_ - x2_;
			var py_:Number = y1_ - y2;
			return px_ * px_ + py_ * py_;
		}

		/**
		 *未加绝对值的距离
		 * @param x1_
		 * @param y1_
		 * @param x2_
		 * @param y2_
		 * @return
		 *
		 */
		public static function distance2(x1_:Number, y1_:Number, x2_:Number, y2_:Number):int
		{
			return Math.sqrt(distanceSQ(x1_, y1_, x2_, y2_));
		}

		/**
		 * 在指定的两点成的直线上插如一个点
		 * @param interpolateDis_ 插入点所在的距离
		 * @param x1_
		 * @param y1_
		 * @param x2_
		 * @param y2_
		 * @return
		 *
		 */
		public static function interpolate(interpolateDis_:Number, x1_:Number, y1_:Number, x2_:Number, y2_:Number):Point
		{
			var dis:Number = distance2(x1_, y1_, x2_, y2_);
			if (dis <= 0)
			{
				dis = 1;
			}
			return Point.interpolate(new Point(x1_, y1_), new Point(x2_, y2_), (interpolateDis_ + dis) / dis);
		}

		/**
		 *随机获得死亡飞出距离
		 * @return
		 *
		 */
		public static function getRandomDeadDistance():int
		{
			var dis:Array = [100, 125];
			var index:int = MathUtil.getRandomInt(0, dis.length);
			return dis[index];
		}

		public static function getRandomDeadDir():int
		{
			var dirs:Array = [CONST_DIRECT.DIRECT_DOWN_0, CONST_DIRECT.DIRECT_LEFT_DOWN_1];
			var index:int = MathUtil.getRandomInt(0, dirs.length);
			return dirs[index];
		}

		/**
		 *格子坐标转换成像素坐标
		 * @param r_
		 * @param c_
		 * @return
		 *
		 */
		public static function gridToPixel(r_:Number, c_:Number):Point
		{
			return new Point(c_ * CONST_MAP.w, r_ * CONST_MAP.h);
		}

		/**
		 * 像素坐标转换成格子坐标
		 * @param x_ 列
		 * @param y_ 行
		 * @return
		 *
		 */
		public static function pixelToGrid(c_:Number, r_:Number):Point
		{
			var px_:Number = c_ / CONST_MAP.w;
			var py_:Number = r_ / CONST_MAP.h;
			return new Point(px_, py_);
		}

		/**
		 *根据像素格转换成逻辑坐标格
		 * @param x_
		 * @param y_
		 * @return
		 *
		 */
		public static function pixetoLogicGrid(x_:Number, y_:Number):Point
		{
			var r:Number = y_ / CONST_MAP.h;
			var c:Number = x_ / CONST_MAP.w;
			return new Point(r, c);
		}

		/**
		 *移动速度换算
		 * @param speed_
		 * @return
		 *
		 */
		public static function moveSpeed(speed_:Number):int
		{
			var speed:int = Base_Speed * speed_;
			return speed;
		}

		/**
		 *每帧间隔多少毫秒
		 */
		public static function get interval():int
		{
			return 1000 / StageProxy.frameRate;
		}

		public static function getDist(grid1:Point, grid2:Point):int
		{
			var _px:int = grid1.x - grid2.x;
			var _py:int = grid1.y - grid2.y;
			return Math.max((_px > 0) ? _px : -_px, (_py > 0) ? _py : -_py);
		}

		/**
		 *把格子距离转换成像素距离
		 * @param dis_
		 * @return
		 *
		 */
		public static function getGridDisToPixDis(dis_:int):int
		{
			return dis_ * CONST_MAP.w;
		}

		public static function getDistanceTo(node:GameMapCell, node2:GameMapCell):Number
		{
			var _px:int = (node.x - node2.x);
			var _py:int = (node.y - node2.y);
			return Math.sqrt((_px * _px) + (_py * _py));
		}
	}
}
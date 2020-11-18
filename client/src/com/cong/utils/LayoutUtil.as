package com.cong.utils
{
	import laya.display.Sprite;
	import laya.ui.Box;
	import laya.ui.Component;

	/**
	 * ...
	 * @author cong (Tool -> 布局管理器)
	 */
	public class LayoutUtil
	{
		/**
		 * 水平中间位置自适应排列(跟切长方形蛋糕一样)
		 * @author fan
		 * @param content_mc 父容器
		 * @param HGap       水平间隔
		 * @param num 可以排列的数量
		 * @param childX child 的X坐标
		 * @param totoalX content_mc的总X
		 */
		public static function layoutHBoxCenter(content_mc:Box, num:int = 0, HGap:Number = 0, paddingTop:Number = 0, paddingLeft:Number = 0):void
		{
			var _length:int = content_mc.numChildren;
			var child:Sprite = content_mc.getChildAt(0) as Sprite;
			var totoalX:int = num * (child.width + HGap);
			var childX:int;
			for (var i:int = 0; i < _length; i++)
			{
				child = content_mc.getChildAt(i) as Sprite;
				childX = totoalX * (i + 1) / (_length + 1) - child.width / 2 - HGap;
				child.x = childX + paddingLeft;
				child.y = paddingTop;
			}
		}

//		/**
//		 * VBox 容器将其子项放在同一垂直列上。
//		 *
//		 * @param	content_mc		父容器
//		 * @param	cellHeight		行高
//		 * @param	paddingTop		上填充
//		 * @param	paddingLeft		左填充
//		 */
//		public static function layoutVBox2(content_mc : Box, cellHeight : Number = 50, paddingTop : Number = 0, paddingLeft : Number = 0) : void
//		{
//			var child : Sprite;
//			for (var i : int = 0; i < content_mc.numChildren; i++)
//			{
//				child=content_mc.getChildAt(i) as Sprite;
//				child.x=paddingLeft;
//				child.y=paddingTop+cellHeight*i;
//			}
//		}

		/**
		 * VBox 容器将其子项放在同一垂直列上。
		 *
		 * @param    content_mc        父容器
		 * @param    vGap            垂直间隙
		 * @param    paddingTop        上填充
		 * @param    paddingLeft        左填充
		 */
		public static function layoutVBox(content_mc:Box, vGap:Number = 0, paddingTop:Number = 0, paddingLeft:Number = 0):void
		{
			var lastChild:Sprite;
			var count:int = 0;
			for (var i:int = 0; i < content_mc.numChildren; i++)
			{
				var child:Component = content_mc.getChildAt(i) as Component;
				if (!child.visible)
				{
					continue;
				}
				count++;
				if (count == 1)
				{
					child.y = paddingTop;
					if (child.anchorY) child.y += child.anchorY * child.height;
				} else
				{
					child.y = lastChild.y + lastChild.height + vGap;
				}
				lastChild = child;
			}
		}

		/**
		 * HBox 容器在单个水平行中布置其子容器。
		 *
		 * @param    content_mc        父容器
		 * @param    hGap            水平间隙
		 * @param    paddingTop        上填充
		 * @param    paddingLeft        左填充
		 */
		public static function layoutHBox(content_mc:Box, hGap:Number = 0, paddingTop:Number = 0, paddingLeft:Number = 0):void
		{
			var lastChild:Sprite;
			var count:int = 0;
			for (var i:int = 0; i < content_mc.numChildren; i++)
			{
				var child:Sprite = content_mc.getChildAt(i) as Sprite;
				if (!child.visible)
				{
					continue;
				}
				count++;
				if (count == 1)
				{
					child.x = paddingLeft;
					child.y = paddingTop;
				} else
				{
					child.x = lastChild.x + lastChild.width + hGap;
					child.y = lastChild.y;
				}
				lastChild = child;
			}
		}

		/**
		 * HBox 容器在单个水平行中布置其子容器。
		 *
		 * @param    content_mc        父容器
		 * @param    hGap            水平间隙
		 * @param    paddingTop        上填充
		 * @param    paddingLeft        左填充
		 */
		public static function layoutHBoxRight(content_mc:Box, hGap:Number = 0):void
		{
			var lastChild:Sprite = null;
			var count:int = 0;
			for (var i:int = 0; i < content_mc.numChildren; i++)
			{
				var child:Sprite = content_mc.getChildAt(i) as Sprite;
				if (!child.visible)
				{
					continue;
				}
				count++;
				if (count == 1)
				{
					child.x = content_mc.width - child.width;
				} else
				{
					child.x = lastChild.x - lastChild.width - hGap;
				}
				lastChild = child;
			}
		}

//		/**
//		 * HBox 容器在单个水平行中布置其子容器。
//		 *
//		 * @param	content_mc		父容器
//		 * @param	cellWidth		列宽
//		 * @param	paddingTop		上填充
//		 * @param	paddingLeft		左填充
//		 */
//		public static function layoutHBox2(content_mc : Box, cellWidth : Number = 50, paddingTop : Number = 0, paddingLeft : Number = 0) : void
//		{
//			var child : Sprite;
//			for (var i : int = 0; i < content_mc.numChildren; i++)
//			{
//				child=content_mc.getChildAt(i) as Sprite;
//				child.x=paddingLeft + cellWidth*i;
//				child.y=paddingTop;
//			}
//		}

//		/**
//		 *
//		 * @param	content_mc 容器
//		 * @param	cols 列
//		 * @param 	cellWidth 单元格宽度
//		 * @param 	cellHeight 单元格高度
//		 * @param	hGap 水平间隙
//		 * @param	vGap 垂直间隙
//		 * @param	paddingLeft 左填充
//		 * @param	paddingTop 上填充
//		 */
//		public static function layoutTile(content_mc : Box, cols : int, vGap : Number = 6, hGap : Number = 12, paddingLeft : Number = 6, paddingTop : Number = 6) : void
//		{
//			var colCount : int = 0;
//			var rowCount : int = 0;
//			for (var i : int = 0; i < content_mc.numChildren; i++)
//			{
//				var child : Sprite = content_mc.getChildAt(i) as Sprite;
//				if (!child.visible)
//				{
//					continue;
//				}
//
//				if (i % cols == 0)
//				{
//					rowCount++;
//					colCount++;
//
//					child.x = paddingLeft;
//				}
//				else if ( i % cols == cols - 1)
//				{
//					colCount++;
//
//					child.x = paddingLeft + (colCount - 1) * (child.width + hGap);
//					colCount = 0;
//				}
//				else
//				{
//					colCount++;
//
//					child.x = paddingLeft + (colCount - 1) * (child.width + hGap);
//				}
//
//				child.y = paddingTop + (rowCount - 1) * (child.height + vGap);
//			}
//		}

//		/**
//		 *
//		 * @param	content_mc 容器
//		 * @param	cols 列
//		 * @param 	cellWidth 单元格宽度
//		 * @param 	cellHeight 单元格高度
//		 * @param	paddingLeft 左填充
//		 * @param	paddingTop 上填充
//		 */
//		public static function layoutTile2(content_mc : Box, cols : int, cellWidth : Number = 6, cellHeight : Number = 12, paddingLeft : Number = 6, paddingTop : Number = 6) : void
//		{
//			var child : Sprite;
//			var childCount:int=content_mc.numChildren;
//			var rows:int=Math.ceil(childCount/cols);
//			for (var i:int = 0; i < childCount; i++)
//			{
//				child=content_mc.getChildAt(i) as Sprite;
//				child.x = paddingLeft + i%cols*cellWidth;
//				child.y=paddingTop+int(i/cols)*cellHeight;
//			}
//		}

//		/**
//		 * 环状排列物体,只做简单的排列，不适合做互动使用
//		 * @param        childNum 排列的物件个数
//		 * @param        w 长半径
//		 * @param        h 高半径
//		 * @param        x 原点X
//		 * @param        y 原点Y
//		 * @param        angle 原点角度
//		 * @return
//		 */
//		public static function layoutRingPoint(content_mc : Box, childNum : uint, w : uint = 100, h : uint = 50, x : int = 100, y : int = 50, angle : Number = -370) : void
//		{
//			var count : int = 0;
//			if (w == 0) w = 100;
//			if (h == 0) h = 100;
//			var pt : Point;
//			var _fangle : Number = 360 / childNum;
//			// 转换0-360角度
//			angle = (angle + 90) % 360;
//			angle = angle < 0 ? angle + 360 : angle;
//			//
//			var nowAngle : Number;
//			for (var i : int = 0; i < childNum; i++)
//			{
//				var child : Sprite = content_mc.getChildAt(i) as Sprite;
//				count++;
//				nowAngle = angle + _fangle * (i );
//				nowAngle = nowAngle * Math.PI / 180;
//				pt = new Point(Math.cos(nowAngle) * w + x, Math.sin(nowAngle) * h + y);
//
//				child.x = pt.x;
//				child.y = pt.y;
//			}
//		}
	}
}
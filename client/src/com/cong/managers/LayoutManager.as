package com.cong.managers
{
	import com.cong.utils.HashMap;

	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;

	public class LayoutManager
	{
		/**
		 *中上
		 */
		public static const LAYOUT_U:int = 1;
		/**
		 右上角
		 */
		public static const LAYOUT_RU:int = 2;
		/**
		 *右中
		 */
		public static const LAYOUT_R:int = 3;
		/**
		 *右下角
		 */
		public static const LAYOUT_RB:int = 4;
		/**
		 *下中
		 */
		public static const LAYOUT_B:int = 5;
		/**
		 * 左下
		 */
		public static const LAYOUT_LB:int = 6;
		/**
		 *左中
		 */
		public static const LAYOUT_L:int = 7;
		/**
		 *左上
		 */
		public static const LAYOUT_LU:int = 8;
		/**
		 *中间
		 */
		public static const LAYOUT_C:int = 9;
		/**
		 *上中
		 */
		public static const LAYOUT_TC:int = 10;

		private static var dic:HashMap = new HashMap();


		public function LayoutManager()
		{
		}

		public static function init():void
		{
			Laya.stage.on(Event.RESIZE, LayoutManager ,LayoutManager.stageResizeHandler);
		}

		public static function registerayout(target:Sprite, type:int, offx:Number = 0, offy:Number = 0, isResize:Boolean = false):void
		{
			var layoutData:LayoutData = new LayoutData(type, offx, offy, isResize);
			dic.put(target, layoutData);
			setLayoutPos(target);
		}

//		public static function unRegisterayout(target:Sprite):void
//		{
//			dic.remove(target);
//		}

		protected static function stageResizeHandler(e:Event = null):void
		{
			for each (var key:Sprite in dic.keys())
			{
				setLayoutPos(key);
			}
		}

		private static function calculatePos(target:Sprite, compoRect:Rectangle):Point
		{
			var data:LayoutData = dic.getValue(target);
			var resultPos:Point = null;
			var uiw:int = target.width;
			var uiH:int = target.height;
			switch (data.type)
			{
				case LAYOUT_U:
					resultPos = new Point((compoRect.width - uiw) * 0.5, 0);
					break;
				case LAYOUT_RU:
					resultPos = new Point(compoRect.width - uiw, 0);
					break;
				case LAYOUT_R:
					resultPos = new Point(compoRect.width - uiw, (compoRect.height - uiH) * .5);
					break;
				case LAYOUT_RB:
					resultPos = new Point(compoRect.width - uiw, compoRect.height - uiH);
					break;
				case LAYOUT_B:
					resultPos = new Point((compoRect.width - uiw) * .5, compoRect.height - uiH);
					break;
				case LAYOUT_LB:
					resultPos = new Point(0, compoRect.height - uiH);
					break;
				case LAYOUT_L:
					resultPos = new Point(0, (compoRect.height - uiH) * .5);
					break;
				case LAYOUT_LU:
					resultPos = new Point(0, 0);
					break;
				case LAYOUT_C:
					resultPos = new Point((compoRect.width - uiw) * .5, (compoRect.height - uiH) * .5);
					break;
				case LAYOUT_TC:
					resultPos = new Point((compoRect.width - uiw) * 0.5, 0);
					break;
				default:
			}
			resultPos.x += data.layoutOffx;
			resultPos.y += data.layoutOffy;
			return resultPos;
		}

		private static function setLayoutPos(target:Sprite):Point
		{
			var p:Point;
			var parent:Sprite = target.parent as Sprite;
			if (parent != null)
			{
				if (parent is Stage)
				{
					p = calculatePos(target, new Rectangle(0, 0,Laya.stage.width, Laya.stage.height));
				} else
				{
					p = calculatePos(target, new Rectangle(0, 0, parent.width, parent.height));
				}
				target.x = p.x;
				target.y = p.y;
			}
			return p;
		}
	}
}

class LayoutData
{
	public var type:int;
	public var layoutOffx:Number;
	public var layoutOffy:Number;
	public var adaptive:Boolean;

	public function LayoutData(type:int, layoutOffx:Number, layoutOffy:Number, adaptive:Boolean):void
	{
		this.type = type;
		this.layoutOffx = layoutOffx;
		this.layoutOffy = layoutOffy;
		this.adaptive = adaptive;
	}

}

package com.cong.utils
{
	import laya.display.Graphics;

	public class GraphicsUtil
	{
		/**
		 * 绘画圆角矩形
		 * @param	graghics 	Graghics对象
		 * @param	x			开始绘制的x轴位置
		 * @param	y			开始绘制的y轴位置
		 * @param	width		矩形宽
		 * @param	height		矩形高
		 * @param	roundRadius	圆角半径
		 * @param	fillColor	填充颜色
		 * @param	borderColor	边框填充颜色
		 * @param	borderWidth 边框大小
		 * @return DrawPathCmd 对象
		 */
		public static function drawRoundRect(graghics:Graphics, x:Number, y:Number, width:Number, height:Number, roundRadius:Number, borderColor:String = "#ff0000", borderWidth:Number = 20):void {
			var paths:Array = [];
			paths.push(["moveTo", roundRadius, 0]);
			paths.push(["lineTo", width - roundRadius, 0]);
			paths.push(["arcTo", width, 0, width, roundRadius, roundRadius]);
			paths.push(["lineTo", width, height - roundRadius]);
			paths.push(["arcTo", width, height, width - roundRadius, height, roundRadius]);
			paths.push(["lineTo", roundRadius, height]);
			paths.push(["arcTo", 0, height, 0, height - roundRadius, roundRadius]);
			paths.push(["lineTo", 0, roundRadius]);
			paths.push(["arcTo", 0, 0, roundRadius, 0, roundRadius]);
//			paths.push(["closePath"]);
			var pen:Object = { strokeStyle:borderColor, lineWidth:borderWidth };
			return graghics.drawPath(x, y, paths, null, pen);
		}
	}
}

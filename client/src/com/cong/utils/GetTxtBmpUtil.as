package com.cong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class GetTxtBmpUtil
	{
		private static var txt:TextField;
		private static var tf:TextFormat;

		public function GetTxtBmpUtil()
		{
		}

		public static function getNormalTxtBmp(content_:String, font:String = "Microsoft YaHei", fontSize:int = 14, fontColor:uint = 0x515151, maxWidth:int = 240, leading:int = 4):Bitmap
		{
			txt = new TextField();
			txt.innerHTML = (content_ + "  ");
			txt.autoSize = "left";
			txt.cacheAsBitmap = true;
			var tf:TextFormat = new TextFormat();
			tf.font = font;
			tf.letterSpacing = 1;
			tf.leading = leading;
			txt.setTextFormat(tf);
			if (txt.textWidth >= maxWidth)
			{
				txt.wordWrap = true;
				txt.multiline = true;
				txt.width = maxWidth;
			}
			tf = new TextFormat();
			tf.size = fontSize;
			tf.color = fontColor;
			txt.setTextFormat(tf);
			sideGlow(txt);
			var bd:Bitmap = new Bitmap();
			bd.bitmapData = new BitmapData(txt.width, txt.height, true, 0);
			bd.bitmapData.draw(txt, getMatrix());
			bd.width = txt.width;
			txt.text = "";
			txt = null;
			return (bd);
		}

		private static function getMatrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):Matrix
		{
			var matrix:Matrix = new Matrix();
			matrix.a = a;
			matrix.b = b;
			matrix.c = c;
			matrix.d = d;
			matrix.tx = tx;
			matrix.ty = ty;
			return matrix;
		}

		private static function sideGlow(item:DisplayObject, alpha:Number = 0.4):void
		{
			var gf:GlowFilter = new GlowFilter(0, alpha, 2, 2, 1, 3, true, false);
			item.filters = [gf];
		}
	}
}
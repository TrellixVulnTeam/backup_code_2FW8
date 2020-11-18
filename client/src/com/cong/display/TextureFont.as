package com.cong.display
{
	import laya.display.Sprite;
	import laya.net.Loader;
	import laya.resource.Texture;
	import laya.utils.Handler;

	/**
	 * ...
	 * @author Fred
	 */
	public class TextureFont
	{
		private static var _fontJsonDic:Object = {};

		/**
		 * 将指定的文本绘制到指定的显示对象上。
		 * var s:Sprite = new Sprite();
		 TextureFont.drawText(CONST_FILE.getNumFont("blood"), "+9849684", s);
		 */
		public static function drawText(fontJsonUrl:String, text:String, sprite:Sprite, drawX:Number = 0, drawY:Number = 0, align:String = "left", width:Number = 0, gap:Number = 0):void
		{
			sprite.graphics.clear();
			var dir:String = _fontJsonDic[fontJsonUrl];
			var a:Array = [fontJsonUrl, text, sprite, drawX, drawY, align, width, gap];
			if (dir)
			{
				drawText1.apply(null, a);
			} else
			{
				Laya.loader.load(fontJsonUrl, Handler.create(null, __jsonLoaded, [fontJsonUrl, a]), null, Loader.ATLAS);
			}
		}

		private static function drawText1(fontJsonUrl:String, text:String, sprite:Sprite, drawX:Number, drawY:Number, align:String, width:Number, gap:Number = 0):void
		{
			var dir:String = _fontJsonDic[fontJsonUrl];
			var tWidth:int = 0;
			var tTexture:Texture;
			for (var i:int = 0, n:int = text.length; i < n; i++)
			{
				tTexture = Laya.loader.getRes(dir + text.charAt(i) + ".png");
				if (tTexture) tWidth += tTexture.width;
			}
			tWidth += (n - 1) * gap;
			var dx:Number = 0;
			if (width > 0)
			{
				align === "center" && (dx = (width - tWidth) / 2);
				align === "right" && (dx = (width - tWidth));
			}
			var tX:Number = 0, tY:Number = 0;
			for (i = 0, n = text.length; i < n; i++)
			{
				tTexture = Laya.loader.getRes(dir + text.charAt(i) + ".png");
				if (tTexture)
				{
					sprite.graphics.drawTexture(tTexture, drawX + tX + dx, drawY/*, tTexture.width, tTexture.height*/);
					tX += tTexture.width + gap;
					tY = Math.max(tY, tTexture.height);
				}
			}
//			sprite.size(tX, tY);
		}

		static private function __jsonLoaded(fontJsonUrl:String, args:Array, data:*):void
		{
//			if (!(data is Object) || data.directory == null)
//			{
//				return;
//			}

			_fontJsonDic[fontJsonUrl] = data.meta.prefix;
			drawText1.apply(null, args);
		}
	}
}
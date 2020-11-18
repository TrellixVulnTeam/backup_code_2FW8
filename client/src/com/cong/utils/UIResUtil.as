/**
 * Created by chencong on 2016/7/27 0027.
 */
package com.cong.utils
{
	import laya.display.Sprite;
	import laya.resource.HTMLCanvas;
	import laya.resource.Texture;

	public class UIResUtil
	{
		public function UIResUtil()
		{
		}

		public static function getRes(url:String):*
		{
			return Laya.loader.getRes(url);
		}

		public static function getBitmapFromSprite(src:Sprite):Sprite
		{
//			var spr:Sprite = new Sprite();
//			var tRenderTarget:RenderTarget2D = RenderTarget2D.create(800, 600);
//			tRenderTarget.start();
//			tRenderTarget.clear(0, 0, 0, 1);
//			src.render(Render.context, 0, 0);
//			(Render.context.ctx as WebGLContext2D).flush();
//			tRenderTarget.end();
//			spr.graphics.drawTexture(tRenderTarget, 0, 0, tRenderTarget.width, tRenderTarget.height);
//			return spr;
			var htmlC:HTMLCanvas =src.drawToCanvas(src.width,src.height,0,0);
			//获取截屏区域的texture
			var _texture:Texture = new Texture(htmlC);
			//将截屏的texture进行draw绘制并显示到舞台
			var sp2:Sprite = new Sprite();
			//sp2.width = src.width;
			//sp2.height = src.height;
			sp2.graphics.drawTexture(_texture,0,0,src.width,src.height);
			return sp2;
		}

		public static function bitmapToBase64(src:Sprite):String{
			var htmlC:HTMLCanvas =src.drawToCanvas(src.width,src.height,0,0);
			var canvas:Object = htmlC.getCanvas();
			var base64Data:String = canvas.toDataURL();
			return base64Data;
		}
	}
}

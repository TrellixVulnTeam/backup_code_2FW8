package com.cong.script
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.ui.AutoBitmap;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Tween;

	public class DialogFoldEffect extends Box
	{
		private var topbg:Image = new Image();
		private var bottombg:Image = new Image();
		public  var foldH:int = 250;
		public function DialogFoldEffect()
		{
			//自定义的脚本会有时序问题，所以在此添加一个延时
			this.frameOnce(2,this,onFrame);
		}

		private function onFrame():void
		{
			var splitImg:Image = getChildByName("splitImg") as Image;
			var bg:Image = getChildByName("bg") as Image;
			bg.removeSelf();
			topbg.graphics.fillTexture( Laya.loader.getRes(bg.skin),0,0,bg.width, splitImg.y + foldH);
			bottombg.graphics.fillTexture( Laya.loader.getRes(bg.skin),0,0,bg.width, bg.height - splitImg.y - foldH,"repeat",new Point(0, bg.height - splitImg.y - foldH));
			bottombg.y = splitImg.y;
			for (var i:int = 0; i < numChildren; i++)
			{
				var child:Sprite = getChildAt(i) as Sprite;
				if(child.y<(splitImg.y+foldH)){
					topbg.addChild(child);
				}else{
					child.y -= (splitImg.y+foldH);
					bottombg.addChild(child);
				}
				i--;
			}
			addChildAt(topbg,0);
			addChild(bottombg);
			Tween.to(bottombg,{y:splitImg.y + foldH},300,null);
		}
	}
}

package com.cong.effects
{
	import com.cong.managers.LayerManager;

	import laya.maths.Bezier;

	import laya.maths.Point;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;

	public class FloatEffect
	{
		public function FloatEffect()
		{
		}

			public static function flyMoney(sPoint:Point,ePoint:Point):*
		{
			var img:Image = Pool.getItemByClass("money",Image);
			img.skin = "common/ico_coin.png";
			img.x = sPoint.x;
			img.y = sPoint.y;
//			Tween.to(img, {x:100, y:100},2000,Ease.bounceOut,Handler.create(FloatEffect,function () {
//
//			}));
			var be:Bezier = new Bezier();
			var arr:Array = be.getBezierPoints([sPoint.x,sPoint.y,ePoint.x*0.8,sPoint.y*0.8,ePoint.x,0],60,2);
			Laya.timer.frameLoop(1,img,function () {
				if(arr.length){
					img.x = arr.shift();
					img.y = arr.shift();
				}else {
					Laya.timer.clearAll(img);
					Pool.recover("money",img);
					img.removeSelf();
				}
			});
			return img;
		}
	}
}

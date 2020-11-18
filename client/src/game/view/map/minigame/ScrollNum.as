package game.view.map.minigame
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class ScrollNum extends Sprite
	{
		private var img1:Image;
		private var img2:Image;
		private var uh:int = 265;
		private var _index:int;

		public function ScrollNum(index:int)
		{
			_index = index;
			img1 = new Image("map/minigame/num.png");
			img2 = new Image("map/minigame/num.png");
			addChild(img1);
			addChild(img2);
			init();
		}

		public function init(){
			img1.y = 0;
			img2.y = uh*10;
			this.scrollRect = new Rectangle(0,0,159,265);
		}

		public function scrollTo(num:int){
			init();
			Tween.to(this.scrollRect,{y:uh*60- uh*num,update:Handler.create(this,updateImg,null,false)},6000+_index*3000 ,Ease.circInOut,null,_index*300);
		}

		private function updateImg():void
		{
			if(this.scrollRect.y - img1.y>=uh*8){
				img2.y = img1.y + img1.height;
			}
			if(this.scrollRect.y - img2.y>=uh*8){
				img1.y = img2.y + img2.height;
			}
		}
	}
}

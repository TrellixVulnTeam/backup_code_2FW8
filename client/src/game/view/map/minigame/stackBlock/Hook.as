package game.view.map.minigame.stackBlock
{
	import game.view.map.minigame.V_StackBlock;

	import laya.utils.Browser;
	import laya.utils.Tween;

	import ui.map.minigame.stackBlock.HookUI;

	public class Hook extends HookUI
	{
		private const minRotate:Number = 12;
		private const rotateRanA:Number = 5;
		private const rotateRanB:Number = 18;
		private const randgeIncre:Number = 0.00035;   //摇晃幅度递增
		private const relYRandge:Number = 0.25;
		private const b:Number = 0.02;
		private var a:Number;
		private var sin_x:Number = 0;
		private var block:BlockItem;
		private var _angleRange:Number = 0;
		private var relY:Number = 0.25;
		private var timeDta:Number = 0;
		private var curTime:int = 0;

//		private var blockPos:Point;

		public function Hook()
		{
			super();
			this.a = 0.06;
			_angleRange = 5;
		}

		public function update()
		{
			this.sin_x = this.sin_x + this.a * this.timeDta / this.b;
			if (this.curTime)
			{
				this.timeDta = (Browser.now() - this.curTime) / 1000;
			}
			this.curTime = Browser.now();
			var rotate:* = Math.sin(this.sin_x) * this._angleRange;
			this.rotation = rotate;
			var yoffset:* = rotate * this.relY;
//			this.reposBlock();
			this.y = this.y + Math.round(yoffset) * this.timeDta / this.b;
		}

		public function releaseBlock():void
		{
//			if (this.block != null)
			Tween.to(this, {y: -150}, 400);
//			}
			this.relY = Math.random() * relYRandge;
			if(V_StackBlock.instance.goodBlockNum<3){
				_angleRange = this.minRotate + V_StackBlock.instance.goodBlockNum*2;
			}else{
				this._angleRange = this.minRotate + randge(this.rotateRanA, this.rotateRanB);
			}
			this.a = this.a + this.randgeIncre;
			Tween.to(this, {_angleRange: this.minRotate}, 3000);
//				TweenMax.to(this.block.view, 0.6, {rotation: 0});
		}


		public function setOffsetY()
		{

		}

		public function randge(a:Number, b:Number)
		{
			return Math.random() * (b - a) + a;
		}
	}
}

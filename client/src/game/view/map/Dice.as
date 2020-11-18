package game.view.map
{
	import laya.ani.bone.Skeleton;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Handler;

	public class Dice extends Box
	{
		private var rollAni:Skeleton;
		private var _value:int;
		private var _isPlaying = false;
		private var dicebg:Image;
		public function Dice()
		{
			super();
			rollAni = new Skeleton();
			rollAni.load("ani/map/touzigundong.sk",Handler.create(this,parseComplete));
//			anchorX = anchorY = 0.5;
			hitArea = new Rectangle(-100,-100,200,200);
			dicebg = new Image("map/dice/dice_1.png");
			dicebg.anchorY = dicebg.anchorX = 0.5;
			addChild(dicebg);
		}

		private function parseComplete():void
		{
			rollAni.stop();
		}

		private function rollComplete():void
		{
			_isPlaying = false;
			rollAni.off(Event.STOPPED,this,rollComplete);
			rollAni.play("num" + value,false);
			rollAni.on(Event.STOPPED,this,resComplete);
		}

		private function resComplete():void
		{
			event(Event.COMPLETE);
		}

		public function castDice(value:int)
		{
			_value = value;
			rollAni.play("gundong",false);
			rollAni.on(Event.STOPPED,this,rollComplete);
			rollAni.off(Event.STOPPED,this,resComplete);
			_isPlaying = true;
			addChild(rollAni);
			dicebg.removeSelf();
		}

		public function get value():int
		{
			return _value;
		}

		public function get isPlaying():*
		{
			return _isPlaying;
		}
	}
}

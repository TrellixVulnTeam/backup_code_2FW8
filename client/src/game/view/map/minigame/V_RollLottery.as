package game.view.map.minigame
{
	import com.cong.interfaces.IView;

	import laya.events.Event;

	import ui.map.minigame.RollLotteryUI;

	public class V_RollLottery extends RollLotteryUI implements IView
	{
		private const max = 9999; //上限
		private const min = 1111; //下限
		private var num0:ScrollNum = new ScrollNum(0);
		private var num1:ScrollNum = new ScrollNum(1);
		private var num2:ScrollNum = new ScrollNum(2);
		private var num3:ScrollNum = new ScrollNum(3);
		public function V_RollLottery()
		{
			super();

			for (var i:int = 0; i < 4; i++)
			{
				var num:ScrollNum = this["num" + i];
				num.x = 170 + 185*i;
				num.y = 345;
				addChild(num);
			}
		}

		private function randNum() {
			var rand:int = parseInt(Math.random() * (max - min + 1)) + min;
			var randArr:Array = rand.toString().split("");
			for (var i:int = 0; i < randArr.length; i++)
			{
				var num:ScrollNum = this["num" + i];
				num.scrollTo(randArr[i]);
			}
		}

		public function onShow():void
		{
		}

		private function onRandClick():void
		{
			randNum();
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_rand.on(Event.CLICK,this,onRandClick);
		}

		public function removeAllListeners():void
		{
			btn_rand.off(Event.CLICK,this,onRandClick);
		}
	}
}

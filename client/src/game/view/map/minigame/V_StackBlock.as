package game.view.map.minigame
{
	import com.cong.interfaces.IView;

	import game.view.map.minigame.stackBlock.BlockItem;
	import game.view.map.minigame.stackBlock.Hook;

	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	import ui.map.minigame.StackBlockUI;

	public class V_StackBlock extends StackBlockUI implements IView
	{
		private var _goodBlocks:Array = [];  //叠加成功的方块
		private var prevBlock:BlockItem;     //前一个叠加的方块
		private var curBlock:BlockItem;      //当前方块
		private var hook:Hook = new Hook();

		private var initBgPos:Number;
		private var initFloorPos:Number;
		private var initMiddlePos:Number;
		public static const BG_BLOCK_HEI:Number = 130;     //方块高度
		private static const UP_GRADE_DUR:Number = 500;    //缓动时长
		public function V_StackBlock()
		{
			super();
			hook.x = width / 2;
			hook.y = -200;
			addChild(hook);

			initBgPos = background.y;
			initFloorPos = floor.y;
			initMiddlePos = middle.y;
//			hook.rotate();
		}

		private static var _instance:V_StackBlock;
		public static function get instance():V_StackBlock
		{
			if (null == _instance)
			{
				_instance = new V_StackBlock();
			}
			return _instance;
		}

		public function get goodBlockNum(){
			return _goodBlocks.length;
		}

		public function onShow():void
		{
			createBlock();
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			Laya.timer.frameLoop(1, this, onframe);
			this.on(Event.CLICK, this, releaseBlock);
//			Laya.timer.once(2000,this,aaa);
		}

		//释放砖块
		private function releaseBlock():void
		{
			if (curBlock&&curBlock.state == 1)
			{
				hook.releaseBlock();
				curBlock.release();
			}
			if (!prevBlock)
			{
				cont_block.x = curBlock.x;
			}
		}


		private function onframe():void
		{
			hook.update();
			if (curBlock)
			{
				if (curBlock.state == 1)
				{
					var pos:Point = hook.localToGlobal(new Point(hook.blockPos.x, hook.blockPos.y));
					curBlock.setPos(pos.x, pos.y);
					curBlock.rotation = hook.rotation;
				}
				curBlock.update();
			}
		}

		//创建方块
		private function createBlock():void
		{
			curBlock = new BlockItem();
			curBlock.on("state_change", this, onJoin);
			curBlock.on("dropEmpty", this, onDropEmpty);
			curBlock.on("dropEdge", this, onDropEdge);
			curBlock.x = curBlock.y = -200;
			addChild(curBlock);
			if (prevBlock)
			{
				curBlock.setBaseBlock(prevBlock);
			}
		}

		//掉落方块边缘
		private function onDropEdge():void
		{
			if (_goodBlocks.length > 1)
			{
				var pos:Point = cont_block.globalToLocal(new Point(curBlock.x, curBlock.y));
				curBlock.x = pos.x;
				curBlock.y = -BlockItem.BLOCK_HEI*_goodBlocks.length;
				curBlock.rotation = 0;
				cont_block.addChild(curBlock);

				prevBlock.state = 4;

				var rotation:Number = curBlock.x > prevBlock.x ? 600 : -600;
				this.brokeBlock(curBlock, rotation);
				this.brokeBlock(prevBlock, rotation, false,0.4);

				_goodBlocks.pop();
				prevBlock = _goodBlocks[_goodBlocks.length - 1];
				Tween.to(cont_block, {y: cont_block.y - BlockItem.BLOCK_HEI}, UP_GRADE_DUR);
				Tween.to(floor, {y: initFloorPos + (_goodBlocks.length-1)*BG_BLOCK_HEI}, UP_GRADE_DUR);
				Tween.to(middle, {y: initMiddlePos  + (_goodBlocks.length-1)*BG_BLOCK_HEI*0.5}, UP_GRADE_DUR);
				Tween.to(background, {y: initBgPos + (_goodBlocks.length-1)*BG_BLOCK_HEI*0.3}, UP_GRADE_DUR);
			} else if (_goodBlocks.length == 1)
			{
				var rotation:Number = curBlock.x > prevBlock.x ? 600 : -600;
				this.brokeBlock(curBlock, rotation);
				createBlock();
			}
		}

		//坠落方块
		private function brokeBlock(block:BlockItem, rot:Number, isFail:Boolean = true,delay:Number = 0):void
		{
			Tween.to(block, {rotation: rot}, 8000, null, null, delay * 1000);
			Tween.to(block, {
				y: block.y + 800
			}, 1000, null, Handler.create(this, function ():void {
//					block.destroyBlock();
				Tween.clearAll(block);
				block.dispose();
				if(curBlock == block){
					curBlock = null;
				}
				if(!isFail){
					createBlock();
				}
//					属性486.blocksStock.addBlock(_block);
			}), delay * 1000 + 300);
		}

		//落空
		private function onDropEmpty():void
		{
			curBlock.removeSelf();
			createBlock();
		}

		private var rock:Boolean;
		private var rotateRange:Number = 0;
		//连接方块成功
		private function onJoin():void
		{
			var pos:Point = cont_block.globalToLocal(new Point(curBlock.x, curBlock.y));
			curBlock.off("state_change", this, onJoin);
			curBlock.x = pos.x;
			curBlock.y = pos.y;
			curBlock.rotation = 0;
			cont_block.addChild(curBlock);
			_goodBlocks.push(curBlock);
			if (prevBlock) rotateRange += Math.abs(prevBlock.x - curBlock.x) * 0.042;
			if (_goodBlocks.length > 1)
			{
				if (!rock)
				{
					shakeHouse();
					rock = true;
				}
				Tween.to(cont_block, {y: cont_block.y + BlockItem.BLOCK_HEI}, UP_GRADE_DUR);
				Tween.to(floor, {y: initFloorPos + (_goodBlocks.length-1)*BG_BLOCK_HEI}, UP_GRADE_DUR);
				Tween.to(middle, {y: initMiddlePos  + (_goodBlocks.length-1)*BG_BLOCK_HEI*0.5}, UP_GRADE_DUR);
				Tween.to(background, {y: initBgPos + (_goodBlocks.length-1)*BG_BLOCK_HEI*0.3}, UP_GRADE_DUR);
			}
			prevBlock = curBlock;
			createBlock();
		}

		public function removeAllListeners():void
		{
		}

		//摇晃
		private function shakeHouse():void
		{
			Tween.to(cont_block, {rotation: rotateRange}, 1500, Ease.sineInOut);
			Tween.to(cont_block, {
				rotation: -rotateRange,
			}, 1500, Ease.sineInOut, Handler.create(this, shakeHouse), 1600);
		}
	}
}

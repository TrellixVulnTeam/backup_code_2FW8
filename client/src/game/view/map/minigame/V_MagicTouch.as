package game.view.map.minigame
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.UnistrokeRecognize;
	import game.config.ConfigGameChest;
	import game.constants.CONST_EVENT;
	import game.controller.C_Minigame;
	import game.data.minigame.RewardInfo;
	import game.view.map.minigame.magicTouch.ExecuteTimePointTable;
	import game.view.map.minigame.magicTouch.GameFinalAlert;
	import game.view.map.minigame.magicTouch.TreasureFactory;
	import game.view.map.minigame.magicTouch.TreasureItem;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Pool
	import ui.map.minigame.MagicTouchUI;
	import com.cong.utils.CTimer;
	import laya.utils.Handler;

	public class V_MagicTouch extends MagicTouchUI implements IView
	{
		private var _layer:Sprite;
		private var _mousePoints:Array = [];
		private var _currentPoint:Point;
		private var gestureUtil:UnistrokeRecognize = new UnistrokeRecognize();   //手势识别
		private var treasures:Array = [];
		private var executeTimePoint:ExecuteTimePointTable;
		private var totalTime:Number; //游戏时间,以秒为单位
		private var totalNum:Number; //游戏宝箱数量
		private var readyBoxList:Array;

		//附加信息
		private var retExtras:Array;

		//计时器(倒计时)
		private var countdown:CTimer;

		//分数
		private var _score:Number = 0;
		public function V_MagicTouch()
		{
			_layer = new Sprite();
			addChild(_layer);
		}

		override protected function initialize():void
		{
			super.initialize();
			retExtras = [];
			//游戏时间
			totalTime = ConfigGameChest.getGameTimes();
			countdown = new CTimer(
					1000,
					totalTime,
					Handler.create(this, onTimerUpdate, null, false),
					Handler.create(this, onTimerCompleted));

			//网络通信,获取服务器数据
			EventCenter.ins.once(CONST_EVENT.MINIGAME_MAGIC_TOUCH_RET, this, MagicTouchStart);
			C_Minigame.instance.getMagicTouchGameDate();
		}

		//接受到服务器确认指令,可以开始游戏
		private function MagicTouchStart(obj:Object):void
		{
			console.log("从服务器获取到宝箱数据: ", obj);
			//拿到宝箱队列
			readyBoxList = obj.boxList;
			totalNum = readyBoxList.length;
			//时间点执行器
			executeTimePoint = new ExecuteTimePointTable(totalTime - 4, totalNum, Handler.create(this, onCreateTreasure, null, false));
			startTimer();
			btn_pause.visible = true;
			btn_continue.visible = false;
		}

		//计时器更新回调,更新时间显示标签
		private function onTimerUpdate():void
		{
			timer_lab.text = String(this.countdown.haveTime);
		}

		//计时器完成回调,游戏结束
		private function onTimerCompleted():void
		{
			//将结果数组拼接为服务器能够接受的结果字符串
			var retListStr:String = retExtras.map(function(o:Object) {
				return o.type + "," + o.result;
			}).join(";");

			console.log("将游戏结果上传服务器: ", retListStr);

			EventCenter.ins.once(CONST_EVENT.MINIGAME_MAGIC_TOUCH_REWARD_RET, this, onRewardRet);
			C_Minigame.instance.getMagicTouchGameReward(retListStr);
			//结束游戏
			//移除所有监听器
			removeAllListeners();
		}

		//得到了奖励数据
		private function onRewardRet(obj:Object):void {
			console.log("获得服务器返回的奖励结果: ", obj);

			var money = 0;

			//将服务器返回的奖励累加
			for each (var info:RewardInfo in obj.rewardList) {
				if (info.type == 2) {
					money += info.num;
				}
			}
			//弹出游戏结束窗口
			var finalAlert:GameFinalAlert = new GameFinalAlert(money);
			finalAlert.popup();
			//绑定关闭事件处理
			finalAlert.closeHandler = Handler.create(this, onClose);
		}

		//响应函数
		private function onMouseDown(evt:Event)
		{
			this._layer.graphics.clear();
			var p:Point = new Point(evt.stageX, evt.stageY);
			this._currentPoint = p;
			this._mousePoints = [];
			this._mousePoints.push(p);
			Laya.stage.on(Event.MOUSE_MOVE, this, mouseMove);
			Laya.stage.on(Event.MOUSE_UP, this, mouseUp);
		}

		private function mouseMove(evt:Event)
		{
			var p:Point = new Point(evt.stageX, evt.stageY);
			this._mousePoints.push(p);
			this._layer.graphics.drawLine(this._currentPoint.x, this._currentPoint.y, p.x, p.y,"#ffffff",5);
			this._currentPoint = p;
		}

		private function mouseUp(evt:Event)
		{
			this._mousePoints.push(new Point(evt.stageX, evt.stageY));
			var result = this.gestureUtil.recognize(this._mousePoints, false);
			trace('name:', result.name, 'score:', result.score);
			for (var i:int = 0; i < treasures.length; i++)
			{
				if(treasures[i].y>=-100&&treasures[i].type == result.name){
					this.score += treasures[i].score;
					removeTreasure(i, true);
					i--;
				}
			}

			//在放开手势时,清空屏幕上的手势轨迹
			this._layer.graphics.clear();

			Laya.stage.off(Event.MOUSE_MOVE, this, mouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, mouseUp);
		}

		public function onShow():void
		{
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			Laya.stage.on(Event.MOUSE_DOWN, this, onMouseDown);
			Laya.timer.frameLoop(1,this,onFrame);
			btn_pause.on(Event.CLICK,this,onPause);
			btn_continue.on(Event.CLICK,this,onContinue);
			btn_close.on(Event.CLICK,this,onClose);
		}

		private function onClose():void
		{
			UIManager.instance.removePanel(this);
		}

		private function onContinue():void
		{
			btn_continue.visible = false;
			btn_pause.visible = true;
			//startTimer不能加入addAllListeners中
			startTimer();
			addAllListeners();
		}

		private function onPause():void
		{
			btn_continue.visible = true;
			btn_pause.visible = false;
			stopTimer();
			removeAllListeners();
		}

		//开启所有计时器
		private function startTimer():void
		{
			if (countdown)
			{
				countdown.start();
			}

			if (executeTimePoint)
			{
				executeTimePoint.start();
			}
		}

		//关闭所有计时器
		private function stopTimer():void
		{
			if (countdown)
			{
				countdown.stop();
			}

			if (executeTimePoint)
			{
				executeTimePoint.stop();
			}
		}

		private function onFrame():void
		{
			//每一帧更新宝箱的位置状态
			for (var i:int = 0; i < treasures.length; i++)
			{
				//宝箱下落
				treasures[i].down();
				//回收超过边界的宝箱
				if(treasures[i].y>height)
				{
					removeTreasure(i);
					i--;
				}
			}
		}

		//创建宝箱并加入到场景
		private function onCreateTreasure():void
		{
			if (1 > readyBoxList.length) return;
			var gtype:Number = gestureUtil.unistrokes[Math.floor(Math.random()* gestureUtil.unistrokes.length)].Name;
			var newType:int = readyBoxList.shift();
			var treasure:TreasureItem = TreasureFactory.create(newType, gtype);

			if (treasure == null)
			{
				return;
			}
			addChild(treasure);
			treasures.push(treasure);

			var extra:Object = {type: newType, result: 0};
			retExtras.push(extra);
			treasure.setExtras(extra);
		}

		//将宝箱移除并根据移除时的状态加入结果
		private function removeTreasure(index:uint, issuccess:Boolean = false):Boolean
		{
			var treasure:TreasureItem = treasures[index];
			treasure.setExtras({result: issuccess ? 1 : 0});
			Pool.recover("treasure", treasure);
			treasure.removeSelf();
			treasures.splice(index,1);
		}

		public function removeAllListeners():void
		{
			stopTimer();
			Laya.stage.off(Event.MOUSE_DOWN, this, onMouseDown);
			Laya.stage.off(Event.MOUSE_MOVE, this, mouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, mouseUp);
			Laya.timer.clear(this,onFrame);
			btn_close.off(Event.CLICK,this,onClose);
		}

		public function get score():Number {
			return this._score;
		}

		public function set score(val:Number) {
			//更新分数标签UI的内容
			score_lab.text = String(this._score);
			this._score = val;
		}
	}
}

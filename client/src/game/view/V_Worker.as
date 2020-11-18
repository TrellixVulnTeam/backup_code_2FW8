package game.view
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.SortOn;
	import com.cong.utils.UITool;

	import game.constants.CONST_EVENT;

	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.estate.WorkerInfo;
	import game.view.worker.WorkerItem;

	import laya.events.Event;
	import laya.utils.Handler;

	import ui.WorkerUI;

	public class V_Worker extends WorkerUI implements IView
	{
		public var fromMap:Boolean;
		public function V_Worker()
		{
			UITool.initList(list,WorkerItem);
		}

		private static var _instance:V_Worker;
		public static function get instance():V_Worker
		{
			if (null == _instance)
			{
				_instance = new V_Worker();
			}
			return _instance;
		}

		public function onShow():void
		{
			C_House.instance.getWorkers();
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			EventCenter.ins.on(CONST_EVENT.SHOW_WORKERS, this, getWorkersRet);
			btn_close.on(Event.CLICK, this, closeHandler);
		}

		private var workers:Array;

		private function getWorkersRet(obj:Object):void
		{
			workers = obj.workers;
			tab.selectHandler = new Handler(this,tabHandler);
			tab.selectedIndex = 0;
		}

		private function tabHandler():void
		{
			switch (tab.selectedIndex)
			{
				case 0:
					//品质
					SortOn.sortOn(workers, "quality");
					break;
				case 1:
					//力量
					SortOn.sortOn(workers, "power");
					break;
				case 2:
					//智力
					SortOn.sortOn(workers, "intelligence");
					break;
				case 3:
					//敏捷
					SortOn.sortOn(workers, "agile");
					break;
				case 4:
					//魅力
					SortOn.sortOn(workers, "charm");
					break;
				case 5:
					//工作
					workers.sort(function (a:WorkerInfo,b:WorkerInfo) {
						if(a.shopType<b.shopType){
							return 1;
						}else{
							return -1;
						}
					})
					break;
			}
			list.dataSource = workers;
		}

		public function removeAllListeners():void
		{
			btn_close.off(Event.CLICK, this, closeHandler);
			EventCenter.ins.off(CONST_EVENT.SHOW_WORKERS, this, getWorkersRet);
			tab.off(Event.SELECT, this, tabHandler);
		}

		private function closeHandler():void
		{
			if (fromMap) C_UI.instance.backToHome(); else UIManager.instance.removePanel(this);
		}
	}
}

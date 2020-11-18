package game.view.worker
{
	import com.cong.managers.UIManager;

	import game.config.ConfigEstateType;

	import game.config.ConfigWorkerGrowUp;
	import game.data.D_Estate;
	import game.data.estate.WorkerInfo;
	import game.view.estate.V_WorkerInfo;

	import laya.events.Event;

	import ui.worker.WorkerItemUI;

	public class WorkerItem extends WorkerItemUI
	{
		public function WorkerItem()
		{
			super();
		}

		private var workerInfo:WorkerInfo;
		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if(value){
				workerInfo = value as WorkerInfo;
				txt_name.text = workerInfo.name;
				var levelCoe:Number = ConfigWorkerGrowUp.getGrowUpByLevel(workerInfo.level).LevelCoefficient;
				txt_power.text = workerInfo.power*workerInfo.qualityCoefficient*levelCoe + "";
				txt_agile.text = workerInfo.agile*workerInfo.qualityCoefficient*levelCoe + "";
				txt_charm.text = workerInfo.charm*workerInfo.qualityCoefficient*levelCoe + "";
				txt_intelligence.text = workerInfo.intelligence*workerInfo.qualityCoefficient*levelCoe + "";
				if(workerInfo.shopType){
					txt_shop.text = ConfigEstateType.getHouseType(workerInfo.shopType).Name;
				}else{
					txt_shop.text = "";
				}
				this.on(Event.CLICK,this,showWorkerInfo);
			}
		}

		private function showWorkerInfo():void
		{
			V_WorkerInfo.instance.setWorkerInfo(workerInfo);
			UIManager.instance.popUpWindow(V_WorkerInfo.instance);
		}
	}
}

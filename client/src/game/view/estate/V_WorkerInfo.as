package game.view.estate
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.net.Network;

	import game.config.ConfigBuyer;
	import game.config.ConfigWorkerGrowUp;

	import game.constants.CONST_EVENT;

	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.D_Estate;

	import game.data.estate.BuyerBase;
	import game.data.estate.CustomerInfo;

	import game.data.estate.WorkerInfo;
	import game.view.V_Worker;

	import laya.events.Event;

	import ui.estate.WorkerInfoUI;

	public class V_WorkerInfo extends WorkerInfoUI implements IView
	{
		public function V_WorkerInfo()
		{
		}

		private static var _instance:V_WorkerInfo;
		private var _data:BuyerBase;

		public static function get instance():V_WorkerInfo
		{
			if (null == _instance)
			{
				_instance = new V_WorkerInfo();
			}
			return _instance;
		}

		public function onShow():void
		{
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_zm.on(Event.CLICK, this, zmHandler);
			btn_sg.on(Event.CLICK, this, sgHandler);
			btn_change.on(Event.CLICK, this, changeHandler);
			EventCenter.ins.on(CONST_EVENT.SHOW_WORKER_INFO, this, showWorkerInfo);
		}

		private function changeHandler():void
		{
			UIManager.instance.removePopUpWindow(this);
			C_UI.instance.showWorkers(false);
		}

		private function showWorkerInfo(worker:WorkerInfo):void
		{
			txt_name.text = worker.name;
			var levelCoe:Number = ConfigWorkerGrowUp.getGrowUpByLevel(worker.level).LevelCoefficient;
			txt_power.text = worker.power * worker.qualityCoefficient * levelCoe + "";
			txt_agile.text = worker.agile * worker.qualityCoefficient * levelCoe + "";
			txt_charm.text = worker.charm * worker.qualityCoefficient * levelCoe + "";
			txt_intelligence.text = worker.intelligence * worker.qualityCoefficient * levelCoe + "";
		}

		private function sgHandler():void
		{
			C_House.instance.operWorker(2, _data.type, D_Estate.instance.operBuild.id, D_Estate.instance.selectFloorId);
			UIManager.instance.removePopUpWindow(this);
			UIManager.instance.removePanel(V_Worker.instance);
		}

		private function zmHandler():void
		{
			C_House.instance.operWorker(1, _data.type, D_Estate.instance.operBuild.id, D_Estate.instance.selectFloorId);
			UIManager.instance.removePopUpWindow(this);
		}

		public function removeAllListeners():void
		{
			btn_zm.off(Event.CLICK, this, zmHandler);
			btn_sg.off(Event.CLICK, this, sgHandler);
			EventCenter.ins.off(CONST_EVENT.SHOW_WORKER_INFO, this, showWorkerInfo);
		}

		public function setCustomerInfo(value:CustomerInfo):void
		{
			//顾客用;
			btn_sg.visible = btn_change.visible = btn_zm.visible = false;
			_data = value;
			txt_name.text = value.name;
			txt_power.text = value.power.toString();
			txt_agile.text = value.agile.toString();
			txt_charm.text = value.charm.toString();
			txt_intelligence.text = value.intelligence.toString();
			if (value.bestValue >= value.bestLimit)
			{
				btn_zm.visible = true;
			}
		}

		//从V_Worker查看员工或者选择员工
		public function setWorkerInfo(value:WorkerInfo)
		{
			btn_sg.visible = btn_change.visible = btn_zm.visible = false;
			_data = value;
			showWorkerInfo(value);
			if (V_Shop.instance.parent && !value.shopType)
			{
				btn_sg.visible = true;
			}
		}

		//从ShopFloorItem查看员工
		public function setWorkerId(userId:int, workerId:int):void
		{
			//员工
			C_House.instance.getWorkerInfo(userId, workerId);
			btn_zm.visible = false;
			btn_sg.visible = false;
			btn_change.visible = true;
		}
	}
}

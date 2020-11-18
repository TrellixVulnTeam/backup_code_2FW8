package game.view.map
{
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;
	import com.cong.utils.UITool;

	import laya.events.Event;

	import ui.map.BuildSkinSettingUI;
	import ui.map.BuildingSkinItemUI;

	public class BuildSkinSetting extends BuildSkinSettingUI implements IView
	{
		public function BuildSkinSetting()
		{
			super();
			UITool.initList(list,BuildingSkinItemUI);
		}

		public function onShow():void
		{
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_close.on(Event.CLICK,this,onClose);
		}

		private function onClose():void
		{
			UIManager.instance.removePanel(this);
		}

		public function removeAllListeners():void
		{
		}
	}
}

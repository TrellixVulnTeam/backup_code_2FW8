package game.view.estate
{
	import com.cong.utils.TextUtil;

	import game.controller.C_UI;

	import game.data.house.CZInfo;
	import game.str.Language;

	import laya.events.Event;

	import ui.estate.LandlordItemUI;

	public class LandlordItem extends LandlordItemUI
	{
		public function LandlordItem()
		{
			super();
			on(Event.CLICK, this, onClick);
		}

		private function onClick():void
		{
			C_UI.instance.showHouse(dataSource,false);
		}

		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (value)
			{
				var shopInfo:CZInfo = value as CZInfo;
				txt_name.text = TextUtil.conectParam(Language.HOUSE_NAME, [shopInfo.level, shopInfo.name]);
				txt_income.text = shopInfo.income + "/" + Language.TIAN;
				txt_value.text = shopInfo.value.toString();
				shopNum.text = shopInfo.czNum + "/" + shopInfo.totalNum;
			}
		}
	}
}

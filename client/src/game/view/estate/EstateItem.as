package game.view.estate
{
	import com.cong.utils.TextUtil;

	import game.constants.CONST_BUILD_TYPE;

	import game.controller.C_UI;
	import game.data.house.EstateInfo;
	import game.str.Language;

	import laya.events.Event;

	import ui.estate.EstateItemUI;

	public class EstateItem extends EstateItemUI
	{
		private var estateInfo:EstateInfo;

		public function EstateItem()
		{
			super();
			on(Event.CLICK, this, onClick);
		}

		private function onClick():void
		{
			if (estateInfo.type == CONST_BUILD_TYPE.SHOP) C_UI.instance.showShop(dataSource, false);
			else if (estateInfo.type == CONST_BUILD_TYPE.HOUSE) C_UI.instance.showHouse(dataSource, false);
		}

		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if (value)
			{
				estateInfo = value as EstateInfo;
				txt_name.text = TextUtil.conectParam(Language.HOUSE_NAME, [estateInfo.level, estateInfo.name]);
				txt_income.text = estateInfo.income + "/" + Language.TIAN;
				if (estateInfo.value)
				{
					txt_value.text = estateInfo.value.toString();
					box_value.visible = true;
					box_rent.visible = false;
				} else
				{
					txt_rent.text = estateInfo.rent.toString();
					box_value.visible = false;
					box_rent.visible = true;
				}
				txt_shopNum.text = estateInfo.shopNum.toString();
			}
		}
	}
}

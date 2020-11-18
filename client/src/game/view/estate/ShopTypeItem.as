package game.view.estate
{
	import com.cong.utils.TextUtil;

	import game.constants.CONST_FILE;
	import game.controller.C_House;
	import game.controller.C_UI;
	import game.data.D_Estate;
	import game.data.D_Game;
	import game.str.Language;

	import laya.events.Event;
	import laya.utils.Handler;

	import ui.estate.ShopTypeItemUI;

	public class ShopTypeItem extends ShopTypeItemUI
	{
		public function ShopTypeItem()
		{
		}

		override public function set dataSource(value:*):void
		{
			super.dataSource = value;
			if(value){
				ico_shopType.skin = CONST_FILE.getShopTypeIcon(value.ID);
				ico_shopAttr.skin = CONST_FILE.getShopAttrIcon(value.Attribute);
				txt_name.text = value.Name;
				txt_income.text = value.Money + "/" + Language.XIAO_SHI;
				if(value.UnlockLevel > D_Game.instance.userInfo.level){
					ico_unlock.visible = true;
				}else{
					ico_unlock.visible = false;
				}
				on(Event.CLICK,this,onClick);
			}
		}

		private function onClick():void
		{
			var msg:String = TextUtil.conectParam(Language.TIP_25,[dataSource.Name]);
			C_UI.instance.alert(msg,2,Handler.create(this,okHandler));
		}

		private function okHandler():void
		{
			C_House.instance.operHouseFloor(6,D_Estate.instance.operBuild.id,V_ShopSelectType.instance.shopInfo.id,0,dataSource.ID);
		}
	}
}

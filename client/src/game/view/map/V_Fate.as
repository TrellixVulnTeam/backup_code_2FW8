package game.view.map
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.utils.LayoutUtil;

	import game.constants.CONST_EVENT;

	import game.constants.CONST_FILE;
	import game.data.map.StayEvent;

	import ui.map.FateUI;

	public class V_Fate extends FateUI implements IView
	{
		public function V_Fate()
		{
			super();
		}

		private static var _instance:V_Fate;
		public static function get instance():V_Fate
		{
			if (null == _instance)
			{
				_instance = new V_Fate();
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
			EventCenter.ins.event(CONST_EVENT.EVENT_HANDLE_COM);
		}

		public function removeAllListeners():void
		{
		}

		public function setData(event:StayEvent,exp:int,money:int, power:int, diamonds:int):void
		{
			img_fate.skin = CONST_FILE.getFateImg(event.secondType);
			txt_msg.text = event.name;
			var numChild:int = box_res.numChildren;
			for (var i:int = 0; i < numChild; i++)
			{
				box_res.removeChildAt(0);
			}
			if (exp)
			{
				if (exp > 0)
				{
					txt_exp.text = "+" + exp;
					txt_exp.color = "#00777d";
				} else
				{
					txt_exp.text = exp.toString();
					txt_exp.color = "#c40000";
				}
				box_res.addChild(box_exp);
			}

			if (money)
			{
				if (money > 0)
				{
					txt_money.text = "+" + money;
					txt_money.color = "#00777d";
				} else
				{
					txt_money.text = money.toString();
					txt_money.color = "#c40000";
				}
				box_res.addChild(box_money);
			}

			if (diamonds)
			{
				if (diamonds > 0)
				{
					txt_diamond.text = "+" + diamonds;
					txt_diamond.color = "#00777d";
				} else
				{
					txt_diamond.text = diamonds.toString();
					txt_diamond.color = "#c40000";
				}
				box_res.addChild(box_diamond);
			}

			if (power)
			{
				if (power > 0)
				{
					txt_power.text = "+" + power;
					txt_power.color = "#00777d";
				} else
				{
					txt_power.text = power.toString();
					txt_power.color = "#c40000";
				}
				box_res.addChild(box_power);
			}
			LayoutUtil.layoutVBox(box_res,0);
		}
	}
}

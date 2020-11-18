package game.view.map
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.utils.LayoutUtil;

	import game.constants.CONST_EVENT;

	import ui.map.NPCEventResultUI;

	public class V_NPCEventResult extends NPCEventResultUI implements IView
	{
		public function V_NPCEventResult()
		{
			super();
		}

		private static var _instance:V_NPCEventResult;
		public static function get instance():V_NPCEventResult
		{
			if (null == _instance)
			{
				_instance = new V_NPCEventResult();
			}
			return _instance;
		}

		public function onShow():void
		{
		}

		public function onHide():void
		{
			EventCenter.ins.event(CONST_EVENT.EVENT_HANDLE_COM);
		}

		public function addAllListeners():void
		{
		}

		public function removeAllListeners():void
		{
		}

		public function setResult(result:String, exp:int, money:int, power:int, diamonds:int):void
		{
			txt_result.text = result;
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

package game.view.map
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.managers.UIManager;

	import game.constants.CONST_EVENT;
	import game.controller.C_Map;
import game.data.map.StayEvent;

import laya.ani.bone.Skeleton;

import laya.events.Event;
import laya.maths.Rectangle;
import laya.utils.Handler;

import ui.map.NPCEventUI;

	public class V_NPCEvent extends NPCEventUI implements IView
	{
		public function V_NPCEvent()
		{
			super();
			_anim = new Skeleton();
			animLayer.addChild(_anim);
		}

		private static var _instance:V_NPCEvent;
		private var _type:int;
		private var _content:Object;
		private var _exp:int;
		private var _money:int;

		private var _anim:Skeleton;

		public static function get instance():V_NPCEvent
		{
			if (null == _instance)
			{
				_instance = new V_NPCEvent();
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
			btn_ok.on(Event.CLICK, this, okHandler);
			btn_cancel.on(Event.CLICK, this, cancelHandler);
			EventCenter.ins.on(CONST_EVENT.NPC_EVENT_RESULT, this, onNpcEventResutlt);
		}

		private function onNpcEventResutlt(obj:Object):void
		{
			UIManager.instance.removePanel(this);
			V_NPCEventResult.instance.setResult(result, obj.exp, obj.money,obj.power,obj.diamonds);
			UIManager.instance.popUpWindow(V_NPCEventResult.instance);
		}

		private var result:String;

		private function cancelHandler():void
		{
			result = _content.Result[1];
			C_Map.instance.selectNPCEvent(1);
		}

		private function okHandler():void
		{
			result = _content.Result[0];
			C_Map.instance.selectNPCEvent(0);
		}

		public function removeAllListeners():void
		{
			btn_ok.off(Event.CLICK, this, okHandler);
		}

		public function set type(type:int):void
		{
			_type = type;
		}

		public function set content(content:Object):void
		{
			_content = content;
			txt_message.text = content.Talk;
			lab_ok.text = content.Button[0];
			lab_cancel.text = content.Button[1];
		}

		public function setData(event:StayEvent):void {
			type = event.secondType;
			content = event.content;
			_anim.load("ani/map/" + event.content.Skin + ".sk", Handler.create(this, onComplete));
		}

		private function onComplete():void {
			var rect:Rectangle = _anim.getBounds();
			_anim.pos(-rect.x /2, -rect.y);
			_anim.play("", true);
		}


//    public function setResult(exp:int, money:int):void
//    {
//        _exp = exp;
//        _money = money;
//    }
	}
}

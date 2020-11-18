package game.view.map
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;

	import game.constants.CONST_EVENT;
	import game.data.map.StayEvent;

	import laya.ani.bone.Skeleton;
	import laya.maths.Rectangle;
	import laya.utils.Handler;

	import ui.map.GodsUI;

	public class V_Gods extends GodsUI implements IView
	{
		private var _type:int;
		private var _animActor:Skeleton;
//		private static var animPlayList:Array = ["idle01", "walk01"];
		public function V_Gods()
		{
			super();
			_animActor = new Skeleton();
			npcLayer.addChild(_animActor);
//			npcLayer.graphics.drawRect(0, 0, npcLayer.width,npcLayer.height, "#f00");

		}


		private static var _instance:V_Gods;
		public static function get instance():V_Gods
		{
			if (null == _instance)
			{
				_instance = new V_Gods();
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

		public function setData(event:StayEvent):void
		{
			txt_msg.text = event.content.Name + ":" + event.content.Talk;
			_animActor.load("ani/map/" + event.content.Skin + ".sk", Handler.create(this, parseCompolete));
		}

		private function parseCompolete():void {
			var bounds:Rectangle = _animActor.getBounds();
			_animActor.size(bounds.width,bounds.height);
			_animActor.scaleX = -1;
			_animActor.pos(_animActor.width / 2, _animActor.height);
			_animActor.play("jump01", true);
//			playAnim();
//			_animActor.on(Event.STOPPED, this, playAnim);
		}

		private function playAnim():void {
//			var anim:String = animPlayList.shift();
//			animPlayList.push(anim);
//			_animActor.play(anim, false);
		}
	}
}
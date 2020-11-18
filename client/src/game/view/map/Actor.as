package game.view.map
{
	import game.config.ConfigActorSpeak;
	import game.constants.CONST_FILE;

	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	import laya.utils.Tween;

	import ui.map.ActorUI;

	public class Actor extends ActorUI implements IRole
	{
		public var skeleton:Skeleton;
		private var aniLoaded:Boolean;
		private var state:String;

		public static const WALK:String = "walk";
		public static const IDLE:String = "idle";

		public var bufState:int = 0;
		private var anim:int;
		private static const ActorTypeToAnimNameTable:Object = {
			1: "sunxiaomei",
			2: "sunxiaomei"
		};

		public function Actor(actorType:int = 2)
		{
			super();
			//创建一个Skeleton对象
			skeleton = new Skeleton();
			//添加到舞台
			addChild(skeleton);

			//通过加载直接创建动画
			skeleton.load(getAnimName(actorType), Handler.create(this, parseComplete));
			state = IDLE;
		}

		private function parseComplete():void
		{
			aniLoaded = true;
			switch (state)
			{
				case WALK:
					skeleton.play("walk01", true);
					break;
				case IDLE:
					skeleton.play("idle01", true);
					break;
			}
		}

		public function set type(val:int)
		{
			img_body.skin = "map/" + "role" + val + ".png";
		}

		public function getAnimName(val:int):String {
			var animName = ActorTypeToAnimNameTable[val];
			if (animName != null) {
				return "ani/actor/" + animName + ".sk"
			}

			return "ani/actor/" + ActorTypeToAnimNameTable[2] + ".sk"
		}

		public function movePath():void
		{
		}

		public function addBuffer(type:int):void
		{
			bufState = type;
			ico_buff.skin = CONST_FILE.getGodBuff(type);
			ico_buff.visible = true;
		}

		public function removeBuffer():void
		{
			bufState = 0;
			ico_buff.visible = false;
		}

		public function showSpeak(money:int)
		{
			if (money)
			{
				var obj:Object = ConfigActorSpeak.getSpeak(money);
				txt_msg.text = obj.msg;
				ico_face.skin = CONST_FILE.getEmoji(obj.Emoji);
				Tween.clearAll(box_speak);
				Tween.to(box_speak, {alpha: 1}, 500, null, Handler.create(this, this.showComplete),1000);
				box_speak.visible = true;
			}
		}

		private function showComplete():void
		{
			Tween.to(box_speak, {alpha: 0}, 500, null, Handler.create(this, this.hideComplete), 1500);
		}

		private function hideComplete():void
		{
			box_speak.visible = false;
		}

			public function playWalk():void {
			if(aniLoaded)
				skeleton.play("walk01", true);
			state = WALK;
		}

		public function playIdle():void
		{
			if (aniLoaded) skeleton.play("idle01", true);
			state = IDLE;
		}
	}
}

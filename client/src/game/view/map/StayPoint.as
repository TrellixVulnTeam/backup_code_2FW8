package game.view.map
{
	import game.config.ConfigStayEvent;
	import game.constants.CONST_FILE;
	import game.data.map.StayEvent;

	import ui.map.StayEventPointUI;

	public class StayPoint extends StayEventPointUI
	{
//		private var _type:int;
//		private var _secType:int;
		public var id:int;
		public var xPos:Number;
		public var yPos:Number;
		private var content:String;
		private var event:StayEvent;
		public function StayPoint(content:String)
		{
			this.content = content;
			var split:Array = content.split(",");
			this.id = split[2];
			this.xPos = split[0];
			this.yPos = split[1];
			event = ConfigStayEvent.getEvent(id);
			icon.skin = CONST_FILE.getStayPoingICon(event.type,event.secondType);
		}

		public function setContent(content:String):void
		{
			if(this.content!=content){
				this.content = content;
				var split:Array = content.split(",");
				this.id = split[2];
				this.xPos = split[0];
				this.yPos = split[1];
				event = ConfigStayEvent.getEvent(id);
				icon.skin = CONST_FILE.getStayPoingICon(event.type,event.secondType);
			}
		}

		public function get type():int{
			return event.type;
		}

		public function setId(id:int = 0):void
		{
			this.id = id;
			this.content = xPos + "," + yPos + id;
			event = ConfigStayEvent.getEvent(id);
			icon.skin = CONST_FILE.getStayPoingICon(event.type,event.secondType);
		}
	}
}

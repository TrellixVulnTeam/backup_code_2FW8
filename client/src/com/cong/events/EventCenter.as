package com.cong.events
{
	import laya.events.EventDispatcher;

	public class EventCenter extends EventDispatcher
	{
		public static var ins:EventCenter = new EventCenter();
	}
}
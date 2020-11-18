/**
 * Created by chencong on 2016/10/9 0009.
 */
package game.data.guide
{
	public class GuideStepData
	{
		public var stepid:int;
		public var direct:int;
		public var posx:int;
		public var posy:int;
		public var pid:int = 0;  //图片id
		public var msg:String;
		public var wid:Number;       //交互区宽高
		public var hei:Number;
		public var relObj:*;
		public var mouseEnabled:Boolean = true;
		public var followObject:Boolean =  false;
		public var offsetX:Number = 0;
		public var offsetY:Number = 0;
		public function GuideStepData()
		{
		}
	}
}

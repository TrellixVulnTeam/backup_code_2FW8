/**
 * Created by chencong on 2016/10/9 0009.
 */
package game.data.guide
{
	public class GuideData
	{
		public var id:int;
		public var type:int;
		public var level:int;
		public var step:Vector.<GuideStepData> = new Vector.<GuideStepData>();
		public var nextGuideId:int;
		public function GuideData()
		{
		}
	}
}

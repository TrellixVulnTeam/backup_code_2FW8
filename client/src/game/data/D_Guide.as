/**
 * Created by chencong on 2016/10/9 0009.
 */
package game.data
{
	import game.data.guide.GuideData;

	public class D_Guide
	{
		public function D_Guide()
		{
		}

		private static var _instance:D_Guide;
		public var curGuide:GuideData;
		private var _finishGuides:Array = [];

		public static function get instance():D_Guide
		{
			if(!_instance ) _instance = new D_Guide();
			return _instance;
		}

		public function get finishGuides():Array
		{
			return _finishGuides;
		}

		public function set finishGuides(value:Array):void
		{
			_finishGuides = value;
		}

		public function get guideId():int{
			if(curGuide){
				return curGuide.id;
			}
			return 0;
		}

		public function guideFinished(id:int):Boolean{
			for (var i:int = 0; i < _finishGuides.length; i++)
			{
				if(_finishGuides[i] == id){
					return true;
				}
			}
			return false;
		}

		public function setGuideFinished(id:int){
			if(!guideFinished(id)){
				_finishGuides.push(id);
				C_User.instance.setGuide();
			}
		}
	}
}

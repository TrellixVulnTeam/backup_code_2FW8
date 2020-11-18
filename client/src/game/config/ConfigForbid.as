package game.config
{
	import game.controller.C_ForbidWords;

	public class ConfigForbid
	{
		private static var data:Object;
		
//		private static var forbidArr:Array = [];
		
		public static var states:Object;
		public static var nowState:uint = 0;
		public static var maxSubStringLen:uint = 0;
		
		public static function initConfig(xmlObj_:Object):void
		{
			data = xmlObj_;
			
			states = new Object();
			
			var dirtyList:Array = xmlObj_["word"];
			var dirtyLen:int = dirtyList.length;
			var wordArray:Array = [];
			
			for (var i:int = 0; i < dirtyLen; i++) 
			{
				if(dirtyList[i]["wordContent"] != "")
				{
					wordArray.push(dirtyList[i]["wordContent"]);
				}			
			}
			
			wordArray.push("<");
			
			wordArray.sort();
			C_ForbidWords.instance.init(wordArray);
			
//            var strContent:String = data["text"][0]["text"];
//			rforbidArr = strContent.split(",");
//
//			C_ForbidText.instance.init(strContent);
//
//			init(strContent);
		}
		
		public static function init(str:String):void{		
//			var strWord:String;
//			nowState = 0;
//			var wordArray:Array = str.split(",");
//			for each (strWord in wordArray) {
//				maxSubStringLen = Math.max(strWord.length, maxSubStringLen);
//				addMaskString(strWord);
//			};
//
//            C_ForbidWords.instance.init(str);
		}
		
		
		
		private static function addMaskString(maskString:String):void{			
			var state:uint = 0;		
			var corretState:uint;	
			var flag:Boolean = true;
			var strCode:uint = 0;
			var stridx:int = 0;
			var strlen:int = maskString.length;
			while (stridx < strlen) {
				strCode = maskString.charCodeAt(stridx);
				corretState = (state | strCode);
				if ((((states[corretState] == null)) || (!(flag)))){
					flag = false;
					nowState = (nowState + 65536);
					states[corretState] = nowState;
					state = nowState;
				}
				else {
					state = states[corretState];
				};
				stridx++;
			};
			if (!flag){
				states[corretState] = (0xFFFF0000 | strlen);
			};
		}
		
//		public function GetForbidArray():Array
//		{
//			return rforbidArr;
//		}
		
	}
}
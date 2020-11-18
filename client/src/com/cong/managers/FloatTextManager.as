package com.cong.managers
{
	import com.cong.components.FloatItem;
	import com.cong.components.FloatingText;

	import laya.display.Sprite;

	import laya.ui.View;
	import laya.utils.Handler;

	import laya.utils.Pool;

	public class FloatTextManager
	{
		public static function showCenter(content_:String,icoType:int = 0,color_:String="#efefef",size_:int=45, _htmlboo:Boolean=false):void
		{
			if(content_==""||content_==null)
			{
				return;
			}
			addFloatingTextInfo(content_,icoType,0,0,size_,color_,_htmlboo);
		}

		public static var floatCount:int;
		private static function addFloatingTextInfo(htmlortextstr:String, _type:int=0, _x:int=0, _y:int=0, _size:int=45, _color:String="#FF0000", _htmlboo:Boolean=false):void
		{
			var _floatingtext:FloatingText = Pool.getItem("toast");
			floatCount++;
			if(!_floatingtext){
				_floatingtext = new FloatingText(htmlortextstr,_type, _size, _color, function () {
					floatCount--;
					Pool.recover("toast",_floatingtext);
				});
			}else{
				_floatingtext.showText(htmlortextstr,_type);
			}
			LayerManager.instance.getLayer(LayerManager.LAYER_TOP_EFFECT).addChild(_floatingtext);
		}

		public static function showItem(view:Sprite,callback:Handler = null){
			var item:FloatItem = new FloatItem(view,callback);
			item.show();
			LayerManager.instance.getLayer(LayerManager.LAYER_TOP_EFFECT).addChild(view);
		}
	}
}

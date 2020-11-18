package com.cong.utils
{
	import laya.ui.List;

	public class UITool
	{
		public function UITool()
		{
		}

		public static function initList(list:List,render:*):void{
			list.itemRender = render;
			list.scrollBar.hide = true;
			list.scrollBar.elasticBackTime = 300;
			list.scrollBar.elasticDistance = 150;
			list.scrollBar.touchScrollEnable = true;
			list.dataSource = [];
		}
	}
}

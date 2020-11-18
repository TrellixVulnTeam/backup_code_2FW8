package com.cong.components
{
import com.cong.components.alert.AlertFactory;
import com.cong.components.alert.IAlert;

import laya.display.Sprite;
import laya.ui.Dialog;
import laya.utils.Handler;

/**
	 * @example
	 * <listing　version=1.0 >
	 *      为系统弹出框注册父级容器
	 * 		Alert.registerPopUpParent(this.stage);
	 *      
	 *      var okHandler:Function = function():void
	 *      {
	 *         trace('开始突飞武将');
	 *      }
	 * 		Alert.show("你确定要花费10金币突飞武将吗？",1,okHandler);
	 * </listing>
	 * @author chencong
	 */
	public class Alert
	{
		private static var _parent : Sprite;
		private static var currentInstance : *;
		public static const OK:int = 1;
		public static const CANCEL:int = 2;

		/**
		 * 为系统弹出框注册父级容器，建议在Application里面调用
		 * 
		 * @param	popupParent　弹出层父级容器
		 */
		public static function registerParent(popupParent : Sprite) : void
		{
			_parent = popupParent;
		}

		/**
		 * 弹出系统提示，提供3种类型，_type=1为确认框（带有确定和取消按钮），_type2为警告框（只有确定按钮）  3今日不再提示
		 * 
		 * @param	_message 	提示信息
		 * @param	_type		弹出框类型,type为1则为确认框（带有确定和取消按钮），type=2则为警告框（只有确定按钮）--- 可能寫錯，2才為有兩個按鈕提示
		 * @param	_backFun	确定按钮回调函数
		 * @param	modal		模式(true表示有遮罩,false表示无遮罩)
		 * @param	maskColor	遮罩颜色
		 * @param	maskAlpha	遮罩颜色透明度
		 * @return
		 */
		public static function show(_message : String, _type : uint = 1, handler:Handler = null) : void
		{
			currentInstance = AlertFactory.getInstanceByType(_type);
			if(handler){
				(currentInstance as IAlert).handler = handler;
			}
			(currentInstance as IAlert).message = _message;
			(currentInstance as Dialog).popupCenter = true;
			(currentInstance as Dialog).popup(false);
//			if(D_Game.instance.sound_on)
//				SoundManager.playSound(CONST_FILE.getSound("warning"));
		}
	}
}

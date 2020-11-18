package com.cong.managers
{
	import com.cong.interfaces.IView;

	import laya.display.Sprite;
	import laya.ui.Dialog;

	public class UIManager
	{

		private static var _ins:UIManager;

		public static function get instance():UIManager
		{
			if (_ins == null)
			{
				_ins = new UIManager();
			}
			return _ins;
		}

		private var showPanelList:Array;
		private var showWindowList:Array;
		public function UIManager()
		{
			showPanelList = new Array();
			showWindowList = new Array();
		}

		/**
		 *打开一个UIPanel的实例
		 * @param
		 * @param layerType
		 * @param isActive
		 *
		 */
		public function showPanel(panel:IView, layerType:String = "LAYER_MAIN_UI", isActive:Boolean = true):void
		{
			this._showPanel(panel, layerType, isActive);
			showPanelList.push(panel);
//			(panel as Sprite).alpha = 0;
//			Tween.clearTween(panel);
//			Tween.to(panel,{alpha:1},300);
		}

		public function removePanel(panel:IView):void
		{
			panel.removeAllListeners();
			panel.onHide();
			for (var i:int = 0; i < showPanelList.length; i++)
			{
				if(showPanelList[i] == panel){
					showPanelList.splice(i,1);
					break;
				}
			}
//			Tween.clearTween(panel);
//			Tween.to(panel,{alpha:0},200,null,Handler.create(panel,function () {
//				(panel as Sprite).removeSelf();
//			}));
			(panel as Sprite).removeSelf();
		}

		public function isShowTop(panel:IView):Boolean{
			if(showPanelList[showPanelList.length-1] == panel){
				return true;
			}
			return false;
		}

		/**
		 * 根据类实例对象打开该窗口 （如果该窗口在打开状态的话不会关闭，如果需要该功能的话请调用 showHidePanelByType()）
		 * @param panel_
		 * @param _layerType
		 * @param _isActive
		 * @param _ignoreDuaringHidingAllPanel
		 * @return
		 *
		 */
		private function _showPanel(panel_:IView, layerType:String = "", _isActive:Boolean = true, ignoreDuaringHidingAllPanel_:Boolean = false):Boolean
		{
			if (panel_ == null)
			{
				return false;
			}
			(panel_ as Sprite).visible = true;
			var ret:Boolean = LayerManager.instance.addLayerChild(layerType, panel_ as Sprite);
			panel_.addAllListeners();
			panel_.onShow();
			return ret;
		}

		/**
		 * 弹出窗口
		 * @param window
		 * @param tabIndex
		 * @param params
		 * @return
		 */
		public function popUpWindow(window:Sprite, tabIndex:int = 0, params:Array = null):Sprite
		{
//			var layer:Sprite = LayerManager.instance.getLayer(LayerManager.LAYER_POPUP_UI);
			if (window.hasOwnProperty("tabIndex"))
			{
				window["tabIndex"] = tabIndex;
			}
			if (window is Dialog)
			{
				(window as Dialog).popupCenter = true;
				(window as Dialog).popup(false);
			}
			if (window is IView)
			{
				(window as IView).addAllListeners();
				(window as IView).onShow();
				(window as Dialog).onClosed = function () {
					(window as IView).removeAllListeners();
					(window as IView).onHide();
					for (var i:int = 0; i < showWindowList.length; i++)
					{
						if(showWindowList[i] == window){
							showWindowList.splice(i,1);
							break;
						}
					}
				}
			}
//			if(D_Game.instance.sound_on)
//				SoundManager.playSound(CONST_FILE.getSound("pop-up"));
			showWindowList.push(window);
			return window;
		}

		/**
		 * 移除窗口
		 * @param window
		 * @param tabIndex
		 * @param params
		 * @return
		 */
		public function removePopUpWindow(window:Sprite):Sprite
		{
			if (window && window.parent)
			{
//				PopUpManager.removePopUp(window);
				(window as Dialog).close();
			}
			return window;
		}

		public function removeAllWindow():void{
			for (var i:int = 0; i < showWindowList.length; i++)
			{
				removePopUpWindow(showWindowList[i]);
			}
		}
	}
}

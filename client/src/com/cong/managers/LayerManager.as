package com.cong.managers
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;

	public class LayerManager
	{
		public static const LAYER_SCENE:String="LAYER_SCENE"; //场景层，主要是内城、外城、世界等场景
		public static const LAYER_MAP_GOPOINT:String="LAYER_MAP_GOPOINT"; //地图鼠标表现层
		public static const LAYER_MAIN_UI:String="LAYER_MAIN_UI"; //主ui层，主要游戏四角的ui，比如小地图，主功能导航条等
		public static const LAYER_FULL_SCREEN_UI:String="LAYER_FULL_SCREEN_UI"; //全屏ui层，比如创建角色界面等
		public static const LAYER_POPUP_UI:String="LAYER_POPUP_UI"; //弹出ui层，所有的弹出式的界面，比如建筑功能界面等
		public static const LAYER_TOP_UI:String="LAYER_TOP_UI"; //顶层ui层，跑马灯等（可交互）
		public static const LAYER_TOP_UI_NO_INTERACTIVE:String="LAYER_TOP_UI_NO_INTERACTIVE"; //顶层ui层，tip等（不可交互）
		public static const LAYER_TOP_EFFECT:String="LAYER_TOP_EFFECT"; //光效层
		public static const LAYER_TOP:String = "LAYER_TOP";
		public static const LAYER_STORY:String="LAYER_STORY"; //NPC对话层 剧情层
		public static const LAYER_TUTOR:String="LAYER_TUTOR"; //教学层
		public static const LAYER_LOADING:String="LAYER_LOADING"; //loading层
		public static const LAYER_SCENE_LOADING:String="LAYER_SCENE_LOADING"; //场景loading层
		public static const LAYER_ACTIVE:String="LAYER_ACTIVE"; //激活状态提示层
		public static const LAYER_MOUSE:String="LAYER_MOUSE"; //鼠标图标层
		public static const LAYER_PRE_LOADING:String="LAYER_PRE_LOADING"; //游戏进入loading层
		public static const LAYER_ALERT:String = "LAYER_ALERT";  //系统弹框
		public static const LAYER_UI:String = "LAYER_UI";
		
		private  static var mainUiLayer:Sprite;
		private static var popPanelLayer:Sprite;
		private  static var tutorLayer:Sprite;
//		private static var topUILayer:Sprite;
		
		

		private static var _sInstance:LayerManager;

		public static function get instance():LayerManager
		{
			if (null == _sInstance)
			{
				_sInstance=new LayerManager();
			}
			return _sInstance;
		}


		private var _layers:Array=[];

		public function LayerManager()
		{
		}

		public function init(root_:Sprite):void
		{
			var sp:Sprite;
			//主界面UI
			mainUiLayer = new Sprite();
			mainUiLayer.name = LAYER_MAIN_UI;
			mainUiLayer.hitArea = Rectangle.EMPTY;
			mainUiLayer.mouseThrough = true ;
			_layers.push(mainUiLayer);
			root_.addChild(mainUiLayer);

			popPanelLayer = new Sprite();
			popPanelLayer.name = LAYER_POPUP_UI;
			popPanelLayer.hitArea = Rectangle.EMPTY;
			popPanelLayer.mouseThrough = true ;
			_layers.push(popPanelLayer);
			root_.addChild(popPanelLayer);

			tutorLayer = new Sprite();
			tutorLayer.name = LAYER_TUTOR;
			tutorLayer.hitArea = Rectangle.EMPTY;
			tutorLayer.mouseThrough = true ;
			_layers.push(tutorLayer);
			root_.addChild(tutorLayer);

			sp = new Sprite();
			sp.name = LAYER_TOP;
			sp.hitArea = Rectangle.EMPTY;
			sp.height = Laya.stage.height;
			sp.width = Laya.stage.width;
			sp.mouseThrough = true;
			_layers.push(sp);
			root_.addChild(sp);

			sp = new Sprite();
			sp.zOrder = 2000;
			sp.name = LAYER_TOP_EFFECT;
			sp.hitArea = Rectangle.EMPTY;
			sp.mouseThrough = true ;
			_layers.push(sp);
			root_.addChild(sp);
		}

 
		public function getLayer(layerName_:String):Sprite
		{
			for each (var sp:Sprite in _layers)
			{
				if (sp.name == layerName_)
				{
					return sp;
				}
			}
			return null;
		}

		public function addLayerChild(layerName_:String, obj_:Sprite):Boolean
		{
			var layer:Sprite=getLayer(layerName_);
			if (layer)
			{
				layer.addChild(obj_);
				return true;
			}
			return false;
		}

	}
}

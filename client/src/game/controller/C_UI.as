package game.controller
{
	import com.cong.components.Alert;
	import com.cong.interfaces.IView;
	import com.cong.managers.LayerManager;
	import com.cong.managers.UIManager;

	import game.data.D_Estate;
	import game.data.house.BuildInfoBase;
	import game.view.V_Bottom;
	import game.view.V_CreateRole;
	import game.view.V_Estate;
	import game.view.V_Map;
	import game.view.V_Top;
	import game.view.V_Worker;
	import game.view.common.NetworkConnectTip;
	import game.view.estate.V_House;
	import game.view.estate.V_Shop;
	import game.view.map.V_NPCEvent;
	import game.view.map.V_News;

	import laya.utils.Handler;

	public class C_UI
	{
		public var netErrorEnabled:Boolean = true;

		private static var _instance:C_UI;
		public static function get instance():C_UI
		{
			if (null == _instance)
			{
				_instance = new C_UI();
			}
			return _instance;
		}

		/**
		 * 弹出系统提示，提供2种类型，_type=1为确认框（带有确定和取消按钮），_type2为警告框（只有确定按钮）
		 *
		 * @param    _message    提示信息
		 * @param    _type        弹出框类型,type为1则为确认框（带有确定和取消按钮），type=2则为警告框（只有确定按钮）
		 * @param    _backFun    确定按钮回调函数
		 * @param    modal        模式(true表示有遮罩,false表示无遮罩)
		 * @param    maskColor    遮罩颜色
		 * @param    maskAlpha    遮罩颜色透明度
		 * @return
		 */
		public function alert(_message:String, _type:uint = 1, handler:Handler = null):void
		{
			Alert.show(_message, _type, handler);
		}

		public function hideTop()
		{
			V_Top.instance.removeSelf();
		}

		public function showTop()
		{
			LayerManager.instance.addLayerChild(LayerManager.LAYER_TOP, V_Top.instance);
		}

		public function hideBottom()
		{
			V_Bottom.instance.removeSelf();
		}

		public function showBottom()
		{
			LayerManager.instance.addLayerChild(LayerManager.LAYER_TOP, V_Bottom.instance);
		}

		private var curView:IView;
		private var preView:IView;

		public function backToHome()
		{
			V_Bottom.instance.showMap();
		}

		public function removeAllPanel()
		{
			while (LayerManager.instance.getLayer("LAYER_MAIN_UI").numChildren)
			{
				var panel:IView = LayerManager.instance.getLayer("LAYER_MAIN_UI").getChildAt(0) as IView;
				UIManager.instance.removePanel(panel);
			}
		}

		public function showMap()
		{
			if (curView == V_Map.instance)
			{
				return;
			}
			removeAllPanel();
			UIManager.instance.showPanel(V_Map.instance);
			preView = curView;
			curView = V_Map.instance;
			showTop();
			showBottom();
		}


		public function showNews():void
		{
			UIManager.instance.popUpWindow(V_News.instance);
		}

		public function showEstate():void
		{
			if (curView == V_Estate.instance)
			{
				return;
			}
			preView = curView;
			curView = V_Estate.instance;
			removeAllPanel();
			UIManager.instance.showPanel(V_Estate.instance);
			showTop();
			showBottom();
		}

		public function showMarket():void
		{
			if (curView == V_Shop.instance)
			{
				return;
			}
			preView = curView;
			curView = V_Shop.instance;
			removeAllPanel();
			UIManager.instance.showPanel(V_Shop.instance);
			showTop();
			showBottom();
		}

		/**
		 *显示网络异常提示
		 * @param msg_
		 *
		 */
		public function showNetError(msg_:String, handler:Handler = null):void
		{
			if (!netErrorEnabled)
			{
				return;
			}
			alert(msg_, 2, handler);
		}

		public function showConnectTip():void
		{
			if (!NetworkConnectTip.instance.isPopup)
			{
				UIManager.instance.popUpWindow(NetworkConnectTip.instance);
			}
		}

		public function removeConnectTip():void
		{

		}

		public function showCreateRole():void
		{
			curView = new V_CreateRole();
			removeAllPanel();
			UIManager.instance.showPanel(curView);
			hideTop();
			hideBottom();
		}

		public function showHouse(houseInfo:BuildInfoBase, fromMap:Boolean = true):void
		{
			if (fromMap)
			{
				if (curView == V_House.instance)
				{
					return;
				}
				preView = curView;
				curView = V_House.instance;
				removeAllPanel();
			}
			D_Estate.instance.operBuild = houseInfo;
			V_House.instance.fromMap = fromMap;
			UIManager.instance.showPanel(V_House.instance);
			showTop();
			showBottom();
		}

		public function showShop(buildInfo:BuildInfoBase, fromMap:Boolean = true):void
		{
			if (fromMap)
			{
				if (curView == V_Shop.instance)
				{
					return;
				}
				preView = curView;
				curView = V_Shop.instance;
				removeAllPanel();
			}
			D_Estate.instance.operBuild = buildInfo;
			V_Shop.instance.fromMap = fromMap;
			UIManager.instance.showPanel(V_Shop.instance);
			showTop();
			showBottom();
		}

		public function showWorkers(fromMap:Boolean = true)
		{
			if (fromMap)
			{
				if (curView == V_Worker.instance)
				{
					return;
				}
				preView = curView;
				curView = V_Worker.instance;
				removeAllPanel();
			}
			V_Worker.instance.fromMap = fromMap;
			UIManager.instance.showPanel(V_Worker.instance);
			showTop();
			showBottom();
		}
	}
}

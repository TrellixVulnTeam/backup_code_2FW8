package
{
	import com.cong.events.EventCenter;
	import com.cong.managers.LayerManager;
	import com.cong.managers.UIManager;

	import game.constants.CONST_EVENT;
	import game.controller.C_UI;
	import game.controller.C_User;
	import game.loading.Preload_JSON;
	import game.view.V_LoginPanel;
	import game.view.V_Map;

	import laya.display.Stage;
	import laya.display.UIButton;
	import laya.net.Loader;
	import laya.net.ResourceVersion;
	import laya.ui.View;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Stat;
	import laya.webgl.WebGL;

	public class Main
	{
		public static var screenAutoSize:Boolean = true;

		public function Main()
		{
			//初始化微信小游戏
//			MiniAdpter.init();

			//初始化引擎
			Config.isAlpha = true;
			Laya.Config.isAntialias = true;
			Laya.init(0, 0, WebGL);
			if (Browser.onPC) Main.screenAutoSize = false;
			if (!screenAutoSize)
			{
				Laya.stage.size(1080, 1920);
			} else
			{
				var fixH:int = Math.min(Browser.clientHeight / Browser.clientWidth * 1080, 1920);
				Laya.stage.size(1080, fixH);
			}
			Laya.stage.bgColor = "none";
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.loader.retryNum = 3;
			Laya.stage.frameRate = Stage.FRAME_FAST;
//			Laya.stage.screenMode = Stage.SCREEN_VERTICAL;
			Stat.show();
			//激活资源版本控制
			ResourceVersion.enable("version.json", Handler.create(this, beginLoad), ResourceVersion.FILENAME_VERSION);
			initEngine();
			UIConfig.closeDialogOnSide = false;
		}

		private function initEngine():void
		{
			LayerManager.instance.init(Laya.stage);
			View.regComponent("UIButton", UIButton);//注册组件
		}

		private function beginLoad():void
		{
			var assets:Array = [];
			assets.push({url: "loading/loadingbg.jpg", type: Loader.IMAGE});
			assets.push({url: "res/atlas/loading.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/comp.atlas", type: Loader.ATLAS});
			Laya.loader.load(assets, Handler.create(this, loadAssert));
		}

		private function loadAssert()
		{
			UIManager.instance.showPanel(V_LoginPanel.instance);
			V_LoginPanel.instance.showLoading();
			//加载引擎需要的资源
			var assets = [];
			assets.push({url: "res/atlas/map/building.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/map.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/map/dice.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/map/minigame.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/common.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/index.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/createRole.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/createRole.atlas", type: Loader.ATLAS});
			assets.push({url: "res/atlas/common/winbg5.png", type: Loader.IMAGE});
			assets.push({url: "res/atlas/estate.atlas", type: Loader.ATLAS});
			assets.push({url: "common/alertbg.png", type: Loader.IMAGE});
			Laya.loader.load(assets, Handler.create(this, onAssetsLoaded), new Handler(this, loadAssetProgress, null, false));
		}

		private function loadAssetProgress(pro:Number):void
		{
			V_LoginPanel.instance.updateProgress(pro);
		}

		private function onAssetsLoaded():void
		{
			Preload_JSON.instance.start(new Handler(this, connectServer));


		}

		private function connectServer():void
		{
			C_User.instance.connectAccountServer(Handler.create(this,onAccountServerConnect));
//			enterGame();
//			if(Geolocation.supported)
//			{
//				Geolocation.enableHighAccuracy = true;
//				Geolocation.getCurrentPosition(Handler.create(this,function(pos):void
//				{
//					trace("pos:"+pos.coords.longitude+","+pos.coords.latitude);
//				}),Handler.create(this,function(error):void
//				{
//					switch (error.code)
//					{
//						case Geolocation.PERMISSION_DENIED:
//							trace("位置服务被拒绝，请检查您的GPS和定位设置");
//							break;
//						case Geolocation.POSITION_UNAVAILABLE:
//							trace("暂时获取不到位置信息");
//							break;
//						case Geolocation.TIMEOUT:
//							trace("获取位置信息超时");
//							break;
//						default:
//							trace("加载地图时出现未知错误");
//							break;
//					}
//				}));
//			}
		}

		private function onAccountServerConnect():void
		{
			V_LoginPanel.instance.showLogin();
			EventCenter.ins.on(CONST_EVENT.LOGIN_SUCCESS,this,onLoginSuccess);
		}

		private function onLoginSuccess(obj:Object):void
		{
			if(obj.isfirstlogin){
				C_UI.instance.showCreateRole();
			}else {
				//实例UI界面
				C_UI.instance.showMap();
			}
		}

		public function getMap():V_Map
		{
			return V_Map.instance;
		}
	}
}
package game.view
{
	import com.cong.components.Alert;
	import com.cong.interfaces.IView;
	import com.cong.net.ErrCode;
	import com.cong.utils.StringUtil;

	import game.controller.C_User;

	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.net.LocalStorage;

	import ui.LoginPanelUI;

	/**
	 * ...
	 * @author
	 */
	public class V_LoginPanel extends LoginPanelUI implements IView
	{
		private var platforms:Array = ["webs2.cp-miners.com"];

		public function V_LoginPanel()
		{
			height = Laya.stage.height;
			txt_version.y = Laya.stage.height - txt_version.height;
			btn_start.visible = false;
		}

		private static var _instance:V_LoginPanel;
		public static function get instance():V_LoginPanel
		{
			if (null == _instance)
			{
				_instance = new V_LoginPanel();
			}
			return _instance;
		}

		public function onShow():void
		{
			box_loading.visible = false;
			if (LocalStorage.getItem("un"))
			{
				txt_userName.text = LocalStorage.getItem("un");
			}
//			txt_version.text = "version:" + ConfigServer.getVersion();
		}


		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			btn_login.on(Event.CLICK, this, loginHandler);
			btn_start.on(Event.CLICK, this, startGame);
		}

		private function startGame():void
		{
			btn_start.mouseEnabled = false;
//			C_User.instance.startGame(hash);
		}

		private function registHandler():void
		{
//			if (txt_userName.text != "" && txt_password.text != "") C_User.instance.regist(txt_userName.text, txt_password.text); else Alert.show("用户名与密码不能为空！");
		}

		private function loginHandler():void
		{
			if (txt_userName.text != "") {
				if(txt_loc.text){
					C_User.instance.lng = txt_loc.text.split(",")[0];
					C_User.instance.lat = txt_loc.text.split(",")[1];
				}
				C_User.instance.login(txt_userName.text);
				btn_login.disabled = true;
			} else Alert.show("用户id不能为空！");
		}

		public function removeAllListeners():void
		{
			btn_login.off(Event.CLICK, this, loginHandler);
			btn_start.off(Event.CLICK, this, startGame);
		}

		public function updateProgress(pro:Number):void
		{
			txt_progress.text = Math.floor(pro * 100).toString() + "%";
			img_progress.scrollRect = new Rectangle(0, 0, pro * img_progress.width, img_progress.height);
		}

		public function showLoading():void
		{
			box_login.visible = false;
			box_loading.visible = true;
		}

		private var hash:String;

		public function showLogin():void
		{
//			C_User.instance.startGame("3EE87356BD543843384C1CD58379191C1118ED470D21CBF67CE6E0DE742D0EA845429866D1BF9CF82511835E6936D0B7");
			var isPlatform:Boolean = false;
			var url:String = __JS__("window.location.href");
			for (var i:int = 0; i < platforms.length; i++)
			{
				if (url.indexOf(platforms[i]) != -1)
				{
					isPlatform = true;
					break;
				}
			}
//			D_Game.instance.isPlatform = isPlatform;
			var urlParams:Object = StringUtil.getURLParam();
			if (urlParams["hash"])
			{
				hash = urlParams["hash"];
				progressbar.visible = false;
				btn_start.visible = true;
//				C_Mail.instance.notice(Handler.create(this, getNoticeRet));
			} else
			{
				if (isPlatform)
				{
					Alert.show(ErrCode.err[2]);
				} else
				{
					box_loading.visible = false;
					box_login.visible = true;
				}
			}
		}

		private function getNoticeRet(data:Object):void
		{
		}
	}

}
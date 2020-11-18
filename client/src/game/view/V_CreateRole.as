package game.view
{
	import com.cong.events.EventCenter;
	import com.cong.interfaces.IView;
	import com.cong.utils.StringUtil;

	import game.config.ConfigDisableWords;

	import game.config.ConfigUserName;

	import game.constants.CONST_EVENT;

	import game.controller.C_UI;
	import game.controller.C_User;
	import game.data.D_Game;
	import game.data.vo.UserInfo;
	import game.str.Language;

	import game.view.createRole.Object3D;
	import game.view.createRole.RoleItem;
	import game.view.map.Dice;

	import laya.events.Event;

	import ui.CreateRoleUI;

	public class V_CreateRole extends CreateRoleUI implements IView
	{
		private var vpX:Number = Laya.stage.width / 2;
		private var vpY:Number = -Laya.stage.height * 0.2;
		private var fl:Number = 1200;
		private var roles:Array = new Array();
		private var selectedType:int = 1;
		public function V_CreateRole()
		{
			super();

			//*修改i < 5 => i < 3,只显示小美、阿土伯
			for (var i:int = 1; i < 3; i++)
			{
				var role:RoleItem = new RoleItem(i);
				if (i == 1)
				{
					role.zpos = -400;
				}
//				else if(i==2){
//					role.xpos = -400;
//				}
				else if (i == 2)
				{
					role.zpos = 400;
				}
//				else if(i==4){
//					role.xpos = 400;
//				}
				role.ypos = 800;
				addChild(role);
				roles.push(role);
				doPerspective(role);
			}
			roles[0].selected = true;
		}

		private function doPerspective(item:Object3D):void
		{
//			if (item.zpos >= -fl)
//			{
			//根据z轴计算缩放系数
			var scale:Number = fl / (fl + item.zpos);
			item.scaleX = item.scaleY = scale;
			item.x = vpX + item.xpos * scale;
			item.y = vpY + item.ypos * scale;
//				item.alpha = scale;
//				item.visible = true;
//			} else
//			{
//				item.visible = false;
//			}
		}

		public function onShow():void
		{
			this.mouseEnabled = true;
			txt_name.text = ConfigUserName.randName(selectedType % 2);
			btn_dice.on(Event.CLICK,this,diceHandler);
		}

		private function diceHandler():void
		{
			txt_name.text = ConfigUserName.randName(selectedType % 2);
		}

		public function onHide():void
		{
		}

		public function addAllListeners():void
		{
			this.on(Event.MOUSE_DOWN, this, onMouseDown);
			btn_ok.on(Event.CLICK, this, okHandler);
			btn_close.on(Event.CLICK, this, closeHandler);
			EventCenter.ins.on(CONST_EVENT.MODIFY_USER_INFO_RET, this, modifyUserInfoRet);
		}

		private function modifyUserInfoRet(obj:Object):void
		{
			if (obj.code == 0)
			{
				var userInfo:UserInfo = D_Game.instance.userInfo;
				userInfo.userImg = selectedType;
				if (selectedType % 2 == 1)
				{
					userInfo.sex = 1;
				} else
				{
					userInfo.sex = 2;
				}
				C_UI.instance.showMap();
				EventCenter.ins.event(CONST_EVENT.UPDATE_USER_INFO);
			} else
			{
				this.mouseEnabled = true;
			}
		}

		private function closeHandler():void
		{
			C_UI.instance.backToHome();
		}

		private function okHandler():void
		{
			var len:int = StringUtil.len(txt_name.text);
			if (len>12||len<4||ConfigDisableWords.isDisableWord(txt_name.text))
			{
				C_UI.instance.alert(Language.NAME_ERROR_TIP);
				txt_name.text="";
			} else
			{
				C_User.instance.modifyUserInfo(3, selectedType, txt_name.text);
				this.mouseEnabled = false;
			}
		}

		private var startX:Number;

		private function onMouseDown():void
		{
			startX = this.mouseX;
			this.on(Event.MOUSE_UP, this, onMouseUp);
		}

		private function onMouseUp():void
		{
			if (this.mouseX - startX > 10)
			{
				tarAngle += Math.PI;
				angleInc = 0.04;
			} else if (this.mouseX - startX < -10)
			{
				angleInc = -0.04;
				tarAngle -= Math.PI;
			} else
			{
				return;
			}
			Laya.timer.frameLoop(1, this, rotate);
			roles[selectedType - 1].selected = false;
			this.off(Event.MOUSE_DOWN, this, onMouseDown);

			//老方法永远只会返回1
			//selectedType = Math.round(tarAngle/Math.PI*2)%roles.length + 1;
			//新方法需要能够返回1, 2的情况 0, Math.PI, Math.PI * 2, Math.PI * 2 + Math.PI
			selectedType = Math.round(tarAngle % (Math.PI * 2)) % roles.length + 1;
			if (selectedType < 1) selectedType += roles.length;
			this.setChildIndex(roles[selectedType - 1], numChildren - 1);
		}

		private var angleInc:Number = 0.04;
		private var anagle:Number = 0;
		private var tarAngle:Number = 0;

		private function rotate():void
		{
			var inc:Number;
			anagle += angleInc;
			if (Math.abs(tarAngle - anagle) < Math.abs(angleInc))
			{
				Laya.timer.clear(this, rotate);
				this.on(Event.MOUSE_DOWN, this, onMouseDown);
				inc = tarAngle - anagle + angleInc;
				anagle = tarAngle;
				if (selectedType % 2 == 1)
				{
					ico_sex.skin = "common/male.png";
				} else
				{
					ico_sex.skin = "common/female.png";
				}
				roles[selectedType - 1].selected = true;
			} else
			{
				inc = angleInc;
			}
			for (var i:int = 0; i < roles.length; i++)
			{
				var role:RoleItem = roles[i];
				role.rotateY(inc);
				doPerspective(role);
			}
		}

		public function removeAllListeners():void
		{
			this.off(Event.MOUSE_DOWN, this, onMouseDown);
			btn_ok.off(Event.CLICK, this, okHandler);
			btn_close.off(Event.CLICK, this, closeHandler);
		}
	}
}

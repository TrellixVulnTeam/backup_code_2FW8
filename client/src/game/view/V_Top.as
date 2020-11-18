package game.view {
    import com.cong.events.EventCenter;

    import game.constants.CONST_EVENT;
    import game.data.D_Game;
    import game.data.vo.UserInfo;

    import laya.net.LocalStorage;

    import ui.TopUI;

    public class V_Top extends TopUI {
    public function V_Top() {
        super();
        EventCenter.ins.on(CONST_EVENT.UPDATE_USER_RES,this,updateUserRes);
    }

    public function updateUserRes():void
    {
        var userInfo:UserInfo = D_Game.instance.userInfo;
        txt_power.text = userInfo.power.toString();
        txt_money.text = userInfo.money.toString();
        txt_diamond.text = userInfo.diamonds.toString();
    }

    public function setUserInfo(info:UserInfo):void
    {
        if(info.nickName!=""){
            txt_userName.text = info.nickName;
        }else{
            txt_userName.text = LocalStorage.getItem("un");
        }
        txt_power.text = info.power.toString();
        txt_lv.text = "Lv " + info.level;
        txt_diamond.text = info.diamonds.toString();
        txt_money.text = info.money.toString();
//        if(info.sex == 1){
//            ico_sex.skin = "common/male.png";
//        }else{
//            ico_sex.skin = "common/female.png";
//        }
    }


    private static var _instance:V_Top;
    public static function get instance():V_Top
    {
        if (null == _instance)
        {
            _instance = new V_Top();
        }
        return _instance;
    }
}
}

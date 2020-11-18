package game.controller
{
    import com.cong.events.EventCenter;
    import com.cong.net.Network;

    import game.constants.CONST_CMD;
    import game.constants.CONST_EVENT;

    public class C_Minigame
    {
        private static var _instance:C_Minigame;

        public static function get instance():C_Minigame
        {
            if (null == _instance) {
                _instance = new C_Minigame();
            }

            return _instance;
        }

        public function C_Minigame()
        {
            Network.addHandler(this, CONST_CMD.MINI_GAME_DATA_RET, miniGameDataRet);
            Network.addHandler(this, CONST_CMD.GET_MINI_GAME_REWARD_RET, getMagicTouchGameRewardRet);
        }

        public function miniGameDataRet(obj:Object):void {
            if (obj.code == 0) {
                EventCenter.ins.event(CONST_EVENT.MINIGAME_MAGIC_TOUCH_RET, obj);
            }
        }

        public function getMagicTouchGameDate():void {
            Network.send(CONST_CMD.MINI_GAME_DATA,  {type: 1});
        }

        public function getMagicTouchGameReward(idListStr:String):void {
            Network.send(CONST_CMD.GET_MINI_GAME_REWARD, {type:1, idListStr: idListStr});
        }

        public function getMagicTouchGameRewardRet(obj:Object):void {
            if (obj.code == 0) {
                EventCenter.ins.event(CONST_EVENT.MINIGAME_MAGIC_TOUCH_REWARD_RET, obj);
            } else if (obj.code == 1) {
                console.log("未触发此事件");
            } else {
                console.log("上传数据不对");
            }
        }

    }
}

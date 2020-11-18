package game.view.map.minigame.magicTouch
{
    import laya.utils.Handler;
    import ui.map.minigame.magicTouch.GameOverDialogUI;

    /**
     * 游戏结算提示框,选奖励后关闭小游戏
     * */
    public class GameFinalAlert extends GameOverDialogUI
    {
        private var _final_money:int = 0;
        public function GameFinalAlert(final_money:int)
        {
            _final_money = final_money;

            this.init();
        }

        //初始化控件数据
        private function init():void
        {
            super.initialize();
            //关闭时不需要任何效果
            closeEffect = null;

            play_video_btn.clickHandler = Handler.create(this, onPlayVideo, null, false);
            get_normal_btn.clickHandler = Handler.create(this, onGetNormalMoney, null, false);

            video_money_lab.text = String(this.video_money);
            normal_money_lab.text = String(this.normal_money);
        }

        private function get normal_money():int
        {
            return this._final_money;
        }

        private function get video_money():int
        {
            return this.normal_money * 2;
        }

        private function onPlayVideo():void
        {
            console.log("播放视频");
        }

        private function onGetNormalMoney():void
        {
            //弹窗类方法,关闭弹窗
            this.close();
        }
    }
}

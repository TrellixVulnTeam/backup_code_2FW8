package game.view.map.minigame.magicTouch
{
    import laya.utils.Handler;

    /**
     * 时间表执行类,对每一个表中的时间点都会调用_onUpdate
     * */
    public class ExecuteTimePointTable
    {
        private var timePointTable:TimePointTable;

        //当前所需要执行的时间点
        private var currTimePoint:Number;
        //上一个执行过的时间点
        private var lastTimePoint:Number;

        //更新方法
        private var _onUpdate:Handler;
        public function ExecuteTimePointTable(realTime:Number, realNum:Number, onUpdate:Handler)
        {
            timePointTable = new TimePointTable(realTime, realNum);
            _onUpdate = onUpdate;
            currTimePoint = 0;
            lastTimePoint = 0;
        }

        public function start():void
        {
            //判断表是否为空
            if (1 > timePointTable.table.length) return;

            //如果上一个时间点等于当前时间点,则表示该时间点已无效,执行下一个
            if (lastTimePoint === currTimePoint)
            {
                //获取下一个时间点
                currTimePoint = timePointTable.table[0];
            }

            //与当前时间点的间隔时间
            var deltaTime = currTimePoint - lastTimePoint;
            if (deltaTime < 0 ) deltaTime = 0;
            Laya.timer.once(secondToMillsecond(deltaTime), this, onUpdate);
        }

        private function onUpdate():void
        {
            console.log(currTimePoint);
            lastTimePoint = timePointTable.table.shift();
            _onUpdate.run();
            //启动下一个
            start();
        }

        public function stop():void
        {
            Laya.timer.clear(this, onUpdate);
        }

        //秒转毫秒
        private function secondToMillsecond(second:Number):Number
        {
            return second * 1000;
        }
    }
}

package game.view.map.minigame.magicTouch
{
    import game.config.ConfigGameChest;

    /**
    * 时间表
    * 按一定时量权重在规定时间区域内取时间点,并返回这些时间点组成的数组
    * */
    public class TimePointTable
    {
        //权重表,暂时放在这里,可以转移到外部
        private var weightConfig:Array;

        //配置表的总权重
        private var _totalTimeWeight:Number;
        private var _totalNumWeight:Number;

        //真实时间,真实数量
        private var _realTime:Number;
        private var _realNum:Number;

        //时间表
        private var _table:Array;

        //所有区域时间点数组的数组
        private var _areaTables:Array;
        //所有区域时间点数组的数组长度总计
        private var _areaTablesLength:uint;

        public function TimePointTable(realTime:Number, realNum:Number)
        {
            _totalTimeWeight = -1;
            _totalNumWeight = -1;
            _realTime = realTime;
            _realNum = realNum;
            _table = null;
            _areaTables = null;
            _areaTablesLength = -1;

            //从配置文件加载权重表
            weightConfig = ConfigGameChest.getWeightTable();
        }

        private function getTable():Array
        {
            _table = [];
            //当前时间区域的偏移值
            var deltaTime:Number = 0;

            weightConfig.forEach(function(config:Object)
            {
                //计算出当前区域真实时间
                var time = _realTime * config.time / totalTimeWeight;
                //计算出当前区域真实数量
                var num = Math.round( _realNum * config.num / totalNumWeight);
                var areaTimeTable:Array = getAreaTimeTable(deltaTime, time, num);
                deltaTime += time;

                _table = _table.concat(areaTimeTable);
            });

            //清理生成的数组
            cleanTable();
        }

        //第一遍生成的时间点数组可能比原始数量多或者少,该方法修剪时间点数组使其元素个数与原始数量一致
        private function cleanTable():void
        {
            var dValue:int = _realNum - _table.length;
            if (dValue < 0)
            {
                //随机删除dValue个数组元素
                for (var i:int = 0; i > dValue; i--)
                {
                    var randomIndex:int = Math.floor(Math.random() * _table.length);
                    _table.splice(randomIndex, 1);
                }
            } else if (dValue > 0)
            {
                //随机生成dValue个数组元素
                for (var i:int = 0; i < dValue; i++)
                {
                    var randomTimePoint:Number = getRandomTimePoint(_realTime);
                    //插入时间点数组中
                    insertTimeTable(randomTimePoint);
                }
            }
        }

        private function insertTimeTable(timePoint:Number):void
        {
            for (var i:int = 0; i < _table.length; i++)
            {
                if (_table[i] > timePoint)
                {
                    _table.splice(i, 0, timePoint);
                    break;
                }
            }
        }

        //获取指定时间区域指定数量的随机时间点
        private function getAreaTimeTable(deltaTime:Number, time:Number, num:int)
        {
            var results = [];
            for (var i:int = 0; i < num; i++)
            {
                results.push(deltaTime + getRandomTimePoint(time));
            }

            //获取的数组要排序
            results.sort(function (a, b):int {
                return a - b;
            });
            return results;
        }

        private function getRandomTimePoint(time:Number)
        {
            return Math.random() * time;
        }

        //时间表的访问方法
        public function get table():Array
        {
            if (_table === null)
            {
                getTable();
            }

            return _table;
        }

        //时间总权重
        public function get totalTimeWeight():Number
        {
            if (_totalTimeWeight < 0)
            {
                calTotal();
            }

            return _totalTimeWeight;
        }

        //数量总权重
        public function get totalNumWeight():Number
        {
            if (_totalNumWeight < 0)
            {
                calTotal();
            }

            return _totalNumWeight;
        }

        //配置表总权重
        private function calTotal():void
        {
            _totalTimeWeight = 0;
            _totalNumWeight = 0;
            weightConfig.forEach(function(weight) {
                _totalTimeWeight += weight.time;
                _totalNumWeight += weight.num;
            })
        }
    }
}

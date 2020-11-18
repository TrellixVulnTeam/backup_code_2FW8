package game.config {
    public class ConfigGameChest {
        public static var _data:Object;

        public function ConfigGameChest() {

        }

        public static function init(data:Object):void {
            _data = data;
        }

        public static function getGameTimes():Number {
            return _data.times;
        }

        public static function getGameNums():uint {
            return _data.nums;
        }

        public static function getGameChestType(lv:int){
            return _data.type[lv];
        }

        public static function getWeightTable():Array {
            return _data.weight;
        }

    }
}

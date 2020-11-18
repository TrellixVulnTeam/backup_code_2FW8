package game.view.map.minigame.magicTouch
{

    import game.config.ConfigGameChest;
    import laya.utils.Pool;

    /**
     * 创建宝箱气球的工厂模式
     * */
    public class TreasureFactory
    {

        public function TreasureFactory()
        {

        }

        public static function create(type:int, gtype:Number):TreasureItem
        {
            //从配置文件中选择所需要创建的宝箱信息
            var config:Object = ConfigGameChest.getGameChestType(type);

            if (config !== null) {
                return createByJsonObject(gtype, config);
            }

            return null;
        }

        private static function createByJsonObject(type:Number, json:Object)
        {
            var treasure = Pool.getItemByClass("treasure",TreasureItem);

            var score:Number = parseInt(json["Reward"].split(",").join(""));
            treasure.init(type, json["ID"], json["Speed"], score);
            treasure.treasureSkin = json["Pic"];

            var y = -treasure.height;
            var x = 30 + Math.random() * (1020 - treasure.width);
            treasure.pos(x, y);

            return treasure;
        }
    }
}

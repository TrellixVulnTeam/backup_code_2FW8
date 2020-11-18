package game.controller.packets
{

import game.data.minigame.BoxInfo;
import game.data.minigame.RewardInfo;

import laya.ui.Box;
import laya.utils.Byte;

    public class Packet_Minigame
    {

        public function Packet_Minigame()
        {
        }

        /**
         *5023 取MINIGAME数据
         * 游戏类型 1=接宝箱
         */
        public static function miniGameData(obj:Object, byte:Byte):void
        {
            byte.writeInt32(obj["type"]);
        }

        /**
         * 5024 返回MINIGAME数据
         *
         /// <summary>
         /// 0=成功 1=没触发此事件
         /// </summary>
         public int Code = 0;
         /// <summary>
         /// 宝箱数据
         /// </summary>
         public List<int> BoxList = new List<int>();
         * */
        public static function miniGameDataRet(byte:Byte):Object
        {
            var obj:Object = {};
            obj.code = byte.getInt32();

            obj.boxList = [];
            var len:uint = byte.getUint16();
            for (var i:int = 0; i < len; i++) {
                obj.boxList.push(byte.getInt32());
            }
            return obj;
        }

        /**
         * 5025获得MINIGAME奖励
         /// <summary>
         /// 模块类型 1=宝箱
         /// </summary>
         public int Type = 0;
         /// <summary>
         /// 宝箱Id(id,状态（0=成功 1=失败）;)
         /// </summary>
         public string IDListStr = "";
         * */
        public static function getMiniGameReward(obj:Object, byte:Byte):void
        {
            byte.writeInt32(obj.type);
            byte.writeUTFString(obj.idListStr);
        }

        /**
         * 5026 返回MINIGAME奖励
         /// <summary>
         /// 0=成功 1=没触发此事件 2=上传数据不对
         /// </summary>
         public int Code = 0;
         /// <summary>
         /// 宝箱数据
         /// </summary>
         public List<RewardInfo> RewardList = new List<RewardInfo>();
         *
         * */
        public static function getMiniGameRewardRet(byte:Byte):Object
        {
            var obj:Object = {};
            obj.code = byte.getInt32();
            obj.rewardList = [];
            var len:uint = byte.getUint16();
            for (var i=0; i < len; i++) {
                var reward:RewardInfo = new RewardInfo();
                reward.type = byte.getInt32();
                reward.num = byte.getInt32();
                obj.rewardList.push(reward);
            }
            //解析奖励数据
            return obj;
        }
    }
}

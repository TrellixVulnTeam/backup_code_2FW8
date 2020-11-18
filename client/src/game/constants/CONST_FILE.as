/**
 * Created by chencong on 2017/5/28.
 */
package game.constants
{
	public class CONST_FILE
	{
		public static const soundPath_chatMsg:String = "sound/woman/chatMsg/";
		public static const config_json:String = "config/config.json";
		public static const number_url:String = "res/atlas/common/font/";
		public static const PLANET_EMPTY:String = "planet/empty.png";
		public static const COIN:String = "common/ico_coin.png";
		public static const MINE:String = "common/ico_mine.png";
		public function CONST_FILE()
		{
		}

		public static function getPlanetIcon(id:int):String
		{
			return "planet/icon/" + id + ".png";
		}
		
		public static function getResIcon(type:int):String
		{
			if(type==1001){
				//金币
				return "common/ico_coin.png";
			}else if(type==1004){
				 //星际币
				return "common/ico_xjb.png";
			}else if(type==2000){
				//星矿
				return "common/ico_mine.png";
			}else if(type==1002){
				//能源
				return "common/ico_power.png";
			}
		}

		public static function getNumFont(name:String):String
		{
			return number_url + name + ".atlas";
		}

		public static function getBuildSkin(skinId:int,lv:int):String
		{
			return "map/building/" + skinId + "_" + lv + ".png";
		}

		public static function getBuildIcon(skinId:int,lv:int):String
		{
			return "map/building/" + skinId + "_" + lv + ".png";
		}

		public static function getFateImg(type:int):String
		{
			return "map/fate/" + type + ".jpg";
		}

		public static function getEmoji(type:int):String
		{
			return "map/emoji" + type + ".png";
		}

		public static function getStayPoingICon(type:int, secType:int):String
		{
			if(secType&&type!=4){
				return "map/sp" + type + "_" + secType + ".png";
			}else{
				return "map/sp" + type + ".png";
			}
		}

		public static function getGodBuff(type:int):String
		{
			return "map/godbuff" + type + ".png";
		}

		public static function getShopTypeIcon(ID:int):String
		{
			return "estate/st" + ID + ".png" ;
		}

		public static function getShopAttrIcon(Attribute:int):String
		{
			return "estate/sa" + Attribute + ".png" ;
		}
	}
}

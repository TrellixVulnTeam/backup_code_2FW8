package com.cong.utils
{
	import flash.net.SharedObject;

	public class SharedObjectManager
	{
		public static var PREFIX:String = "/";

		public function SharedObjectManager()
		{
		}

		public static function saveValue(name:String, key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["cookies"];
			if (obj == null)
			{
				obj = new Object();
				a.data["cookies"] = obj;
			}
			obj[key] = data;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
			a = null;
		}

		public static function getValue(name:String, key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["cookies"];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *保存登入帐号和密码
		 * @param name
		 * @param key
		 * @param data
		 *
		 */
		public static function saveLogin(name:String, key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["login"];
			if (obj == null)
			{
				obj = new Object();
				a.data["login"] = obj;
			}
			obj[key] = data;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *获得上次登入帐号和密码
		 * @param name
		 * @param key
		 *
		 */
		public static function getLogin(name:String, key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["login"];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *悬赏任务今日不再提示
		 * @param name
		 * @param key
		 * @param data
		 *
		 */
		public static function saveRewardQuestFinishImeToday(name:String, key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["rewardQuestToday"];
			if (obj == null)
			{
				obj = new Object();
				a.data["rewardQuestToday"] = obj;
			}
			obj[key] = data;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *悬赏任务今日不再提示
		 * @param name
		 * @param key
		 *
		 */
		public static function getRewardQuestFinishImeToday(name:String, key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["rewardQuestToday"];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *委托任务今日不再提示
		 * @param name
		 * @param key
		 * @param data
		 *
		 */
		public static function saveBailyFinishImeToday(name:String, key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["bailyQuestToday"];
			if (obj == null)
			{
				obj = new Object();
				a.data["bailyQuestToday"] = obj;
			}
			obj[key] = data;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *委托任务今日不再提示
		 * @param name
		 * @param key
		 *
		 */
		public static function getBailyFinishImeToday(name:String, key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + name);
			var obj:Object = a.data["bailyQuestToday"];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *保存今日不再提示,通用
		 * @param name
		 * @param key
		 * @param data
		 *
		 */
		public static function saveTodayNotAgain(key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.TodayNotAgain);
			var obj:Object = a.data[CONST_SHAREOBJECT_NAME.TodayNotAgain];
			if (obj == null)
			{
				obj = new Object();
				a.data[CONST_SHAREOBJECT_NAME.TodayNotAgain] = obj;
			}
			obj[key] = data;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *获取今日不再提示,通用
		 * @param name
		 * @param key
		 *
		 */
		public static function getTodayNotAgain(key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.TodayNotAgain);
			var obj:Object = a.data[CONST_SHAREOBJECT_NAME.TodayNotAgain];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *保存今日不再提示快速战斗
		 * @param key
		 * @param data
		 *
		 */
		public static function saveQuicklyEndBattle(key:String, data:Object):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.War_Quickly_End);
			var obj:Object = a.data[key];
			if (obj == null)
			{
				obj = new Object();
			}
			obj[key] = data;
			a.data[key] = obj;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *获取今日不再提示快速战斗
		 * @param key
		 *
		 */
		public static function getQuicklyEndBattle(key:String):Object
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.War_Quickly_End);
			var obj:Object = a.data[key];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}

		/**
		 *保存今日宠物护主模式
		 * @param key
		 * @param data
		 *
		 */
		public static function saveMaidProtectMode(mode:int):void
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.Maid_Protect_Mode);
			a.data["mode" + D_Player.intance.playerData.characterId] = mode;
			try
			{
				a.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *获取今日宠物护主模式
		 * @param key
		 *
		 */
		public static function getMaidProtectMode():int
		{
			var a:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.Maid_Protect_Mode);
			var n:* = a.data["mode" + D_Player.intance.playerData.characterId];
			return n ? n : 0;
		}


		/**
		 * 保存系统设置的数据对象
		 * @param key
		 * @param data
		 *
		 */
		public static function saveSystemSettingDataObject(key:String, data:Object):void
		{
			var sharedObject_:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.SystemSetting_Data_Object);
			var obj:Object = sharedObject_.data[key];
			if (obj == null)
			{
				obj = new Object();
			}
			obj[key] = data;
			sharedObject_.data[key] = obj;
			try
			{
				sharedObject_.flush();
			} catch (e:Error)
			{

			}
		}

		/**
		 *根据key获取保存设置数据对象
		 * @param key
		 * @return
		 *
		 */
		public static function getSystemSettingDataObject(key:String):Object
		{
			var sharedObject_:SharedObject = SharedObject.getLocal(PREFIX + CONST_SHAREOBJECT_NAME.SystemSetting_Data_Object);
			var obj:Object = sharedObject_.data[key];
			if (null != obj && obj.hasOwnProperty(key))
			{
				return obj[key];
			}
			return null;
		}
	}
}
package com.cong.utils
{
	import flash.display.Bitmap;

	public class IconUtil
	{

//		private static var  iconPool:HashMap = new HashMap();

		public function IconUtil()
		{
		}

		public static function getItemIcon(icon_:String):Bitmap
		{
//			var url_:String = setGridIconUrl(ShortcutManager.Shortcut_Prop_Item_Type,icon_);
//			if(iconPool.getValue(url_)!=null)
//			{
//				
//				return iconPool.getValue(url_);
//			}
//			
//			var bd:Bitmap = new Bitmap();
//			iconPool.put(url_,bd);
			var url_:String = setGridIconUrl(ShortcutManager.Shortcut_Prop_Item_Type, icon_);
			var bd:Bitmap = new Bitmap();
			ImageSwfManager.getImage(url_, null, {
				"onCompleteParams": [bd],
				"onComplete": onComplete,
				"priority": GameLoaderPriority.E_PRIORITY_HEIGHT
			});

			return bd;
		}

		public static function getSkillcon(icon_:String, size:int):Bitmap
		{
			var url_:String = size == 36 ? CONST_FILE.getSkillMediumIconUrl(icon_) : CONST_FILE.getSkillBigIconUrl(icon_);
//			if(iconPool.getValue(url_)!=null)
//			{
//				return iconPool.getValue(url_);
//			}
			var bd:Bitmap = new Bitmap();//DataCenter.instance.getAsynBitmap(url_);//new Bitmap();
//			iconPool.put(url_,bd);
			ImageSwfManager.getImage(url_, null, {
				"onCompleteParams": [bd],
				"onComplete": onComplete,
				"priority": GameLoaderPriority.E_PRIORITY_HEIGHT
			});

			return bd;
		}

		/**
		 *获得NPC圆型头像
		 * @param icon_
		 * @param type_ 1:圆型
		 * @return
		 *
		 */
		public static function getNpcIcon(icon_:String, type_:int):Bitmap
		{
			var bd:Bitmap = new Bitmap();
			switch (type_)
			{
				case 1:
					ImageSwfManager.getImage(CONST_FILE.Url_Npc_Halfbody + icon_ + ".swf", null, {
						"onComplete": getNpcIconLoaderComplete,
						"onCompleteParams": [bd],
						"priority": GameLoaderPriority.E_PRIORITY_HEIGHT
					});
					break;
			}
			return bd;
		}

		private static function getNpcIconLoaderComplete(bd_:Bitmap, paramsBd_:Bitmap):void
		{
			paramsBd_.bitmapData = bd_.bitmapData;
		}

		/**
		 * 法宝的图标
		 * @param icon_
		 * @param size
		 * @return
		 *
		 */
		public static function getHeavenIcon(icon_:String, size:int):Bitmap
		{
			var url_:String = setGridIconUrl(3, icon_);
//			if(iconPool.getValue(url_)!=null)
//			{
//				return iconPool.getValue(url_);
//			}
			var bd:Bitmap = new Bitmap();
//			iconPool.put(url_,bd);
			ImageSwfManager.getImage(url_, null, {
				"onCompleteParams": [bd],
				"onComplete": onComplete,
				"priority": GameLoaderPriority.E_PRIORITY_HEIGHT
			});

			return bd;
		}

		public static function getSkillIcoByType(icon_:String, type:int, onCompCall:Function = null):Bitmap
		{
			var url_:String = CONST_FILE.getSkillGridIconUrl(icon_, type);
//			if(iconPool.getValue(url_)!=null)
//			{
//				return iconPool.getValue(url_);
//			}
			var bd:Bitmap = new Bitmap();
//			iconPool.put(url_,bd);
			ImageSwfManager.getImage(url_, null, {"onCompleteParams": [bd, onCompCall], "onComplete": onComplete2});

			return bd;
		}

		private static function onComplete2(bitmap_:Bitmap, bd_:Bitmap, onCompCallback:Function):void
		{
//			var _bd:Bitmap = iconPool.remove(url_);
//			if(_bd)
//			{
			bd_.bitmapData = bitmap_.bitmapData;
			if (onCompCallback != null)
				onCompCallback.call();
//			}
		}

		private static function onComplete(bitmap_:Bitmap, bd_:Bitmap):void
		{
//			var _bd:Bitmap = iconPool.remove(url_);
//			if(_bd)
//			{
//				_bd.bitmapData = bitmap_.bitmapData;
//			}
			bd_.bitmapData = bitmap_.bitmapData;
		}

		private static function setGridIconUrl(type_:int, icon_:String):String
		{
			var url:String = "";
			switch (type_)
			{
				case ShortcutManager.Shortcut_Skill_Type:
					url = CONST_FILE.getSkillMediumIconUrl(icon_);
					break;
				case  ShortcutManager.Shortcut_Prop_Item_Type:
					url = CONST_FILE.getItemMidIconUrl(icon_);
					break;
				case ShortcutManager.Shortcut_Heaven_Type:
					url = CONST_FILE.getSkillMediumIconUrl(icon_);
					break;
			}
			return url;
		}

		/**
		 * 根据神将头像ID和迟大小获取神将头像
		 * @param icon_
		 * @param sizeType_
		 * @return
		 *
		 */
		public static function getHeroIcon(icon_:String, heroType_:int):Bitmap
		{
			var iconBitmap:Bitmap = new Bitmap();
			var url_:String = "";
			switch (heroType_)
			{
				case CONST_HERO.HERO_TYPE_1:
				{
					url_ = "resource/image/hero/head/mediumIcon/" + icon_ + ".swf";
					break;
				}
				case CONST_HERO.HERO_TYPE_2:
				{
					url_ = "resource/image/hero/head/bigIcon/" + icon_ + ".swf";
					break;
				}

			}

			ImageSwfManager.getImage(url_, null, {
				"onComplete": onHeroIconComplete,
				"onCompleteParams": [iconBitmap],
				"priority": GameLoaderPriority.E_PRIORITY_HEIGHT
			});
			return iconBitmap;
		}

		private static function onHeroIconComplete(bd_:Bitmap, paramsBd_:Bitmap):void
		{
			paramsBd_.bitmapData = bd_.bitmapData;
		}
	}
}
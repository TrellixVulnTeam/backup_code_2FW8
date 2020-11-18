package com.cong.utils
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class HtmlUtil
	{
		public function HtmlUtil()
		{
		}

		public static function setEmebedBoldTextFormat(textFiled:TextField, tft:TextFormat):void
		{
			textFiled.embedFonts = true;
			textFiled.sharpness = 0;
			textFiled.thickness = 200;
			textFiled.antiAliasType = AntiAliasType.ADVANCED;
			textFiled.defaultTextFormat = tft;
			textFiled.setTextFormat(tft);

		}

		public static const BR:String = "<BR>";

		/**
		 * 设置字体颜色并添加一个换行
		 * @param content
		 * @param color
		 * @param size
		 * @return
		 *
		 */
		public static function fontBr(content:String, color:String, size:int = 12):String
		{
			return font(content, color, size) + "\n";
		}

		/**
		 *设置字体为粗体
		 * @param content
		 * @param color
		 * @param size
		 * @return
		 *
		 */
		public static function fontBold(content:String, color:String, size:int = 12):String
		{
			return "<font color=\'" + color + "\' size=\'" + size + "\'><b>" + content + "</b></font>";
		}

		public static function fontFaceBold(content:String, face:String):String
		{
			return "<font face=\'" + face + "\'><b>" + content + "</b></font>";
		}

		public static function bold(content_:String):String
		{
			return "<b>" + content_ + "</b>";
		}

		/**
		 *设置字体颜色
		 * @param content
		 * @param color
		 * @return
		 *
		 */
		public static function color(content:String, color:String, underline:Boolean = false):String
		{
			if (underline)
			{
				content = under(content);
			}
			return "<font color=\'" + color + "\' >" + content + "</font>";
		}

		/**
		 *设置字体为红色
		 * @param content
		 * @return
		 *
		 */
		public static function colorRed(content:String):String
		{
			return color(content, "#ff0000");
		}

		/**
		 *设置字体为绿色
		 * @param content
		 * @return
		 *
		 */
		public static function colorGreen(content:String):String
		{
			return color(content, "#00ff00");
		}

		/**
		 *设置字体为蓝色
		 * @param content
		 * @return
		 *
		 */
		public static function colorBlue(content:String):String
		{
			return color(content, "#0000ff");
		}

		/**
		 *设置字体为淡蓝色
		 * @param content
		 * @return
		 *
		 */
		public static function colorThinBlue(content:String):String
		{
			return color(content, "#DAF9FF");
		}

		/**
		 *设置字体颜色和大小
		 * @param content
		 * @param color
		 * @param size
		 * @return
		 *
		 */
		public static function font(content:String, color:String, size:int = 12):String
		{
			return "<font color=\'" + color + "\' size=\'" + size + "\'>" + content + "</font>";
		}

		/**
		 *根据16进制设置字体颜色2
		 * @param content
		 * @param color
		 * @param size
		 * @return
		 *
		 */
		public static function font2(content:String, color:uint, size:int = 12):String
		{
			return font(content, "#" + color.toString(16));
		}

		public static function leading(content:String, size:int = 5):String
		{
			return "<textformat leading=\'" + size + "\'>" + content + "</textformat>";
		}

		public static function br(content:String):String
		{
			return "<br>" + content + "</br>";
		}

		/**
		 *下划线
		 * @param content
		 * @return
		 *
		 */
		public static function under(content:String):String
		{
			return "<u>" + content + "</u>";
		}

		public static function center(content:String):String
		{
			return "<p align=\'center\'>" + content + "</p>";
		}

		public static function right(content:String):String
		{
			return "<p align=\'right\'>" + content + "</p>";
		}

		public static function left(content:String):String
		{
			return "<p align=\'left\'>" + content + "</p>";

		}


		public static function link(content:String, ldata:String = "", underline:Boolean = false):String
		{
			if (underline)
			{
				return "<u><a href=\'event:" + ldata + "\'>" + content + "</a></u>";
			}
			return "<a href=\'event:" + ldata + "\'>" + content + "</a>";
		}

		public static function linkcolor(content:String, ldata:String = "", underline:Boolean = false, color:uint = 5832448, size:int = 12):String
		{
			return font2(link(content, ldata, underline), color, size);
		}

		public static function filterHtml(content:String):String
		{
			var format:String = content.replace(/\<\/?[^\<\>]+\>""\<\/?[^\<\>]+\>/gmi, "");
			return format;
		}

		/**
		 *根据品质获得颜色
		 * @return
		 *
		 */
		public static function getQualityColor(quality_:int, content_:String, underline:Boolean = false):String
		{

			return color(content_, CONST_COLOR.getColorStringByQuality(quality_), underline);
		}

		public static function indent(content:String, indent_:int):String
		{
			return "<textformat indent=\'" + indent_ + "\'>" + content + "</textformat>";
		}
	}
}

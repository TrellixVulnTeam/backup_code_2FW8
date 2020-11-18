package com.cong.utils
{
	import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class TextFormatUtils
	{
		public static const SONG:String = "SimSun,宋体";

		public static const TAHOMA:String = "Tahoma";

		public static const WhiteSongTI12:TextFormat = new TextFormat(SONG, 12, CONST_COLOR.COLOR_WHITE_INT);
		/**<窗口标题>*/
		public static const WhiteSongTI16Bold:TextFormat = new TextFormat(SONG, 16, CONST_COLOR.COLOR_WHITE_INT, true);
		public static const WhiteSongTI12Leading2:TextFormat = new TextFormat(SONG, 12, CONST_COLOR.COLOR_WHITE_INT);
		{
			WhiteSongTI12Leading2.leading = 5;

		}
		public static const styleLinkOverRed:StyleSheet = new StyleSheet();
		{
			styleLinkOverRed.setStyle("a:link", {
				color: CONST_COLOR.COLOR_GOLD_YELLOW,
				textDecoration: 'underline',
				fontSize: '12'
			});
			styleLinkOverRed.setStyle("a:hover", {color: CONST_COLOR.COLOR_RED, fontSize: '12'});
		}

		public function TextFormatUtils()
		{
		}


		public static function createTextfield($fontSize:int = 12, $bold:Object = null):TextField
		{
			var textfield:TextField = new TextField;
			textfield.defaultTextFormat = new TextFormat(TextFormatUtils.SONG, $fontSize, 0xffffff, $bold, null, null, null, null, null, null, null, null, 2);
			textfield.type = TextFieldType.DYNAMIC;
			textfield.multiline = false;
			textfield.selectable = false;
			textfield.width = 100;
			textfield.height = 18;
			return textfield;
		}

		public static function createBlackGlowFilterTextfield($fontSize:int = 12, $bold:Object = null):TextField
		{
			var textfield:TextField = createTextfield($fontSize, $bold);
			textfield.filters = DisplayUtil.blackGlowFilterArray;
			return textfield;
		}

		public static function getTextFilter(color:uint = 0):GlowFilter
		{
			return new GlowFilter(color, 0.8, 2, 2, 8);
		}
	}
}

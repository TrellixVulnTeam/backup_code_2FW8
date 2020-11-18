package com.cong.utils
{
	import laya.utils.Byte;

	public class GameUtil_String
	{

		private static var noLegalArr:Array = Language_zh_CN.LEGAL_NUM_STR.split(",");

		/**
		 *例：传入（提高武将统率:#value1#，#value1#，2
		 * 返回： 提高武将统率:23
		 * @param oStr
		 * @param keyStr
		 * @param dStr
		 *
		 */
		public static function ReplaceStringExtends(oStr:String, dStrArr:Array):String
		{
			var keyStrArr:Array = new Array();
			for (var index:int = 0; index < dStrArr.length; index++)
			{
				var str:String = '#value' + String(index + 1) + '#';
				keyStrArr.push(str);
			}
			return StringUtil.ReplaceString(oStr, keyStrArr, dStrArr);
		}

		/**
		 *例：传入（提高武将统率:{0}{1}，[2,3]
		 * 返回： 提高武将统率:23
		 * @param oStr
		 * @param keyStr
		 * @param dStr
		 *
		 */
		public static function ReplaceStringExtends2(oStr:String, dStrArr:Array):String
		{
			var keyStrArr:Array = new Array();
			for (var index:int = 0; index < dStrArr.length; index++)
			{
				var str:String = '{' + String(index) + '}';
				keyStrArr.push(str);
			}
			return StringUtil.ReplaceString(oStr, keyStrArr, dStrArr);
		}

		/**
		 *将文本中的所有 "|" 线转换城"\n"
		 * @param str_
		 * @return
		 *
		 */
		public static function ReplaceStringExtends3(str_:String):String
		{
			return str_.replace(/\|/g, "\n");
		}

		/**
		 *是否含有屏蔽字
		 * @param input_
		 * @return
		 *
		 */
//		public static function containInvalidChar(input_:String):Boolean
//		{
//			for each(var reg:RegExp in CONST_INVALID_CHAR.REGEXPS)
//			{
//				if(-1 != input_.search(reg))
//				{
//					return true;
//				}
//			}
//			return false;
//		}


		/**
		 * 将一百万以上的数字转换为"x万"的字符串
		 * @param value_ 要转换的数字
		 * @return 转换完成的字符串
		 *
		 */
//		public static function shortNumber_million(value_:Number):String
//		{
//			if(value_ >= 1000000 || value_ <= -1000000)
//			{
//				return String(Math.bubbleLayer(value_ / 10000)) + StrC.str(408);
//			}
//			
//			return String(value_);
//		}	
//		
		public static function Flush(Stream:Byte, Value:String):void
		{
			var Count:int;
			var Index:int;

			Count = Value.length;

			Stream.writeShort(Count);

			for (Index = 0; Index < Count; Index++)
			{
				Stream.writeShort(Value.charCodeAt(Index));
			}
			;
		}

		/**
		 *给服务器发个定长的字符串
		 * @param Stream
		 * @param Value
		 * @param len
		 *
		 */
		public static function FlushFixLen(Stream:Byte, Value:String, len:int):void
		{
			var temp:Byte = new Byte();
			temp.length = len;
			temp.writeUTFBytes(Value);
			Stream.writeBytes(temp, 0, temp.length);
		}

		/**
		 *传入时间段获得几天前，几小时前等
		 */
		public static function getTimeDifference(value_:Number):String
		{
			if (value_ > 0)
			{
				var hour:int = value_ / 3600; //小时
				if (hour <= 3)
				{
					return Language_zh_CN.SYS_GANG_GANG;
				}

				if (hour > 3 && hour <= 24)
				{
					return hour + Language_zh_CN.SYS_XIAO_SHI_QIAN;
				}

				if (hour > 24 && hour <= 48)
				{
					return Language_zh_CN.SYS_ZUO_TIAN;
				}

				if (hour > 48 && hour <= 72)
				{
					return Language_zh_CN.SYS_QIAN_TIAN;
				}

				var day:int = Math.ceil(value_ / 3600 / 24); //天
				if (hour > 72 && day < 365)
				{
					return day + Language_zh_CN.SYS_TIAN_QIAN;
				}

				if (day >= 365)
				{
					return Language_zh_CN.SYS_CHAO_GUO_1_NIAN;
				}
			}

			return Language_zh_CN.SYS_GANG_GANG;
		}

		/**
		 *根据品质等级获得颜色16位色值
		 * @param qulity_
		 * @return
		 *
		 */
		public static function getColorByQulityUint(qulity_:int):uint
		{
			var color_:uint = 0;

			switch (qulity_)
			{
				case CONST_QUALITY.WHITE: //白色
					return COLOR_ENUM.White_Int;
				case CONST_QUALITY.GREEN: //绿色
					return COLOR_ENUM.Green_Int;
				case CONST_QUALITY.BLUE: //蓝色
					return COLOR_ENUM.Blue_Int;
				case CONST_QUALITY.PURPLE: //紫色
					return COLOR_ENUM.Purple_Int;
				case CONST_QUALITY.GOLD: //橙色
					return COLOR_ENUM.Orange_Int;
			}
			return 0xFF6100;

			return color_;
		}

		/**
		 *根据战斗力等阶获取颜色
		 */
		public static function getColorByFightingColor(color_:int):String
		{
			var str:String = "";
			switch (color_)
			{
				case 1:
					str = COLOR_ENUM.White_Str; // 白
					break;
				case 2:
					str = COLOR_ENUM.Green_Str; // 绿
					break;
				case 3:
					str = COLOR_ENUM.Blue_Str; // 蓝
					break;
				case 4:
					str = COLOR_ENUM.Purple_Str; // 紫
					break;
				case 5:
					str = COLOR_ENUM.Orange_Str; // 橙
					break;
				case 6:
					str = COLOR_ENUM.Red_Str; //红
					break;
			}

			return str;
		}

		/**
		 *根据装备品质获得颜色
		 */
		public static function getColorByQulity(qulity_:int):String
		{
			var str:String = "";
			switch (qulity_)
			{
				case 1:
					str = COLOR_ENUM.White_Str; // 白
					break;
				case 2:
					str = COLOR_ENUM.Green_Str; // 绿
					break;
				case 3:
					str = COLOR_ENUM.Blue_Str; // 蓝
					break;
				case 4:
					str = COLOR_ENUM.Purple_Str; // 紫
					break;
				case 5:
					str = COLOR_ENUM.Orange_Str; // 橙
					break;
				case 6:
					str = COLOR_ENUM.Red_Str; //红
					break;
			}

			return str;
		}

		/**
		 *跟据武将品质获得颜色
		 * @param qulity_
		 * @return
		 *
		 */
		public static function getPartnerColorByQulity(qulity_:int):String
		{
			var str:String = "";
			switch (qulity_)
			{
				case 1:
					str = COLOR_ENUM.White_Str; // 白
					break;
				case 2:
					str = COLOR_ENUM.Green_Str; // 绿
					break;
				case 3:
					str = COLOR_ENUM.Blue_Str; // 蓝
					break;
				case 4:
					str = COLOR_ENUM.Purple_Str; // 紫
					break;
				case 5:
					str = COLOR_ENUM.Orange_Str; // 橙
					break;
				case 6:
					str = COLOR_ENUM.Red_Str; //红
					break;
				case 99:
					str = CONST_COLOR.COLOR_GOLD_YELLOW;
					break;
				default:
					str = COLOR_ENUM.White_Str; // 白
					break;


			}

			return str;
		}


		/**
		 * 把字符串里面的|替换成换行符
		 * @param sourceStr_
		 * @return
		 *
		 */
		public static function getStringReplaceNewline(sourceStr_:String):String
		{
			var targetStr_:String = "";
			for (var index:int = 0; index < sourceStr_.length; index++)
			{
				var showStr:String = sourceStr_.charAt(index);
				if (showStr == "|")
				{
					targetStr_ += "\n";
				} else
				{
					targetStr_ += showStr;
				}
			}

			return targetStr_;
		}

		/**
		 *传入玩家金钱 102000 返回 “10万”
		 *
		 * 如果是小于10000的话直接返回实际金钱个数
		 * 如果 是大于10000并且小于20000 例如 12000 返回 1万
		 * @return
		 *
		 */
		public static function getMoneyWan(nun_:Number, isShowAll_:Boolean = false):String
		{

			var numStr:String = "";

			if (nun_ < 10000)
			{
				return nun_.toString();
			}
			if (nun_ >= 100000000)
			{
				numStr = Math.floor(nun_ / 100000000) + Language_zh_CN.SYS_MONEY_YI;
			} else
			{
				if (isShowAll_)
				{
					return nun_.toString();
				}
				numStr = Math.floor(nun_ / 10000) + Language_zh_CN.SYS_MONEY_WAN;
			}
			return numStr;

		}

		/**
		 *替换字符串中的[font,[/font]
		 * @param str_
		 * @return
		 *
		 */
		public static function replaceStringExtends3(str_:String):String
		{
			return str_.replace(/\[/g, "<").replace(/\]/g, ">").replace(/\|/g, "\n");
		}

		public static function getLength(value_:*, maxV_:int = 14, isNeedUTF8_:Boolean = false):String
		{
			var str:String = value_.toString();
			var length:int;
			if (isNeedUTF8_)
			{
				length = StringUtil.getLength_UTF8(str);
			} else
			{
				length = str.length;
			}
//			str.
			if (length < maxV_)
			{
				var ff:int = maxV_ - length;
				for (var index:int = 0; index < ff; index++)
				{
					str += " ";
				}
			}

			return str;
		}


		public static function getEquipTypeName(equipType_:int):String
		{
			var str:String = "";
			/*switch (equipType_)
			 {
			 case 1:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_WUQI;
			 break;
			 case 2:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_TOULUI;
			 break;
			 case 3:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_YIFU;
			 break;
			 case 4:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_KUZI;
			 break;
			 case 5:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_XIEZI;
			 break;
			 case 6:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_HUWAN;
			 break;
			 case 7:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_SHIPIN;
			 break;
			 case 8:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_JIEZI;
			 break;
			 case 9:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_YAODAI;
			 break;
			 case 10:
			 str=Language_zh_TW.EQUIP_TYPE_NAME_NECKLACE;
			 break;

			 }*/
			str = Language_zh_CN.ROLE_EQUIP_TYPE_TIP[equipType_];
			return str;
		}

		/**
		 *传入（2013-12-23 00:00:00）此格式的时间字符串，返回1970年之后的毫秒数
		 */
		public static function getDateTimeNum(str_:String):Number
		{
			var strArr:Array = str_.split(" ");
			var dateArr:Array = strArr[0].split("-");
			var timeArr:Array = strArr[1].split(":");
			var curDate:Date = new Date(int(dateArr[0]), int(dateArr[1] - 1), int(dateArr[2]), int(timeArr[0]), int(timeArr[1]), int(timeArr[2]));
			return curDate.time;
		}

		/**
		 *  Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 *  @param str The string to make substitutions in.
		 *  This string can contain special tokens of the form
		 *  <code>{n}</code>, where <code>n</code> is a zero based index,
		 *  that will be replaced with the additional parameters
		 *  found at that index if specified.
		 *
		 *  @param rest Additional parameters that can be substituted
		 *  in the <code>str</code> parameter at each <code>{n}</code>
		 *  location, where <code>n</code> is an integer (zero based)
		 *  index value into the array of values specified.
		 *  If the first parameter is an array this array will be used as
		 *  a parameter list.
		 *  This allows reuse of this routine in other methods that want to
		 *  use the ... rest signature.
		 *  For example <pre>
		 *     public function myTracer(str:String, ... rest):void
		 *     {
		 *         label.text += StringUtil.substitute(str, rest) + "\n";
		 *     } </pre>
		 *
		 *  @return New string with all of the <code>{n}</code> tokens
		 *  replaced with the respective arguments specified.
		 *
		 *  @example
		 *
		 *  var str:String = "here is some info '{0}' and {1}";
		 *  Console.traceDebug(StringUtil.substitute(str, 15.4, true));
		 *
		 *  // this will output the following string:
		 *  // "here is some info '15.4' and true"
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function substitute(str:String, ...rest):String
		{
			if (str == null)
				return '';

			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			} else
			{
				args = rest;
			}

			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
			}

			return str;
		}


		/**
		 *获得小时分钟
		 */
		public static function getTimeHourMin(value_:Number):String
		{
			var timeStr:String = "";
			if (value_ > 0)
			{
				var hour:int = value_ / 3600; //小时
				var min:int = (value_ % 3600) / 60; //分钟		
				timeStr = hour + Language_zh_CN.TIME_HOUR + min + Language_zh_CN.TIME_MINUTE;
			} else
			{
				timeStr = Language_zh_CN.TIME_NOLIMIT;
			}

			return timeStr;
		}

		/**
		 *获得小时分钟
		 */
		public static function getTimeHourMin2(value_:Number):String
		{
			var timeStr:String = "";
			if (value_ > 0)
			{
				var hour:int = value_ / 3600; //小时
				var min:int = (value_ % 3600) / 60; //分钟	
				var sec:int = value_ % 60; //秒数
				timeStr = hour + Language_zh_CN.TIME_HOUR + min + Language_zh_CN.TIME_MINUTE + sec + Language_zh_CN.TIME_SECOND;
			} else
			{
				timeStr = Language_zh_CN.TIME_NOLIMIT;
			}

			return timeStr;
		}

		/**
		 *获得时间00:00:00格式
		 */
		public static function getTimeHourMinSec(value_:Number):String
		{
			var timeStr:String = "";
			if (value_ > 0)
			{
				var hour:int = value_ / 3600; //小时
				var min:int = (value_ % 3600) / 60; //分钟
				var second:int = value_ % 60; //秒


				timeStr += hour < 10 ? "0" + hour + ":" : hour + ":";
				timeStr += min < 10 ? "0" + min + ":" : min + ":";
				timeStr += second < 10 ? "0" + second : "" + second;
			} else
			{
				timeStr = Language_zh_CN.TIME_NOLIMIT;
			}

			return timeStr;
		}

		/**
		 *获得时间00:00格式
		 */
		public static function getTimeMinSec(value_:Number):String
		{
			var timeStr:String = "";
			if (value_ > 0)
			{
				var min:int = (value_ % 3600) / 60; //分钟
				var second:int = value_ % 60; //秒

				timeStr += min.toString().length > 1 ? min.toString() : "0" + min.toString();
				timeStr += ":";
				timeStr += second.toString().length > 1 ? second.toString() : "0" + second.toString();
			} else
				timeStr = "00:00"

			return timeStr;
		}

		/**
		 * 湖区记录时间格式
		 * */
		public static function getTimeFormat(timing_:Number):String
		{
			var passTime:Number = D_System.intance.nowTimeSec - timing_;
			var days_:int = passTime / 86400;
			var hours:int = passTime / 3600;
			var mins:int = passTime / 60;

			var timeHtml:String = "";
			if (days_ > 0)
			{
				timeHtml = HtmlUtil.color("[" + days_ + Language_zh_CN.SYS_TIAN_QIAN + "]", CONST_COLOR.COLOR_GOLD_YELLOW);
			} else if (hours > 0)
			{
				timeHtml = HtmlUtil.color("[" + hours + Language_zh_CN.SYS_XIAO_SHI_QIAN + "]", CONST_COLOR.COLOR_GOLD_YELLOW);
			} else if (mins > 0)
			{
				timeHtml = HtmlUtil.color("[" + mins + Language_zh_CN.SYS_MIN_QIAN + "]", CONST_COLOR.COLOR_GOLD_YELLOW);
			}

			return timeHtml;
		}


		/**
		 * 获取万字表达发
		 * */
		public static function getNumberShow(number:Number):String
		{
			var numStr:String;
			if (number > 10000)
				numStr = int(number / 10000) + Language_zh_CN.TEN_THOUSAND; else
				numStr = number + "";
			return numStr;
		}

		/**
		 *根据怪物品质获得怪物品质描述
		 * @param quality_
		 * @return
		 *
		 */
		public static function getMonstereQualityDesc(quality_:uint):String
		{
			switch (quality_)
			{
				case CONST_MONSTER.MONSTER_QUALITY_NORMAL_1:
				{
					return Language_zh_CN.MONSTER_QUALITY_NORMAL_DESC;
				}

				case CONST_MONSTER.MONSTER_QUALITY_ELITE_2:
				{

					return Language_zh_CN.MONSTER_QUALITY_ELITE_DESC;
				}
				case CONST_MONSTER.MONSTER_QUALITY_BOSS_3:
				{

					return Language_zh_CN.MONSTER_QUALITY_BOSS_DESC;
				}
				default:
				{
					return "";
				}
			}
		}

		/**
		 *Date 所指定的星期值（0 代表星期日，1 代表星期一，依此类推)
		 *根据
		 */
		public static function getDateString(value_:int):String
		{
			switch (value_)
			{
				case 0:
					return Language_zh_CN.SUNDAY;
					break;
				case 1:
					return Language_zh_CN.MONDAY;
					break;
				case 2:
					return Language_zh_CN.TUESDAY;
					break;
				case 3:
					return Language_zh_CN.WEDNESDAY;
					break;
				case 4:
					return Language_zh_CN.THURSDAY;
					break;
				case 5:
					return Language_zh_CN.FRIDAY;
					break;
				case 6:
					return Language_zh_CN.SATURDAY;
					break;
			}

			return Language_zh_CN.SUNDAY;
		}

		/**
		 * 补充字符长度
		 * */

		public static function fillSpaceToString(srcStr_:String, len:int):String
		{
			var sbyte:Byte = new Byte();
			sbyte.writeUTFBytes(srcStr_);

			var fixLen:int = len - sbyte.length;
			for (var i:int = 0; i < fixLen; i++)
			{
				srcStr_ += " ";
			}
			return srcStr_;
		}

		public static function repStrNum(str_:String, strMask_:String = "*"):String
		{
			var name:String = str_;
			var repList:Array = [];
			for (var i:int = 0; i < name.length; i++)
			{
				var char_:String = name.charAt(i);

				for each(var legalStr:String in noLegalArr)
				{
					if (legalStr.indexOf(char_) != -1)
					{
						repList.push(i);
						break;
					}
				}
			}
			var repLen:int = repList.length;
			//			var newStr:String="";
			for (i = 0; i < repLen; i++)
			{

				var index:int = repList[i];
				var repStr:String = name.charAt(index);
				if (repStr != strMask_)
				{
					name = name.replace(repStr, "*")
				}
			}
			return name;
		}

		/**
		 * 检查字符中是否有限制数字字符
		 * @return
		 *
		 */
		public static function checkStrNum(str_:String):Boolean
		{
			var name:String = str_;
			for (var i:int = 0; i < name.length; i++)
			{
				var char_:String = name.charAt(i);

				for each(var legalStr:String in noLegalArr)
				{
					if (legalStr.indexOf(char_) != -1)
					{
						return true;
					}
				}
			}
			return false;
		}

		/**
		 *根据游戏渲染类型获得渲染限制
		 * @param useStarling_
		 * @return
		 *
		 */
		public static function parseRace(parseStr_:String, useStarling_:Boolean = false):Number
		{
			var index:int = 0;
			if (useStarling_)
			{
				index = 1;
			}
			var _strList:Array = parseStr_.split("#");
			if (_strList.length > 1)
			{
				return Number(_strList[index]);
			}
			return Number(_strList[0]);
		}

		/**
		 *检查是否达到非法或者敏感字 上限(true:达到上限)
		 * @return
		 *
		 */
		public static function checkIsUnlawfulCountLimt(str_:String):Boolean
		{
			var count:int = checkNumCount(str_);
			if (count >= 3)
			{
				return true;
			}
			return false;
		}

		public static function checkNumCount(str_:String):int
		{
			if (str_ == null || str_ == "")
			{
				return 0;
			}
			var count:int = 0;
			var len:int = str_.length;

			for (var i:int = 0; i < len; i++)
			{
				var char:String = str_.charAt(i);
				for each(var legalStr:String in noLegalArr)
				{
					if (legalStr.indexOf(char) != -1)
					{
						count++;
						break;
					}
				}
			}

			return count;
		}
	}
}
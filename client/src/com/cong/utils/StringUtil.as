package com.cong.utils
{
	import game.str.Language;

	import laya.utils.Byte;

	public class StringUtil
	{

//		public static var linkcss:StyleSheet;

//		/**
//		 * 判断一个字符串是否为空字符串（null或""）
//		 * @param str_
//		 * @return
//		 *
//		 */
//		public static function isEmpty(str_:String):Boolean
//		{
//			if (null != str_ && str_.length > 0)
//			{
//				return false;
//			}
//			return true;
//		}

//		/**
//		 * 将数字转换为字符串，可以指定进制、最少位数、大小写
//		 * @param _value 需要转换的数字
//		 * @param _radix 进制，2 <= _radix <= 36
//		 * @param _minChars 最少位数，如果位数不足，则在字符串前补0,
//		 * @param lowerCase_ 是否为小写，true为小写，false为大写
//		 * @return 转换完成的字符串
//		 *
//		 */
//		public static function intToString(_value:uint, _radix:*=10, _minChars:int=0, lowerCase_:Boolean=true):String
//		{
//			var str:String=_value.toString(_radix);
//			if (str.length < _minChars)
//			{
//				var needChars:int=_minChars - str.length;
//				for (var i:int=0; i < needChars; i++)
//				{
//					str="0" + str;
//				}
//			}
//
//			if (!lowerCase_)
//			{
//				str=str.toUpperCase();
//			}
//
//			return str;
//		}
//
//		/**
//		 * 将秒数转换为格式"HH:MM:SS"的字符串。如果H、M、S小于0，则会补0，比如61秒会转换成"00:01:01"。
//		 * <br><b>属于时间段转换</b>
//		 * @param _value 秒数
//		 * @return 转换完成的字符串
//		 *
//		 */
//		public static function secondsToTimeStamp(_value:int):String
//		{
//			if (_value <= 0)
//				return "00:00:00";
//
//			var hours:int=parseInt(_value / 3600);
//			var minsAndSecs:int=_value % 3600;
//			var mins:int=parseInt(minsAndSecs / 60);
//			var secs:int=minsAndSecs % 60;
//
//			var hourStr:String=String(hours);
//			if (hours < 10)
//			{
//				hourStr="0" + hourStr;
//			}
//
//			var minStr:String=String(mins);
//			if (mins < 10)
//			{
//				minStr="0" + minStr;
//			}
//
//			var secStr:String=String(secs);
//			if (secs < 10)
//			{
//				secStr="0" + secStr;
//			}
//
//			return hourStr + ":" + minStr + ":" + secStr;
//		}
//
//		/**
//		 * 格式"HH:MM:SS"的字符串转成秒
//		 * @param str_
//		 *
//		 */
//		public static function TimeStampToSeconds(str_:String):int
//		{
//			if (null == str_)
//			{
//				return 0;
//			}
//
//			var arr:Array=str_.split(":");
//			if (null == arr || arr.length < 1)
//			{
//				return 0;
//			}
//			var seconds:int=parseparseInt(arr[2]) + parseparseInt(arr[1]) * 60 + parseparseInt(arr[0]) * 3600;
//
//			return seconds;
//		}
//
//		/**
//		 * 将一百万以上的数字转换为"x万"的字符串
//		 * @param value_ 要转换的数字
//		 * @return 转换完成的字符串
//		 *
//		 */
//		public static function shortNumber_million(value_:Number):String
//		{
//			if (value_ >= 1000000 || value_ <= -1000000)
//			{
//				return String(Math.bubbleLayer(value_ / 10000)) + Language.WANG;
//			}
//
//			return String(value_);
//		}
//
//		/**
//		 * 将数字转换成万，亿，(四舍五入)
//		 * @param n
//		 * @return
//		 *
//		 */
//		public static function numToMoneyFixedStr(n:Number, fixed_:int = 0):String
//		{
//			if(n <= 0)
//			{
//				return "0";
//			}
//
//			if (n >= 10000)
//			{
//				if (n >= 100000000)
//				{
//					return ((n / 100000000)).toFixed(fixed_) + Language.YI;
//				}
//				else
//				{
//					return ((n / 10000)).toFixed(fixed_) + Language.WANG;
//				}
//			}
//			else
//			{
//				return "" + n;
//			}
//		}

		/**
		 * 将数字转换成万，亿，（向下取整的）
		 * @param n
		 * @return
		 *
		 */
		public static function numToMoneyStr(n:Number):String
		{
			if (n <= 0)
			{
				return "0";
			}

			if (n >= 10000)
			{
				if (n >= 100000000)
				{
					return (parseInt(n / 100000000)) + Language.YI;
				} else
				{
					return (parseInt(n / 10000)) + Language.WANG;
				}
			} else
			{
				return "" + n;
			}
		}

//		/**
//		 * 将数字转换成万，亿，
//		 * @param n
//		 * @return
//		 *
//		 */
//		public static function numToWEStr(n:Number):String
//		{
//			if (n > 10000)
//			{
//				if (n > 100000000)
//				{
//					return ((n / 100000000) >> 0) + "E";
//				}
//				else
//				{
//					return ((n / 10000) >> 0) + "W";
//				}
//			}
//			else
//			{
//				return "" + n;
//			}
//		}


		/**
		 * 将秒数转换为格式"x小时x分钟x秒"的字符串。如果不足某个单位，则该单位不显示，比如61秒会转换成"1分钟1秒"。
		 * <br><b>属于时间段转换</b>
		 * @param _value 秒数
		 * @return 转换完成的字符串
		 *
		 */
		public static function secondsToTimeString(_value:int,isCeil:Boolean = false):String
		{
			if (_value <= 0) return "0" + Language.MIAO;

			var hours:int = parseInt(_value / 3600);
			var minsAndSecs:int = _value % 3600;
			var mins:int = parseInt(minsAndSecs / 60);

			if (hours >= 1)
			{
				if (mins > 0)
				{
					return hours + Language.XIAO_SHI + mins + Language.FEN_ZHONG;
				} else
				{
					return hours + Language.XIAO_SHI;
				}
			} else
			{
				var secs:int =isCeil?Math.ceil(minsAndSecs % 60): minsAndSecs % 60;
				if (mins >= 1)
				{
					if (secs > 0)
					{
						return mins + Language.FEN_ZHONG + secs + Language.MIAO;
					} else
					{
						return mins + Language.FEN_ZHONG;
					}
				} else
				{
					return secs + Language.MIAO;
				}
			}
		}

//		/** 将秒数转换为格式"x小时x分钟x秒"的字符串 */
//		public static function secondsToTimeString3($second:int,isShowSecond_:Boolean = true):String
//		{
//			if ($second <= 0)
//			{
//				if(isShowSecond_)
//				{
//					return "0"+Language.MIAO;
//				}
//				else
//				{
//					return "0"+Language.FEN_ZHONG;
//				}
//			}
//
//			var hours:int=parseInt($second / 3600);
//
//			var minsAndSecs:int=$second % 3600;
//
//			var mins:int=parseInt(minsAndSecs / 60);
//
//			var secs:int=minsAndSecs % 60;
//
//			if (hours > 0)
//			{
//				if(isShowSecond_)
//				{
//					return hours + Language.XIAO_SHI + mins + Language.FEN_ZHONG + secs + Language.MIAO;
//				}
//				else
//				{
//					return hours + Language.XIAO_SHI + mins + Language.FEN_ZHONG;
//				}
//			}
//			else if (mins > 0)
//			{
//				if(isShowSecond_)
//				{
//					return mins + Language.FEN_ZHONG + secs + Language.MIAO;
//				}
//				else
//				{
//					return mins + Language.FEN_ZHONG;
//				}
//			}
//
//			if(isShowSecond_)
//			{
//				return secs + Language.MIAO;
//			}
//
//			return "0"+Language.FEN_ZHONG;
//		}

		/**
		 *61秒=1分钟
		 * @return
		 *
		 */
		public static function secondsToTimeString2(value_:int):String
		{
			var hours:int = Math.floor(value_ / 3600);
			var mins:int = Math.floor(value_ / 60);
			var days:int = Math.floor(hours / 24);
			if (days > 0)
			{
				return days + Language.TIAN;
			} else if (hours > 0)
			{
				return hours + Language.XIAO_SHI;
			} else if (mins > 0)
			{
				return mins + Language.FEN_ZHONG;
			} else
			{
				return value_ + Language.MIAO;
			}
		}


		/**
		 * 将自 1970 年 1 月 1 日午夜（通用时间）以来的秒数转换成形如"yyyy-mm-dd hh:mm:ss"的字符串。
		 * 除了年份，每个单位会自动补0，比如"2001-01-01 16:04:03"
		 * <br><b>属于时间点转换</b>
		 * @param value_ 秒数
		 * @param needLit_ 1: 显示2001-01-01 16:04:03 ，2：显示2001-01-01，3：16:04:03
		 * isNeedSeconds_ 是否需要显示秒
		 * @return
		 *
		 */
		public static function timeToString(value_:Number, needLit_:int = 1, isNeedSeconds_:Boolean = true,splitStr:String='-'):String
		{
			value_ *= 1000;
			var date:Date = new Date(value_);

			var monthStr:String = String(parseInt(date.getMonth() + 1));
			if (date.getMonth() < 9)
			{
				monthStr = "0" + monthStr;
			}

			var dateStr:String = String(parseInt(date.getDate()));
			if (date.getDate() < 10)
			{
				dateStr = "0" + dateStr;
			}
			var hourStr:String = String(parseInt(date.getHours()));
			if (date.getHours() < 10)
			{
				hourStr = "0" + hourStr;
			}

			var minStr:String = String(parseInt(date.getMinutes()));
			if (date.getMinutes() < 10)
			{
				minStr = "0" + minStr;
			}

			var secStr:String = String(parseInt(date.getSeconds()));
			if (date.getSeconds() < 10)
			{
				secStr = "0" + secStr;
			}
			var timeStr:String = date.getFullYear() + splitStr + monthStr + splitStr + dateStr;
			switch (needLit_)
			{
				case 1:
					if (isNeedSeconds_)
					{
						timeStr += " " + hourStr + ":" + minStr + ":" + secStr;
					} else
					{
						timeStr += " " + hourStr + ":" + minStr;
					}

					break;
				case 3:
					if (isNeedSeconds_)
					{
						timeStr = hourStr + ":" + minStr + ":" + secStr;
					} else
					{
						timeStr = hourStr + ":" + minStr;
					}
					break;
			}


			return timeStr;
		}

		/**
		 * 将自 1970 年 1 月 1 日午夜（通用时间）以来的秒数转换成形如"yyyy年mm月dd日 hh:mm:ss"的字符串
		 * <br><b>注意：年月日不补0，时分秒补0</b>
		 * <br><b>属于时间点转换</b>
		 * @param value_ 秒数
		 * @param isNeedLit 是否需要"hh:mm:ss"。true为需要，false不需要（只返回"yyyy年mm月dd日"）
		 * @return
		 *
		 */
		public static function timeToString2(value_:Number, isNeedLit:Boolean = false):String
		{
			value_ *= 1000;
			var date:Date = new Date(value_);
			var lit:String = "";
			if (date.getHours() < 10)
			{
				lit += "0" + date.getHours();
			} else
			{
				lit += date.getHours();
			}
			lit += ":";
			if (date.getMinutes() < 10)
			{
				lit += "0" + date.getMinutes();
			} else
			{
				lit += date.getMinutes();
			}
			lit += ":";
			if (date.getSeconds() < 10)
			{
				lit += "0" + date.getSeconds();
			} else
			{
				lit += date.getSeconds();
			}
			if (isNeedLit)
			{
				return (date.getFullYear() + Language.NIAN + (date.getMonth() + 1) + Language.YUE + date.getDate() + Language.RI + " " + lit);
			} else
			{
				return (date.getFullYear() + Language.NIAN + (date.getMonth() + 1) + Language.YUE + date.getDate() + Language.RI);
			}

		}

		/**
		 * 将自 1970 年 1 月 1 日午夜（通用时间）以来的秒数转换成形如"yyyy年mm月dd日hh小时mm分钟"的字符串
		 * <br><b>注意：年月日不补0，时分秒补0</b>
		 * <br><b>属于时间点转换</b>
		 * @param value_ 秒数
		 * @param isNeedLit 是否需要"hh:mm:ss"。true为需要，false不需要（只返回"yyyy年mm月dd日"）
		 * @return
		 *
		 */
		public static function timeToStringNew2(value_:Number, isNeedLit:Boolean = true):String
		{
			value_ *= 1000;
			var date:Date = new Date(value_);
			var lit:String = "";
			if (date.getHours() < 10)
			{
				lit += "0" + date.getHours();
			} else
			{
				lit += date.getHours();
			}
			lit += Language.SHI;
			if (date.getMinutes() < 10)
			{
				lit += "0" + date.getMinutes();
			} else
			{
				lit += date.getMinutes();
			}
			lit += Language.FEN;
			/*if (date.getSeconds() < 10)
			{
				lit+="0" + date.getSeconds();
			}
			else
			{
				lit+=date.getSeconds();
			}*/
			if (isNeedLit)
			{
				return (date.getFullYear() + Language.NIAN + (date.getMonth() + 1) + Language.YUE + date.getDate() + Language.RI + lit);
			} else
			{
				return (date.getFullYear() + Language.NIAN + (date.getMonth() + 1) + Language.YUE + date.getDate() + Language.RI);
			}

		}

		/**
		 * 将秒数转化为格式"mm:ss"的字符串，自动补0
		 * <br><b>属于时间段转换</b>
		 * @param value_
		 * @return
		 *
		 */
		public static function timeToString3(value_:Number):String
		{
			var min:uint= parseInt(value_ / 60);
			var second:int=value_ - min * 60;
			var time:String="";
			if (min < 10)
			{
				time+="0" + min + ":";
			}
			else
			{
				time+=min + ":";
			}

			if (second < 10)
			{
				time+="0" + second;
			}
			else
			{
				time+=second;
			}

			return time;
		}

//		/**
//		 * 传入毫秒数，返回格式为"x天x小时x分钟"的字符串，不自动补0
//		 * <br><b>属于时间段转换</b>
//		 * @param time_ 毫秒数
//		 * @param isOnlyShowDay_ 是否只显示天
//		 * @return 转换完成的字符串
//		 *
//		 */
//		public static function timeToString4(time_:Number, isOnlyShowDay_:Boolean=false):String
//		{
//			var day:int;
//			var hour:int;
//			var min:int;
//			var temp:Number;
//			var reString:String="";
//			day=time_ / 86400000;
//			temp=time_ % 86400000;
//			if (temp > 0)
//			{
//				hour=(temp) / 3600000;
//				temp=temp % 3600000;
//				if (temp > 0)
//				{
//					min=temp / 60000;
//				}
//			}
//
//			if (day > 0)
//			{
//				reString+=day + Language.TIAN;
//				if (isOnlyShowDay_)
//				{
//					return reString;
//				}
//			}
//			if (hour > 0)
//			{
//				reString+=hour + Language.XIAO_SHI;
//			}
//			if (min > 0)
//			{
//				reString+=min + Language.FEN_ZHONG;
//			}
//
//			return reString;
//		}

		/**
		 *  传入秒数，返回格式为"hh:mm:ss"的字符串，自动补0
		 * @param value_
		 * @return
		 *
		 */
		public static function timeToString5(value_:Number):String
		{
			var hour:int = parseInt(value_ / 3600);
			var hourStr:String = (hour < 10 ? ("0" + hour) : String(hour));
			value_ -= (hour * 3600);
			var min:int = parseInt(value_ / 60);
			var minStr:String = (min < 10 ? ("0" + min) : String(min));
			var sec:int = value_ - (min * 60);
			var secStr:String = (sec < 10 ? ("0" + sec) : String(sec));
			return (hourStr + ":" + minStr + ":" + secStr);
		}

//		/**
//		 * 将秒数转化为格式"mm:ss"的字符串，自动补0
//		 * <br><b>属于时间段转换</b>
//		 * @param value_
//		 * @return
//		 *
//		 */
		public static function timeToString6(value_:Number):String
		{
//			var hour:uint = value_/3600;
			var min:uint = parseInt((value_) / 60);
			var second:uint = value_ - min * 60;
			var time:String = "";
			if (min < 10)
			{
				time += "0" + min + ":";
			} else
			{
				time += min + ":";
			}

			if (second < 10)
			{
				time += "0" + second;
			} else
			{
				time += second;
			}
//			Console.traceDebug(time);
			return time;
		}

//		/**
//		 *传入秒数，返回格式 小于24:返回"hh:mm:ss"     大于24小时：返回"X天X小时"自动补0
//		 * @param value_
//		 * @return
//		 *
//		 */
//		public static function timeToString7(value_:Number):String
//		{
//			var hour:int=value_ / 3600;
//			if (hour < 24)
//			{
//				return timeToString5(value_);
//			}
//
//			var day:int=parseInt(hour / 24);
//			value_-=day * 3600 * 24;
//			hour=value_ / 3600;
//			var hourStr:String=String(hour);
//			return (day + Language.TIAN + hourStr + Language.XIAO_SHI);
//		}

//		/**
//		 *  传入秒数，返回格式为"hh:mm"的字符串，自动补0
//		 * @param value_
//		 * @return
//		 *
//		 */
//		public static function timeToString8(value_:Number):String
//		{
//			var hour:int=parseInt(value_ / 3600);
//			var hourStr:String=(hour < 10 ? ("0" + hour) : String(hour));
//			value_-=(hour * 3600);
//			var min:int=parseInt(value_ / 60);
//			var minStr:String=(min < 10 ? ("0" + min) : String(min));
////			var sec:int = value_ - (min * 60);
////			var secStr:String = (sec < 10 ? ("0" + sec) : String(sec));
//			return (hourStr + ":" + minStr);
//		}


		/**
		 * 传入毫秒数，返回格式为"x天x小时x分钟x秒"的字符串，不自动补0
		 * <br><b>属于时间段转换</b>
		 * @param time_ 毫秒数
		 * @param isOnlyShowDay_ 是否只显示天
		 * @return 转换完成的字符串
		 *
		 */
		public static function timeToString9(time_:Number, isOnlyShowDay_:Boolean = false, color_:String = ""):String
		{
			var day:int;
			var hour:int;
			var min:int;
			var second:int;
			var temp:Number;
			var reString:String = "";
			day = parseInt(time_ / 86400000);
			temp = time_ % 86400000;
			if (temp > 0)
			{
				hour = parseInt((temp) / 3600000);
				temp = temp % 3600000;
				if (temp > 0)
				{
					min = parseInt(temp / 60000);
					temp = temp % 60000;
					if (temp > 0)
					{
						second = parseInt(temp / 1000);
					}
				}
			}

			if (day > 0)
			{
				if (color_ != "")
				{
					reString += "<font color=\'" + color_ + "\' >" + day + "</font>" + "天";
				} else
				{
					reString += day + Language.TIAN;
				}
				if (isOnlyShowDay_)
				{
					return reString;
				}
			}
			if (hour > 0)
			{
				if (color_ != "")
				{
					reString += "<font color=\'" + color_ + "\' >" + hour + "</font>" + "小时";
				} else
				{
					reString += hour + Language.XIAO_SHI;
				}

			}
			if (min > 0)
			{
				if (color_ != "")
				{
					reString += "<font color=\'" + color_ + "\' >" + min + "</font>" + "分钟";
				} else
				{
					reString += min + Language.FEN_ZHONG;
				}

			}
			if (second > 0)
			{
				if (color_ != "")
				{
					reString += "<font color=\'" + color_ + "\' >" + second + "</font>" + "秒";
				} else
				{
					reString += second + Language.MIAO;
				}

			}
			return reString;
		}


		/**
		 * 传入毫秒数，返回格式为"x天x小时x分钟"的字符串，
		 * 例：365天0小时0分钟0秒,显示365天
		 例：0天0小时30分种0秒，显示30分钟
		 例：0天0小时30分种12秒，显示30分钟12秒
		 * <br><b>属于时间段转换</b>
		 * @param time_ 毫秒数
		 * @param isOnlyShowDay_ 是否只显示天
		 * @return 转换完成的字符串
		 *
		 */
		public static function timeToString10(time_:Number):String
		{
			var day:int;
			var hour:int;
			var min:int;
			var second:int;
			var temp:Number;
			var reString:String = "";
			day = parseInt(time_ / 86400000);
			temp = parseInt(time_ % 86400000);
			if (temp > 0)
			{
				hour = parseInt(temp / 3600000);
				temp = parseInt(temp % 3600000);
				if (temp > 0)
				{
					min = parseInt(temp / 60000);
					temp = parseInt(temp % 60000);
					if (temp > 0)
					{
						second = parseInt(temp / 1000);
					}
				}
			}

			if (day > 0)
			{
				reString += day + Language.TIAN;
				if (hour <= 0)
				{
					return reString;
				}
			}
			if (hour > 0)
			{
				reString += hour + Language.XIAO_SHI;
				if (min <= 0)
				{
					return reString;
				}
			}
			if (min > 0)
			{
				reString += min + Language.FEN_ZHONG;
				if (second <= 0)
				{
					return reString;
				}
			}
//			if (second > 0)
//			{
//				reString+=second + Language.MIAO;
//			}

			return reString;
		}

		/**
		 * 时间秒转换成 时间对象
		 * obj_["hours"]  小时
		 * obj_["mins"]   分钟
		 * obj_["seconds"] 秒
		 * @return
		 *
		 */
		public static function timeToString11(value_:int):Object
		{
			var obj_:Object = {};
			var hours:int = parseInt(value_ / 3600);
			value_ = value_ - (hours * 3600);

			var mins:int = parseInt(value_ / 60);
			value_ = value_ - (mins * 60);

			obj_["hours"] = hours;
			obj_["mins"] = mins;
			obj_["seconds"] = value_;

			return obj_;
		}

//		/**
//		 * 传入毫秒数，返回格式为"x小时x分钟x秒"的字符串，不自动补0
//		 * <br><b>属于时间段转换</b>
//		 * @param time_ 毫秒数
//		 * @return 转换完成的字符串
//		 *
//		 */
//		public static function timeToString12(time_:Number,color_:String=""):String
//		{
//			var hour:int;
//			var min:int;
//			var second:int;
//			var temp:int;
//			var reString:String="";
//			if (time_ > 0)
//			{
//				hour=(time_) / 3600000;
//				temp=time_ % 3600000;
//				if (temp > 0)
//				{
//					min=temp / 60000;
//					temp=temp % 60000;
//					if (temp > 0)
//					{
//						second=temp / 1000;
//					}
//				}
//			}
//
//			if (hour > 0)
//			{
//				if (color_ != "")
//				{
//					reString+="<font color=\'" + color_ + "\' >" + hour + "</font>" + Language.XIAO_SHI;
//				}
//				else
//				{
//					reString+=hour + Language.XIAO_SHI;
//				}
//
//			}
//			if (min > 0)
//			{
//				if (color_ != "")
//				{
//					reString+="<font color=\'" + color_ + "\' >" + min + "</font>" + Language.FEN_ZHONG;
//				}
//				else
//				{
//					reString+=min + Language.FEN_ZHONG;
//				}
//
//			}
//			if (second > 0)
//			{
//				if (color_ != "")
//				{
//					reString+="<font color=\'" + color_ + "\' >" + second + "</font>" + Language.MIAO;
//				}
//				else
//				{
//					reString+=second + Language.MIAO;
//				}
//
//			}
//			return reString;
//		}
//		/**
//		 * 时间秒转换成 时间对象
//		 * obj_["days"]  天
//		 * obj_["hours"]  小时
//		 * obj_["mins"]   分钟
//		 * obj_["seconds"] 秒
//		 * @return
//		 *
//		 */
//		public static function timeToString13(value_:int):Object
//		{
//			var obj_:Object = {};
//			var days:int=parseInt(value_ /86400);
//			value_ = value_ - (days * 86400);
//			var hours:int=parseInt(value_ / 3600);
//			value_ = value_ - (hours * 3600);
//			var mins:int=parseInt(value_ / 60);
//			value_ = value_ - (mins * 60);
//			obj_["days"]  = days;
//			obj_["hours"]  = hours;
//			obj_["mins"]  = mins;
//			obj_["seconds"]  = value_;
//
//			return obj_;
//		}
//		/**
//		 *  判断一个字符是不是空白字符（包括虽然不是空格但是会显示成类似空格的样子的字符）
//		 * <br><b>注意：只能传入长度为1的字符串，即只有一个字符</b>
//		 * @param char_ 字符
//		 * @return
//		 *
//		 */
//		public static function charIsBlank(char_:String):Boolean
//		{
//			if (char_ == " " || char_ == "" || char_ == "　" || char_ == "　") //一个特殊字符
//			{
//				return true;
//			}
//			return false;
//		}

//		/**
//		 * 是否含有空白字符（包括虽然不是空格但是会显示成类似空格的样子的字符）
//		 * @param str_ 需要检查的字符串
//		 * @return true含有，false不含有
//		 *
//		 */
//		public static function isContainBlank(str_:String):Boolean
//		{
//			for (var i:int=0; i < str_.length; i++)
//			{
//				var s:String=str_.charAt(i);
//				if (charIsBlank(s))
//				{
//					return true;
//				}
//			}
//			return false;
//		}
//
//		/**
//		 * 判断字符串是不是全都是空白字符（包括虽然不是空格但是会显示成类似空格的样子的字符）
//		 * @param str_
//		 * @return
//		 *
//		 */
//		public static function isAllBlank(str_:String):Boolean
//		{
//			for (var i:int=0; i < str_.length; i++)
//			{
//				var s:String=str_.charAt(i);
//				if (!charIsBlank(s))
//				{
//					return false;
//				}
//			}
//
//			return true;
//		}

		/**
		 *例：传入（提高武将统率:{0}，{0}，2
		 * 返回： 提高武将统率:2
		 * @param oStr
		 * @param keyStr
		 * @param dStr
		 *
		 */
		public static function ReplaceString(oStr:String, keyStrArr:Array, dStrArr:Array):String
		{
			var oStr_C:String = oStr;
			var rStr:String = "";
			var index_re:int = 0;
			for (index_re = 0; index_re < keyStrArr.length && index_re < dStrArr.length; index_re++)
			{
				var arr:Array = oStr_C.split(keyStrArr[index_re]);
				var tag:Boolean = false;
				for (var index:int = 0; index < arr.length; index++)
				{
					rStr += (arr[index] + dStrArr[index_re]);
					tag = true;
				}
				if (tag)
				{
					rStr = rStr.substr(0, rStr.length - String(dStrArr[index_re]).length);
					oStr_C = rStr;
					rStr = "";
				}
			}

			return oStr_C;
		}

//		public static function replaceLanguage(rawStr:String, ... args):String
//		{
//			var reg:RegExp=new RegExp(/\{[^\}]+\}/g);
//			var arr:Array=rawStr.match(reg);
//			if (arr.length)
//			{
//				for (var i:int=0, ilen:int=arr.length; i < ilen; i++)
//				{
//					rawStr=rawStr.replace(arr[i], args[i]);
//				}
//			}
//			return rawStr;
//		}
//
//
//
//		public static function Format(format:Object, dStrArr:Array):String
//		{
//			if (arguments.length == 0)
//			{
//				return '';
//			}
//			if (arguments.length == 1)
//			{
//				return String(format);
//			}
//
//			var strOutput:String='';
//			for (var i:int=0; i < format.length - 2; )
//			{
//				if (format.charAt(i) == '{' && format.charAt(i + 1) != '{')
//				{
//					var token:String=format.substr(i);
//					var index:String=String(token.match(/\d+/));
//					if (format.charAt(i + index.length + 1) == '}')
//					{
//						var swapArg:String=dStrArr[Number(index)];
//						if (swapArg)
//						{
//							strOutput+=swapArg;
//						}
//						i+=index.length + 2;
//					}
//				}
//				else
//				{
//					if (format.charAt(i) == '{' && format.charAt(i + 1) == '{')
//					{
//						strOutput+=format.charAt(i);
//						i++
//					}
//					strOutput+=format.charAt(i);
//					i++;
//				}
//			}
//			strOutput+=format.substr(i);
//			return strOutput.replace(/{{/g, '{').replace(/}}/g, '}');
//		}
//
//		/**
//		 * 将字符串写入Byte，每个字符转成1个byte，所以每个字符都必须为Unicode字符代码只有1byte的
//		 * @param str_
//		 * @param target_
//		 *
//		 */
//		public static function flush_byte(str_:String, target_:Byte):void
//		{
//			var len:int=str_.length;
//			for (var i:int=0; i < len; i++)
//			{
//				target_.writeByte(str_.charCodeAt(i));
//			}
//		}
//
//
//		/**
//	 * 从Byte中读取字符串，每个byte对应1个字符，所以每个字符都必须为Unicode字符代码只有1byte的
//		 * @param source_
//		  * @return
//		*
//	 */
//		public static function read_byte(source_:Byte):String
//		{
//			var result:String="";
//			while (source_.bytesAvailable > 0)
//			{
//				result+=String.fromCharCode(source_.getUint8());
//			}
//			return result;
//		}

		/**
		 *获得字符串在utf8编码下的长度（中文2个长度，数字和英文1个）
		 * @param str_
		 * @return
		 *
		 */
		public static function getLength_UTF8(str_:String):int
		{
			/*var bytes:Byte = new Byte();
			bytes.writeMultiByte(str_, "utf8");
			return bytes.length;*/


			return str_.replace(/[^\x00-\xff]/g, "aa").length;
		}

		/**
		 *获取字符串字节长度
		 * @param str_
		 * @return
		 *
		 */
		public static function len(str_:String):int
		{
			return str_.replace(/[^\x00-\xff]/g, "aa").length;
		}

		/**
		 * 传入格式 2012-06-07 12:30:45
		 * 按照 UTC 将表示日期的字符串转换为一个数字，它等于自 1970 年 1 月 1 日起已经过的秒数。
		 * @param str_
		 * @return
		 *
		 */
		public static function stringToTime(str_:String):Number
		{
			var date:Date = new Date(str_.replace(/\-/g, "/"));
			return date.getTime() / 1000;
		}

		/**
		 *剔除字符串头尾空格
		 * @return
		 *
		 */
		public static function trim(str_:String):String
		{
			var _regexp:RegExp = /^\s*/g;
			var _regexp2:RegExp = /\s*$/g;
			return str_.replace(_regexp, "").replace(_regexp2, "");

		}

//		/**
//		 *去掉字符串左边空格
//		 * @return
//		 *
//		 */
//		public static function leftTrim(str_:String):String
//		{
//			return str_.replace(/(^\s*)/g, "");
//		}
//
//		/**
//		 *去掉字符串右边边空格
//		 * @return
//		 *
//		 */
//		public static function rightTrim(str_:String):String
//		{
//			return str_.replace(/(\s*$)/g, "");
//		}

//		/**
//		 * 将 GB2312 转换成 UTF8
//		 */
//		public static function GB2312toUTF8(input:*):String
//		{
//			var ba:Byte=Byte(input);
//			return ba.readMultiByte(ba.length, "gb2312");
//		}


//		/**
//		 * 遍历查询数组中的所有对象的某一字符串属性，将该属性含有check_的对象放在一个新数组中返回
//		 * @param dataArr_ 对象数组
//		 * @param param 属性名称
//		 * @param check_ 需要检查的被包含的关键字
//		 * @return
//		 *
//		 */
//		public static function regExpCheck(dataArr_:Array, param:String, check_:String):Array
//		{
//			var check:RegExp=new RegExp(check_);
//			var returnData:Array=[];
//			for (var i:int=0; i < dataArr_.length; i++)
//			{
//				var temp:Object=dataArr_[i];
//				var result:Object=(temp[param] as String).match(check);
//				if (null != result)
//				{
//					if (result.length > 0)
//						returnData.push(temp);
//				}
//
//			}
//
//			if (returnData.length > 0)
//			{
//				return returnData;
//			}
//			return null;
//		}

//		/**
//		 *获得超链的样式
//		 * @return
//		 * 例如：
//		 *  text.styleSheet = linkcss;
//			text.text  = "<a href='event:123'>ddddddddddddd</a>";
//		 */
//		public static function getLinkCss():StyleSheet
//		{
//			if (linkcss == null)
//			{
//				linkcss=new StyleSheet();
//				linkcss.parseCSS("a {color: #FFFc00;text-decoration:underline;} a:hover {color: #00ff00;text-decoration:underline;}");
//				//a:active {color: #ff0000}
//			}
//			return linkcss;
//		}

//		public static function nextLineStr():String
//		{
//			return String.fromCharCode(13);
//		}


//		/**
//		 * 使用指定的字符集从字节流中读取指定长度的多字节字符串
//		 * @param str
//		 * @param charSet
//		 * @return 字节长度
//		 *
//		 */
//		public static function getStringBytesLength(str:String, charSet:String):int
//		{
//			var bytes:Byte=new Byte();
//
//			bytes. (str, charSet);
//
//			bytes.pos=0;
//
//			return bytes.length;
//		}
//
//		/**
//		 *传入秒数
//		 * @param time_
//		 *
//		 */
//		public static function timeToString753(time_:Number):String
//		{
//			if (time_ > 86400)
//			{
//				return StringUtil.timeToString7(time_);
//			}
//			else if (time_ > 3600)
//			{
//				return StringUtil.timeToString5(time_);
//			}
//			return StringUtil.timeToString3(time_);
//		}

//		/**
//		 * 取中文的“一”到“十”
//		 * @param $num  0-10
//		 * @return
//		 *
//		 */
//		public static function getChineseNumStr($num:int):String
//		{
//			return Language.CHINESE_NUM_LIST[$num];
//		}

//		public static function dateFormat(date:Date, formatStr:String="y-m-d h:i:s"):String
//		{
//			var regExp_:RegExp=/y/gi;
//			formatStr=formatStr.replace(regExp_, date.getFullYear());
//			regExp_=/m/gi;
//			formatStr=formatStr.replace(regExp_, (date.getMonth() + 1));
//			regExp_=/d/gi;
//			formatStr=formatStr.replace(regExp_, date.getDate());
//			regExp_=/h/gi;
//			formatStr=formatStr.replace(regExp_, date.getHours());
//			regExp_=/i/gi;
//			formatStr=formatStr.replace(regExp_, date.getMinutes());
//			regExp_=/s/gi;
//			formatStr=formatStr.replace(regExp_, date.getSeconds());
//			regExp_=/t/gi;
//			return formatStr.replace(regExp_, date.getTime() / 1000);
//		}
//
		/**
		 * 一个数字，用指定字符分割 如10000,侵害成10,000
		 * @param num
		 * @param spliter
		 * @return
		 *
		 */
		public static function splitNumber2String(num:Number, spliter:String = ",", inter:uint = 3):String
		{
//			var numStr:String=(num >> 0).toString();
//			var index:int=numStr.length;
//			var str:String="";
//			do
//			{
//				index=index - inter;
//				var addLen:int=inter;
//				if (index <= 0)
//				{
//					addLen=inter + index;
//					index=0;
//				}
//				if (str)
//				{
//
//					str=numStr.substr(index, addLen) + spliter + str;
//				}
//				else
//				{
//					str=numStr.substr(index, addLen);
//				}
//			} while (index > 0);
//			return str;
			var str = "";
			var unit:String = "";
			if (num < 0)
			{
				num = 0;
			}
			if (num >= 1000000000)
			{
				str = (num / 1000000000).toFixed(3);
				unit = "B";
			} else if (num >= 1000000)
			{
				str = (num / 1000000).toFixed(3);
				unit = "M";
			} else if (num >= 1000)
			{
				str = (num / 1000).toFixed(3);
				unit = "K";
			} else
			{
				if(num.toString().split(".")[1]&&num.toString().split(".")[1].length>3){
					str = (num / 1).toFixed(3);
				}else{
					str = num.toString();
				}
			}
			if (str== "0.000")
			{
				str = "0.000";
			} else if (str.lastIndexOf(".") != -1)
			{
				while (str.lastIndexOf("0") == str.length - 1)
				{
					str = str.substr(0, str.length - 1);
				}
				if (str.lastIndexOf(".") == str.length - 1)
				{
					str = str.substr(0, str.length - 1);
				}
			}
			str += unit;
			return str;
		}

		public static function splitNumber2String2(num:Number, spliter:String = ",", inter:uint = 3):String
		{
			var numStr:String = (Math.floor(num)).toString();
			var index:int = numStr.length;
			var str:String = "";
			do
			{
				index = index - inter;
				var addLen:int = inter;
				if (index <= 0)
				{
					addLen = inter + index;
					index = 0;
				}
				if (str)
				{
					str = numStr.substr(index, addLen) + spliter + str;
				} else
				{
					str = numStr.substr(index, addLen);
				}
			} while (index > 0);
			return str;
		}

//		/**
//		 *间时间转化成秒钟
//		 * @param hours
//		 * @param minutes
//		 * @param seconds
//		 * @return
//		 *
//		 */
//		public static function timeToMilSeconds(hours_:int=0, minutes_:int=0, seconds_:int=0):Number
//		{
//			var time:Number = (hours_ * 3600) + (minutes_ * 60) + (seconds_);
//			return time;
//		}
		public static function changeDateToDateStr(_date:Date, index:int = 0, isOnlyDay:Boolean = false, isOnMinue:Boolean = false):String
		{
			var retStr:String = "";
			var _local_7:int;

			if (index < 1)
			{
				retStr = ((retStr + _date.getFullYear()) + Language.NIAN);
			}
			if (index < 2)
			{
				retStr = ((retStr + (_date.getMonth() + 1)) + Language.YUE);
			}
			if (index < 3)
			{
				retStr = ((retStr + _date.getDate()) + Language.RI);
			}
			if (isOnlyDay)
			{
				return (retStr);
			}
			retStr = (retStr + _date.getHours());
			_local_7 = _date.getMinutes();
			if (_local_7 < 10)
			{
				retStr = (retStr + (":0" + _local_7));
			} else
			{
				retStr = (retStr + (":" + _local_7));
			}
			if (isOnMinue)
			{
				return (retStr);
			}
			if (index != 4)
			{
				var _local_5:Number = _date.getSeconds();
				if (_local_5 < 10)
				{
					retStr = (retStr + (":0" + _local_5));
				} else
				{
					retStr = (retStr + (":" + _local_5));
				}
			}
			return (retStr);
		}

//		/**
//		 *删除字符中的空格并且符留maxLen 个字符
//		 * @param str
//		 * @param maxLen
//		 * @return
//		 *
//		 */
//		public static function deleteStringblankSpace(str:String, maxLen:int=14):String
//		{
//			var _index:int;
//			var _newStr:String = "";
//			var _str:String = "";
//			var _len:int = str.length;
//			_index = 0;
//			while (_index < _len)
//			{
//				_str = str.substring(_index, (_index + 1));
//				if (_str != " ")
//				{
//					_newStr = _newStr + _str;
//					if (getTextByteLen(_newStr) >= maxLen)
//					{
//						return (_newStr);
//					}
//				}
//				_index++;
//			}
//			return _newStr;
//		}
		/**
		 *获得 指定长度的字符
		 * @param _info
		 * @param maxlen
		 * @return
		 *
		 */
		public static function getStrByByteLen(_info:String, maxlen:int = 96):String
		{
			var _index:int;
			_info = trim(_info);
			var _newStr:String = "";
			var _len:int = _info.length;
			_index = 0;
			while (_index < _len)
			{
				_newStr = _info.substring(0, (_index + 1));
				if (getTextByteLen(_newStr) >= maxlen) break;
				_index++;
			}
			return _newStr;
		}

		/**
		 *获得字符的长度（英文跟数字2个，中文1个）
		 * @param info
		 * @return
		 *
		 */
		public static function getTextByteLen(info:String):int
		{
			return toByte(info).length;
		}

		public static function formatStr(maxlen:int, info:String):String
		{
			if (info == null)
			{
				return "";
			}
			var str:String = "";
			var curlen:int = 0;
			var i:int = 0;
			while (curlen < maxlen)
			{
				if (i == info.length)
				{
					return str;
				}
				if (info.charCodeAt(i) > 255)
				{
					curlen += 2;
				} else
				{
					curlen += 1.2;
				}
				str += info.charAt(i);
				i++;
			}
			return str + "..";
		}

		public static function toByte(info:String):Byte
		{
			var _bytes:Byte = new Byte();
			_bytes.writeUTFBytes(info);
			_bytes.pos = 0;
			return _bytes;
		}

		public static function timeToNum(time_:Number):Number
		{
			var timeH:Number = time_ / 3600;
			return timeH;
		}

//		/**
//		 * 字符串转换为Date
//		 * @param	str_ 格式 "2013-8-7 9:30:15"
//		 * @return Date
//		 */
//		public static function strToDate(str_:String):Date
//		{
//			var d:Date = new Date(stringToTime(str_) * 1000);
//			return d;
//		}
//
//		/**
//		 * 两个日期的天数相差几天，精确到天
//		 */
//		public static function dayCountDiffer(d1:Date, d2:Date):uint
//		{
//			var d:Date = new Date(Math.abs(new Date(d1.getFullYear(), d1.getMonth(), d1.getDate()).getTime() - new Date(d2.getFullYear(), d2.getMonth(), d2.getDate()).getTime()));
//			return d.getDate() - 1;
//		}
//		/**
//		 *将超过某一数值的数字变成显示前几位的字符
//		 * @param num	数值
//		 * @param maxnum	文本能显示的最大数值
//		 * @param shownum	超过最大数值显示的数值位数
//		 * @return
//		 *
//		 */
//		public static function changeNumtoStr(num:int,maxnum:int=999999,shownum:int=4):String
//		{
//			var re:String="";
//			if(num>maxnum)
//			{
//				var str:String=num.toString();
//				for (var i:int = 0; i < shownum; i++)
//				{
//					re+=str.charAt(i);
//				}
//				re+="..";
//
//			}
//			else
//			{
//				re=num.toString();
//			}
//			return re;
//		}

		/**
		 * 转身字符串的拼接
		 * @param str_
		 * @param revialNum
		 * @param type_  (1:默认类型)
		 * @return
		 */
//		public static function revialToolStr(str_:String, revialNum:int, type_:int = 1, colorStr:String = "#FF9933"):String
//		{
//			var str:String = "";
//			str = str_;
//
//			if(revialNum > 0)
//			{
//				switch(type_)
//				{
//					case 1:
//						str = str + HtmlUtil.color("【"+revialNum + Language.Revival_prompt1+"】", colorStr);
//						break;
//				}
//			}
//			return str;
//		}
		public static function transDate(timeStamp:int):String
		{
			var date:Date = new Date(timeStamp * 1000);
			return date.getFullYear() + "/" + (date.getMonth() + 1) + "/" + date.getDate();
		}

		public static function toFixed(val:Number,p:int):String{
			var valstr:String = val.toFixed(p);
			if(Number(valstr) - Math.floor(valstr) == 0){
				return val.toFixed(0);
			}
			return valstr;
		}

		public static function getURLParam():Object{
			var url = __JS__("window.location.href");
			var obj:Object = {};
			if(url.lastIndexOf('?') != -1) {
				var params:String = url.split('?')[1];
				var arr:Array = params.split("&");
				for (var i:int = 0; i < arr.length; i++)
				{
					var vo:Object = arr[i];
					obj[vo.split("=")[0]] = vo.split("=")[1];
				}
			}
			return obj;
		}
	}
}

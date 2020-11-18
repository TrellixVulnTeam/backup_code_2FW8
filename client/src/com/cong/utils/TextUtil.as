package com.cong.utils
{
	public class TextUtil
	{
//		private static var getHtmlStr_Pattern:RegExp=/0x/gi;
//		public static const MONST_NAME_GRAY:uint=0XA79E8B;

//		public static function getImgUrl(imgUrl:String):String
//		{
//			return (imgUrl.replace(/\//g, "_"));
//		}

//		public static function getHtmlStr(content:String, color:Object="#ffffff", size:int=12, isNextLine:Boolean=false, face:String="", isBold:Boolean=false, isUnderLine:Boolean=false):String
//		{
//			if (content == null)
//			{
//				return ("");
//			}
//
//			var _local_8:String="";
//			if ((color is String))
//			{
//				color=color.replace(getHtmlStr_Pattern, "#");
//				if (color.charAt(0) != "#")
//				{
//					color=("#" + color);
//				}
//
//			}
//			else
//			{
//				if (color != null && !isNaN(Number(color)))
//				{
//					color=("#" + (color as uint).toString(16));
//				}
//
//			}
//
//			if (isBold)
//			{
//				_local_8=(_local_8 + "<b>");
//			}
//
//			if (isUnderLine)
//			{
//				_local_8=(_local_8 + "<u>");
//			}
//
//			_local_8=(_local_8 + "<font ");
//			if (face != "")
//			{
//				_local_8=(_local_8 + (("face ='" + face) + "' "));
//			}
//
//			if (size != -1)
//			{
//				_local_8=(_local_8 + (("size = '" + size.toString()) + "' "));
//			}
//
//			if (color != null)
//			{
//				_local_8=(_local_8 + (("color='" + color.toString()) + "'"));
//			}
//
//			_local_8=(_local_8 + ">");
//			_local_8=(_local_8 + content);
//			_local_8=(_local_8 + "</font>");
//			if (isBold)
//			{
//				_local_8=(_local_8 + "</b>");
//			}
//
//			if (isUnderLine)
//			{
//				_local_8=(_local_8 + "</u>");
//			}
//
//			if (isNextLine)
//			{
//				_local_8=(_local_8 + "<br>");
//			}
//
//			return (_local_8);
//		}

//		public static function getColorHtml(txt:String, color:String, size:int=12):String
//		{
//			if (txt == null)
//			{
//				return ("");
//			}
//
//			return ((((((("<font color='" + color) + "' size='") + size) + "' >") + txt) + "</font>"));
//		}

//		public static function changeSecondToTimeStr(_second:Number):String
//		{
//			var _local_4:int;
//			var _local_7:int=(_second / 3600);
//			var _local_2:int=((_second - (3600 * _local_7)) / 60);
//			_local_4=(((_second - (3600 * _local_7)) - (60 * _local_4)) % 60);
//			var _local_3:String="";
//			if (_local_7 > 0)
//			{
//				_local_3=(((_local_7) < 10) ? (("0" + _local_7) + ":") : (_local_7 + ":"));
//			}
//
//			var _local_5:String=(((_local_2) < 10) ? ("0" + _local_2) : _local_2.toString());
//			var _local_6:String=(((_local_4) < 10) ? ("0" + _local_4) : _local_4.toString());
//			return ((((_local_3 + _local_5) + ":") + _local_6));
//		}


//		public static function changeServerTimeToSeconds(_second:Number):Number
//		{
//			var _local_3:Date=new Date(_second);
//			return ((((_local_3.getHours() * 3600) + (_local_3.getMinutes() * 60)) + _local_3.getSeconds()));
//		}


//		public static function changeDateToSpecStr(_date:Date, index:int=0, isOnlyDay:Boolean=false):String
//		{
//			var _local_5:String="";
//			var _minutes:int=0;
//			var _local_4:int;
//			if (index < 1)
//			{
//				_local_5=((_local_5 + _date.getFullYear()) + "-");
//			}
//
//			if (index < 2)
//			{
//				_local_5=((_local_5 + (_date.getMonth() + 1)) + "-");
//			}
//
//			if (index < 3)
//			{
//				_local_5=((_local_5 + _date.getDate()) + " ");
//			}
//
//			if (isOnlyDay)
//			{
//				return (_local_5);
//			}
//
//			_local_5=(_local_5 + _date.getHours());
//			_minutes=_date.getMinutes();
//			if (_minutes < 10)
//			{
//				_local_5=(_local_5 + (":0" + _minutes));
//			}
//			else
//			{
//				_local_5=(_local_5 + (":" + _minutes));
//			}
//
//			if (index != 4)
//			{
//				_local_4=_date.getSeconds();
//				if (_local_4 < 10)
//				{
//					_local_5=(_local_5 + (":0" + _local_4));
//				}
//				else
//				{
//					_local_5=(_local_5 + (":" + _local_4));
//				}
//
//			}
//
//			return (_local_5);
//		}
//
//		public static function timeToMilSeconds(hours:int=0, minutes:int=0, seconds:int=0):Number
//		{
//			var _local_4:Number=((((hours * 3600) + (minutes * 60)) + seconds) * 1000);
//			return (_local_4);
//		}


		public static function formatNumber(value:Number):String
		{
			var _local_5:Array=value.toString().split(".");
			var _local_2:String="";
			if (_local_5.length > 1)
			{
				_local_2=_local_5[1];
			}

			var _local_4:String="";
			var _local_8:Array=_local_5[0].split("");
			var _local_7:int=_local_8.length;
			if (_local_7 <= 3)
			{
				return (value.toString());
			}

			var _local_6:int=3;
			_local_5=[];
			var _local_3:int;
			while (_local_3 < _local_7)
			{
				if (((((_local_3 % _local_6) == 0)) && ((_local_3 > 0))))
				{
					_local_5.push(",");
				}

				_local_5.push(_local_8.pop());
				_local_3++;
			}

			_local_5.reverse();
			_local_3=0;
			_local_7=_local_5.length;
			while (_local_3 < _local_7)
			{
				_local_4=(_local_4 + _local_5[_local_3]);
				_local_3++;
			}

			if (_local_2 != "")
			{
				_local_4=(_local_4 + ("." + _local_2));
			}
			else
			{
				_local_4=(_local_4 + _local_2);
			}

			return (_local_4);
		}

//		public static function addColor(context:String, color:String):String
//		{
//			return ((((("<font color='" + color) + "'>") + context) + "</font>"));
//		}

		public static function conectParam(context:String, strList:Array):String
		{
			var i:int = 0;
			if (strList == null)
			{
				return context;
			}

			if (context == null)
			{
				return null;
			}

			while (i < strList.length)
			{
				var reg:RegExp = new RegExp("{.+?}");
				context=context.replace(reg, strList[i]);
				i++;
			}
			return context;
		}

//		public static function conectValue(context:String, strList:Array):String
//		{
//			var _local_3:int;
//			if (strList == null)
//			{
//				return (context);
//			}
//
//			if (context == null)
//			{
//				return (null);
//			}
//
//			while (_local_3 < strList.length)
//			{
//				context=context.replace("#value#", strList[_local_3]);
//				_local_3++;
//			}
//
//			return (context);
//		}

//		public static function strToArr(str:String):Array
//		{
//			return str.split("");
//		}

//		public static function getResPath(path:String):String
//		{
//			var _local_2:RegExp=new RegExp("/", "g");
//			return (path.replace(_local_2, "_"));
//		}
//
//		public static function createLinkStr(evtInfo:String, linkName:String, underline:Boolean=true):String
//		{
//			var _local_4:String="";
//			if (underline)
//			{
//				_local_4=(_local_4 + "<u>");
//			}
//
//			_local_4=(_local_4 + (((("<a href='event:" + evtInfo) + "'>") + linkName) + "</a>"));
//			if (underline)
//			{
//				_local_4=(_local_4 + "</u>");
//			}
//
//			return (_local_4);
//		}

//		public static function isCn(info:String):Boolean
//		{
//			var _local_2:RegExp=/^[一-龟]+$/;
//			return (_local_2.test(info));
//		}
//
//		public static function isCnEn(chatName:String):Boolean
//		{
//			var _local_2:RegExp=/^[a-zA-Z一-龟0-9]+$/;
//			return (_local_2.test(chatName));
//		}



//		public static function formatStr(info:String, repList:Array=null):String
//		{
//			var _local_4:int;
//			if ((((repList == null)) || ((info == null))))
//			{
//				return (info);
//			}
//
//			info=LanUtil.getLanStr(info);
//			if (repList == null)
//			{
//				return (info);
//			}
//
//			var _local_3:int=repList.length;
//			while (_local_4 < _local_3)
//			{
//				info=info.replace("{@}", repList[_local_4]);
//				_local_4++;
//			}
//
//			return (info);
//		}

//		public static function conectParamV(info1:String, info2List:Vector.<String>):String
//		{
//			if (info2List == null)
//			{
//				return (info1);
//			}
//
//			if (info1 == null)
//			{
//				return (null);
//			}
//
//			var _local_4:int;
//			var _local_3:int=info2List.length;
//			while (_local_4 < _local_3)
//			{
//				info1=info1.replace("{@}", info2List[_local_4]);
//				_local_4++;
//			}
//
//			return (info1);
//		}


//		public static function getTextLimitLen(info:String, len:int=12):String
//		{
//			var _local_3:Byte=toByte(info);
//			return (_local_3.readUTFBytes(len));
//		}



//		public static function addStrChangeLine(info:String, len:int):String
//		{
//			var _local_6:int;
//			var _local_3:String="";
//			var _local_5:Array=splitStrByLen(info, len);
//			var _local_4:int=_local_5.length;
//			while (_local_6 < _local_4)
//			{
//				_local_3=(_local_3 + (_local_5[_local_6] + "\r"));
//				_local_6++;
//			}
//
//			return (_local_3);
//		}

//		public static function splitStrByLen(info:String, len:int):Array
//		{
//			return (splitStrByPixel(info, (len * 6)));
//		}

//		public static function splitStrByPixel(info:String, pWidth:int):Array
//		{
//			var _local_7:int;
//			if (info == null)
//			{
//				return ([]);
//			}
//
//			var _local_4:Array=[];
//			var _local_3:int;
		/*	var _local_6:GTextField=new GTextField();
			_local_6.text="";
			var _local_5:int=info.length;
			while (_local_7 < _local_5)
			{
				_local_6.text=(_local_6.content + info.charAt(_local_7));
				if (_local_6.textWidth > pWidth)
				{
					_local_4.push(info.substring(_local_3, (_local_7 + 1)));
					_local_6.text="";
					_local_3=(_local_7 + 1);
				}

				_local_7++;
			}

			if (_local_6.text != "")
			{
				_local_4.push(_local_6.text);
			}
*/
//			return (_local_4);
//		}

/*
		public static function getTxtPixW(info:String):int
		{
			var _local_2:GTextField=new GTextField();
			_local_2.textalign=0;
			_local_2.text=info;
			return (_local_2.textWidth);
		}
*/

//		public static function padLeft(info1:String, info2:String, len:int):String
//		{
//			while (info1.length < len)
//			{
//				info1=(info2 + info1);
//			}
//
//			return (info1);
//		}

//		public static function padRight(info1:String, info2:String, len:int):String
//		{
//			while (info1.length < len)
//			{
//				info1=(info1 + info2);
//			}
//
//			return (info1);
//		}

//		public static function compareStrPinyin(info1:String, info2:String):int
//		{
//			var _local_4:Number;
//			var _local_3:Number;
//			var _local_5:int;
//			if (info1.length == _local_5)
//			{
//				if (info2.length == _local_5)
//				{
//					return (0);
//				}
//
//				if (info2.length > _local_5)
//				{
//					return (1);
//				}
//
//			}
//
//			if (info2.length == _local_5)
//			{
//				return (-1);
//			}
//
//			_local_4=info1.charCodeAt(_local_5);
//			_local_3=info2.charCodeAt(_local_5);
//			if (_local_4 > _local_3)
//			{
//				return (1);
//			}
//
//			if (_local_4 < _local_3)
//			{
//				return (-1);
//			}
//
//			return (0);
//		}

//		public static function compare(d1:String, d2:String):int
//		{
//			return (PinYin.sortPinYin(PinYin.toNewPinYin(d1), PinYin.toNewPinYin(d2)));
//		}
//
//		public static function isNumber(info:String, _arg2:int=-1):Boolean
//		{
//			var regExp:RegExp=new RegExp(/^-?(\d|,)*[\.]?\d*$/);
//			if (_arg2 > 0)
//			{
//				regExp=new RegExp("^-?(\\d|,)*\\.\\d{" + _arg2.toString() + "}$");
//
//				return regExp.test(info);
//			}
//
//			return regExp.test(info);
//		}
//
//		public static function clearSpaceEnter(info:String):String
//		{
//			return (clearEnter(clearSpace(info)));
//		}
//
//		public static function clearBackSpaceEnter(info:String):String
//		{
//			return (clearEnter(clearBackSpace(info)));
//		}
//
//		public static function toSBC(str:String, alsoSpace:Boolean=true):String
//		{
//			var _local_3:int;
//			var _local_4:Array=str.split("");
//			var _local_5:int=_local_4.length;
//			while (--_local_5 > -1)
//			{
//				_local_3=str.charCodeAt(_local_5);
//				if ((((32 == _local_3)) && (alsoSpace)))
//				{
//					_local_4[_local_5]=String.fromCharCode(0x3000);
//				}
//				else
//				{
//					if ((((_local_3 >= 33)) && ((_local_3 <= 126))))
//					{
//						_local_4[_local_5]=String.fromCharCode((_local_3 + 65248));
//					}
//
//				}
//
//			}
//
//			return (_local_4.join(""));
//		}



//		public static function getLinkTxt(text:String, eventTxt:String):String
//		{
//			return ((((('<u><a href="event:' + eventTxt) + '">') + text) + "</a></u>"));
//		}
//
//		public static function numToHtmlC(colorInt:uint):String
//		{
//			return (("#" + colorInt.toString(16)));
//		}
//
//		public static function createNetLink(showName:String, showUrl:String):String
//		{
//			showUrl=(((16).toString() + "_") + showUrl);
//			return ((((('<A HREF="event:' + showUrl) + '">') + showName) + "</A>"));
//		}
//
//		public static function getColorFromHtml(info:String):uint
//		{
//			var _local_2:Array=info.split("#");
//			if (_local_2.length <= 1)
//			{
//				return (14604487);
//			}
//
//			return int(("0x" + _local_2[1]).substr(0, 6));
//		}
//
//		private function hasNumLetter(info:String):Boolean
//		{
//			var _local_2:String=null;
//			var _local_4:int;
//			var _local_3:int=info.length;
//			_local_4=0;
//			while (_local_4 < _local_3)
//			{
//				_local_2=info.charAt(_local_4);
//				if ((((_local_2 >= "a")) && ((_local_2 <= "z"))))
//				{
//					return (true);
//				}
//				if ((((_local_2 >= "A")) && ((_local_2 <= "Z"))))
//				{
//					return (true);
//				}
//				if (!isNaN(Number(_local_2)))
//				{
//					return (true);
//				}
//				_local_4++;
//			}
//			return (false);
//		}

//		public static function secondToHMS(totalTime:Number, isContainsSec:Boolean=true, showChinese:Boolean=true, fullShow:Boolean=false):String
//		{
//			totalTime=(totalTime / 1000);
//			var _local_6:int=3600;
//			var _local_9:int=60;
//			var _local_8:int=(totalTime / _local_6);
//			totalTime=(totalTime % _local_6);
//			var _local_10:int=(totalTime / _local_9);
//			var _local_5:int=(totalTime % _local_9);
//			var _local_7:String="";
//			if (_local_8 != 0)
//			{
//				if (showChinese)
//				{
//					_local_7=(_local_7 + (_local_8 + Language_zh_TW.TIME_HOUR));
//				}
//				else
//				{
//					_local_7=(_local_7 + (_local_8 + ":"));
//				}
//
//			}
//			else
//			{
//				if (fullShow)
//				{
//					if (showChinese)
//					{
//						_local_7=(_local_7 + ("0" + Language_zh_TW.TIME_HOUR));
//					}
//					else
//					{
//						_local_7=(_local_7 + "00:");
//					}
//
//				}
//
//			}
//
//			if (((!((_local_10 == 0))) || (!((_local_8 == 0)))))
//			{
//				if (_local_10 < 10)
//				{
//					_local_7=(_local_7 + ("0" + _local_10));
//				}
//				else
//				{
//					_local_7=(_local_7 + _local_10);
//				}
//
//				if (showChinese)
//				{
//					_local_7=(_local_7 + Language_zh_TW.TIME_MINUTE);
//				}
//				else
//				{
//					_local_7=(_local_7 + ":");
//				}
//
//			}
//			else
//			{
//				if (fullShow)
//				{
//					if (showChinese)
//					{
//						_local_7=(_local_7 + ("0" + Language_zh_TW.TIME_MINUTE));
//					}
//					else
//					{
//						_local_7=(_local_7 + "00:");
//					}
//
//				}
//
//			}
//
//			if (!isContainsSec)
//			{
//				return (_local_7);
//			}
//
//			if (!_local_5 == 0 || !_local_8 == 0 || !_local_10 == 0)
//			{
//				if (_local_5 < 10)
//				{
//					_local_7=(_local_7 + ("0" + _local_5));
//				}
//				else
//				{
//					_local_7=(_local_7 + _local_5);
//				}
//
//				if (showChinese)
//				{
//					_local_7=(_local_7 + Language_zh_TW.TIME_SECONDS);
//				}
//
//			}
//
//			if (_local_7 == "")
//			{
//				_local_7=("00" + Language_zh_TW.TIME_SECONDS);
//			}
//
//			return (_local_7);
//		}

//		/**
//		 * 去掉html标签 "<"和">"
//		 * */
//		public static function removeHTMLTag(info:String):String
//		{
//			return info.replace(/<.*?>/g, "");
//		}
//
//		/**
//		 * 获取文本的byte长度
//		 * */
//		public static function getTextByteLen(info:String):int
//		{
//			return toByte(info).length;
//		}


//		/**
//		 * 把字符串转换成Byte
//		 * */
//		public static function toByte(info:String):Byte
//		{
//			var byte:Byte=new Byte();
//			byte.writeUTFBytes(info);
//			byte.pos=0;
//			return byte;
//		}
//
//		/**
//		 * 清楚前后空格
//		 * */
//		public static function clearSpace(info:String):String
//		{
//			var reg1:RegExp=/^\s*/g;
//			var reg2:RegExp=/\s*$/g;
//			return info.replace(reg1, "").replace(reg2, "");
//		}
//
//		/**
//		 * 清楚前空格
//		 * */
//		public static function clearFrontSpace(info:String):String
//		{
//			var reg:RegExp=/^\s*/g;
//			return info.replace(reg, "");
//		}
//
//		/**
//		 * 清楚后空格
//		 * */
//		public static function clearBackSpace(info:String):String
//		{
//			var reg:RegExp=/\s*$/g;
//			return (info.replace(reg, ""));
//		}
//
//		/**
//		 * 清楚所有空格
//		 * */
//		public static function clearAllSpace(info:String):String
//		{
//			return toDBC(info).split(" ").join("");
//		}

//		public static function toDBC(str:String, alsoSpace:Boolean=true):String
//		{
//			var strCode:int;
//			var strArray:Array=str.split("");
//			var len:int=strArray.length;
//			while (--len > -1)
//			{
//				strCode=str.charCodeAt(len);
//				if ((0x3000 == strCode) && (alsoSpace))
//				{
//					strArray[len]=String.fromCharCode(32);
//				}
//				else
//				{
//					if ((strCode >= 65281) && (strCode <= 65374))
//					{
//						strArray[len]=String.fromCharCode((strCode - 65248));
//					}
//				}
//			}
//			return strArray.join("");
//		}


//		/**
//		 * 清除回车换行
//		 * */
//		public static function clearEnter(info:String):String
//		{
//			return info.split("\n").join("");
//		}

//		/**
//		 *根据等级获得等级差颜色
//		 * @param compareLevel
//		 * @param level
//		 * @return
//		 *
//		 */
//		public static function getLevelDifferenceColor(compareLevel:int, level:int):uint
//		{
//			var colorValue:uint;
//			var levelPoor:int=compareLevel - level;
//			if (levelPoor <= -10)
//			{
//				colorValue=MONST_NAME_GRAY;
//			}
//			else
//			{
//				if (levelPoor < -5)
//				{
//					colorValue=0xffffff;
//				}
//				else
//				{
//					if(levelPoor>=-5&&levelPoor<=5)
//					{
//						colorValue=0x3bde1b;
//					}
//					else if (levelPoor > 5&&levelPoor<=10)
//					{
//						colorValue=0xFFCC00;
//					}
//					else if (levelPoor > 10)
//					{
//						colorValue=0xFF3333;
//					}
//				}
//			}
//			return colorValue;
//		}
	}
}


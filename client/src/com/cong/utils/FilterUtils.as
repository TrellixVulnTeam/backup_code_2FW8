package com.cong.utils
{
	import laya.filters.ColorFilter;

	public class FilterUtils
	{
//		public static var ALPHA_YELLO_FILTER:Array = [new GlowFilter(0xFFCC66, 1, 2, 2, 2)];
//		public static var BLACK_FILTER:Array = [new GlowFilter(0x0, 1, 2, 2, 2)];
//		public static var GRAY_FILTERS:Array = [new ColorMatrixFilter([0.3086, 0.6093, 0.082, 0, 0, 0.3086, 0.6093, 0.082, 0, 0, 0.3085, 0.6093, 0.0819, 0, 0, 0, 0, 0, 1, 0])];
//		public static var HIGHT_LIGHT_FILTERS:Array = [new ColorMatrixFilter([1.059, 0, 0, 0, 5.73, 0, 1.059, 0, 0, 5.73, 0, 0, 1.059, 0, 5.73, 0, 0, 0, 1, 0])];
//		public static var WHITE_FILTER:Array = [new GlowFilter(0xFFffff, 1, 2, 2, 2)];
//		public static var _lifeFilter:ColorMatrixFilter;
//		public static var m_Poisonfilters:ColorMatrixFilter;
//		public static var m_stableFilters:ColorMatrixFilter;
//		private static var HightLightft:ColorMatrixFilter;
//		private static var blackFilter:ColorMatrixFilter;
//		private static var bloodFilter:ColorMatrixFilter;
//		private static var blueFilter:ColorMatrixFilter;
//		private static var deathFilter:ColorMatrixFilter;
//		private static var dragonLineNo:GlowFilter;
//		private static var dragonLineOk:BlurFilter;
//		private static var dragonLineOk2:GlowFilter;
//		private static var equipPosGlow:GlowFilter;
//		private static var grayFilter:ColorMatrixFilter;
//		private static var gridSelGlow:GlowFilter;
		private static var highLightFilter:ColorFilter;
//		private static var imgNumGlow:GlowFilter;
//
//
//		private static var itemGridGlow:GlowFilter;
//		private static var jumpDownFilter:ColorMatrixFilter;
//		private static var lightFilter:ColorMatrixFilter;
//		private static var lineStartGlow:GlowFilter = null;
//		private static var litteBlueGlowFilter:GlowFilter;
//		private static var petGridGlow:GlowFilter;
//		private static var redFilter:ColorMatrixFilter;
//		private static var taskStartGlow:GlowFilter = null;
//		private static var taskStartGlow2:GlowFilter = null;
//		private static var tipsFilter:ColorMatrixFilter;
//		private static var trumpetTextGlow:GlowFilter;
//		private static var uiObjSelGlow:GlowFilter;
//		private static var whiteFilter:ColorMatrixFilter;
//		private static var yellowFilter:GlowFilter;

//		public static function addBlackGlow(isAdd:Boolean, item:DisplayObject):void
//		{
//			if (isAdd)
//			{
//				var _local_3:GlowFilter = new GlowFilter(0, 0.8, 2, 2, 4);
//				item.filters = [_local_3];
//			} else
//			{
//				item.filters = [];
//			}
//		}
//
//		public static function addFilter(_arg1:Array, _arg2:Object):Array
//		{
//			var _local_4:int;
//			var _local_5:Array = [_arg2];
//			var _local_3:int = _arg1.length;
//			while (_local_4 < _local_3)
//			{
//				_local_5.push(_arg1[_local_4]);
//				_local_4++;
//			}
//			;
//			return (_local_5);
//		}
//
//		public static function chatTextDropFilter():DropShadowFilter
//		{
//			var _local_1:DropShadowFilter = new DropShadowFilter();
//			_local_1.alpha = 1;
//			_local_1.distance = 1;
//			_local_1.angle = 45;
//			_local_1.color = 0;
//			_local_1.blurX = 1;
//			_local_1.blurY = 1;
//			_local_1.quality = 3;
//			_local_1.strength = 0.6;
//			return (_local_1);
//		}
//
//		public static function chatTextGlowFilter():GlowFilter
//		{
//			var _local_1:GlowFilter = new GlowFilter();
//			_local_1.color = 0x3333;
//			_local_1.alpha = 1;
//			_local_1.blurX = 1;
//			_local_1.blurY = 1;
//			_local_1.strength = 1;
//			_local_1.quality = 3;
//			return (_local_1);
//		}
//
//		public static function clearFilter(_arg1:Array, _arg2:Object):Array
//		{
//			return ([]);
//		}
//
//		public static function getBlackFilter():ColorMatrixFilter
//		{
//
//			if (blackFilter == null)
//			{
//				var _local_1:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
//				blackFilter = new ColorMatrixFilter(_local_1);
//			}
//
//			return (blackFilter);
//		}
//
//		public static function getBloodFilter():ColorMatrixFilter
//		{
//			if (bloodFilter == null)
//			{
//				var _local_1:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
//				bloodFilter = new ColorMatrixFilter(_local_1);
//			}
//			;
//			return (bloodFilter);
//		}
//
//		public static function getBlueFilter():ColorMatrixFilter
//		{
//			if (blueFilter == null)
//			{
//				var _local_1:Array = [0.2, 0, 0, 0, 0, 0, 0.6, 0, 0, 0, 0, 0, 1.5, 0, 130, 0, 0, 0, 1, 0];
//				blueFilter = new ColorMatrixFilter(_local_1);
//			}
//			return (blueFilter);
//		}
//
//		public static function getDeathFilter():ColorMatrixFilter
//		{
//			if (deathFilter == null)
//			{
//				var _local_1:Array = [0.77, 0.77, 0.77, 0, 0, 0.77, 0.77, 0.77, 0, 0, 0.77, 0.77, 0.77, 0, 0, 0, 0, 0, 1, 0];
//				deathFilter = new ColorMatrixFilter(_local_1);
//			}
//			return (deathFilter);
//		}
//
//		public static function getDragonLineNO():Array
//		{
//			if (dragonLineNo == null)
//			{
//				dragonLineNo = new GlowFilter();
//				dragonLineNo.color = 3222303;
//				dragonLineNo.alpha = 1;
//				dragonLineNo.blurX = 4;
//				dragonLineNo.blurY = 4;
//				dragonLineNo.strength = 4;
//				dragonLineNo.quality = 2;
//			}
//			;
//			return ([dragonLineNo]);
//		}
//
//		public static function getDragonLineOK():Array
//		{
//			if (dragonLineOk == null)
//			{
//				dragonLineOk = new BlurFilter(3, 3, 1);
//			}
//			;
//			if (dragonLineOk2 == null)
//			{
//				dragonLineOk2 = new GlowFilter();
//				dragonLineOk2.color = 0;
//				dragonLineOk2.alpha = 1;
//				dragonLineOk2.blurX = 3;
//				dragonLineOk2.blurY = 3;
//				dragonLineOk2.strength = 4;
//				dragonLineOk2.quality = 2;
//			}
//			;
//			return ([dragonLineOk2, dragonLineOk]);
//		}
//
//		public static function getEquipPosGlow():GlowFilter
//		{
//			if (equipPosGlow == null)
//			{
//				equipPosGlow = new GlowFilter();
//				equipPosGlow.color = 0xFFFFFF;
//				equipPosGlow.alpha = 0.8;
//				equipPosGlow.blurX = 8;
//				equipPosGlow.blurY = 8;
//				equipPosGlow.strength = 2;
//				equipPosGlow.quality = 2;
//				equipPosGlow.inner = true;
//			}
//			;
//			return (equipPosGlow);
//		}
//
//		public static function getGrayFilter():ColorMatrixFilter
//		{
//			if (grayFilter == null)
//			{
//				var _local_1:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
//				grayFilter = new ColorMatrixFilter(_local_1);
//			}
//			return (grayFilter);
//		}

		public static function getHighLightFilter():ColorFilter
		{
			if (highLightFilter == null)
			{
				var _local_1:Array = [1.2, 0, 0, 0, 0, 0, 1.2, 0, 0, 0, 0, 0, 1.2, 0, 0, 0, 0, 0, 1, 0];
				highLightFilter = new ColorFilter(_local_1);
			}
			return (highLightFilter);
		}
//
//		public static function getHightLightFilter():ColorMatrixFilter
//		{
//			if (HightLightft == null)
//			{
//				var _local_1:Array = [1.2, 0, 0, 0, 0, 0, 1.2, 0, 0, 0, 0, 0, 1.2, 0, 0, 0, 0, 0, 1, 0];
//				HightLightft = new ColorMatrixFilter(_local_1);
//			}
//			;
//			return (HightLightft);
//		}
//
//		public static function getHightLightFilter2():ColorMatrixFilter
//		{
//			if (HightLightft == null)
//			{
//				var _local_1:Array = [1.4, 0, 0, 0, 0, 0, 1.4, 0, 0, 0, 0, 0, 1.4, 0, 0, 0, 0, 0, 1, 0];
//				HightLightft = new ColorMatrixFilter(_local_1);
//			}
//			;
//			return (HightLightft);
//		}
//
//		public static function getImgNumGlow():GlowFilter
//		{
//			if (imgNumGlow == null)
//			{
//				imgNumGlow = new GlowFilter();
//				imgNumGlow.color = 11513651;
//				imgNumGlow.alpha = 1;
//				imgNumGlow.blurX = 8;
//				imgNumGlow.blurY = 8;
//				imgNumGlow.strength = 3;
//				imgNumGlow.quality = 2;
//			}
//			;
//			return (imgNumGlow);
//		}
//
//		public static function getItemGridGlow():GlowFilter
//		{
//			if (itemGridGlow == null)
//			{
//				itemGridGlow = new GlowFilter();
//				itemGridGlow.color = 16777011;
//				itemGridGlow.alpha = 1;
//				itemGridGlow.blurX = 8;
//				itemGridGlow.blurY = 8;
//				itemGridGlow.strength = 5;
//				itemGridGlow.quality = 2;
//			}
//			;
//			return (itemGridGlow);
//		}
//
//		public static function getJumpDownFilter():ColorMatrixFilter
//		{
//			if (jumpDownFilter == null)
//			{
//				var _local_1:Array = [2.9, 0.6, 0, 0, -61.5, 0.6, 2.9, 0, 0, -61.5, 0.1, 0.2, 2.8, 0, -61.5, 0, 0, 0, 1, 0];
//				jumpDownFilter = new ColorMatrixFilter(_local_1);
//			}
//			return (jumpDownFilter);
//		}
//
//		public static function getLightFilter():ColorMatrixFilter
//		{
//			if (lightFilter == null)
//			{
//				lightFilter = new ColorMatrixFilter();
//				var _local_1:ColorMatrix = new ColorMatrix();
//				_local_1.SetBrightnessMatrix(50);
//				lightFilter.matrix = _local_1.GetFlatArray();
//			}
//			return (lightFilter);
//		}
//
//		public static function getLineStartFilter():GlowFilter
//		{
//			if (lineStartGlow == null)
//			{
//				lineStartGlow = new GlowFilter();
//				lineStartGlow.color = 15636855;
//				lineStartGlow.blurX = 4;
//				lineStartGlow.blurY = 4;
//				lineStartGlow.strength = 4;
//				lineStartGlow.quality = 2;
//			}
//			;
//			return (lineStartGlow);
//		}
//
//		public static function getLitteBlueGlowFilter():GlowFilter
//		{
//			if (litteBlueGlowFilter == null)
//			{
//				litteBlueGlowFilter = new GlowFilter();
//				litteBlueGlowFilter.color = 12320767;
//				litteBlueGlowFilter.alpha = 1;
//				litteBlueGlowFilter.blurX = 2;
//				litteBlueGlowFilter.blurY = 2;
//				litteBlueGlowFilter.strength = 4;
//				litteBlueGlowFilter.alpha = 1;
//				litteBlueGlowFilter.quality = 2;
//			}
//			return (litteBlueGlowFilter);
//		}
//
//		public static function getMicFilterByColor(value:uint, alpha:Number = 1, blurX:Number = 8, blurY:Number = 8, strength:Number = 2):GlowFilter
//		{
//			return (new GlowFilter(value, alpha, blurX, blurY, strength));
//		}
//
//		public static function getPetGridGlow():GlowFilter
//		{
//			if (petGridGlow == null)
//			{
//				petGridGlow = new GlowFilter();
//				petGridGlow.color = 12320767;
//				petGridGlow.alpha = 1;
//				petGridGlow.blurX = 8;
//				petGridGlow.blurY = 8;
//				petGridGlow.strength = 4;
//				petGridGlow.alpha = 1;
//				petGridGlow.quality = 2;
//			}
//			;
//			return (petGridGlow);
//		}
//
//		public static function getRedFilter():ColorMatrixFilter
//		{
//			if (redFilter == null)
//			{
//				var _local_1:Array = [1.5, 0, 0, 0, 120, 0, 0.4, 0, 0, 0, 0, 0, 0.3, 0, 0, 0, 0, 0, 1, 0];
//				redFilter = new ColorMatrixFilter(_local_1);
//			}
//			;
//			return (redFilter);
//		}
//
//		public static function getSelGridFilter():GlowFilter
//		{
//			if (gridSelGlow == null)
//			{
//				gridSelGlow = new GlowFilter();
//				gridSelGlow.color = 14604487;
//				gridSelGlow.alpha = 0.5;
//				gridSelGlow.blurX = 2;
//				gridSelGlow.blurY = 2;
//				gridSelGlow.strength = 2;
//				gridSelGlow.quality = 2;
//			}
//			;
//			return (gridSelGlow);
//		}
//
//		public static function getSplashWhiteFilter():ColorMatrixFilter
//		{
//			if (whiteFilter == null)
//			{
//				var _local_1:Array = [6, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1, 0];
//				whiteFilter = new ColorMatrixFilter(_local_1);
//			}
//			;
//			return (whiteFilter);
//		}
//
//		public static function getTaskStartFilter():GlowFilter
//		{
//			if (taskStartGlow == null)
//			{
//				taskStartGlow = new GlowFilter();
//				taskStartGlow.color = 10231282;
//				taskStartGlow.blurX = 8;
//				taskStartGlow.blurY = 8;
//				taskStartGlow.strength = 4;
//				taskStartGlow.quality = 2;
//			}
//			return (taskStartGlow);
//		}
//
//		public static function getTaskStartFilter2():GlowFilter
//		{
//			if (taskStartGlow2 == null)
//			{
//				taskStartGlow2 = new GlowFilter();
//				taskStartGlow2.color = 14489847;
//				taskStartGlow2.blurX = 4;
//				taskStartGlow2.blurY = 4;
//				taskStartGlow2.strength = 4;
//				taskStartGlow2.quality = 2;
//			}
//			return (taskStartGlow2);
//		}
//
//		public static function getTextFilter():GlowFilter
//		{
//			var _local_3:Number = 0;
//			var _local_4:Number = 0.8;
//			var _local_5:Number = 2;
//			var _local_1:Number = 2;
//			var _local_2:Number = 8;
//			return (new GlowFilter(_local_3, _local_4, _local_5, _local_1, _local_2));
//		}
//
//		public static function getTipsFilter():ColorMatrixFilter
//		{
//			if (tipsFilter == null)
//			{
//				var _local_1:Array = [1, 0, 0, 0, 60, 0, 1, 0, 0, 66, 0, 0, 1, 0, 60, 0, 0, 0, 1, 0];
//				tipsFilter = new ColorMatrixFilter(_local_1);
//			}
//			return (tipsFilter);
//		}
//
//		public static function getTreeFruitGlow():GlowFilter
//		{
//			if (itemGridGlow == null)
//			{
//				itemGridGlow = new GlowFilter();
//				itemGridGlow.color = 5746411;
//				itemGridGlow.alpha = 0.7;
//				itemGridGlow.blurX = 10;
//				itemGridGlow.blurY = 10;
//				itemGridGlow.strength = 3;
//				itemGridGlow.quality = 2;
//			}
//			return (itemGridGlow);
//		}
//
//		public static function getTrumpetTextFilter():GlowFilter
//		{
//			if (trumpetTextGlow == null)
//			{
//				trumpetTextGlow = new GlowFilter();
//				trumpetTextGlow.color = 0xFFFFFF;
//				trumpetTextGlow.alpha = 0.8;
//				trumpetTextGlow.blurX = 16;
//				trumpetTextGlow.blurY = 16;
//				trumpetTextGlow.strength = 2;
//				trumpetTextGlow.quality = 2;
//			}
//			;
//			return (trumpetTextGlow);
//		}
//
//		public static function getUiObjSelGlowFilter():GlowFilter
//		{
//			if (uiObjSelGlow == null)
//			{
//				uiObjSelGlow = new GlowFilter();
//				uiObjSelGlow.color = 16777011;
//				uiObjSelGlow.alpha = 1;
//				uiObjSelGlow.blurX = 4;
//				uiObjSelGlow.blurY = 4;
//				uiObjSelGlow.strength = 5;
//				uiObjSelGlow.quality = 2;
//			}
//			return (uiObjSelGlow);
//		}
//
//		public static function getYellowFilter(blurValue:int = 4):GlowFilter
//		{
//			if (yellowFilter == null)
//			{
//				yellowFilter = new GlowFilter(0xFFFF00, 0.6, blurValue, blurValue, 4);
//			}
//			return (yellowFilter);
//		}
//
//		public static function get lifeFilter():ColorMatrixFilter
//		{
//			if (_lifeFilter == null)
//			{
//				_lifeFilter = getHightLightFilter();
//			}
//			return (_lifeFilter);
//		}
//
//		public static function moneyGlowFilter():GlowFilter
//		{
//			var _local_1:GlowFilter = new GlowFilter();
//			_local_1.color = 8352853;
//			_local_1.alpha = 1;
//			_local_1.blurX = 2;
//			_local_1.blurY = 2;
//			_local_1.strength = 1;
//			_local_1.quality = 3;
//			return (_local_1);
//		}
//
//		public static function get poisonFilter():ColorMatrixFilter
//		{
//			if (m_Poisonfilters == null)
//			{
//				m_Poisonfilters = new ColorMatrixFilter([0, 0, 0, 0, 0, 0.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
//			}
//			return (m_Poisonfilters);
//		}
//
//		public static function get stableFilter():ColorMatrixFilter
//		{
//			if (m_stableFilters == null)
//			{
//				m_stableFilters = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);
//			}
//			return (m_stableFilters);
//		}
//
//
//		public static function startFlash(dis:DisplayObject, color:uint = 0xFFFFFF, currBlurX:int = 5, maxBlurX:int = 5, minBlurX:int = 2, streng:int = 10):void
//		{
//			var tweenVar:TweenLiteVars = new TweenLiteVars();
//			tweenVar.glowFilter = new GlowFilterVars(currBlurX, currBlurX, color, 1, 10);
//			tweenVar.onComplete = startFlash;
//			tweenVar.onCompleteParams = [dis, color, currBlurX >= maxBlurX ? minBlurX : maxBlurX]
//			TweenMax.to(dis, 0.3, tweenVar);
//		}
//
//		public static function stopFlash(dis:DisplayObject, toBlurX:int = 0):void
//		{
//			TweenMax.killTweensOf(dis);
//			var tweenVar:TweenLiteVars = new TweenLiteVars();
//			tweenVar.glowFilter = new GlowFilterVars(toBlurX, toBlurX);
//			TweenMax.to(dis, 0.3, tweenVar);
//
//		}
//
//		private var moneyGlow:GlowFilter = null;
	}
}

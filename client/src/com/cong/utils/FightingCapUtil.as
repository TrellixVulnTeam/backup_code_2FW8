package com.cong.utils
{
	public class FightingCapUtil
	{
		public function FightingCapUtil()
		{
		}

		/**
		 * 根据属性转换战斗力
		 * */
		public static function fightingTransform(hp_:int, pow_:int, def_:int, hit_:int, dodge_:int, crit_:int, toughness_:int):uint
		{
			return uint(hp_ * CONST_FightWeight.HP + pow_ * CONST_FightWeight.POW + def_ * CONST_FightWeight.DEF + hit_ * CONST_FightWeight.HIT + dodge_ * CONST_FightWeight.DODGE + crit_ * CONST_FightWeight.CRIT + toughness_ * CONST_FightWeight.TOUGHNESS);
		}
	}
}
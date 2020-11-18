package com.cong.utils
{
	import laya.maths.Point;

	public class MountUtil
	{

		public static var mountUid:Number = 20000000;

		public function MountUtil()
		{
		}

		public static function isMountHide(mountV_:MountActor):Boolean
		{
			var gamePlayer:GameMapPlayer = D_Map.instance.getAliveUnitByObjId(mountV_.ownerId) as GameMapPlayer;

			if (gamePlayer == null)
			{
				return false;
			}
			if (C_Player.instance.selfPlayer && mountV_.ownerId == C_Player.instance.selfPlayer.objID)
			{
				return false;
			}

			return true;
		}

		public static function getMountOriginPos(ownerSitType:int, ownerPos_:Point, dis:int = 3):Point
		{
			var tempOwnerPos:Point = ownerPos_.clone();
			switch (ownerSitType)
			{
				case 1:
					tempOwnerPos.x = ownerPos_.x - 1;
					tempOwnerPos.y = ownerPos_.y;
					break;
				case 2:
					tempOwnerPos.x = ownerPos_.x - 1;
					tempOwnerPos.y = ownerPos_.y - dis;
					break;
				case 3:
					tempOwnerPos.x = ownerPos_.x - 1;
					tempOwnerPos.y = ownerPos_.y + dis;
					break;
			}
			return tempOwnerPos;
		}

	}
}
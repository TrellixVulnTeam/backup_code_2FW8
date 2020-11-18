package game.view.map
{
	import game.constants.CONST_FILE;

	import ui.map.BuildingSkinItemUI;

	public class BuildSkinItem extends BuildingSkinItemUI
	{
		public function BuildSkinItem()
		{
		}

		override public function set dataSource(value:*):void
		{
			if(value){
				super.dataSource = value;
				icon.skin = CONST_FILE.getBuildSkin(value.SkinId,value.SkinLv);
			}
		}
	}
}

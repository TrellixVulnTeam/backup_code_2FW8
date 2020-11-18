package game.config
{
	import laya.utils.Browser;

	public class GameConfig
	{

		public static var data:Object;
		//public static var versionContent:String;

		/**
		 *游戏版本号
		 */
		public static var version:String;

		public static function initData(fileName_:String, obj:*):void
		{
			var timerNum:Number = Browser.now();
			var desc:String = "";

			switch (fileName_)
			{
				case "config":
					data = obj;
					desc = "客户端总配置表";
//					initVersionInfo();
					break;
				case "server":
					ConfigServer.init(obj);
					break;
				case "notice":
					ConfigNotice.init(obj);
					break;
				case "HouseType":
					ConfigHouseType.init(obj);
					break;
				case "HouseSkin":
					ConfigHouseSkin.init(obj);
					break;
				case "StopPointEvent":
					ConfigStayEvent.init(obj);
					break;
				case "UserGrowUp":
					ConfigUserGrowUp.init(obj);
					break;
				case "PlayerTalk":
					ConfigActorSpeak.init(obj);
					break;
					case "ShopType":
					ConfigEstateType.init(obj);
					break;
				case "Buyer":
					ConfigBuyer.init(obj);
					break;
				case "GameChest":
					ConfigGameChest.init(obj);
					break;
				case "WorkerGrowUp":
					ConfigWorkerGrowUp.init(obj);
					break;
				case "ShopGrowUp":
					ConfigShopGrowUp.init(obj);
					break;
				case "DisableWords":
					ConfigDisableWords.init(obj);
					break;
				case "UserName":
					ConfigUserName.init(obj);
					break;
				default:
					break;
			}
			console.log("GameConfig:" + "加载配置：" + fileName_);
		}

		/*
				private static function initVersionInfo():void
				{
					var versionInfo:Object=data["versionInfo"];
					versionContent="";

					if (versionInfo != null)
					{
						isDialog=versionInfo[0]["isDialog"] as Boolean;
						version=versionInfo[0]["version"]
						var items:Array=versionInfo[0]["item"];
						if (items != null && items.length > 0)
						{
							for each (var item:Object in items)
							{
								versionContent+=item["content"] + "\n";
							}
						}
					}
				}
		*/
		public static function getConfigList():Array
		{
			var urls:Array = [];
			var fileList:Array = data["file"];
			trace(fileList);
			for each (var item:Object in fileList)
			{
				urls.push(item["url"]);
			}
			return urls;
		}
	}
}

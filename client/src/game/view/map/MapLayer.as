package game.view.map
{
	import com.cong.managers.FloatTextManager;
	import com.cong.managers.UIManager;
	import com.cong.utils.EdgeGraph;
	import com.cong.utils.Graph;
	import com.cong.utils.SortOn;

	import game.config.ConfigStayEvent;
	import game.constants.CONST_BUILD_TYPE;
	import game.controller.C_Map;
	import game.controller.C_UI;
	import game.data.D_Game;
	import game.data.house.BuildInfo;
	import game.data.map.StayEvent;
	import game.view.V_Map;

	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Browser;
	import laya.utils.ClassUtils;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	import laya.utils.Tween;

	import ui.map.HouseChargeTipUI;

	public class MapLayer extends Sprite
	{
		public var actor:Actor;
		private var curPos:Point = new Point(); //玩家当前位置
		private var tarPos:Point = new Point(); //玩家目标位置
		private var path:Array;   //导航路径
		private var pathLayer:Sprite;
		private var buildLayer:Sprite;
		private var roleLayer:Sprite;
		private var buildData:Dictionary = new Dictionary();  //建筑数据
		private var customers:Dictionary = new Dictionary();    //顾客
		private var stayEventsDic:Dictionary = new Dictionary();     //事件点
		private var pathDic:Dictionary = new Dictionary();  //导航路径字典（包含停留点）

		private var buildings:Dictionary = new Dictionary()   //建筑显示列表
		private var stayPoints:Dictionary = new Dictionary();  //停留点显示列表
		private var stayPointMerge:Dictionary = new Dictionary();  //合并后的停留点列表
		private var startPos:Point = new Point();           //地图起始位置
		private var endPos:Point = new Point();             //地图结束位置
		private var mapPadding:int = 300;
		private var curStayIndex:int = 0;    //当前停留点索引
		private var curRouteEvents:Array = [];//当前路段事件集合
		private var mapScaleX:Number = 0;
		private var mapScaleY:Number = 0;

		private var alphaStayPoints:Array; //需要虚化的点


		private var graph:Graph; //所有停留点所构成的表

		public function MapLayer(wid:Number, hei:Number)
		{
			super();
			pathLayer = new Sprite();
			pathLayer.cacheAsBitmap = true;
			addChild(pathLayer);
			buildLayer = new Sprite();
//			buildLayer.cacheAsBitmap = true;
			addChild(buildLayer);
			roleLayer = new Sprite();
			addChild(roleLayer);
			actor = new Actor(D_Game.instance.userInfo.userImg);
			addChild(actor);
			graph = new Graph();
			alphaStayPoints = [];

			size(wid, hei);
			if (Browser.onPC)
			{
				mapScaleX = 1 / Laya.stage.clientScaleX;
				mapScaleY = 1 / Laya.stage.clientScaleY;
			} else
			{
				var clientHeight:Number = Browser.clientHeight;
				if (Browser.clientHeight / Browser.clientWidth >= 1920 / 1080)
				{
					clientHeight = Browser.clientWidth * 1920 / 1080;
				}
				mapScaleX = 1 / (Browser.clientWidth / Laya.stage.width);
				mapScaleY = 1 / (clientHeight / height);
			}
		}

		//定时维护屏幕内图形
		private function onFrame():void
		{
			for (var i:int = 0; i < customers.keys.length; i++)
			{
				var customer:Customer = customers.values[i];
				if (customer.x + this.x < Laya.stage.width + mapPadding && customer.x + this.x > -mapPadding && customer.y + this.y < height + mapPadding && customer.y + this.y > -mapPadding)
				{
					customer.update();
					roleLayer.addChild(customer);
				} else
				{
					customer.removeSelf();
				}
			}
			var showbuilds:Array = [];
			for (var i:int = 0; i < buildings.keys.length; i++)
			{
				var building:Building = buildings.values[i];
				if (building.x + this.x < Laya.stage.width + mapPadding && building.x + this.x > -mapPadding && building.y + this.y < height + mapPadding && building.y + this.y > -mapPadding)
				{
					buildLayer.addChild(building);
					showbuilds.push(building);
				} else
				{
					building.removeSelf();
				}
			}
			SortOn.sortOn(showbuilds, "y");
			for (var i:int = 0; i < showbuilds.length; i++)
			{
				buildLayer.setChildIndex(showbuilds[i], i);
			}

			for (var i:int = 0; i < playerDic.values.length; i++)
			{
				var role:Role = playerDic.values[i];
				if (role.x + this.x < Laya.stage.width + mapPadding && role.x + this.x > -mapPadding && role.y + this.y < height + mapPadding && role.y + this.y > -mapPadding)
				{
					roleLayer.addChild(role);
				} else
				{
					role.removeSelf();
				}
			}
		}

		//显示建筑
		public function setBuildingData(arr:Array):void
		{
			var build:Building;
			for (var i:int = 0; i < arr.length; i++)
			{
				var key:String = arr[i].getLocationStr();
				if (!buildData.get(key))
				{
					buildData.set(key, arr[i]);
					var point:Point = __JS__("lnglatToPoint( arr[i].xPos, arr[i].yPos)");
					scaleContainerPoint(point);
					build = new Building(arr[i]);
					point.x = point.x - build.width / 2;
					point.y = point.y - build.height / 2;
					point = buildLayer.globalToLocal(point);
					build.x = point.x;
					build.y = point.y;
					buildLayer.addChild(build);
					buildings.set(key, build);
				} else
				{
					build = buildings.get(key);
					build.data = arr[i];
				}
			}
		}


//		private var xxssdic:Dictionary = new Dictionary();
		//显示导航路线
		public function setNavRouteData(navRoutes:Dictionary):void
		{
//			stayPoints = new Vector.<StayPoint>();
//			pathLayer.removeChildren();
//			pathLayer.graphics.clear();
			for (var i:int = 0; i < navRoutes.keys.length; i++)
			{
				var keySplit:Array = navRoutes.keys[i].split("|");
				if (pathDic.get(keySplit[1] + "|" + keySplit[0]))
				{
					var copyArr:Array = pathDic.get(keySplit[1] + "|" + keySplit[0]).concat();
					pathDic.set(navRoutes.keys[i], copyArr.reverse());
					continue;
				}
				var routeStr:Array = navRoutes.values[i];
				var polylines:Array = routeStr.split(";");
				var gParth = [];
//				var pathobj:Object = {};
//				var mapPath:Array = [];
				for (var k:int = 0; k < polylines.length; k++)
				{
					var pointStr = polylines[k].split(",");
					var point:Point = __JS__("lnglatToPoint(pointStr[0],pointStr[1])");
					scaleContainerPoint(point);
					point = pathLayer.globalToLocal(point);
					gParth.push(Math.floor(point.x));
					gParth.push(Math.floor(point.y));
//					mapPath.push([pointStr[0], pointStr[1]]);
//					pathobj.path = mapPath;
//					pathobj.key = navRoutes.keys[i];
				}
//				__JS__("drawPath(pathobj)");
				//顾客
				var customer:Customer = customers.get(navRoutes.keys[i]);
				var build1:BuildInfo = buildData.get(navRoutes.keys[i].split("|")[0]);
				var build2:BuildInfo = buildData.get(navRoutes.keys[i].split("|")[1]);
				if (!customer)
				{
					if (build1 && build2)
					{
						if (build1.type == CONST_BUILD_TYPE.HOUSE && build2.type == CONST_BUILD_TYPE.SHOP)
						{
							var customerPath:Array = gParth.concat();
							customer = new Customer();
							customer.path = customerPath;
							customer.isBack = false;
							roleLayer.addChild(customer);
							customers.set(navRoutes.keys[i], customer);
						} else if (build1.type == CONST_BUILD_TYPE.SHOP && build2.type == CONST_BUILD_TYPE.HOUSE)
						{
							var customerPath:Array = gParth.concat();
							customer = new Customer();
							customer.path = customerPath;
							customer.isBack = true;
							roleLayer.addChild(customer);
							customers.set(navRoutes.keys[i], customer);
						}
					}
				} else
				{
					var path:Array = gParth.concat();
					customer.path = path;
					if (build1.type == CONST_BUILD_TYPE.HOUSE && build2.type == CONST_BUILD_TYPE.SHOP)
					{
						customer.isBack = false;
					} else if (build1.type == CONST_BUILD_TYPE.SHOP && build2.type == CONST_BUILD_TYPE.HOUSE)
					{
						customer.isBack = true;
					}
				}
				var totalDis:Number = getPahtDis(gParth);
				var events:Array = stayEventsDic.get(navRoutes.keys[i]);
				if (!events)
				{
					events = stayEventsDic.get(keySplit[1] + "|" + keySplit[0]).concat();
					events.reverse();
				}
				var perDis:Number = totalDis / (events.length + 1);    //停留点间隔
				var stayIndex:int = 0;
				var calDis:Number = 0;
				var pPath:Array = [];
				if (gParth.length)
				{
					pPath.push(new PathPoint(Math.floor(gParth[0]), Math.floor(gParth[1]), true));
				}

				for (var k:int = 2; k < gParth.length; k += 2)
				{
//					pathLayer.graphics.drawLine(gParth[k - 2], gParth[k - 1], gParth[k], gParth[k + 1], "#9023ab", 6);
					//绘制停留点
					var p2dis:Number = Math.sqrt((gParth[k - 2] - gParth[k]) * (gParth[k - 2] - gParth[k]) + (gParth[k - 1] - gParth[k + 1]) * (gParth[k - 1] - gParth[k + 1]));
					if (p2dis == 0)
					{
						continue;
					} else if (calDis + p2dis < perDis - 0.01)
					{
						calDis += p2dis;
					} else
					{
						var radius:Number = (perDis - calDis) / p2dis;
						var stayX:Number = gParth[k - 2] + (gParth[k] - gParth[k - 2]) * radius;
						var stayY:Number = gParth[k - 1] + (gParth[k + 1] - gParth[k - 1]) * radius;
						if (stayIndex < events.length)
						{
							//事件点
							var stayPointSplit:Array = events[stayIndex].split(",");
							var stayPoint:StayPoint = stayPointMerge.get(stayPointSplit[0]+ "," + stayPointSplit[1]);
							if (!stayPoint)
							{
								stayPoint = new StayPoint(events[stayIndex]);
								var pixels:Point = __JS__("lnglatToPoint(stayPoint.xPos,stayPoint.yPos)");
								scaleContainerPoint(pixels);
								pixels = this.globalToLocal(pixels);
								stayPoint.pos(pixels.x, pixels.y);
								//将事件点加入路径层
								pathLayer.addChild(stayPoint);
								stayPointMerge.set(stayPointSplit[0]+ "," + stayPointSplit[1], stayPoint);
							}
//							var sppp:Array = events[stayIndex].split(",");
//							if(!xxssdic.get(sppp[0] + "," + sppp[1])){
//								var stayPoint2:StayPoint = new StayPoint(events[stayIndex]);
//								stayPoint2.graphics.drawRect(0,0,50,50,"#ff0000");
//								stayPoint2.txt_pos.text = stayPoint2.xPos + "\n" + stayPoint2.yPos;
//								var point2:Point = __JS__("lnglatToPoint(stayPoint2.xPos,stayPoint2.yPos)");
//								scaleContainerPoint(point2);
//								point2 = this.globalToLocal(point2);
//								stayPoint2.pos(point2.x,point2.y);
//								pathLayer.addChild(stayPoint2);
//								xxssdic.set(sppp[0] + "," + sppp[1],stayPoint2);
//							}
							stayPoints.set(navRoutes.keys[i] + "_" + (stayIndex + 1), stayPoint);
							var keySplit:Array = navRoutes.keys[i].split("|");
							stayPoints.set(keySplit[1] + "|" + keySplit[0] + "_" + (events.length - stayIndex), stayPoint);
							stayIndex++;
							calDis = calDis + p2dis - perDis;
							pPath.push(new PathPoint(stayPoint.x, stayPoint.y, true));
						} else
						{
							//房产停留点
							stayIndex++;
							calDis = calDis + p2dis - perDis;
							pPath.push(new PathPoint(stayX, stayY, true));
							break;
						}

						while (calDis > perDis - 0.01)
						{
							radius = perDis / p2dis;
							stayX = stayX + (gParth[k] - gParth[k - 2]) * radius;
							stayY = stayY + (gParth[k + 1] - gParth[k - 1]) * radius;
							if (stayIndex < events.length)
							{
								var stayPointSplit:Array = events[stayIndex].split(",");
								var stayPoint:StayPoint = stayPointMerge.get(stayPointSplit[0]+ "," + stayPointSplit[1]);
								if (!stayPoint)
								{
									stayPoint = new StayPoint(events[stayIndex]);
									var pixels:Point = __JS__("lnglatToPoint(stayPoint.xPos,stayPoint.yPos)");
									scaleContainerPoint(pixels);
									pixels = this.globalToLocal(pixels);
									stayPoint.pos(pixels.x, pixels.y);
									//将事件点加入路径层
									pathLayer.addChild(stayPoint);
									stayPointMerge.set(stayPointSplit[0]+ "," + stayPointSplit[1], stayPoint);
								}
								stayPoints.set(navRoutes.keys[i] + "_" + (stayIndex + 1), stayPoint);
								var keySplit:Array = navRoutes.keys[i].split("|");
								stayPoints.set(keySplit[1] + "|" + keySplit[0] + "_" + (events.length - stayIndex), stayPoint);
								stayIndex++;
								calDis -= perDis;
								pPath.push(new PathPoint(stayPoint.x, stayPoint.y, true));

//								if (!xxssdic.get(sppp[0] + "," + sppp[1]))
//								{
//									var stayPoint2:StayPoint = new StayPoint(events[stayIndex]);
//									stayPoint2.graphics.drawRect(0, 0, 50, 50, "#ff0000");
//									stayPoint2.txt_pos.text = stayPoint2.xPos + "\n" + stayPoint2.yPos;
//									var point2:Point = __JS__("lnglatToPoint(stayPoint2.xPos,stayPoint2.yPos)");
//									scaleContainerPoint(point2);
//									point2 = this.globalToLocal(point2);
//									stayPoint2.pos(point2.x, point2.y);
//									pathLayer.addChild(stayPoint2);
//									xxssdic.set(sppp[0] + "," + sppp[1], stayPoint2);
//								}
							} else
							{
								//房产停留点
//							pathLayer.graphics.drawCircle(stayX, stayY, 10, "#ffff00");
								stayIndex++;
								calDis -= perDis;
								pPath.push(new PathPoint(stayX, stayY, true));
								break;
							}

						}
					}
					pPath.push(new PathPoint(Math.floor(gParth[k]), Math.floor(gParth[k + 1]), false));
				}
				pathLayer.graphics.drawLines(0, 0, gParth.concat(), "#80C908", 20);
				pathDic.set(navRoutes.keys[i], pPath);
			}
			Laya.timer.frameLoop(15, this, onFrame);
			if (firstEnded)
			{
				tweenCenter(startPos.x, startPos.y);
				firstEnded = false;
			}
			if (relocationFlag)
			{
				C_Map.instance.relocation();
				relocationFlag = false;
			}
		}

		//缩放容器坐标
		private function scaleContainerPoint(point:Point)
		{
			point.x *= mapScaleX;
			point.y *= mapScaleY;
		}

		//计算两点距离
		private function getPahtDis(arr:Array):Number
		{
			var dis:Number = 0;
			for (var i:int = 2; i < arr.length; i += 2)
			{
				dis += Math.sqrt((arr[i - 2] - arr[i]) * (arr[i - 2] - arr[i]) + (arr[i - 1] - arr[i + 1]) * (arr[i - 1] - arr[i + 1]));
			}
			return dis;
		}

		public function setStayPoint(dic:Dictionary)
		{
			if (_walkData && _walkData.eventId!=2)
			{
				var lastEvent:StayPoint = stayPointMerge.get(_walkData.event);
			}

			var edgeGraph:EdgeGraph = new EdgeGraph();
			for (var i:int = 0; i < dic.keys.length; i++)
			{
				//121.221,31.204|121.334,31.442
				stayEventsDic.set(dic.keys[i], dic.values[i]);

				//子数组数量
				var count = dic.values[i].length;
				var key:String = dic.keys[i];
				var vertexs = key.split("|");
				var startPoint:String = vertexs[0];
				var endPoint:String = vertexs[1];

				edgeGraph.reset(startPoint, endPoint);

				for (var j:int = 0; j < count; j++)
				{
					var childPoint:String = key + "_" + (j + 1);
					if (stayPoints.get(childPoint))
					{
						//最后一个不更新
						if (stayPoints.get(childPoint)==lastEvent&&(lastEvent.type == 2 || lastEvent.type == 3))
						{
							continue;
						}
						stayPoints.get(childPoint).setContent(dic.values[i][j]);
						edgeGraph.addPoint(childPoint);
					}
				}
				graph.mergeEdgeGraph(edgeGraph);
			}
		}

		//移动到地图中心位置  只调用一次
		public function moveCenter(xPos:Number, yPos:Number):void
		{
			curPos.setTo(xPos, yPos);
			__JS__("setCenter(xPos,yPos)");
			var point:Point = __JS__("lnglatToPoint(xPos,yPos)");
			scaleContainerPoint(point);

			actor.x = point.x;
			actor.y = point.y;
			this.x = -actor.x + width / 2;
			this.y = -actor.y + height / 2;
		}

		//移动到地图中心位置
		public function reposCenter(xPos:Number, yPos:Number):void
		{
			var oriCenter = __JS__("getMapCenter()");
			var oriPoint:Point = __JS__("lnglatToPoint(oriCenter.lng,oriCenter.lat)");
			scaleContainerPoint(oriPoint);
			var point:Point = __JS__("lnglatToPoint(xPos,yPos)");
			scaleContainerPoint(point);
			curPos.setTo(xPos, yPos);
			__JS__("setCenter(xPos,yPos)");
			actor.x += point.x - oriPoint.x;
			actor.y += point.y - oriPoint.y;
			this.x = -actor.x + width / 2;
			this.y = -actor.y + height / 2;
			actor.playIdle();
		}

		//定位到停留点
		public function setEventIndex(toPointX:Number, toPointY:Number, stayEventIndex:int):void
		{
			var offsetX:Number = 0;
			var offsetY:Number = 0;
			var startX:Number;
			var startY:Number;
			for (var i:int = 0; i < pathDic.keys.length; i++)
			{
				if (pathDic.keys[i] == curPos.x + "," + curPos.y + "|" + toPointX + "," + toPointY)
				{
					var arr:Array = pathDic.values[i];
					startX = arr[0].x;
					startY = arr[0].y;
					var eventIndex:int = -1;
					for (var j:int = 0; j < arr.length; j++)
					{
						if (arr[j].isStayPoint) eventIndex++;
						if (eventIndex == stayEventIndex)
						{
							offsetX = arr[j].x - startX;
							offsetY = arr[j].y - startY;
							moveActorBy(offsetX, offsetY);
							curStayIndex = stayEventIndex;
							return;
						}
					}
				}
			}
		}

		//缓动到地图中心位置
		public function tweenCenter(xPos:Number, yPos:Number)
		{
			if (curPos.x && curPos.y)
			{
				//计算重定位中心点偏移
				var endPos:Point = __JS__("lnglatToPoint(xPos,yPos)");
				scaleContainerPoint(endPos);
				endPos = this.globalToLocal(endPos);
			}
			Tween.to(actor, {
				x: endPos.x, y: endPos.y, update: new Handler(this, function () {
					var preX:Number = this.x;
					var preY:Number = this.y;
					this.x = -actor.x + width / 2;
					this.y = -actor.y + height / 2;
					V_Map.instance.moveMapBy(this.x - preX, this.y - preY, false);
				})
			}, 2000, null, new Handler(this, function () {
				V_Map.instance.mapOrigX = this.x;
				V_Map.instance.mapOrigY = this.y;
				curStayIndex = 0;
				pointNum--;
				event("move_step");
				curPos.setTo(xPos, yPos);
				if (_walkData.walkRoute.length)
				{
					moveActorTo(_walkData.walkRoute.shift());
				} else
				{
					if (godState == "")
					{
						actor.removeBuffer();
					} else
					{
						actor.addBuffer(godState.split(",")[0]);
					}
					//路过房产
					if (_walkData.money)
					{
						var tip:HouseChargeTipUI = new HouseChargeTipUI();
						tip.txt_money.text = _walkData.money.toString();
						FloatTextManager.showItem(tip);
						actor.showSpeak(_walkData.money);
					}
					actor.playIdle();
					event("move_complete");
				}
			}));
		}

		public var pointNum:int;
		public var _walkData:Object;
		private var godState:String = "";
		private var firstEnded:Boolean = false;  //第一次到达终点
		//处理主角走路
		public function movePath():void
		{
			//*移动开始,将玩家角色动画变更为行走状态
			actor.playWalk();
			pointNum = _walkData.pointNum;
			godState = _walkData.godState;
			if (_walkData.walkRoute.length)
			{
				moveActorTo((_walkData.walkRoute as Array).shift());
			}
		}

		public function set walkData(obj:Object){
			_walkData = obj;
			if(_walkData.eventId!=2){
				var lastPathEvents:Array = _walkData.walkRoute[_walkData.walkRoute.length - 1].events;
				var lastEventStrSplit = lastPathEvents[lastPathEvents.length - 1].split(",");
				_walkData.event = lastEventStrSplit[0]+","+lastEventStrSplit[1];
			}else{
				_walkData.event = "";
			}
		}

		private var relocationFlag:Boolean = false;

		//移动到下一个房产
		public function moveActorTo(obj:Object):void
		{
			if (!obj.TwoPointStr)
			{
				debugger;
			}
			var startPosStr:String = obj.TwoPointStr.split("|")[0];
			var tarPosStr:String = obj.TwoPointStr.split("|")[1];
			var xPos:Number = tarPosStr.split(",")[0];
			var yPos:Number = tarPosStr.split(",")[1];

			if (curPos.x == endPos.x && curPos.y == endPos.y && xPos == startPos.x && yPos == startPos.y)
			{
				console.log("走到地图终点");
				if (!firstEnded)
				{
					C_Map.instance.getMapInfo(startPos.x, startPos.y);
					firstEnded = true;
				} else
				{
					tweenCenter(startPos.x, startPos.y);
				}
				return;
			}
			if (curPos.x != startPosStr.split(",")[0] || curPos.y != startPosStr.split(",")[1])
			{
				console.log("起始点跟当前点不一致");
				relocationFlag = true;
				C_Map.instance.refreshMapInfo();
				return;
			}
			var pathPoints:Array = pathDic.get(curPos.x + "," + curPos.y + "|" + xPos + "," + yPos);
			if (!pathPoints)
			{
				console.log("没找到路线：：" + curPos.x + "," + curPos.y + "|" + xPos + "," + yPos);
				console.log("地图起点：：" + startPos.x, startPos.y + "地图终点：：" + endPos.x, endPos.y);
				relocationFlag = true;
				C_Map.instance.refreshMapInfo();
				return;
			}
			tarPos.setTo(xPos, yPos);
			curRouteEvents = stayEventsDic.get(curPos.x + "," + curPos.y + "|" + xPos + "," + yPos);
			path = [];
			//累计路程
			var stayIndex:int = -1;
			var leftPointNum:int = pointNum;
			for (var i:int = 0; i < pathPoints.length; i++)
			{
				if (stayIndex >= curStayIndex && leftPointNum > 0)
				{
					path.push(pathPoints[i]);
					if (pathPoints[i].isStayPoint)
					{
						leftPointNum--;
					}
				}
				if (pathPoints[i].isStayPoint)
				{
					stayIndex++;
				}
			}
			if (path.length)
			{
				_index = 0;
				Laya.timer.frameLoop(1, this, moveActor);
				return;
			}
		}

		private var _index:int;
		private var _speed:Number = 10;   //玩家移动速度
		private function moveActor():void
		{
			var targetX:Number = path[_index].x;
			// 路径节点X值
			var targetY:Number = path[_index].y;
			// 路径节点Y值
			var dx:Number = targetX - actor.x;
			// 路径节点X 与 人物X值差值
			var dy:Number = targetY - actor.y;
			// 路径节点Y 与 人物Y值差值
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			// 距离
			if (dist <= 5) // 判断走步到位
			{
				if (path[_index].isStayPoint)
				{
					pointNum--;
					curStayIndex++;
					event("move_step");
				}
				_index++;
				// 更新步数
				if (_index >= path.length) // 步数等于路径，行走结束
				{
					Laya.timer.clear(this, moveActor);
					//判断走到建筑点
					if (curStayIndex > stayEventsDic.get(curPos.x + "," + curPos.y + "|" + tarPos.x + "," + tarPos.y).length)
					{
						curStayIndex = 0;
						curPos.setTo(tarPos.x, tarPos.y);
					}
					if (_walkData.walkRoute.length)
					{
						moveActorTo(_walkData.walkRoute.shift());
					} else
					{
						//*移动结束,将玩家角色动画变更为待机状态
						actor.playIdle();
						console.log("curStayIndex::" + curStayIndex, _walkData.stayIndex);
						if (curStayIndex != _walkData.stayIndex)
						{
							debugger;
						}
						if (curStayIndex)
						{
							//角色停止,处理透明化
							alphaAdjPoint();
//							var eventID = curRouteEvents[curStayIndex - 1];
							var eventID = _walkData.eventId;
							handlerEvent(eventID);
						} else
						{
							//路过房产
							if (_walkData.money)
							{
								var tip:HouseChargeTipUI = new HouseChargeTipUI();
								tip.txt_money.text = _walkData.money.toString();
								FloatTextManager.showItem(tip);
								actor.showSpeak(_walkData.money);
							}
						}
						if (godState == "")
						{
							actor.removeBuffer();
						} else
						{
							actor.addBuffer(godState.split(",")[0]);
						}
						event("move_complete");
					}
				} else
				{
					//切换人物方向
					if (path[_index].x - path[_index - 1].x >= 0)
					{
						actor.skeleton.scaleX = -1;
					} else
					{
						actor.skeleton.scaleX = 1;
					}
					moveActor();
				}
			} else
			{
				moveActorBy(dx / dist * _speed, dy / dist * _speed);
			}
		}

		//停留点处理
		public function handlerEvent(eventID:int)
		{
			var stayEvent:StayEvent = ConfigStayEvent.getEvent(eventID);
			console.log(stayEvent);
			switch (stayEvent.type)
			{
				case 1:
					//过路费
					break;
				case 2:
					//事件npc
					V_NPCEvent.instance.setData(stayEvent);
					UIManager.instance.popUpWindow(V_NPCEvent.instance);
					var stayPoint:StayPoint = stayPointMerge.get(_walkData.event);
					if (stayPoint)
					{
						stayPoint.setId(1);
					}else{
						console.log("找不到停留点",_walkData.event);
					}
					break;
				case 3:
					//神灵
					V_Gods.instance.setData(stayEvent);
					UIManager.instance.popUpWindow(V_Gods.instance);
					var stayPoint:StayPoint = stayPointMerge.get(_walkData.event);
					if (stayPoint)
					{
						stayPoint.setId(1);
					}else{
						console.log("找不到停留点",_walkData.event);
					}
					break;
				case 4:
					//命运
					V_Fate.instance.setData(stayEvent, _walkData.exp, _walkData.money, _walkData.power, _walkData.diamonds);
					UIManager.instance.popUpWindow(V_Fate.instance);
					break;
				case 5:
					//报刊亭
					C_UI.instance.showNews();
					break;
				case 6:
					//游乐场
					break;
				case 7:
					//道具包
					break;
				case 8:
					//大盗
					break;
			}
		}

		//将主角偏移X,Y像素
		public function moveActorBy(offsetX:Number, offsetY:Number)
		{
			var preX:Number = this.x;
			var preY:Number = this.y;
			actor.x += offsetX;
			actor.y += offsetY;
			this.x = -actor.x + width / 2;
			this.y = -actor.y + height / 2;
			V_Map.instance.moveMapBy(this.x - preX, this.y - preY);
		}

		//设置地图起点跟终点
		public function setStartAndEnd(startX:Number, startY:Number, endX:Number, endY:Number):void
		{
			startPos.setTo(startX, startY);
			endPos.setTo(endX, endY);
		}

		public function updateBuildInfo(obj:Object):void
		{
			for (var i:int = 0; i < buildings.values.length; i++)
			{
				if (buildings.values[i].data.id == obj.buildId)
				{
					buildings.values[i].setSkin(obj.skinId);
				}
			}
		}

		private var playerDic:Dictionary = new Dictionary();

		//显示屏幕内其他玩家
		public function setOtherPlayers(players:Array):void
		{
			for (var i:int = 0; i < players.length; i++)
			{
				var player:Role = playerDic.get(players[i].userId);
				if (!player)
				{
					player = new Role(players[i]);
					playerDic.set(players[i].userId, player);
				}
				var eventCount:int = -1;
				var startPath:Array = pathDic.get(players[i].startX + "," + players[i].startY + "|" + players[i].endX + "," + players[i].endY);
				if (!startPath)
				{
					continue;
				}
				for (var j:int = 0; j < startPath.length; j++)
				{
					if (startPath[j].isStayPoint) eventCount++;
					if (eventCount >= players[i].startEventIndex)
					{
						player.x = startPath[j].x;
						player.y = startPath[j].y;
						roleLayer.addChild(player);
						break;
					}
				}
			}
		}

		public function setOtherPlayer2(obj:Object):void
		{
			var pathPoints:Array = [];
			var player:Role = playerDic.get(obj.userId);
			if (!player)
			{
				player = new Role(obj.userId);
				playerDic.set(obj.userId, player);
			}
			var startEventIndex = obj.startEventIndex;
			var endEventIndex = obj.endEventIndex;
			for (var i:int = 0; i < obj.walkRoute.length; i++)
			{
				//地图终点到起点特殊处理
				var key:String = obj.walkRoute[i].TwoPointStr;
				if (key == endPos.x + "," + endPos.y + "|" + startPos.x + "," + startPos.y)
				{
					var point:Point = __JS__("lnglatToPoint(this.startPos.x,this.startPos.y)");
					scaleContainerPoint(point);
					point = pathLayer.globalToLocal(point);
					var startPoint:PathPoint = new PathPoint(point.x, point.y, true);
					startPoint.isStartPoint = true;
					pathPoints.push(startPoint);
					continue;
				}
				var path:Array = pathDic.get(obj.walkRoute[i].TwoPointStr);
				if (path)
				{
					if (i == 0)
					{
						//第一个点停留点处理
						var eventCount:int = -1;
						for (var j:int = 0; j < path.length; j++)
						{
							if (path[j].isStayPoint) eventCount++;
							if (eventCount >= startEventIndex)
							{
								pathPoints.push(path[j]);
								if (obj.walkRoute.length == 1 && eventCount == endEventIndex && startEventIndex != endEventIndex)
								{
									break;
								}
							}
						}
					} else if (i == obj.walkRoute.length - 1)
					{
						//最后一个点停留点处理
						var eventCount:int = -1;
						for (var j:int = 0; j < path.length; j++)
						{
							pathPoints.push(path[j]);
							if (path[j].isStayPoint) eventCount++;
							if (eventCount == endEventIndex)
							{
								break;
							}
						}
					} else
					{
						pathPoints = pathPoints.concat(path);
					}

				}
			}
			if (pathPoints.length)
			{
				player.path = pathPoints;
				roleLayer.addChild(player);
			}
		}

		public function setOtherPlayer(obj:Object):void
		{
			var pathCount:int = 0;
			var pathPoints:Array = [];
			var player:Role = playerDic.get(obj.userId);
			if (player)
			{
				var start:String = obj.startX + "," + obj.startY;
				var end:String = obj.endX + "," + obj.endY;
				var startEventIndex = obj.startEventIndex;
				var endEventIndex = obj.endEventIndex;
				while (pathCount <= 6)
				{
					if (start == end)
					{
						break;
					}
					//地图终点到起点特殊处理
					if (start == endPos.x + "," + endPos.y)
					{
						var point:Point = __JS__("lnglatToPoint(this.startPos.x,this.startPos.y)");
						scaleContainerPoint(point);
						point = pathLayer.globalToLocal(point);
						var startPoint:PathPoint = new PathPoint(point.x, point.y, true);
						startPoint.isStartPoint = true;
						pathPoints.push(startPoint);
						start = startPos.x + "," + startPos.y;
						pathCount++;
						continue;
					}
					var foundPath:Boolean = false;
					for (var i:int = 0; i < pathDic.keys.length; i++)
					{
						var keySplit:String = pathDic.keys[i].split("|");
						if (keySplit[0] == start)
						{
							//是否找到线路，未找到线路返回
							foundPath = true;
							if (pathCount == 0 && startEventIndex)
							{
								//第一个点停留点处理
								var eventCount:int = 0;
								for (var j:int = 0; j < pathDic.values[i].length; j++)
								{
									if (pathDic.values[i][j].isStayPoint) eventCount++;
									if (eventCount >= startEventIndex)
									{
										pathPoints.push(pathDic.values[i][j]);
										if (end == "0,0")
										{
											player.x = pathPoints[0].x;
											player.y = pathPoints[0].y;
											return;
										}
									}
								}
							} else if (keySplit[1] == end && endEventIndex)
							{
								//最后一个点停留点处理
								var eventCount:int = 0;
								for (var j:int = 0; j < pathDic.values[i].length; j++)
								{
									pathPoints.push(pathDic.values[i][j]);
									if (pathDic.values[i][j].isStayPoint) eventCount++;
									if (eventCount == endEventIndex)
									{
										break;
									}
								}
							} else
							{
								if (end == "0,0")
								{
									player.x = pathDic.values[i][0].x;
									player.y = pathDic.values[i][0].y;
									return;
								}
								pathPoints = pathPoints.concat(pathDic.values[i]);
							}
							start = keySplit[1];
							pathCount++;
							break;
						}
					}
					if (!foundPath)
					{
						return;
					}
				}
				if (pathPoints.length)
				{
					player.path = pathPoints;
				}
			}
		}

		//获取当前所在停留点
		public function getCurrPoint():StayPoint
		{
			return this.stayPoints.get(this.curPos + "_" + curStayIndex);
		}

		//在此处处理透明度
		public function alphaAdjPoint():void
		{
			var startVertex = curPos + "|" + tarPos + "_" + curStayIndex;
			//深度遍历此图
			console.log(points);
			var points:Array = graph.dfs(startVertex, 6);
			console.log(points);
			for each (var point:* in alphaStayPoints)
			{
				point.icon.alpha = 0.2;
			}
			alphaStayPoints = [];
			for each (var point:String in points)
			{
				var sp:StayPoint = stayPoints.get(point);

				//忽略顶点为逻辑点的情况
				if (!!sp && !!sp.icon)
				{
					sp.icon.alpha = 1;
					alphaStayPoints.push(sp);
				}
			}
		}

		public function showSpeak():void
		{
			actor.showSpeak(_walkData.money);
		}
	}
}

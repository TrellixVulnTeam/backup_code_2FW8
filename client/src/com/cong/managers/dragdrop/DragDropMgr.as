//Created by Action Script Viewer - http://www.buraks.com/asv
package com.cong.managers.dragdrop
{
import cong.managers.dragdrop.*;
	import com.cong.utils.HashMap;
	import com.cong.utils.UIResUtil;

	import flash.geom.Point;

	import laya.display.Sprite;
	import laya.events.Event;

	public final class DragDropMgr
	{
		private static var ins:DragDropMgr;

		public static function get instance():DragDropMgr
		{
			if (ins == null)
			{
				ins = new DragDropMgr();
			}
			return ins;
		}
		private var _dragdropSrc:Sprite;
		private var _curDragData:*;
		private var _dragImage:Sprite;
		public var isDragDropState:Boolean;
		private var _dragables:HashMap;
		private var _dropables:HashMap;

		public function DragDropMgr()
		{
			this._dragables = new HashMap();
			this._dropables = new HashMap();
		}
		
		private function findDropTarget():Sprite
		{
			for each (var sprite:Sprite in _dropables.keys())
			{
				if (sprite!=_dragdropSrc&&sprite.hitTestPoint(Laya.stage.mouseX, Laya.stage.mouseY))
				{
					if(_dropables.getValue(sprite).group == _dropables.getValue(_dragdropSrc).group)
					{
						return sprite;
					}
				}
			}
			return null;
		}

		public function regDragableComp(target:Sprite, data:*, group:int = 0):void
		{
			_dragables.put(target, {"data": data, "group": group});
			target.on(Event.MOUSE_DOWN, this, mouseDownHandler);
		}

		public function unRegDragableComp(target:Sprite):void
		{
			_dragables.remove(target);
			target.off(Event.MOUSE_DOWN, this, mouseDownHandler);
		}

		public function regDropableComp(target:Sprite, data:*, group:int = 0):void
		{
			_dropables.put(target, {"data": data, "group": group});
		}

		public function unRegDropableComp(target:Sprite):void
		{
			_dropables.remove(target);
		}

//		public function isDropableComp(target:Sprite):Boolean
//		{
//			return (this._dropables[target]);
//		}

		public function mouseDownHandler(e:Event = null):void
		{
			if (e)
				this._dragdropSrc = e.currentTarget;
			this._curDragData = _dragables.getValue(this._dragdropSrc).data;
			this._dragImage = UIResUtil.getBitmapFromSprite(this._dragdropSrc);
			Laya.stage.addChild(this._dragImage);
			this._dragImage.startDrag();
			this.isDragDropState = true;
			Laya.stage.on(Event.MOUSE_MOVE, this, this.mouseMoveHandler);
			Laya.stage.on(Event.MOUSE_UP, this, this.mouseUpHandler);
		}


//		public function forceDrag(target:Sprite):void
//		{
//			if (target != null)
//			{
//				this._dragdropSrc = target;
//				mouseDownHandler();
//			}
//		}
//
//		public function forceCancelDrag():void
//		{
//			if (this._dragdropSrc)
//			{
//                drop();
//			}
//		}

		public function mouseUpHandler(e:Event):void
		{
			if (this._dragdropSrc)
			{
				this.drop();
			}
		}

		public function mouseMoveHandler(e:Event):void
		{
			this.findDropTarget();
		}

		public function drop():void
		{
			var exitEvt:DragDropEvent = null;
			var dropEvt:DragDropEvent = null;
			this._dragImage.stopDrag();
			var _local1:Point = new Point(Laya.stage.mouseX, Laya.stage.mouseY);

			var dropTarget:Sprite = findDropTarget();
			if (dropTarget)
			{
				dropEvt = new DragDropEvent(DragDropEvent.DRAG_DROP, this._dragdropSrc, this._curDragData, _local1, dropTarget);
				dropTarget.event(DragDropEvent.DRAG_DROP, dropEvt);
			}
			if (_dragdropSrc)
			{
				exitEvt = new DragDropEvent(DragDropEvent.DRAG_EXIT, this._dragdropSrc, this._curDragData, _local1, null);
				this._dragdropSrc.event(DragDropEvent.DRAG_EXIT, exitEvt);
			}
			this._dragImage = null;
			this._curDragData = null;
			this._dragdropSrc = null;
			this.isDragDropState = false;
			Laya.stage.off(Event.MOUSE_MOVE, this, this.mouseMoveHandler);
			Laya.stage.off(Event.MOUSE_UP, this, this.mouseUpHandler);
		}

//		public function get dragdropSrc():Sprite
//		{
//			return _dragdropSrc;
//		}
	}
}
//Created by Action Script Viewer - http://www.buraks.com/asv
package com.cong.managers.dragdrop
{
	import flash.geom.Point;

	import laya.display.Sprite;
	import laya.events.Event;

	public class DragDropEvent extends Event
    {

//        public static const DRAG_RECOGNIZED:String = "dragRecognized_event";
//        public static const DRAG_START:String = "dragStart_event";
//        public static const DRAG_ENTER:String = "dragEnter_event";
//        public static const DRAG_OVERRING:String = "dragOverring_event";
        public static const DRAG_EXIT:String = "dragExit_event";
        public static const DRAG_DROP:String = "dragDrop_event";

        private var _dragData:*;
        private var _mousePt:Point;
        private var _dragdropSrc:Sprite;
        private var _dragdropDst:Sprite;
        private var _relatedTarget:Sprite;

        public function DragDropEvent(type:String, dragSrc:Sprite, dragData:*, mousePt:Point, dropDst:Sprite=null, relatedTarget:Sprite=null)
        {
            this.type = type;
            this._dragdropSrc = dragSrc;
            this._dragdropDst = dropDst;
            this._dragData = dragData;
            this._mousePt = mousePt.clone();
            this._relatedTarget = relatedTarget;
        }

//        public function get dragdropSrc():Sprite
//        {
//            return (this._dragdropSrc);
//        }
//
//        public function get dragData():*
//        {
//            return (this._dragData);
//        }
//
//        public function get mousePt():Point
//        {
//            return (this._mousePt);
//        }
//
//        public function get dragdropDst():Sprite
//        {
//            return (this._dragdropDst);
//        }
//
//        public function setDragdropDst(item:Sprite):void
//        {
//            this._dragdropDst = item;
//        }
//
//        public function get relatedTarget():Sprite
//        {
//            return (this._relatedTarget);
//        }
    }
}
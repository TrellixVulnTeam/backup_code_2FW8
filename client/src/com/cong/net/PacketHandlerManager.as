package com.cong.net
{
	import com.cong.utils.Console;

	import game.controller.packets.PacketUnPacker;

	/**
	 * 封包消息处理管理器
	 */
	public class PacketHandlerManager
	{
		/**
		 * 消息处理函数字典
		 */
		private var _handlers:Object = {};
//		/**
//		 * 消息处理
//		 */
//		private var _messageHandler:Object = {};
		private var _callers:Object = {};

		public function PacketHandlerManager()
		{
		}

		/**
		 * 添加消息处理函数
		 * @param    id_ 消息id
		 * @param    handler_ 消息回调函数
		 */
		public function addHandler(caller:*, id_:uint, handler_:Function):void
		{
			var handlers:Array;
			if (!_handlers.hasOwnProperty(id_.toString()))
			{
				handlers = [];
				_handlers[id_] = handlers;
			} else
			{
				handlers = _handlers[id_];
			}
			if (handlers.indexOf(handler_) == -1)
			{
				handlers.push(handler_);
				_callers[handler_] = caller;
			}
		}

		/**
		 * 移除消息处理函数
		 * @param    id_ 消息id
		 * @param    handler_ 消息回调函数
		 */
		public function removeHandler(caller:*, id_:uint, handler_:Function):void
		{
			var handlers:Array;
			if (!_handlers.hasOwnProperty(id_.toString()))
			{
				return;
			} else
			{
				handlers = _handlers[id_];
			}

//			ArrayUtil.remove(handlers, handler_);
			_callers[handler_] = null;
			delete _callers[handler_];
		}

		public function dispatchPacket(packet_:*):void
		{
			var data:Object;
			if (null != packet_.data)
			{
				packet_.data.pos = 0;
				data = PacketUnPacker.unpack(packet_.type, packet_.data);
				packet_.data.pos = 0;
				if (data) console.log(JSON.stringify(data));
			}
			var handlers:Array = _handlers[packet_.type] is Array ? _handlers[packet_.type] : null;

			if (null == handlers)
			{
				return;
			}

			for (var i:int = 0; i < handlers.length; i++)	//保证顺序，先添加的监听先触发
			{
				var handler:Function = handlers[i] is Function ? handlers[i] : null;
				if (null != handler)
				{
					handler.apply(_callers[handler], [data]);
				}
			}
		}

		/**
		 * 移除消息处理函数
		 * @param    id_ 消息id
		 * @param    handler_ 消息回调函数
		 */
		/*public function removeMessageHandler(id_:uint, handler_:Handler):void
		{
			var handlers:Array;
			if(!_messageHandler.hasOwnProperty(id_))
			{
				return;
			}
			else
			{
				handlers = _messageHandler[id_];
			}

			ArrayUtil.remove(handlers, handler_);
		}*/
//		/**
//		 * 分发消息包
//		 * @param	packet_
//		 */
//		public function dispatchMessagePacket(packet_:SocketPacket):void
//		{
//			var handlers:Array = _messageHandler[packet_.type] is Array ? _messageHandler[packet_.type] : null;
//
//			if(null == handlers)
//			{
//				return;
//			}
//			for(var i:int = 0; i < handlers.length; i++)	//保证顺序，先添加的监听先触发
//			{
//				var handler:Handler = handlers[i] is Handler ? handlers[i] : null;
//				packet_.data.pos = 0;
//				if(null != handler)
//				{
//					handler.runWith(packet_);
//				}
//			}
//		}

	}
}
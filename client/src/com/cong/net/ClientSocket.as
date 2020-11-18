package com.cong.net
{
	import com.cong.managers.TimeManager;
	import com.cong.utils.CacheManager;
	import com.cong.utils.Console;

	import laya.events.Event;
	import laya.net.Socket;
	import laya.utils.Byte;

	public class ClientSocket
	{
		private static const CONNECT_FAIL_OUT_TIME:int = 30000;	//连接失败的超时值，毫秒数，超时则认为连接失败，不再重试
		
		private var _host:String;
		private var _port:uint;
		private var _socket:Socket;

		//private var _onActivate:Function;
		private var _onClose:Function;
		private var _onConnect:Function;
//		private var _onDeactivate:Function;
		private var _onIOError:Function;
		private var _onReceivePacket:Function;
		private var _onSecurityError:Function;
		private var _onConnectOutTime:Function;
		
		private var _receivedBytes:Byte;
		
		private var _listenedConnectFail:Boolean = false;
		
//		private var _encryptor:Encryptor;
		
		private var tempBytes:Byte;
//		private var recvedPackets:Vector.<SocketPacket>;f

		public var firstConnectSuccess:Boolean = true;
		public function ClientSocket()
		{
			_receivedBytes = new Byte();
			_receivedBytes.endian = Byte.LITTLE_ENDIAN;
//			_encryptor = new Encryptor(MainMhj.key);
		}

		public function get onClose():Function
		{
			return _onClose;
		}
		
		public function set onClose(value:Function):void
		{
			_onClose = value;
		}
		
//		public function get onConnect():Function
//		{
//			return _onConnect;
//		}
		
		public function set onConnect(value:Function):void
		{
			_onConnect = value;
		}

		public function set onIOError(value:Function):void
		{
			_onIOError = value;
		}
		
		public function set onReceivePacket(value:Function):void
		{
			_onReceivePacket = value;
		}
		
//		public function get onSecurityError():Function
//		{
//			return _onSecurityError;
//		}
		
		public function set onSecurityError(value:Function):void
		{
			_onSecurityError = value;
		}
		
//		public function get onConnectOutTime():Function
//		{
//			return _onConnectOutTime;
//		}
		
		public function set onConnectOutTime(value:Function):void
		{
			_onConnectOutTime = value;
		}
		
		
		/**
		 * 连接服务器
		 * @param	host_ 服务端地址
		 * @param	port_ 服务器端口号
		 * @param	policyPort_ 安全策略文件端口号
		 */
		public function connect(host_:String, port_:uint, policyPort_:uint=0):void
		{
			_host = host_;
			_port = port_;
			clearSocket();

			_socket = new Socket();
			_socket.endian = Socket.BIG_ENDIAN;

			_socket.on(Event.CLOSE, this, closeHandler);
			_socket.on(Event.OPEN, this, connectHandler);
			_socket.on(Event.ERROR, this, ioErrorHandler);
			_socket.on(Event.MESSAGE, this, receiveDataHandler);
			try
			{
				_socket.connect(_host, _port);
			}
			catch(err:Error)
			{
				console.log("连接服务器socket失败");
			}
			_receivedBytes.clear();
		}
		
//		private function addConnectOutTimeListener():void
//		{
//			if(!_listenedConnectFail)
//			{
//				_listenedConnectFail = true;
//				TimeManager.addCallback(this, CONNECT_FAIL_OUT_TIME, onConnectFailOutTime, null, 10);
//			}
//		}
		
		private function removeConnectOutTimeListener():void
		{
			TimeManager.removeCallback(this, onConnectFailOutTime);
			_listenedConnectFail = false;
		}
		
		private function onConnectFailOutTime():void
		{
//			Dd.add("[ClientSocket.onConnectFail]"+_host+":"+_port);
			clearSocket();
			
			if(null != _onConnectOutTime)
			{
				_onConnectOutTime.apply(this);
			}
		}
		
		public function close():void
		{
			clearSocket();
		}
		/**
		 *检查Socket是否关闭 
		 * @return 
		 * 
		 */		
		public function checkSocketClose():int
		{
			if(_socket)
			{
				if(_socket.connected)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			return -1;
		}
		
		public function sendBytes(bytes_:Byte,isDecrypt:Boolean=true):void
		{
			if(null != _socket && _socket.connected)
			{
				_socket.output.writeArrayBuffer(bytes_.__getBuffer(), 0, bytes_.length);
				_socket.flush();
			}
		}
		/*
		public function sendPacket(packet_:SocketPacket, encode_:Boolean=true):void
		{
			if(null != _socket && _socket.connected)
			{
				var len:uint;
				
				var bye:Byte = new Byte();
				{
					if(null != packet_.data)
					{
						len = 8 + packet_.data.length;
						bye.writeUnsignedInt(len);
						bye.writeUnsignedInt(packet_.type);
						bye.writeBytes(packet_.data);
					}
					else
					{
						len = 8;
						bye.writeUnsignedInt(len);
						bye.writeUnsignedInt(packet_.type);
					}
				}
//				bye = Decrypt(bye);
				_socket.writeBytes(bye);
				_socket.flush();
			
				 
				
			}
		}
		*/
		private function clearSocket():void
		{
			_listenedConnectFail = false;
			if(connect!=null)
			{
				TimeManager.removeCallback(this, connect);
			}
			
			if(null != _socket)
			{
				if(_socket.connected)
				{
					_socket.close();
					_socket.off(Event.CLOSE, this, closeHandler);
					_socket.off(Event.OPEN, this, connectHandler);
					_socket.off(Event.ERROR, this, ioErrorHandler);
					_socket.off(Event.MESSAGE, this, receiveDataHandler);
				}
			}
		}
		/*
		private function activateHandler(event_:Event):void
		{
			if(null != _onActivate)
			{
				_onActivate.apply();
			}
		}
		*/
		private function closeHandler(event_:Event):void
		{
			//if(_socket == event_.currentTarget)
			{
				clearSocket();
				removeConnectOutTimeListener();
				
				if(null != _onClose)
				{
					_onClose.apply();
				}
			}
		}
		
		private function connectHandler(event_:Event):void
		{
			TimeManager.removeCallback(this, connect);
			//removeConnectOutTimeListener();
			if(null != _onConnect)
			{
				_onConnect.apply(this);
			}
			firstConnectSuccess = false;
		}
		/*
		private function deactivateHandler(event_:Event):void
		{
			if(null != _onDeactivate)
			{
				_onDeactivate.apply();
			}
		}*/
		/**
		 * 接受数据处理
		 * @param	event_
		 */
		private function receiveDataHandler(message:*):void
		{
			//包结构：4个byte表示包长度，4个byte表示包id，然后是包data
			tempBytes = new Byte(message);
			tempBytes.endian = Byte.LITTLE_ENDIAN;

			_receivedBytes.pos = _receivedBytes.length;
			_receivedBytes.writeArrayBuffer(tempBytes.buffer,0,tempBytes.length);
			while(_receivedBytes.length >= 8)
			{
				_receivedBytes.pos = 0;
				var len:uint = _receivedBytes.getUint16();
				var id:uint = _receivedBytes.getUint16();
				var seqid:int = _receivedBytes.getInt32();
				var memberCount  = _receivedBytes.getByte();
//				Console.traceDebug("收到报:"+id);
				if(len>407200)
				{
					trace("收到了一个超过400k的包啊，咋整的啊，搞毛啊"+id);
				}
				if(_receivedBytes.length < len)	//如果包未接收完整（断包）
				{
					break;
				}

				var packet:SocketPacket;

				if(len > 8)
				{
					packet = CacheManager.instance.create(SocketPacket);
					packet.type = id;

					packet.initData();
					//带有数据
					packet.data.writeArrayBuffer(_receivedBytes.buffer, 9, len - 9);
					packet.data.pos = 0;
				}
				else
				{
					//不带有数据
					packet = CacheManager.instance.create(SocketPacket);
					packet.clear();
					packet.type = id;
				}
				console.log("接收协议：：" + packet.type,_receivedBytes.length);
				_onReceivePacket.call(null, packet);

				//只存储剩余数据（粘包）
				tempBytes.clear();
				var remainLen:int = _receivedBytes.length - len;
				if (remainLen>0)
				{
					tempBytes.writeArrayBuffer(_receivedBytes.buffer,len,_receivedBytes.length - len);
					tempBytes.pos = 0;
					_receivedBytes.clear();
					_receivedBytes.writeArrayBuffer(tempBytes.buffer, 0, tempBytes.length);

				}else if (remainLen == 0)
				{
					_receivedBytes.clear();
				}
			}
//			_onReceivePacket.call(null, message);
		}

		private function ioErrorHandler(event_:Event):void
		{
			clearSocket();
			removeConnectOutTimeListener();
			
			if(null != _onIOError)
			{
				_onIOError.apply(this);
			}
		}

		public function reconnect():void
		{
			//connect(_host, _port,843);
			trace("重新连接服务器::",_host, _port);
			_socket.connect(_host, _port);
		}
	}
}
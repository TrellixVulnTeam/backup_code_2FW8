package com.cong.net
{
	import com.cong.utils.CacheManager;
	import com.cong.utils.Console;

	import game.constants.CONST_CMD;

	import game.controller.C_UI;
	import game.controller.C_User;
	import game.controller.packets.PacketPacker;

	import laya.utils.Byte;
	import laya.utils.Handler;

	public class Network
	{
		public static var gameSocket:ClientSocket;	
		
//		private static var _handlers:Object={};
		
		private static var _packetHandlerManager:PacketHandlerManager=new PacketHandlerManager();
		
//		private static var _recvedPackets:Vector.<SocketPacket>=new Vector.<SocketPacket>();
//		private static var _processing:Boolean=false;
		
//		private static var _dispatchPacketCount:int;
		
		private static var onConnect:Handler;
		private static var connectCount:int;  //重连次数
//		/**
//		 *是否开启分帧处理回包协议 
//		 */
//		public static var isOpenFrameProcessRecvedPack:Boolean = false;
		
		public function Network():void
		{
			
		}
		
		public static function connectServer(host_:String, port_:uint, onConnect_:Handler, onClose_:Function, onConnectOutTime_:Function, onIOError_:Function, onSecurityError_:Function, onReceivePacket_:Function):void
		{
			if (null == gameSocket)
			{
				gameSocket = new ClientSocket();
			}
			onConnect = onConnect_;
			gameSocket.onClose=onClose_;
			gameSocket.onConnectOutTime=onConnectOutTime_;
			gameSocket.onIOError=onIOError_;
			gameSocket.onSecurityError=onSecurityError_;
			gameSocket.onConnect=connectHandler;
			gameSocket.onReceivePacket=onReceivePacket_;
			gameSocket.connect(host_, port_,843);
			connectCount = 0;
			console.log("连接服务器", host_,port_);
		}

		/**
		 *
		 * @param cmdID
		 * @param param_
		 * @param onResponse_
		 *
		 */
		public static function send(cmdID:int, param_:*=null, onResponse_:Function=null):void
		{
			if (!gameSocket)
				return ;
			var socketPack:SocketPacket;
			if (null != param_)
			{
				socketPack=PacketPacker.pack(cmdID, param_);
			}
			
			var totalLen:int=9;
			var sendBytes:Byte=new Byte();
			sendBytes.endian = Byte.LITTLE_ENDIAN;
			
			if (null != socketPack)
			{
				totalLen+=socketPack.data.length;
				sendBytes.writeUint16(totalLen);
				sendBytes.writeUint16(cmdID);
				sendBytes.writeInt32(0);
				sendBytes.writeByte(3);
				sendBytes.writeArrayBuffer(socketPack.data.__getBuffer(), 0, socketPack.data.length);
			}
			else
			{
				sendBytes.writeUint16(totalLen);
				sendBytes.writeUint16(cmdID);
				sendBytes.writeInt32(0);
				sendBytes.writeByte(3);
			}
			console.log("发送协议：：" + cmdID,totalLen);
			gameSocket.sendBytes(sendBytes);
		}
		
		//监听协议		
		public static function addHandler(caller:*, id_:uint, handler_:Function):void
		{
			_packetHandlerManager.addHandler(caller, id_, handler_);
		}
		
		public static function removeHandler(caller:*, id_:uint, handler_:Function):void
		{
			_packetHandlerManager.removeHandler(caller, id_, handler_);
		}
		
		public static function dispatchPacket(packet_:SocketPacket):void
		{
			_packetHandlerManager.dispatchPacket(packet_);
		}
		
		/**
		 *关闭socket连接
		 *
		 */
		public static function closeSocket():void
		{
			if (gameSocket != null)
			{
				gameSocket.close();
				Laya.timer.clear(Network,sendHeartAlive);
			}
		}
		
		public static function connectHandler():void
		{
			/*if(MainMhj.USE_TGW)
			{				
				var httpHead:String = "tgw_l7_forward\r\nHost:"+gameSocket.host+":"+gameSocket.port+"\r\n\r\n";
				var httpHeadBytes:Byte = new Byte();
				httpHeadBytes.endian = Endian.LITTLE_ENDIAN;
				StringUtil.flush_byte(httpHead, httpHeadBytes);			
				gameSocket.sendBytes(httpHeadBytes,false);
				Dd.add("发送TGW串"+httpHead);
			}
			*/
			console.log("成功连接服务器");
			if(null != onConnect)
			{
				onConnect.run();
			}
			C_UI.instance.removeConnectTip();
		}

		public static function keepHeartAlive():void{
			Laya.timer.loop(30000,Network,sendHeartAlive);
		}

		private static function sendHeartAlive():void
		{
			console.log(Laya.timer.toString());
			send(CONST_CMD.PING,null);
		}
		
		public static function onConnectionBreak():void
		{
			console.log("与服务器断开连接");
			C_UI.instance.showNetError("网络连接异常，请重试！",Handler.create(Network,relogin));
			Laya.timer.clear(Network,sendHeartAlive);
//			gameSocket.reconnect();
		}

		private static function relogin():void
		{
			__JS__("window.location.reload()");
		}

		public static function onConnectionOutTime():void
		{
			console.log("连接超时");
			C_UI.instance.showNetError("连接超时");
			C_UI.instance.showConnectTip();
			connectCount++;
			if(connectCount<4){
				gameSocket.reconnect();
//				C_User.instance.connectAccountServer();
			}
		}
		
		public static function onConnectionIOError():void
		{
			console.log("socket传输出错");
			C_UI.instance.showNetError("网络连接异常，请重试！",Handler.create(Network,relogin));
			Laya.timer.clear(Network,sendHeartAlive);
		}
		
		public static function onConnectionSecurityError():void
		{
			console.log("安全错误");
			C_UI.instance.showNetError("安全错误");
		}
		
		public static function onReceivePacket(packet_:SocketPacket):void
		{
			//Dd.add("receivePacket:"+packet_.type);
//			console.log(packet_);
			dispatchPacket(packet_);
			CacheManager.instance.remove(packet_);
		}
		 
//		public static function processPacket():void
//		{
//			if (_processing || _recvedPackets.length <= 0)
//			{
//				return ;
//			}
//			if( _recvedPackets.length <= 0)
//			{
//				return;
//			}
//
//			_processing=true;
//
//			while (_recvedPackets.length > 0)
//			{
//				var packet:SocketPacket=_recvedPackets.shift();
//					Dd.add("receivePacket:"+packet.type);
//					dispatchPacket(packet);
//					CacheManager.instance.remove(packet);
//			}
//
//			_processing=false;
//		}
		
//		public static function processPacket1():void
//		{
////			if (_processing || _recvedPackets.length <= 0)
////			{
////				return ;
////			}
//			if( _recvedPackets.length <= 0)
//			{
//				return;
//			}
//
////			_processing=true;
//
//			while (_recvedPackets.length > 0)
//			{
//				var packet:SocketPacket=_recvedPackets.shift();
//				//				try
//				//				{
//				Dd.add("receivePacket:"+packet.type);
//				dispatchPacket(packet);
//				CacheManager.instance.remove(packet);
////				_dispatchPacketCount++;
////				if(_dispatchPacketCount>10)
////				{
////					break;
////				}
//
//				//				}
//				//				catch (err:Error)
//				//				{
//				//
//				//					throw err;
//				//				}
//			}
//
//			_dispatchPacketCount = 0;
////			_processing=false;
//		}
		
		public static function checkSocketClose():int
		{
			if(gameSocket)
			{
				return gameSocket.checkSocketClose();	
			}
			return -1;
			
		}
	}
}
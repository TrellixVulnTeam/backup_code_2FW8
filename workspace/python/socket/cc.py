import socket

sock = socket.socket() # 建立socket
sock.connect(('127.0.0.1', 5500)) # 远程连接
request = 'GET {} HTTP/1.0\r\nHost: 127.0.0.1:5500\r\n\r\n'.format('/hello.html') # 构建请求
sock.send(request.encode('ascii')) # 向socket发送数据
response = b'' 
chunk = sock.recv(4096) # 从socket接收数据
while chunk:
    response += chunk
    chunk = sock.recv(4096)

print(response)

import socket
import sys
import time

# host = sys.argv[1]
# port = sys.argv[2]

host = '127.0.0.1'
port = 5500
# TCP协议
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.connect((host, port))

fd = s.makefile('rw')

time.sleep(3)

request = 'GET {} HTTP/1.0\r\nHost: 127.0.0.1:5500\r\n\r\n'.format('/hello.html') # 构建请求
fd.write(request)

fd.flush()
s.shutdown(1)
s.close()

while 1:
    try:
        buf = fd.readline()
    except:
        print('error!')
    
    if not len(buf):
        break
    print(buf)

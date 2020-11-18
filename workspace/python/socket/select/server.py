import socket
import select
import json

file = open('./config.json','r',encoding='utf-8')
config = json.load(file)

HOST = config['host']
PORT = config['port']

# 创建
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 设置
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# 绑定
server.bind((HOST, PORT))
server.listen(1)
server.setblocking(0)

inputs = [server, ]

while True:
    rs, ws, es = select.select(inputs, [], inputs)
    for r in rs:
        #r等于Server,代表有新连接进入
        if r == server:
            conn, addr = server.accept()
            inputs.append(conn)
        #若为其它连接,则读取数据
        else:
            data = r.recv(1024)
            if len(data) > 0:
                print('接受数据: {0}'.format(data.decode('utf-8')))
                r.send('服务端已接受到数据'.encode('utf-8'))
                # inputs.remove(r)
                # r.close()

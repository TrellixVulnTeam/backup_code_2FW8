import socket, json

file = open('./config.json','r',encoding='utf-8')
config = json.load(file)

HOST = config['host']
PORT = config['port']
print(PORT)

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((HOST, PORT))

while True:
    client.sendall(input().encode('utf-8'))
    data = client.recv(1024)
    if len(data):
        data = data.decode('utf-8')
        print(data)
import socket

host = ''
port = 51423

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((host, port))
s.listen(1)

print("Server is Running in Port{0} ...".format(port))

while 1:
    clientsock, clientaddr = s.accept()
    clientfile = clientsock.makefile('rw')
    clientfile.write("Welcome, {0}\nPlease enter a string".format(clientaddr))
    line = clientfile.readline().strip()
    clientfile.write("You entered {0} characters".format(len(line)))
    clientfile.close()
    clientsock.close()
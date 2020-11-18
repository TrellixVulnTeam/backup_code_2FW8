# -*- coding: utf-8 -*-


'''
The 102 nonisomorphic ways of arranging zero to nine X's on a
tic-tac-toe board, each shown together with its corresponding misere quotient
element from Q.
'''
#      0   1   2   3   4   5   6   7   8
# -----------------------------------------------
#c
#c = []
#c.append(['-','-','-','-','-','-','-','-','-'])
# ONE
#o = []
#o.append(['X','-','-','-','-','-','-','-','-'])
#o.append(['-','X','-','-','-','-','-','-','-'])
#o.append(['-','-','X','-','-','-','-','-','-'])
#o.append(['-','-','-','X','-','-','-','-','-'])
#ad
#ad = []
#ad.append(['X','X','-','-','-','-','-','-','-'])
#ad.append(['-','X','X','-','-','-','-','-','-'])
#ad.append(['X','-','-','X','-','-','-','-','-'])
#ad.append(['-','-','X','-','-','X','-','-','-'])

nonisomorphic_board ={}

c = []
c.append('000000000')

o = []
o.append('100000000')
o.append('010000000')
o.append('111000000')
o.append('100010001')
o.append('100001010')
o.append('010010010')
o.append('111100000')
o.append('111010000')
o.append('111000100')
o.append('111000010')
o.append('110010010')
o.append('110010001')
o.append('101010100')
o.append('010111000')
o.append('111110000')
o.append('111101000')
o.append('111100100')
o.append('111100010')
o.append('111100001')
o.append('111010100')
o.append('111010010')
o.append('111000110')
o.append('111000101')
o.append('110111000')
o.append('110110001')
o.append('110011010')
o.append('110011001')
o.append('110010110')
o.append('110010101')
o.append('110010011')
o.append('101010101')
o.append('010111010')
o.append('111111000')
o.append('111110100')
o.append('111110010')
o.append('111110001')
o.append('111101100')
o.append('111101010')
o.append('111100101')
o.append('111100011')
o.append('111010110')
o.append('111010101')
o.append('111000111')
o.append('110111010')
o.append('110111001')
o.append('110011110')
o.append('110011101')
o.append('111111100')
o.append('111111010')
o.append('111110101')
o.append('111110011')
o.append('111101110')
o.append('111101101')
o.append('111010111')
o.append('110111011')
o.append('111111110')
o.append('111111101')
o.append('111101111')
o.append('111111111')

cc = []
cc.append('000010000')

ad = []
ad.append('110000000')

b = []
b.append('101000000')
b.append('100010000')
b.append('100001000')
b.append('010010000')
b.append('110100000')
b.append('010101000')
b.append('110011000')
b.append('110010100')
b.append('110001100')
b.append('110000110')
b.append('110000101')
b.append('101010010')
b.append('100011010')
b.append('110101010')
b.append('110101001')

a = []
a.append('100000001')
a.append('010100000')
a.append('010000010')
a.append('110000100')
a.append('101010000')
a.append('101000010')
a.append('100011000')
a.append('110110000')
a.append('110101000')
a.append('110100001')
a.append('110000011')
a.append('101000101')
a.append('010101010')
a.append('110011100')
a.append('110001110')
a.append('110001101')
a.append('110101011')

ab = []
ab.append('110010000')
ab.append('101000100')
ab.append('010110000')
ab.append('110001010')
ab.append('110001001')

d = []
d.append('110001000')
d.append('110000010')
d.append('110000001')

def symmetry(board):
    res = ''
    res += board[2]
    res += board[1]
    res += board[0]
    res += board[5]
    res += board[4]
    res += board[3]
    res += board[8]
    res += board[7]
    res += board[6]
    return res


def rotation90(board):
    res = ''
    res += board[6]
    res += board[3]
    res += board[0]
    res += board[7]
    res += board[4]
    res += board[1]
    res += board[8]
    res += board[5]
    res += board[2]
    return res

def getAll(board):
    res = []
    tmp = rotation90(board)
    res.append(tmp)
    tmp = rotation90(tmp)
    res.append(tmp)
    tmp = rotation90(tmp)
    res.append(tmp)
    tmp = symmetry(board)
    res.append(tmp)
    tmp = rotation90(tmp)
    res.append(tmp)
    tmp = rotation90(tmp)
    res.append(tmp)
    tmp = rotation90(tmp)
    res.append(tmp)
    return res

for item in o:
    nonisomorphic_board[item] = 'o'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'o'

for item in b:
    nonisomorphic_board[item] = 'b'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'b'

for item in a:
    nonisomorphic_board[item] = 'a'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'a'

for item in ad:
    nonisomorphic_board[item] = 'ad'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'ad'

for item in cc:
    nonisomorphic_board[item] = 'cc'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'cc'
for item in ab:
    nonisomorphic_board[item] = 'ab'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'ab'
for item in c:
    nonisomorphic_board[item] = 'c'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'c'
for item in d:
    nonisomorphic_board[item] = 'd'
    res = getAll(item)
    for board in res:
        if board not in nonisomorphic_board:
            nonisomorphic_board[board] = 'd'

nonisomorphic_board[''] = '1'
print len(nonisomorphic_board)
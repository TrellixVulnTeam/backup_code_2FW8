# -*- coding: utf-8 -*-

from TicTacToe_exceptions import InvalieMove
from monoid import *

################################################################
class Board:
    def __init__(self, nb, mqa, mqb, mqc, mqd):
        self.boardindex = nb
        self.misereQuotientA = mqa
        self.misereQuotientB = mqb
        self.misereQuotientC = mqc
        self.misereQuotientD = mqd
        self.dead = False
        self.board = ['-', '-', '-', '-', '-', '-', '-', '-', '-']

    def get_misere_quotient(self):
        return self.misereQuotientA, self.misereQuotientB, \
               self.misereQuotientC, self.misereQuotientD

    def to_string(self):
        res = ''
        for item in self.board:
            if item == '-':
                res += '0'
            else:
                res += '1'
        return res

    def print_board(self):
        print( 'Board ',self.boardindex)
        if self.dead:
            print( '( DEAD )')
        print( self.board[0], ' ',self.board[1], ' ',self.board[2], ' ')
        print( self.board[3], ' ',self.board[4], ' ',self.board[5], ' ')
        print( self.board[6], ' ',self.board[7], ' ',self.board[8], ' ')
        print( '(a,b,c,d) = ', self.misereQuotientA, self.misereQuotientB, \
               self.misereQuotientC, self.misereQuotientD)
        print( ' ')

    def update_monoid(self):
        #TODO: update misere Quotient (a, b, c, d)
        board_str = self.to_string()
        board = nonisomorphic_board[board_str]
        self.misereQuotientA = board.count('a')
        self.misereQuotientB = board.count('b')
        self.misereQuotientC = board.count('c')
        self.misereQuotientD = board.count('d')

    def is_valid_pos(self, pos):
        if self.board[pos] != 'X':
            return True
        return False

    def make_move(self, pos):
        if pos < 0 or pos > 8:
#            raise InvalieMove('Invalid move: Your input must be in [1,9]. ')
            print( 'Invalid move: Your input must be in [1,9]. ')
            return False
        elif self.board[pos] != 'X':
            self.board[pos] = 'X'
            if self.is_alive():
                self.update_monoid()
            return True
        else:
#            raise InvalieMove('Invalid move: Already moved in this position.')
            print( 'Invalid move: Already moved in this position.')
            return False
    def is_dead(self):
        return self.dead

    def is_alive(self):
        if (self.board[0] == 'X' and self.board[1] == 'X' and self.board[2] == 'X') or \
                (self.board[3] == 'X' and self.board[4] == 'X' and self.board[5] == 'X') or \
                (self.board[6] == 'X' and self.board[7] == 'X' and self.board[8] == 'X') or \
                (self.board[0] == 'X' and self.board[3] == 'X' and self.board[6] == 'X') or \
                (self.board[1] == 'X' and self.board[4] == 'X' and self.board[7] == 'X') or \
                (self.board[2] == 'X' and self.board[5] == 'X' and self.board[8] == 'X') or \
                (self.board[0] == 'X' and self.board[4] == 'X' and self.board[8] == 'X') or \
                (self.board[2] == 'X' and self.board[4] == 'X' and self.board[6] == 'X'):
            self.dead = True
            self.misereQuotientA = 0
            self.misereQuotientB = 0
            self.misereQuotientC = 0
            self.misereQuotientD = 0
            return False
        return True

################################################################
class Game:
    def __init__(self, n_board, mqa, mqb, mqc, mqd):
        if n_board < 1:
            raise ValueError("Must have at least 1 board")
        self.n_boards = n_board
        self._boards = []
        for i in range(n_board):
            self._boards.append(Board(i, 0, 0, 1, 0))
        self.misereQuotientA = mqa
        self.misereQuotientB = mqb
        self.misereQuotientC = mqc
        self.misereQuotientD = mqd

    def to_string(self):
        res = []
        for item in self._boards:
            if item.is_dead():
                res.append('')
            else:
                res.append(item.to_string())
        return res

    def get_misere_quotient(self):
        return self.misereQuotientA, self.misereQuotientB, \
               self.misereQuotientC, self.misereQuotientD

    def is_board_alive(self, index):
        return not self._boards[index].is_dead()

    def print_all_boards(self):
        for board in self._boards:
            board.print_board()
        print( '3-Board MQ : (a,b,c,d) = ', self.misereQuotientA, self.misereQuotientB, \)
               self.misereQuotientC, self.misereQuotientD
        print( '')

    def alive_board(self):
        return filter(lambda board: not board.is_dead(), self._boards)

    def conversion_mq(self):
        while self.misereQuotientA > 1 or self.misereQuotientB > 2 or \
                self.misereQuotientC > 2 or self.misereQuotientD > 1 or\
                (self.misereQuotientB > 1 and self.misereQuotientC > 0) or \
                (self.misereQuotientB > 1 and self.misereQuotientD > 0) or \
                (self.misereQuotientC > 0 and self.misereQuotientD > 0):
            if self.misereQuotientA > 1:
                self.misereQuotientA %= 2
            if self.misereQuotientB > 2:
                if self.misereQuotientB%2 == 1:
                    self.misereQuotientB = 1
                else:
                    self.misereQuotientB = 2
            if self.misereQuotientC > 2:
                self.misereQuotientA += (self.misereQuotientC-2)
                self.misereQuotientC = 2
            if self.misereQuotientD > 1:
                tmp = self.misereQuotientD%2
                if tmp == 0:
                    self.misereQuotientC += self.misereQuotientD
                    self.misereQuotientD = tmp
                else:
                    self.misereQuotientC += (self.misereQuotientD-1)
                    self.misereQuotientD = tmp
            if self.misereQuotientB > 1 and self.misereQuotientC > 0:
                self.misereQuotientB -= 2
            if self.misereQuotientB > 1 and self.misereQuotientD > 0:
                self.misereQuotientB -= 2
            if self.misereQuotientC > 0 and self.misereQuotientD > 0:
                self.misereQuotientC -= 1
                self.misereQuotientA += 1

    def update_monoid(self):
        #TODO: update misere Quotient (a, b, c, d)
        for board in self._boards:
            board.update_monoid()
        self.misereQuotientA, self.misereQuotientB, \
        self.misereQuotientC, self.misereQuotientD = 0,0,0,0
        for board in self._boards:
            mq_list = board.get_misere_quotient()
            self.misereQuotientA += mq_list[0]
            self.misereQuotientB += mq_list[1]
            self.misereQuotientC += mq_list[2]
            self.misereQuotientD += mq_list[3]
        self.conversion_mq()

    def make_move(self, board_index, pos):
        if board_index < 0 or board_index >= self.n_boards:
            print( 'Invalid move: Board index must be in [0,',self.n_boards-1,']. ')
            return False
        board = self._boards[board_index]
        if not board.is_dead():
            if not board.make_move(pos):
                return False
            self.update_monoid()
            return True
        else:
            print( 'This board is already dead.')
            return False
            #raise InvalieMove('This board is already dead.')

    def is_end(self):
        return not any(self.alive_board())

################################################################
def make_move(game, board_index):
    strInput = "Board [" + str(board_index)+']: put X in [1-9] '
    pos = -1
    while True:
        pos = input(strInput)
        pos -= 1
        if game.make_move(board_index, pos):
            break

def between_turns(game):
    if game.is_end():
        return False
    else:
        return True

def AI_rondom_move(game):
    import random
    print( '*** -------- AI turn --------- ***')
    while True:
        index = random.randint(0,2)
        pos = random.randint(1,9)-1
        if game.make_move(index, pos):
            print( 'AI has moved on Board [',index,'] : ', pos+1)
            break

def AI_move(game):
    def conversion_mq(misereQuotientA, misereQuotientB, misereQuotientC, misereQuotientD):
        while misereQuotientA > 1 or misereQuotientB > 2 or \
                misereQuotientC > 2 or misereQuotientD > 1 or\
                (misereQuotientB > 1 and misereQuotientC > 0) or \
                (misereQuotientB > 1 and misereQuotientD > 0) or \
                (misereQuotientC > 0 and misereQuotientD > 0):
            if misereQuotientA > 1:
                misereQuotientA %= 2
            if misereQuotientB > 2:
                if misereQuotientB%2 == 1:
                    misereQuotientB = 1
                else:
                    misereQuotientB = 2
            if misereQuotientC > 2:
                misereQuotientA += (misereQuotientC-2)
                misereQuotientC = 2
            if misereQuotientD > 1:
                tmp = misereQuotientD%2
                if tmp == 0:
                    misereQuotientC += misereQuotientD
                    misereQuotientD = tmp
                else:
                    misereQuotientC += (misereQuotientD-1)
                    misereQuotientD = tmp
            if misereQuotientB > 1 and misereQuotientC > 0:
                misereQuotientB -= 2
            if misereQuotientB > 1 and misereQuotientD > 0:
                misereQuotientB -= 2
            if misereQuotientC > 0 and misereQuotientD > 0:
                misereQuotientC -= 1
                misereQuotientA += 1
        return misereQuotientA, misereQuotientB, misereQuotientC, misereQuotientD

    def get_misere_quotient(board0, board1, board2):
        a,b,c,d = 0,0,0,0
        board_mq = nonisomorphic_board[board0], nonisomorphic_board[board1],\
                    nonisomorphic_board[board2]
        for item in board_mq:
            if item == '1':
                continue
            a += item.count('a')
            b += item.count('b')
            c += item.count('c')
            d += item.count('d')
        return conversion_mq(a,b,c,d)

    def is_P(a,b,c,d):
        if (a==1 and b==0 and c==0 and d==0) or \
            (a==0 and b==2 and c==0 and d==0) or \
            (a==0 and b==1 and c==1 and d==0) or \
            (a==0 and b==0 and c==2 and d==0):
            return True
        return False

    print( '*** -------- AI turn --------- ***')
    misereQuotientA, misereQuotientB, misereQuotientC, misereQuotientD = 0,0,0,0
    res = game.to_string()
#    print( res[0])
    if not res[0] == '':
        item = res[0]
        for i in range(9):
            if item[i] == '0':
                tmp = item[:i]+'1'+item[i+1:]
                a,b,c,d = get_misere_quotient(tmp, res[1], res[2])
                if is_P(a,b,c,d):
                    game.make_move(0, i)
                    print( 'AI has moved on Board [',0,'] : ', i+1)
#                    print( a,b,c,d)
#                    print( tmp)
#                    print( nonisomorphic_board['001000000'])
                    return
    if not res[1] == '':
        item = res[1]
        for i in range(9):
            if item[i] == '0':
                tmp = item[:i]+'1'+item[i+1:]
                a,b,c,d = get_misere_quotient(res[0], tmp, res[2])
                if is_P(a,b,c,d):
                    game.make_move(1, i)
                    print( 'AI has moved on Board [',1,'] : ', i+1)
                    return
    if not res[2] == '':
        item = res[2]
        for i in range(9):
            if item[i] == '0':
                tmp = item[:i]+'1'+item[i+1:]
                a,b,c,d = get_misere_quotient(res[0], res[1], tmp)
                if is_P(a,b,c,d):
                    game.make_move(2, i)
                    print( 'AI has moved on Board [',2,'] : ', i+1)
                    return

def player_move(game):
    print( '*** -------- your turn --------- ***')
    board_index = -1
    while True:
        board_index = input("Input board index [0, 2]: ")
        strInput = "Board [" + str(board_index)+']: put X in [1-9] '
        pos = input(strInput)
        pos -= 1
        if game.make_move(board_index, pos):
            print( 'You has moved on Board [',board_index,'] : ', pos+1)
            break

def runGame(n_boards):
    print( '##################################################')
    print( '###           3-Board Tic-Tac-Toe Game         ###')
    print( '##################################################')
    print( 'Rule: You will play aginst the AI, AI is the first move.')
    print( 'start: ')
    game = Game(n_boards,0,0,0,0)
    player = 1
    while(between_turns(game)):
        AI_move(game)
        game.print(_all_boards())
        player += 1
        if not between_turns(game):
            break
        player_move(game)
        game.print(_all_boards())
        player += 1
    if player%2 == 0:
        print( 'Congratulation, You win!')
    else:
        print( 'AI win! try harder.')

if __name__ == "__main__":
    runGame(3)


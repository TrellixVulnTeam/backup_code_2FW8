
import copy


class Board:

    def __init__(self, name):
        self.name = name
        self.board = []
        for i in range(3):
            self.board.append([])
            for j in range(3):
                self.board[i].append(int(i * 3 + j))

    def make_copy(self):
        board = Board(self.name)
        board.board = copy.deepcopy(self.board)
        return board

    def __is_win_horizon(self):
        for i in range(3):
            if self.board[i][0] == 'X' and self.board[i][1] == 'X' and self.board[i][2] == 'X':
                return True
        return False

    def __is_win_vertical(self):
        for i in range(3):
            if self.board[0][i] == 'X' and self.board[1][i] == 'X' and self.board[2][i] == 'X':
                return True
        return False

    def __is_win_diag(self):
        if self.board[0][0] == 'X' and self.board[1][1] == 'X' and self.board[2][2] == 'X':
            return True
        return False

    def __is_win_diag2(self):
        if self.board[2][0] == 'X' and self.board[1][1] == 'X' and self.board[0][2] == 'X':
            return True
        return False

    def is_finish(self):
        return self.__is_win_horizon() or self.__is_win_vertical() or self.__is_win_diag() or self.__is_win_diag2()

    def play(self, row, col):
        if self.board[row][col] == 'X':
            return False
        self.board[row][col] = 'X'
        return True

    def to_display(self):
        line = ['', '', '', '']
        line[0] += self.name + '     '
        for i in range(3):
            for j in range(3):
                line[i + 1] += str(self.board[i][j]) + ' '
        for i in range(4):
            line[i] += ' '
        return line

    def is_empty(self):
        for i in range(3):
            for j in range(3):
                if self.board[i][j] == 'X':
                    return False
        return True

    def is_lose_state(self):

        if self.is_finish():
            return True
        for i in range(3):
            for j in range(3):
                if self.board[i][j] != 'X':
                    newboard = self.make_copy()
                    newboard.play(i, j)
                    if newboard.is_lose_state():
                        return False
        return True

    def is_winning_state(self):
        if self.is_finish():
            return False
        for i in range(3):
            for j in range(3):
                if self.board[i][j] != 'X':
                    newboard = self.make_copy()
                    newboard.play(i, j)
                    if newboard.is_winning_state():
                        return False
        return True


class AIPlayer:
    # returns a list of four rotated boards
    def rotate(self, board):
        rotated_boards = [board]
        temp = list(board)
        for i in range(3):
            newBoard = list(board)
            newBoard[0] = temp[6]
            newBoard[1] = temp[3]
            newBoard[2] = temp[0]
            newBoard[3] = temp[7]
            newBoard[5] = temp[1]
            newBoard[6] = temp[8]
            newBoard[7] = temp[5]
            newBoard[8] = temp[2]
            temp = list(newBoard)
            for i in range(9):
                if temp[i] != 'X':
                    temp[i] = i
            rotated_boards.append(temp)
        return rotated_boards

    # returns a list of four refleted boards
    def reflect(self, board):
        reflectedBoards = []
        newBoard = list(board)
        newBoard[0] = board[6]
        newBoard[1] = board[7]
        newBoard[2] = board[8]
        newBoard[6] = board[0]
        newBoard[7] = board[1]
        newBoard[8] = board[2]
        for i in range(9):
            if newBoard[i] != 'X':
                newBoard[i] = i
        reflectedBoards.append(newBoard)
        newBoard = list(board)
        newBoard[0] = board[2]
        newBoard[2] = board[0]
        newBoard[3] = board[5]
        newBoard[5] = board[3]
        newBoard[6] = board[8]
        newBoard[8] = board[6]
        for i in range(9):
            if newBoard[i] != 'X':
                newBoard[i] = i
        reflectedBoards.append(newBoard)
        newBoard = list(board)
        newBoard[1] = board[3]
        newBoard[3] = board[1]
        newBoard[5] = board[7]
        newBoard[7] = board[5]
        newBoard[2] = board[6]
        newBoard[6] = board[2]
        for i in range(9):
            if newBoard[i] != 'X':
                newBoard[i] = i
        reflectedBoards.append(newBoard)
        newBoard = list(board)
        newBoard[0] = board[8]
        newBoard[8] = board[0]
        newBoard[1] = board[5]
        newBoard[5] = board[1]
        newBoard[3] = board[7]
        newBoard[7] = board[3]
        for i in range(9):
            if newBoard[i] != 'X':
                newBoard[i] = i
        reflectedBoards.append(newBoard)
        return reflectedBoards

    # returns a list of unique transformed boards by rotation or reflection
    def transform(self, board):
        totalBoards = self.rotate(board)
        for pattern in self.reflect(board):
            if pattern not in totalBoards:
                totalBoards.append(pattern)
        return totalBoards

    def isSpace(self, boards, moveInput):
        if moveInput[0] in boards.keys() and int(moveInput[1]) in range(9):
            return boards[moveInput[0]][int(moveInput[1])] != 'X'
        return False

    def getFingerprint(self, board):
        pattern_1 = [['X', 1, 2, 3, 4, 5, 6, 7, 8],
                     [0, 'X', 2, 3, 4, 5, 6, 7, 8],
                     ['X', 'X', 'X', 3, 4, 5, 6, 7, 8],
                     ['X', 1, 2, 3, 'X', 5, 6, 7, 'X'],
                     ['X', 1, 2, 3, 4, 'X', 6, 'X', 8],
                     [0, 'X', 2, 3, 'X', 5, 6, 'X', 8],
                     ['X', 'X', 'X', 'X', 4, 5, 6, 7, 8],
                     ['X', 'X', 'X', 3, 'X', 5, 6, 7, 8],
                     ['X', 'X', 'X', 3, 4, 5, 'X', 7, 8],
                     ['X', 'X', 'X', 3, 4, 5, 6, 'X', 8],
                     ['X', 'X', 2, 3, 'X', 5, 6, 'X', 8],
                     ['X', 'X', 2, 3, 'X', 5, 6, 7, 'X'],
                     ['X', 1, 'X', 3, 'X', 5, 'X', 7, 8]]
        pattern_a = [['X', 1, 2, 3, 4, 5, 6, 7, 'X'],
                     [0, 'X', 2, 'X', 4, 5, 6, 7, 8],
                     [0, 'X', 2, 3, 4, 5, 6, 'X', 8],
                     ['X', 'X', 2, 3, 4, 5, 'X', 7, 8],
                     ['X', 1, 'X', 3, 'X', 5, 6, 7, 8],
                     ['X', 1, 'X', 3, 4, 5, 6, 'X', 8],
                     ['X', 1, 2, 3, 'X', 'X', 6, 7, 8],
                     ['X', 'X', 2, 'X', 'X', 5, 6, 7, 8],
                     ['X', 'X', 2, 'X', 4, 'X', 6, 7, 8],
                     ['X', 'X', 2, 'X', 4, 5, 6, 7, 'X'],
                     ['X', 'X', 2, 3, 4, 5, 6, 'X', 'X'],
                     ['X', 1, 'X', 3, 4, 5, 'X', 7, 'X'],
                     [0, 'X', 2, 'X', 4, 'X', 6, 'X', 8],
                     ['X', 'X', 2, 3, 'X', 'X', 'X', 7, 8],
                     ['X', 'X', 2, 3, 4, 'X', 'X', 'X', 8],
                     ['X', 'X', 2, 3, 4, 'X', 'X', 7, 'X'],
                     ['X', 'X', 2, 'X', 4, 'X', 6, 'X', 'X']]
        pattern_b = [['X', 1, 'X', 3, 4, 5, 6, 7, 8],
                     ['X', 1, 2, 3, 'X', 5, 6, 7, 8],
                     ['X', 1, 2, 3, 4, 'X', 6, 7, 8],
                     [0, 'X', 2, 3, 'X', 5, 6, 7, 8],
                     ['X', 'X', 2, 'X', 4, 5, 6, 7, 8],
                     [0, 'X', 2, 'X', 4, 'X', 6, 7, 8],
                     ['X', 'X', 2, 3, 'X', 'X', 6, 7, 8],
                     ['X', 'X', 2, 3, 'X', 5, 'X', 7, 8],
                     ['X', 'X', 2, 3, 4, 'X', 'X', 7, 8],
                     ['X', 'X', 2, 3, 4, 5, 'X', 'X', 8],
                     ['X', 'X', 2, 3, 4, 5, 'X', 7, 'X'],
                     ['X', 1, 'X', 3, 'X', 5, 6, 'X', 8],
                     ['X', 1, 2, 3, 'X', 'X', 6, 'X', 8],
                     ['X', 'X', 2, 'X', 4, 'X', 6, 'X', 8],
                     ['X', 'X', 2, 'X', 4, 'X', 6, 7, 'X']]
        pattern_c = [[0, 1, 2, 3, 4, 5, 6, 7, 8]]
        pattern_d = [['X', 'X', 2, 3, 4, 'X', 6, 7, 8],
                     ['X', 'X', 2, 3, 4, 5, 6, 'X', 8],
                     ['X', 'X', 2, 3, 4, 5, 6, 7, 'X']]
        pattern_ab = [['X', 'X', 2, 3, 'X', 5, 6, 7, 8],
                      ['X', 1, 'X', 3, 4, 5, 'X', 7, 8],
                      [0, 'X', 2, 'X', 'X', 5, 6, 7, 8],
                      ['X', 'X', 2, 3, 4, 'X', 6, 'X', 8],
                      ['X', 'X', 2, 3, 4, 'X', 6, 7, 'X']]
        pattern_ad = [['X', 'X', 2, 3, 4, 5, 6, 7, 8]]
        pattern_c2 = [[0, 1, 2, 3, 'X', 5, 6, 7, 8]]
        living_patterns = pattern_1 + pattern_a + pattern_b + pattern_c + \
            pattern_d + pattern_ab + pattern_ad + pattern_c2
        transformedBoard = [i for i in self.transform(board)
                            if i in living_patterns][0]
        if transformedBoard in pattern_1:
            return {'1': 1}
        elif transformedBoard in pattern_a:
            return {'a': 1}
        elif transformedBoard in pattern_b:
            return {'b': 1}
        elif transformedBoard in pattern_c:
            return {'c': 1}
        elif transformedBoard in pattern_d:
            return {'d': 1}
        elif transformedBoard in pattern_ab:
            return {'a': 1, 'b': 1}
        elif transformedBoard in pattern_ad:
            return {'a': 1, 'd': 1}
        elif transformedBoard in pattern_c2:
            return {'c': 2}
        else:
            return False

    # returns the multiplied fingerprint of input boards
    def multiplyFP(self, boards):
        fingerprints = [self.getFingerprint(boards[key])
                        for key in ["A", "B", "C"]]
        totalFP = {}
        for boardFP in fingerprints:
            for cha in boardFP:
                if cha not in totalFP.keys():
                    totalFP[cha] = boardFP[cha]
                else:
                    totalFP[cha] += boardFP[cha]
        if '1' in totalFP.keys():
            if totalFP.keys() != ['1']:
                del totalFP['1']
            else:
                totalFP = {'1': 1}
        return totalFP


class Game:

    def __init__(self):
        self.boards = {'A': Board('A'), 'B': Board('B'), 'C': Board('C')}
        self.turn = 1
        self.ai_player = AIPlayer(self)

    def exchange_turn(self):
        if self.turn == 1:
            self.turn = 2
        else:
            self.turn = 1

    def is_lose(self):
        if len(self.boards) == 0:
            return True
        return False

    def play(self, line):
        if len(line) != 2:
            print('Invalid move, please input again')
            return False
        if not (line[1] >= '0' and line[1] <= '8'):
            print('Invalid move, please input again')
            return False
        if line[0] not in self.boards:
            print('Invalid move, please input again')
            return False
        index = int(line[1])
        row = index // 3
        col = index % 3
        if self.boards[line[0]].play(row, col):
            if self.boards[line[0]].is_finish():
                del self.boards[line[0]]
            self.exchange_turn()
        else:
            print('Invalid move, please input again')
            return False
        return True

    def display(self):
        lines = ['', '', '', '']
        for key in self.boards:
            x = self.boards[key].to_display()
            for i in range(4):
                lines[i] += x[i]

        for i in range(4):
            lines[i] = lines[i].strip()
        for i in range(4):
            print(lines[i])

    def is_all_empty(self):
        for key in self.boards:
            if not self.boards[key].is_empty():
                return False
        return True

    def ai_play(self):
        pass

    def run(self):
        while True:
            self.display()
            if self.turn == 1:
                line = self.ai_player.play()
                print('Player %d: %s' % (self.turn, line))
                self.play(line)
            else:
                while True:
                    line = input('Player %d: ' % self.turn).strip()
                    if self.play(line):
                        self.ai_player.push_player_step(line)
                        break
            if self.is_lose():
                break
        print('Player %d wins game' % self.turn)


if __name__ == '__main__':
    game = Game()
    game.run()


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
    def __init__(self, game):
        self.game = game
        self._corners = [0, 2, 6, 8]
        self._edges = [1, 3, 5, 7, 4]
        self.player_step_dict = {name: None for name in game.boards}
        self.player_board_name = None

    def push_player_step(self, line):
        name = line[0]
        index = int(line[1])
        self.player_step_dict[name] = index
        self.player_board_name = name

    def get_top_player_step(self):
        # pbn = self.player_board_name
        # if pbn is not None and \
        #     pbn in self.game.boards and \
        #     self._is_piece_count_even(self.game.boards[pbn].board):
        #     return [pbn, self.player_step_dict[pbn]]

        odd_boards = None
        for name, board in self.game.boards.items():
            if self._is_piece_count_even(board.board):
                return [name, self.player_step_dict[name]]
            else:
                odd_boards = [name, self.player_step_dict[name]]
        return odd_boards

    def get_order_boards(self):
        even_boards = []
        other_boards = []
        ret_dicts = {}
        for name, board in self.game.boards.items():
            if self._is_piece_count_even(board.board):
                even_boards.append(name)
            else:
                other_boards.append(name)
        for name in even_boards + other_boards:
            ret_dicts[name] = self.game.boards[name].board

        return ret_dicts


    def _is_piece_count_even(self, board):
        c = 0
        for i in range(0, 3):
            for j in range(0, 3):
                if board[i][j] == 'X':
                    c += 1
        return c % 2 == 0

    def play(self):
        ret = self._input_board_by_enemy()
        if ret is not None:
            self.push_player_step(ret)
            return ret

        s = self._random_input()
        self.push_player_step(s)
        return s

    def _random_input(self):
        backup = None
        for name, board in self.get_order_boards().items():
            for i in range(3):
                for j in range(3):
                    if board[i][j] != 'X':
                        backup = i * 3 + j
                        is_hor_win = self._is_hor_win(board, i)
                        is_ver_win = self._is_ver_win(board, j)
                        is_diag_win = self._is_diag_win(board, i, j)
                        is_win = is_hor_win or is_ver_win or is_diag_win
                        if not is_win:
                            return self._input(name, i * 3 + j)

        if backup != None:
            return self._input(name, backup)

    def _input(self, name, index):
        return '{0}{1}'.format(name, index)

    def _get_other_indexs(self, index):
        return self._corners.copy() if index in self._edges.copy() else self._edges.copy()

    def _get_another_board(self, name):
        for n, b in self.game.boards.items():
            if n != name:
                return n, b.board

    # 返回所需要放置在棋盘的x位置
    def _input_board_by_enemy(self):
        player_step = self.get_top_player_step()
        name = player_step[0]
        board = self.game.boards[name].board
        index = player_step[1]
        if index is None:
            return self._input(name, 4)
        if len(self.game.boards) == 2:
            ret = None
            if self._is_piece_count_even(board):
                an, ab = self._get_another_board(name)
                ret = self._input_to_lost(ab, an)
            else:
                ret = self._input_to_lost(board, name)

            if ret is not None:
                return ret

        return self._input_best(board, name, index)

    def _input_to_lost(self, board, name):
        for c_row in range(0, 3):
            for c_col in range(0, 3):
                if board[c_row][c_col] == 'X':
                    continue
                is_hor_win = self._is_hor_win(board, c_row)
                is_ver_win = self._is_ver_win(board, c_col)
                is_diag_win = self._is_diag_win(board, c_row, c_col)
                is_win = is_hor_win or is_ver_win or is_diag_win
                if is_win:
                    return self._input(name, c_row * 3 + c_col)
        return None
    # 缠斗
    def _input_best(self, board, name, index):
        row = index // 3
        col = index % 3

        def filter_by_no_match_index(index):
            c_row = index // 3
            c_col = index % 3
            return row != index // 3 and col != index % 3 and board[c_row][c_col] != 'X'

        curr_indexs = self._get_other_indexs(index)
        curr_indexs = list(filter(filter_by_no_match_index, curr_indexs))
        best_index = self._get_best_index(board, curr_indexs)
        if best_index is not None:
            return self._input(name, best_index)
        return None

    # 快速结束棋盘
    def _input_odd(self, board, name, index):
        pass

    def _get_best_index(self, board, indexs):
        if len(indexs) == 0:
            return None

        for i in range(0, len(indexs)):
            index = indexs[i]
            c_row = index // 3
            c_col = index % 3
            is_hor_win = self._is_hor_win(board, c_row)
            is_ver_win = self._is_ver_win(board, c_col)
            is_diag_win = self._is_diag_win(board, c_row, c_col)
            is_win = is_hor_win or is_ver_win or is_diag_win
  
            if not is_win:
                return index

        return None

    def _is_hor_win(self, board, row):
        return board[row].count('X') >= 2

    def _is_ver_win(self, board, col):
        c = 0
        for row_index in range(0, len(board)):
            if board[row_index][col] == 'X':
                c += 1
        return c >= 2

    def _is_diag_win(self, board, row, col):
        index = row * 3 + col

        # 当前点不在斜边上，无需判定
        if not index in [0, 2, 6, 8, 4]:
            return False

        diag1 = [0, 4, 8]
        if index in diag1 and self._is_win_index(board, diag1):
            return True

        diag2 = [2, 4, 6]
        if index in diag2 and self._is_win_index(board, diag2):
            return True

        return False

    def _is_win_index(self, board, indexs):
        count = 0
        for i in indexs:
            r = i // 3
            c = i % 3
            if board[r][c] == 'X':
                count += 1
        return count >= 2


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

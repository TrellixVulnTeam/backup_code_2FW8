import lesson

def test_RPS():
    all_choose = [
        ['paper', 'rock'],
        ['rock', 'scissors'],
        ['scissors', 'paper'],
    ]

    for select_value in all_choose:
        t1 = select_value[0]
        t2 = select_value[1]

        if lesson.winner_RPS(t1, t2) != t1 or \
            lesson.winner_RPS(t2, t1) != t1:
            print("Test FAIL")
            break

    print("Test SUCCESS")

    

if __name__ == "__main__":
    test_RPS()
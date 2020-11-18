def winner_RPS(t1, t2):
    #距离为1 大大于小,距离为2小大于2
    rs = {
        'rock': 1,
        'paper': 2,
        'scissors': 3,
    }
    ans = (rs[t1] - rs[t2] + 4) % 3 - 1
    if ans > 0:
        return t1
    elif ans < 0:
        return t2
    else:
        return "平局"

    


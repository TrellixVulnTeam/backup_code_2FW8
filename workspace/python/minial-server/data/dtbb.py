import json

def solution_speedup_perfect(money,choose_sz,choose_num_sz):
    """
    带空间压缩和进一步加速的 0-1 背包问题
    :param data: 数据集
    :return: 最优价值和放入背包的物品序号
    """
    with open("./data/goods.json", "r") as file:
        goodsname0 = json.load(file)

    goodslist = list(goodsname0.items())

    old = []
    weight = []
    value = []
    w = []
    w_p = []
    if(len(choose_sz)):
        choose = choose_sz[0]

    for i in range(0, len(goodslist)):
        a = goodslist[i][1]
        weight.append(float(a))
        old.append(float(a))
        value.append(1)
    for i in range(0, len(weight)):
        a = weight[i]
        w.append(int(a*10))
    #print(weight)
    v = weight

    must_choose_money = 0
    for i in range(0, len(choose_sz)):
        must_choose_money = must_choose_money + w[choose_sz[i]]*choose_num_sz[i]

    total = money*10


    if(len(choose_sz)):
        total = total - must_choose_money
        for i in range(0, len(w)):
            if(i in choose_sz ):
                continue
            else:
                w_p.append(w[i])
        w = w_p
        v = w

    item_num = len(w)

    dp = [0 for _1 in range(total + 1)]
    trace = [[] for _1 in range(total + 1)]
    for i in range(item_num):
        lower = max(total-sum(w[i:]), w[i])  # 修正下限，进一步加速
        for j in range(total, lower-1, -1):
            trace[j], dp[j] = (trace[int(j - w[i])] + [i], dp[j - w[i]] + v[i]) \
                if dp[j - w[i]] + v[i] > dp[j] else (trace[j], dp[j])

    c=0
    result = []                  #最终结果
    must = []
    flag=0
    bianhao=[]
    bianhao_result=[]
    for i in range(0,len(old)):
        bianhao.append(i)
    for i in range(0,len(bianhao)):
        if(flag<=len(choose_sz)):
            if(flag==len(choose_sz)):
                bianhao_result.append(bianhao[i])
            else:
                if(bianhao[i]==choose_sz[flag]):
                    flag=flag+1
                else:
                    bianhao_result.append(bianhao[i])#舟氏算法
    #print(bianhao)                   #测试语句
    #print(bianhao_result)            #测试语句
    #print(trace[total])              #测试语句
    if(len(choose_sz)):
        for i in range(0, len(choose_sz)):
            for j in range(0,choose_num_sz[i]):
                result.append(choose_sz[i])
                must.append(choose_sz[i])
        for j in range(0, len(trace[total])):
            #for i in range(0, len(choose_sz)):
                trace[total][j]=bianhao_result[trace[total][j]]

                '''if(trace[total][i]<choose_sz[0]):
                    trace[total][i]=trace[total][i]+0
                elif(trace[total][i]>=choose_sz[i]):
                    trace[total][i] = trace[total][i]+1
                    th.append(trace[total][i])
                    result.append(trace[total][i])'''
        for j in range(0,len(trace[total])):
            result.append(trace[total][j])
    else:
        #print(trace[total])
        c=c+1
    #print(result)                     #测试语句
    free = 0
    th = trace[total]

    for i in range(0,len(result)):
        free = free+old[result[i]]

    return must, th, free, result

def solution_speedup_more(money,choose_sz,choose_num_sz, son_th):
    """
    带空间压缩和进一步加速的 0-1 背包问题
    :param data: 数据集
    :return: 最优价值和放入背包的物品序号
    """
    with open("./data/goods.json", "r") as file:
        goodsname0 = json.load(file)

    goodslist = list(goodsname0.items())

    old = []
    weight = []
    value = []
    w = []
    w_p = []
    if(len(choose_sz)):
        choose = choose_sz[0]
    all_choose_sz = choose_sz
    all_choose_sz = all_choose_sz+son_th
    all_choose_sz.sort()
    for i in range(0, len(goodslist)):
        a = goodslist[i][1]
        weight.append(float(a))
        old.append(float(a))
        value.append(1)
    for i in range(0, len(weight)):
        a = weight[i]
        w.append(int(a*10))
    v = weight

    must_choose_money = 0

    for i in range(0, len(choose_sz)):
        must_choose_money = must_choose_money + w[choose_sz[i]]*choose_num_sz[i]
    #print(must_choose_money)             #测试语句
    total = money*10

    if(len(choose_sz)):
        total = total - must_choose_money
        for i in range(0, len(w)):
            if(i in all_choose_sz ):
                continue
            else:
                w_p.append(w[i])
        w = w_p
        v = w

    #print(w)                              #测试语句
    item_num = len(w)

    dp = [0 for _1 in range(total + 1)]
    trace = [[] for _1 in range(total + 1)]
    for i in range(item_num):
        lower = max(total-sum(w[i:]), w[i])  # 修正下限，进一步加速
        for j in range(total, lower-1, -1):
            trace[j], dp[j] = (trace[int(j - w[i])] + [i], dp[j - w[i]] + v[i]) \
                if dp[j - w[i]] + v[i] > dp[j] else (trace[j], dp[j])
    #print("s")                        #测试语句
    #print(trace[total])               #测试语句
    result = []#最终结果
    must = []
    flag = 0
    bianhao=[]
    bianhao_result=[]
    c=0
    for i in range(0,len(old)):
        bianhao.append(i)
    for i in range(0,len(bianhao)):
        if(flag<=len(all_choose_sz)):
            if(flag==len(all_choose_sz)):
                bianhao_result.append(bianhao[i])
            else:
                if(bianhao[i]==all_choose_sz[flag]):
                    flag=flag+1
                else:
                    bianhao_result.append(bianhao[i])#宋氏算法
    #print(bianhao)                        #测试语句
    #print(bianhao_result)                 #测试语句
    #print(trace[total])                   #测试语句
    if(len(choose_sz)):
        for i in range(0, len(choose_sz)):
            for j in range(0,choose_num_sz[i]):
                result.append(choose_sz[i])
                must.append(choose_sz[i])
        for j in range(0, len(trace[total])):
            #for i in range(0, len(choose_sz)):
                trace[total][j]=bianhao_result[trace[total][j]]

                '''if(trace[total][i]<choose_sz[0]):
                    trace[total][i]=trace[total][i]+0
                elif(trace[total][i]>=choose_sz[i]):
                    trace[total][i] = trace[total][i]+1
                    th.append(trace[total][i])
                    result.append(trace[total][i])'''
        for j in range(0,len(trace[total])):
            result.append(trace[total][j])
    else:
        #print(trace[total])
        c=c+1
    #print(result)                    #测试语句
    free = 0
    th = trace[total]

    for i in range(0,len(result)):
        free = free+old[result[i]]

    return must, th, free, result

def solution_speedup_perfect_without_choice(money):
    with open("./data/goods.json", "r") as file:
        goodsname0 = json.load(file)

    goodslist = list(goodsname0.items())
    old = []
    weight = []
    value = []
    w = []
    w_p = []
    for i in range(0, len(goodslist)):
        a = goodslist[i][1]
        weight.append(float(a))
        old.append(float(a))
        value.append(1)
    for i in range(0, len(weight)):
        a = weight[i]
        w.append(int(a*10))
    item_num=len(w)
    print(weight)
    v = weight
    total = money * 10
    dp = [0 for _1 in range(total + 1)]
    trace = [[] for _1 in range(total + 1)]
    for i in range(item_num):
        lower = max(total - sum(w[i:]), w[i])  # 修正下限，进一步加速
        for j in range(total, lower - 1, -1):
            trace[j], dp[j] = (trace[int(j - w[i])] + [i], dp[j - w[i]] + v[i]) \
                if dp[j - w[i]] + v[i] > dp[j] else (trace[j], dp[j])
    return dp[total],trace[total]
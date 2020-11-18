import json
from .dtbb import *
import operator
#------------------------------------------#
def create_son_list(items):

    if len(items) == 0:#若空返回空数组
        return [[]]
    subsets = []
    first_elt = items[0]  #第一个元素
    rest_list = items[1:]

    for partial_sebset in create_son_list(rest_list):
        subsets.append(partial_sebset)
        next_subset = partial_sebset[:] + [first_elt]
        subsets.append(next_subset)

    return subsets
#------------------------------------------#

def end(money,choose,choose_num):
    #money = 20                  # money为前端传入的数据（金额）
    #choose = []                 # choose为前端传入的用户的选择序号（加入用户有自己想选择的东西，以编号形式传入，比如该物品为json文件内第2个物品，则对应编号为1）
    #choose_num = []             # choose_num为前端传入的用户的选择物品对应的份数，如果顾客选择货物1，并且需要的数量为2个，则choose_num为2
    #choose.append(5)
    #choose_num.append(2)
    if(len(choose)):
        must, th, free, result_perfect = solution_speedup_perfect(money, choose, choose_num)
        #print(free,result_perfect)
        zuiyou=[]
        zuiyou.append(free)
        zuiyou.append(result_perfect)

        son_list = create_son_list(th)
        del(son_list[0])

        #print("多解：")

        more_result = [[] for i in range(len(son_list))]
        way_more = []                 #保存每一次计算出来的多解结果，用于判断当前结果是否重复
        way_more.append(result_perfect)
        k = 0
        for i in range(0, len(son_list)):
            son_th = son_list[i]
            must, th, free, result = solution_speedup_more(money, choose, choose_num, son_th)
            for j in range(len(way_more)):
                if(operator.eq(result,way_more[j])):
                    break
                else:
                    if(j==(len(way_more)-1)):
                        more_result[k].append(round(free,2))
                        more_result[k].append(result)
                        k = k+1
                        way_more.append(result)
                    continue
        #print(more_result)
        send_web=[]
        for i in range(0, k):
            #print(more_result[i])
            send_web.append(more_result[i])
        if(len(choose)):
            send_web.append(zuiyou)
            return send_web   #send_web为最后传至前端的方案列表，每个方案为一个列表，里面包含此方案的金额和此方案的具体的商品选择
            #print("eee")
    else:
        free, result_perfect = solution_speedup_perfect_without_choice(money)
        end_choice=[]
        end_choice.append(free)
        end_choice.append(result_perfect)
        return end_choice
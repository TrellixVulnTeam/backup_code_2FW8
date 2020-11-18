from flask import Flask, jsonify, request
import json
from utils import convert_goods_dict_to_list
from data.duojie import end
app = Flask(__name__)

@app.route('/goods')
def get_goods():
    f = open('./data/goods.json', 'r', encoding='utf-8')
    goods = json.load(f)
    goods = convert_goods_dict_to_list(goods)
    print(goods)
    return jsonify(goods)

@app.route('/calc', methods=['post'])
def calc():
    choose = request.json.get('choose', [])
    choose_num = request.json.get('choose_num', [])
    money = request.json.get('money', [])
    def str_to_int(s):
        return int(s)

    choose = list(map(str_to_int, choose))
    choose_num = list(map(str_to_int, choose_num))
    money = int(money)
    print(choose)
    print(choose_num)
    print(money)

    return jsonify(end(money, choose, choose_num))

app.debug = True
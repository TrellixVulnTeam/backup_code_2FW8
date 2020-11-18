def convert_goods_dict_to_list(goods_dict):
    l = []
    i = 0
    for k, v in goods_dict.items():
        l.append({
            'id': i,
            'name': k,
            'price': v,
        })
        i += 1 

    return l
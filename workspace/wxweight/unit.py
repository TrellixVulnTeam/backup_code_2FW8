def cnnumber_to_number(num_str):
    if num_str.endswith('万'):
        return float(num_str[:-1]) * 10000
    elif num_str.endswith('亿'):
        return float(num_str[:-1]) * 100000000
    else:
        return float(num_str)

def number_to_cnnumber(num, unit):
    if unit == '万':
        return str(round(num / 10000, 2))
    elif unit == '亿':
        return str(round(num / 100000000, 2))
    else:
        return num

def one_step_convert_num(num_str, unit):
    num = cnnumber_to_number(num_str)
    return number_to_cnnumber(num, unit)

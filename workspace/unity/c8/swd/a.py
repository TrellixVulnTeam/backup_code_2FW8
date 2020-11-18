import requests
import json
import base64
import os
import sys
import pandas as pd

API_KEY = ''
SECRET_KEY = ''

def get_token():
    params = {
        'grant_type': 'client_credentials',
        'client_id': API_KEY,
        'client_secret': SECRET_KEY
    }

    req = requests.get(
        'https://aip.baidubce.com/oauth/2.0/token?', params=params)
    content = req.content.decode('utf-8')
    data = json.loads(content)
    return data['access_token']

token = get_token()

def analysis_image_str(image):
    data = {'image': image}
    params = { 'access_token': token }
    headers = {'content-type': 'application/x-www-form-urlencoded'}
    req = requests.post("https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic", headers=headers, params=params, data=data)
    content = req.content.decode('utf-8')
    data = json.loads(content)
    return data

def get_base64_img(imgsrc):
    f = open(imgsrc, 'rb')
    img = base64.b64encode(f.read())
    return img.decode('utf-8')

def get_all_words(data):
    if not 'words_result' in data:
        return ''
    return ', '.join([v['words'] for v in  data['words_result']])


def get_words_in_file(file_name):
    image = get_base64_img(file_name)
    s = analysis_image_str(image)
    words = get_all_words(s)
    return words

def loop_dirs(file_dir):
    dcs = {}
    for root, dirs, files in os.walk(file_dir):
        for f in files:
            dcs[f] = get_words_in_file(file_dir + "\\" +  f)
            print('已提取文件 {0} 文字'.format(f))

    df = pd.DataFrame.from_dict(dcs,orient='index',columns=['提取文字'])
    df = df.reset_index().rename(columns = {'index':'名称'})
    df.to_excel(r'./output.xlsx')

loop_dirs(r'C:\Users\liiiv\Documents\Tencent Files\757160610\FileRecv\screenshoots_sample_48\screenshoots_sample_48')

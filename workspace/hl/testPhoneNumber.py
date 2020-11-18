import requests
import json
import xlrd
import time
import re

wb = xlrd.open_workbook("./test.xls")
sheet = wb.sheet_by_index(0)
phones = list(map(int, sheet.col_values(0)))

for phone in phones:
    html = requests.get('https://pay.91y.com/servlet/do.ashx?a=changeuser&acc={0}&t=0.11141897133276202'.format(phone),
        headers = {
            "Cookie": "Hm_lvt_64f9bb47cd627a8a4069b1e07b127e1f=1562516463; pkRegisterToolEx=ef43a7ea96e132044bda08a28336f54f4d75f345dd865554ce4b84f0b84584d1c758680f1a3125f43fc34b7afddd4875d047506d9f1bcb53317111bbdaf0026e6d6685a2880eb65d92b19b7ef78858229302a6d62ef99d60882fb083a4a7fe6f6f24af31439560b90dcc8affbccdfb4e74f33717586072a85724ccec5e74345ee94a0b2141e347d1; Hm_lpvt_64f9bb47cd627a8a4069b1e07b127e1f=1562516596; mUser_91y=uinfo=3281c469116d19fb9eb7c657c194bc20df04d95255b5cdc32ad53f843218d1f297b9158ec33078f1a0293afdc5520fe0b27c6894da6e8b1f4d2cb6fb667c6e7e&sign=ef50bd531be3da9ee0a3bf638bb944a1&some=b061460e0b10011dc92375958cb637e90a43663cc2def149d970c4e6e4f0aea627dfd8cc2a9ce8af&tginfo=",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"
        }).content.decode()

    a = re.findall(r"Accounts:\s'(\d*)?'", html)

    pj = "存在"
    if len(a) > 0 and a[0] == '0':
        pj = '不存在'

    answer = "{0} {1}\n".format(phone, pj)
    print(answer)
    with open('asas.json', 'a', encoding='utf-8') as f:
        f.write(answer)

    time.sleep(2)

import requests
import json
from lxml import etree
import seaborn as sns
import pandas as pd

base_url = 'http://www.mtime.com/top/movie/top100/'
config_headers = {
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36'
}

#数据爬取
def get_page(page_count):
    res = requests.get("https://www.top500.org/list/2019/11/?page={0}".format(page_count), headers = config_headers)
    return res.content.decode('utf-8')

def parse(data):
    html = etree.HTML(data)
    with open('a', 'w', encoding='utf-8') as f:
        f.write(data)
    computer_list = html.xpath("//table/tr")
    return [parse_item(item) for item in computer_list]

#数据清洗
def parse_item(item):
    d = {}
    d['rank'] = item.xpath('string(./td[1])')
    d['country'] = item.xpath('./td[2]/text()')
    d['company'] = item.xpath('./td[3]/text()')
    d['name'] = item.xpath('string(./td[3]/a/b)')
    d['cores'] = item.xpath('./td[4]/text()')
    d['rmax'] = item.xpath('./td[5]/text()')
    for key, v in d.items():
        if isinstance(v, list) and len(v) > 0:
            d[key] = v[0]
    return d


parse_data = []
for i in range(1, 6):
    data = get_page(i)
    clear_data = parse(data)
    parse_data.extend(clear_data)

pd.DataFrame(parse_data).to_csv('data.csv')

def get_column(dc, column_name):
    return ','.join([item[column_name] for item in dc])


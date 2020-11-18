import requests
import re
import json
import time
from lxml import etree
url = "https://www.cnstats.org/e/search/result/?searchid=1726"
headers = {
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36",
    "referer": "https://www.cnstats.org/tjgb/201903/gzzgzz-2018-klm_3.html",
}

report_link_pattern = '<a.*?href="(\S+)".*{0}.*国民经济.*社会发展.*统计公报.*/a>'

search_dict = {
    # '阿坝州': 'https://www.cnstats.org/e/search/result/?searchid=872',
    # '甘孜州': 'https://www.cnstats.org/e/search/result/?searchid=1726',
    # '凉山州': 'https://www.cnstats.org/e/search/result/?searchid=182',
    # '怒江州': 'https://www.cnstats.org/e/search/result/?searchid=381',
    # '迪庆藏族自治州': 'https://www.cnstats.org/e/search/result/?searchid=1069',
    # '昌都市': 'https://www.cnstats.org/e/search/result/?searchid=455',
    # '山南市': 'https://www.cnstats.org/e/search/result/?searchid=2656',
    # # '日喀则': '' 无数据,
    # # '那曲': '', 无数据
    # # '阿里': '', 无数据
    # # '林芝市': '' 无数据
    # '临夏州': 'https://www.cnstats.org/e/search/result/?searchid=1198',
    # '甘南州': 'https://www.cnstats.org/e/search/result/?searchid=1868',
    # '黄南州': 'http://www.cnstats.org/e/search/result/?searchid=2604',
    # '海南藏族自治州': 'https://www.cnstats.org/e/search/result/?searchid=2607',
    # '果洛藏族自治州': 'https://www.cnstats.org/e/search/result/?searchid=3826',
    # '玉树藏族自治州': 'https://www.cnstats.org/e/search/result/?searchid=1584',
    # '阿克苏地区': 'http://www.cnstats.org/e/search/result/?searchid=1906',
    # '克孜勒苏柯尔克孜自治州': 'http://www.cnstats.org/e/search/result/?searchid=4062',
    # '喀什地区': 'http://www.cnstats.org/e/search/result/?searchid=1386',
    '和田地区':'http://www.cnstats.org/e/search/result/?searchid=2012',
    '西藏': 'http://www.cnstats.org/e/search/result/?searchid=1212'
}

years = [2014, 2015, 2016, 2017, 2018]


def re_find_one(pattern, string):
    ans = re.findall(pattern, string)
    return ans[0] if len(ans) > 0 else None


def get_html(url, decode='utf-8'):
    try:
        req = requests.get(url, headers=headers, verify=False)
        content = req.content.decode(decode)
        return content
    except:
        time.sleep(3)
        print("重试连接")
        return get_html(url, decode)


def get_report_links(url):
    html = get_html(url)
    links = {}
    for year in years:
        c_report_link_pattern = report_link_pattern.format(year)
        pp = re_find_one(c_report_link_pattern, html)
        if pp is not None:
            links[year] = pp
    return links


# //a[contains(text(),"下一页")]/@href
def get_entire_report(url):
    if url is None:
        return ""
    html = get_html("https://www.cnstats.org{0}".format(url))
    et = etree.HTML(html)
    next_link = get_xpath_string(et, '//a[contains(text(),"下一页")]/@href')
    content = get_xpath_string(et, 'string(//article//ul)')
    return content + get_entire_report(next_link)


def get_xpath_string(htree, path):
    req = htree.xpath(path)
    if isinstance(req, str):
        return req

    if len(req) > 0:
        return req[0]
    return None

# 得到整片文章,再进行解析,特定函数


def analysis_iter(num_str, serving):
    if num_str is None:
        return num_str
    num = cnnumber_to_number(num_str)
    return round(num / serving, 2)


def analysis_report(report_content):
    d = {}
    resident = get_resident(report_content)
    if resident is None:
        return d
    resident_str = resident
    resident = int(cnnumber_to_number(resident))

    tourist_trips = get_tourist_trips(report_content)
    tourist_trips_avg = analysis_iter(tourist_trips, resident)
    tourist_income = get_tourist_income(report_content)
    tourist_income_avg = analysis_iter(tourist_income, resident)

    gdp = get_capita_gdp(report_content)
    gdp_per_capita = analysis_iter(gdp, resident)

    village_avg_money = one_step_convert_num(
        get_village_avg_money(report_content), "元")

    return {
        'resident': one_step_convert_num(resident_str, "万"),
        'tourist_trips': one_step_convert_num(tourist_trips, "万"),
        'tourist_income': one_step_convert_num(tourist_income, "亿"),
        'tourist_trips_avg': tourist_trips_avg,
        'tourist_income_avg': tourist_income_avg,
        'gdp': gdp,
        'gdp_per_capita': gdp_per_capita,
        'village_avg_money': village_avg_money,
    }


def get_resident(c):
    s = re_find_one(r'常住\w*?人口\w*?(\d+\.?\d*[万|亿]?)', c)
    if s is None:
        s = re_find_one(r'户籍\w*?人口\w*?(\d+\.?\d*[万|亿]?)', c)
    if s is None:
        s = re_find_one(r'总人口\w*?(\d+\.?\d*[万|亿]?)', c)

    return s

def get_tourist_trips(c):
    s = re_find_one(r'接待\w*?游客.*?(\d+\.?\d*[万|亿]?)', c)
    if s is None:
        s = re_find_one(r'[旅游|游客]\w*?(\d+\.?\d*[万|亿]?)人次', c)
    return s

def get_tourist_income(c):
    s = re_find_one(r'旅游\w*?收入\w*?(\d+\.?\d*[万|亿]?)元', c)
    return s

def get_capita_gdp(c):
    s = re_find_one(r'生产总值\S*?(\d+\.?\d*[万|亿]?)元', c)
    return s

def get_village_avg_money(c):
    s = re_find_one(r'可支配收入.*?(\d+\.?\d*[万|亿]?)元', c)
    return s

def main():
    for name, url in search_dict.items():
        links = get_report_links(url)
        city_datas = []
        for year, link in links.items():
            report_content = ' '.join(get_entire_report(link).split())
            d = analysis_report(report_content)
            d['year'] = year
            d['cityname'] = name
            city_datas.append(d)
        with open('extra.json', 'a+') as f:
            json.dump(city_datas, f)

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
    if num_str is None:
        return None
    num = cnnumber_to_number(num_str)
    return number_to_cnnumber(num, unit)

if __name__ == "__main__":
    main()

import requests
from lxml import etree
import json
import pymysql
con = pymysql.connect(host='127.0.0.1',
                           port=3306,
                           user='root',
                           password='',
                           database='ci_demo',
                           charset='latin1')


url = "https://tiku.21cnjy.com/tiku.php?mod=list&channel=8&xd=3&page={0}"

def getPage(count):
    cur = con.cursor()
    html = requests.get(url.format(count), headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36"
    })


    json_texts = []
    tree = etree.HTML(html.content.decode().encode('utf-8'))
    li_list = tree.xpath("//div[@class='questions_col']/ul/li")
    for li in li_list:
        topic = ''.join(li.xpath("./text()")).strip()
        options_xml = li.xpath(".//table//td")
        options = []
        for option_xml in options_xml:
            txt = option_xml.xpath("./text()")
            options.append(''.join(txt).strip())
        answer_url = ''.join(li.xpath("./p/a[1]/@href"))
        answer = getAnswer(answer_url)
        if (answer in ['a', 'b', 'c', 'd', 'A', 'B', 'C', 'D']):
            json_texts.append(json.dumps(create_json(topic, options, answer)))
    cur.executemany("INSERT INTO topics (body) VALUES (%s)", json_texts)
    con.commit()
    cur.close()

def getAnswer(url):
    url = "https://tiku.21cnjy.com/" + url
    html = requests.get(url, headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36"
    })
    tree = etree.HTML(html.text)
    answer = ''.join(tree.xpath("//div[@class='answer_detail']//dd/p[1]/i/text()")).strip()
    return answer

def create_json(content, options, answer):
    a = ord(answer.upper()) - 65
    return {
        'type': 1,
        'content': content,
        'options': options,
        'answer': a
    }


# with open('a.html', 'w', encoding="utf-8") as f:
#     json.dump(json_texts, f, ensure_ascii=False)


for i in range(1, 100):
    getPage(i)
    print("爬取完成, 第{0}页".format(i))

con.close()
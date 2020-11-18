import requests
import json
import xlrd
import csv
import time
import re
from lxml import etree
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import threading

cookies = "thw=cn; cna=u906Ff6nfFwCAdz5og//Ovg4; t=4ba7cc13ae7a94e210d2fc04f4ce1a5f; tracknick=acldmx; tg=0; enc=psyUCCg4T9ePXxoFH7l6KqyOHLRJitzytD7dvdx1hXsLivKRBkFSNF30PiLv%2BOJ5sS4ubHA9zoLZju6kaZMa9Q%3D%3D; hng=CN%7Czh-CN%7CCNY%7C156; UM_distinctid=16a2b948fb6771-023c1c04939e4d-e323069-1fa400-16a2b948fb762d; miid=781096711244671256; _uab_collina=155992721084150063607568; lgc=acldmx; x=e%3D1%26p%3D*%26s%3D0%26c%3D0%26f%3D0%26g%3D0%26t%3D0%26__ll%3D-1%26_ato%3D0; uc3=vt3=F8dBy3jfBJ8LbHLzXAs%3D&id2=UUGrctUQTUSvRQ%3D%3D&nk2=AnIjDs0V&lg2=Vq8l%2BKCLz3%2F65A%3D%3D; _cc_=VFC%2FuZ9ajQ%3D%3D; mt=ci=41_1&np=; _m_h5_tk=5d55e58021ef180c63c807a86f690810_1560008363985; _m_h5_tk_enc=8f0771d2b0e057c80da2ac4a1e8f513f; v=0; uc1=cookie14=UoTaGOizX7am0g%3D%3D; cookie2=1ab25ed0d7216b93fc0e7d6af0ede878; _tb_token_=ee3b575eae6e7; tk_trace=oTRxOWSBNwn9dPyorMJE%2FoPdY8zZPEr%2FCrvCMS%2BG3sTRRWrQ%2BVVTl09ME1KrXEsGXVDctvUOUoDf1Biq%2BfidlgcpkkNmYCdoo6dIa3s2uSNgnDYiPezTkmu%2BMoV2%2FpQVj%2B4kep7KTDxm4Jpn0I6Uxe2blopNa4rHXiJXX0WUPtzUaolGv%2BFxj47v7C9JykoLApQbAFiq6HHycVTpsyS6LaukwUBuXCiJRlYHcJBvs%2FuFkR7pyT7%2F5kp8qHpPyO3Cnv%2FKi8bvuvvwulYQlZkUxco877CKpj1PVg2UJ7QtJNOXIssPuiGrB1I5XWrDGPzyckc9wmRSYNgSy3vtQg8c; MIDWAY_SESS=hY-yC9urlu4-bScoL2ggVk22jK9GlGQAqqMhBmGEu7SXPcq1lqEZlBVJIFFMpy-rjT44Z8q1mSpXD4jOLDRDZKRIOR_alIihSHb9EyKvHDrwO5Vs281qUUhl_0anYAUB; l=bBLv-pLHvGE1XYtdBOCwmuIJH8_TbIRAguPRwppWi_5a96Y6kMQOlFcORFv6Vj5RseYH4s6vWje9-etlw; isg=BGlpRqWOEWPE6y2YdrU_nQ8PeBUDnm_KOztWEwte5dCP0onkU4ZtOFfElDbByvWg"

feedId = '5d1639f5-b854-454d-99cd-00bb2dc6dd06'
def getItemsUrl(feedId):
    url = "https://taobaolive.taobao.com/api/live_detail/1.0?creatorId=&liveId={0}".format(feedId)
    print("爬取 " + feedId)
    html = requests.get(url, headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
        "referer": "https://taobaolive.taobao.com/room/index.htm?{0}".format(feedId),
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-encoding": "gzip, deflate, br",
        "accept-language": "zh-CN,zh;q=0.9",
        "cookie": cookies,
        "x-requested-with": "XMLHttpRequest"},)
    
    js = json.loads(html.content.decode())
    print(js)
    return {
        "liveId": js['result']['liveId'],
        "creatorId": js['result']['accountId']
    }
    
def getItems(feedId, filename):
    browers = webdriver.Chrome()
    flag = getItemsUrl(feedId)
    url = "https://taobaolive.taobao.com/api/item_list/1.0?type=0&creatorId={0}&liveId={1}".format(flag['creatorId'], flag['liveId'])
    print(url)
    items = requests.get(url,  headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
        "referer": "https://taobaolive.taobao.com/room/index.htm?{0}".format(feedId),
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-encoding": "gzip, deflate, br",
        "accept-language": "zh-CN,zh;q=0.9",
        "cookie": cookies,
        "x-requested-with": "XMLHttpRequest"})
    items_js = json.loads(items.content.decode())
    item_list = items_js['result']['data']['itemList']
    datas = []
    for item in item_list:
        data = {'name': 'undefined', 'price': 'undefined', 'service': 'undefined', 'logistics': 'undefined', 'public': 'undefined', 'assess': 'undefined', 'score': 'undefined'}
        itemId = item['goodsList'][0]['itemId']
        p = requests.get("https://detail.tmall.com/item.htm?id={0}".format(itemId), headers = {
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "cookie": cookies,
            "accept": "application/json, text/javascript, */*; q=0.01",
            "accept-encoding": "gzip, deflate, br",
            "accept-language": "zh-CN,zh;q=0.9",
            "cookie": cookies,
        })
        # with open("s.html", 'wb') as f:
        #      f.write(p.content)
        itemH5TaokeUrl = item['goodsList'][0]['itemH5TaokeUrl']
        data['name'] = item['goodsList'][0]['itemName']
        data['price'] = item['goodsList'][0]['itemPrice']

        try:
            browers.get("https:{0}".format(itemH5TaokeUrl))
            # browers.implicitly_wait(20)
            
            scores = browers.find_elements_by_class_name("shopdsr-score")
            s = ["", "service", "logistics"]
            for score_index in range(1, len(scores[:3])):
                score = scores[score_index].text
                data[s[score_index]] = score

            public = None
            try:
                public = browers.find_element_by_id("J_CollectCount")
            except:
                pass
            
            try:
                public = browers.find_element_by_class_name("J_FavCount")
            except:
                pass

            if public:
                public_text = re.findall("（(.+)人气）", public.text)
                if (len(public_text) > 0):
                    data['public'] = public_text[0]

            pjs = browers.find_elements_by_class_name("tm-indcon")
            for pj in pjs:
                if (pj.text.find("累计评价")) != -1:
                    data['assess'] = pj.text[4:]
            browers.execute_script("document.documentElement.scrollTop = 300")
            browers.execute_script("document.querySelector('#sufei-dialog-close').click()")
            btn = browers.find_element_by_css_selector("a[href='#J_Reviews']")
            if btn:
                btn.click()
            #使用selenium打开网页 > 正则匹配获取数据 > 再爬取下一个
            # p_tree = etree.HTML(p.content.decode())
            # ss = p_tree.xpath("//div[@class='main-info']//span[@class='shopdsr-score-con']")
            # print(ss)
            time.sleep(3)
            score = browers.execute_script("return document.querySelector('h4+strong').innerText")
            if score:
                data['score'] = score
        except:
            pass
        datas.append(data)
        print(data)
        # (feedId.replace('-', '_') + ".json"
        with open(filename, 'a', encoding="utf-8", newline = "") as f:
            csv_write = csv.writer(f, dialect="excel")
            csv_write.writerow(data.values())

def getfeedIds():
    workbook = xlrd.open_workbook(u's.xlsx')
    sheet1 = workbook.sheet_by_name("Sheet1")
    feeds = []
    for row_index in range(1, sheet1.nrows):
        row = sheet1.row_values(row_index)
        feeds.append(row[1].split("=")[-1])
    return feeds

def getFeedList(feeds, filename):
    for feed in feeds:
        getItems(feed, filename)

def dfList(listTemp, n):
    s = []
    for i in range(0, len(listTemp), n):
        s.append(listTemp[i:i + n])
    return s

if __name__ == "__main__":
    feeds = getfeedIds()
    #分离数组
    feed_lists = dfList(feeds, 64)
    threads = []
    #创建线程
    index = 0
    for feed in feed_lists:
        t = threading.Thread(target=getFeedList,args=(feed, "s{0}.csv".format(index)))
        threads.append(t)
        index+=1

    for t in threads:
        t.setDaemon(True)
        t.start()
    t.join()

    # for feed in feeds:
    #     getItems(feed)


# getItems(feedId)
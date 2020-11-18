import requests
import json
import csv
import datetime

url = "https://www.ctg.com.cn/eportal/ui?moduleId=50c13b5c83554779aad47d71c1d1d8d8&&struts.portlet.mode=view&struts.portlet.action=/portlet/waterFront!getDatas.action"

data = {

}

def loadConfig():
    config = {}
    with open('./config.json', 'r', encoding="utf-8") as f:
        config = json.load(f)

    return config
    
def getSXJSON(time):
    html = requests.post(url, data = {
        "time": time
    }, headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
        "X-Requested-With": "XMLHttpRequest",
    })

    return json.loads(html.content.decode())

def parseCol(name, arrs):
    s = [name]
    for arr in arrs:
        s.extend([arr['time'], arr['v']])
    return s

def parseAll(arrs):
    datas = []
    datas.append(parseCol("出库", arrs['ckList']))
    datas.append(parseCol("入库", arrs['rkList']))
    datas.append(parseCol("上游水位", arrs['syList']))
    datas.append(parseCol("下游水位", arrs['xyList']))
    return datas

if __name__ == "__main__":
    config = loadConfig()
    js = getSXJSON(config['time'])
    try:
        datas = parseAll(js)
        date = datetime.datetime.strptime(config['time'], "%Y-%m-%d")
        with open("sx.csv", 'a', encoding="gbk", newline="") as f:
            writer = csv.writer(f, dialect="excel")
            writer.writerow([config['time']])
            for data in datas:
                writer.writerow(data)
        newDate = date + datetime.timedelta(days=1)
        with open("./config.json","w") as f:
            json.dump({
                "time": newDate.strftime("%Y-%m-%d")
            },f)
        print("爬取成功!")
    except:
        print("爬取失败")
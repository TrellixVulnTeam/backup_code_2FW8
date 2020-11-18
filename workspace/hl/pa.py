import requests
import json
import csv

#是否存在表头
isHeader = False

def handleJson(data):
    product = data['product']
    infos = []
    for item in product:
        if type(item) != dict:
            continue
        info = {}

        try:
            info['id'] = item['pid']
            info['名称'] = item['pname']
            info['价格'] = item['price']['price']
            info['经度'] = item['pos']['lat']
            info['纬度'] = item['pos']['lng']
            info['房型'] = "{0}".format(item['rname'],)
            info['宜住'] = "{0}人".format(item['people'],)
            info['床位'] = item['beds']
            info['评分'] = item['commentScore']
            info['评价'] = item['commentDesc']
            info['喜欢'] = item['favorites']
        except:
            pass

        info = dict(info, **getExtraInfo(item['pid']))

        try:
            detail = getDetailInfo(item['pid'])
            info = dict(info, **detail)
        except:
            pass
        # try:
        # except:
        #     item['comments'] = []

        infos.append(info)
    with open('ak.csv', 'a', encoding='utf-8', newline="") as f:
        csv_writer = csv.writer(f, dialect='excel')

        for info in infos:
            global isHeader
            if not isHeader:
                csv_writer.writerow(info.keys())
                isHeader = True

            csv_writer.writerow(info.values())
        

def delDictKeys(d, *keys):
    for key in keys:
        if key in d:
            del d[key]

def mapComments(comment):
    return comment['content'] if type(comment) == dict and 'content' in comment else ""

def getDetailInfo(pid):
    infoDetail = json.loads(requests.post('https://m.ctrip.com/restapi/soa2/12455/json/BnbCommentList?_fxpcqlniredt=09031107110690501469', data = json.dumps({
    "pid": pid,
    "searchType": 2,
    "tagId": 0,
    "pageindex": 0,
    "pageSize": 30,
    "order": 0,
    "head": {
        "cid": "09031107110690501469",
        "ctok": "",
        "cver": "1.0",
        "lang": "01",
        "sid": "8888",
        "syscode": "09",
        "auth": "",
        "xsid": "",
        "extension": [
            {
                "name": "webp",
                "value": "1"
            },
            {
                "name": "cityid",
                "value": ""
            },
            {
                "name": "platform",
                "value": "pc"
            },
            {
                "name": "source",
                "value": "2"
            },
            {
                "name": "pagecode",
                "value": "10650016818"
            },
            {
                "name": "module",
                "value": "11"
            }
        ]
    }

})).content.decode())
    # with open('ax.json', 'a', encoding="utf-8") as f:
    #     json.dump(infoDetail, f, ensure_ascii=False)

    # comments = infoDetail['clist']
    info = {}
    rate = infoDetail['rateStat']
    info['点评数'] = infoDetail['count']
    info['周边环境评分'] = rate['avgEnvironmentRate']
    info['设施设备评分'] = rate['avgFacilityRate']
    info['房东服务评分'] = rate['avgHygieneRate']
    info['房间卫生评分'] = rate['avgEnvironmentRate']
    return info


def getExtraInfo(pid):
    try:
        url = "https://m.ctrip.com/restapi/soa2/12455/json/LegendOwnerDetail?_fxpcqlniredt=09031107110690501469"
        js = json.loads(requests.post(url, data = json.dumps({
            "ownerid": "$$3588873",
            "pid": pid,
            "head": {
            "cid": "09031107110690501469",
            "ctok": "",
            "cver": "1.0",
            "lang": "01",
            "sid": "8888",
            "syscode": "09",
            "auth": "",
            "xsid": "",
            "extension": [
                {
                    "name": "webp",
                    "value": "1"
                },
                {
                    "name": "cityid",
                    "value": ""
                },
                {
                    "name": "platform",
                    "value": "pc"
                },
                {
                    "name": "source",
                    "value": "2"
                },
                {
                    "name": "pagecode",
                    "value": "10650016818"
                },
                {
                    "name": "module",
                    "value": "11"
                }
            ]
        }
        })).content.decode())
        info = {}
        info['属性'] = '个人房东' if js['userType'] == 2  else '商户房东'
        info['房源数量'] = js['spaceCount']
        return info
    except:
        return {}


url = "https://m.ctrip.com/restapi/soa2/12455/prod/json/searchProduct?_fxpcqlniredt=09031107110690501469"

index = 1
while True:
    body = {
        "pindex": index,
        "pSize": 30,
        "orderBy": 0,
        "conds": [
            {
                "cond": "date",
                "value": "2019-07-07,2019-07-08"
            }
        ],
        "cityid": 14,
        "cityname": "苏州",
        "head": {
            "cid": "09031107110690501469",
            "ctok": "", 
            "cver": "1.0",
            "lang": "01",
            "sid": "8888",
            "syscode": "09",
            "auth": "",
            "xsid": "",
            "extension": [
                {
                    "name": "webp",
                    "value": "1"
                },
                {
                    "name": "cityid",
                    "value": ""
                },
                {
                    "name": "platform",
                    "value": "pc"
                },
                {
                    "name": "source",
                    "value": "2"
                },
                {
                    "name": "pagecode",
                    "value": "10650016817"
                },
                {
                    "name": "module",
                    "value": "11"
                }
            ]
        }
    }

    js = json.loads(requests.post(url, data=json.dumps(body)).content.decode())
   
    handleJson(js)
    print("已爬取第{0}页".format(index))
    if js['hasNext'] != True:
        break
    index+=1


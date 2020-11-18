import requests

req = requests.get('https://club.jd.com/comment/productPageComments.action',
params = {
    'productId': 7868262,
    'score': 1,
    'sortType': 6,
    'page': 1,
    'pageSize': 10,
    'isShadowSku': 0,
    'rid': 0,
    'fold': 1,
},
headers = {
    "Referer": "https://item.jd.com/3337468.html",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"
})

print(req.content)
import requests
url = "https://520xiyan.com/api/v1/calendar?month={0}-{1}"

for year in range(2019, 2022):
    for month in range(1, 13):
        html = requests.get(url.format(year, month), headers = {
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
        })
        with open("j{0}_{1}.json".format(year, month), "w", encoding="utf-8") as f:
            f.write(html.content.decode())



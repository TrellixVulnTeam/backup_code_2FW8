import csv
import json

f = open('a.csv', 'w', encoding='utf-8', newline="")
csv_write = csv.writer(f, dialect='excel')

data = None
with open('ss.json', 'r', encoding='utf-8') as js_file:
    data = json.load(js_file)

is_header = False
for item in data:
    if not is_header:
        csv_write.writerow(item.keys())
        is_header=True
    csv_write.writerow(item.values())
    
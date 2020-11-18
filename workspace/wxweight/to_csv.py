import json
import pandas as pd
file = open('extra.json', 'r', encoding='utf-8')
data = json.load(file)

data = pd.DataFrame(data)

data.to_csv('s.csv')
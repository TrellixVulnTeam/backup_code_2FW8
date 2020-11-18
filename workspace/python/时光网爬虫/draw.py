import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

f = open('data.csv',encoding='UTF-8')
data = pd.read_csv(f,sep=',',header=None,encoding='UTF-8',names=['rank','country','company','name','ores','rmax'])

#各国家拥有超级电脑数量
country = data['country'].value_counts()
sns.set_style("darkgrid")
bar_plot = sns.barplot(x=(country.index),y=country.values, palette="muted")
plt.xticks(rotation=90)
plt.show()

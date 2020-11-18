import matplotlib.pyplot as plt
from wordcloud import WordCloud
import pandas as pd

f = open('data.csv',encoding='UTF-8')
data = pd.read_csv(f,sep=',',header=None,encoding='UTF-8',names=['rank','country','company','name','ores','rmax'])

def draw_country_wordcloud():
    country_str = ",".join(data['country'])
    #生成国家词云
    country_wordcloud = WordCloud(background_color="white",width=1000, height=860, margin=2).generate(country_str)
    #生成公司词云
    plt.imshow(country_wordcloud)
    plt.axis("off")
    plt.show()
    country_wordcloud.to_file('country_wordcloud.png')

def draw_company_wordcloud():
    company_str = ",".join(data['company'])
    company_wordcloud = WordCloud(background_color="white",width=1000, height=860, margin=2).generate(company_str)
    plt.imshow(company_wordcloud)
    plt.axis("off")
    plt.show()
    company_wordcloud.to_file('country_wordcloud.png')


# draw_country_wordcloud()
draw_company_wordcloud()
from os.path import dirname, join
from bokeh.plotting import figure, output_file, show
import pandas as pd

data = pd.read_csv('data/datas.csv')
p = figure(x_range=list(data.get('university').values[:10]), plot_width=1200, plot_height=600, x_minor_ticks = 20)

s = data.get('2017').values[:10]
p.vbar(top=s, width = 0.5, bottom = 0, x=[i + 0.5 for i in range(0, len(s))], color="firebrick")
# # show the results
show(p)
from os.path import dirname, join
from bokeh.plotting import figure, output_file, show, curdoc
from bokeh.layouts import column, layout
from bokeh.models.widgets import Select, RadioButtonGroup
from bokeh.models import CustomJS, ColumnDataSource, FactorRange
from bokeh.palettes import Spectral10
from bokeh.transform import factor_cmap
import pandas as pd
import numpy as np

#读取数据
data = pd.read_csv('data/datas.csv')

universitys = list(data.get('university').values)

#图一,对于每一个选中的学校进行历年统计
p = figure(plot_width=600, plot_height=480, x_range=["2013", "2015", "2017"])

#设置坐标轴显示
p.xaxis.axis_label = "年份"
p.yaxis.axis_label = "薪酬/元"

#绘制折线
s = p.line(["2013", "2015", "2017"], [0, 0, 0], line_width=2)
ds = s.data_source

def show_university_year_salary(university_name):
    dd = data[data['university'] == university_name]
    return [int(dd['2013']), int(dd['2015']), int(dd['2017'])]

#学校切换,重新绑定数据源
def change_university(value):
    global ds
    data = ds.data
    newdata = {
        'x': data['x'],
        'y': show_university_year_salary(value),
    }
    ds.data = newdata

#为Select
def select_university_change(attr, old, new):
    change_university(new)

#图2, 条状图,计算不同专业的不同薪酬
majors = list(set(data['category']))


source = ColumnDataSource(data=dict(majors=majors, major_salarys=[]))

major_figure = figure(x_range=majors, plot_height=350, title="大学专业薪酬表", tooltips=[
    ('薪酬', '@major_salarys元'),
    ('专业', '@majors'),
])
major_figure.vbar(x='majors', top='major_salarys', width=0.9, source=source,
           line_color='white', fill_color=factor_cmap('majors', palette=Spectral10, factors=majors))

year_options = ["all", "2013", "2015", "2017"]
def on_year_btn_click(index):
    value = year_options[index]
    if value == 'all':
        select_year_change(is_all=True)
    else:
        select_year_change(value)

def select_year_change(year = 0, is_all = False):
    major_salarys = []
    if is_all:
        for major in majors:
            major_values = data[data['category']== major]
            major_values = zip(major_values['2013'], major_values['2015'], major_values['2017'])
            major_values = [np.mean(v) for v in major_values]
            mean = np.mean(major_values)
            major_salarys.append(mean)
    else:
        major_salarys = [np.mean(data[data['category']== major][year]) for major in majors]
    source.data = dict(majors=majors, major_salarys=major_salarys)
    
#init
change_university("清华大学")
select_year_change(is_all=True)

#选择学校
select = Select(title="请选择需要查看的学校", value="foo", options=universitys)
select.on_change('value', select_university_change)

#选择年份
year_radio_button_group = RadioButtonGroup(
        labels=year_options , active=0)
year_radio_button_group.on_click(on_year_btn_click)

curdoc().add_root(layout([
    [select, p],
    [year_radio_button_group, major_figure]
]))
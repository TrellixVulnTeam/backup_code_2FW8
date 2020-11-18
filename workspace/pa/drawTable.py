import csv
from pyecharts.charts import Bar
from pyecharts import options as opts

def readCSV():
    f = open("bj.csv", "r", encoding="utf-8")

    reader = csv.reader(f)

    areas = {}
    for row in reader:
        area, num = row[0], row[1]
        if area not in areas.keys():
            areas[area] = []
        areas[area].append(int(num))

    for key in areas.keys():
        areas[key] = avg(areas[key])
    
    results = {}
    for k in sorted(areas,key=areas.__getitem__):
       results[k] = areas[k]
    return results

def avg(num_list):
    sum = 0
    size = len(num_list)
    for num in num_list:
        sum += num
    return round(sum / size, 2)
        

def draw(nums):
    bar = (
        Bar(init_opts=opts.InitOpts(width="1680px", height="800px"))
        .add_xaxis(list(nums.keys()))
        .add_yaxis("平均价格: ", list(nums.values()))
        .set_global_opts()
    )
    bar.render()


if __name__ == "__main__":
    nums = readCSV()
    draw(nums)

import time
start_time = time.mktime(time.strptime('2020-1-1 00:00:00','%Y-%m-%d %H:%M:%S'))
end_time = time.mktime(time.strptime('2020-1-7 00:00:00','%Y-%m-%d %H:%M:%S'))

def less_start_date(ctime):
    now_time = time.mktime(time.strptime(ctime,'%Y-%m-%d %H:%M:%S'))
    return now_time - start_time < 0

def bigger_end_date(ctime):
    now_time = time.mktime(time.strptime(ctime,'%Y-%m-%d %H:%M:%S'))
    return now_time - end_time > 0

nowtime = '2020-1-6 00:00:00'
lesstime = '2019-12-6 00:00:00'
biggertime = '2020-12-12 00:00:00'
print(less_start_date(nowtime))
print(less_start_date(lesstime))
print(bigger_end_date(nowtime))
print(bigger_end_date(biggertime))
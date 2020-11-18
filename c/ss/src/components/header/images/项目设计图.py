from tkinter import *

root = Tk()
#我的分辨率是1920X1020，如果分辨率不同的电脑可能组件位置不同，希望技术大佬可以改
root.geometry("1920x1020")
#标题
root.title("项目设计图")

#最顶上的那一栏的文件（暂时无功能）
menubar = Menu(root)
 
filemenu = Menu(menubar,tearoff=False)
filemenu.add_checkbutton(label="打开")
filemenu.add_checkbutton(label="保存")
filemenu.add_checkbutton(label="另存为")
filemenu.add_separator()
filemenu.add_checkbutton(label="退出",command=root.quit,)
menubar.add_cascade(label="文件",menu=filemenu)

root.config(menu=menubar)

#定义保存
def save1():
    pass
def save2(save1):
    pass
def save3(save1):
    pass


#右上角项目信息组
group1 = LabelFrame(root, text="项目信息",font=("宋体",20),fg="red",labelanchor=N)
group1.place(relx=0.85,rely=0.01)
#文字
Label(group1,text="项目编号:").grid(row=0,column=0)
Label(group1,text="项目名称:",padx=23).grid(row=1,column=0)
Label(group1,text="行业大类:").grid(row=2,column=0)
Label(group1,text="海康技术:").grid(row=3,column=0)
Label(group1,text="海康销售:").grid(row=4,column=0)
Label(group1,text="用户信息:").grid(row=5,column=0)
Label(group1,text="工程商信息:").grid(row=6,column=0)

#输入框
e1 = Entry(group1)
e2 = Entry(group1)
e3 = Entry(group1)
e4 = Entry(group1)
e5 = Entry(group1)
e6 = Entry(group1)
e7 = Entry(group1)

e1.grid(row=0, column=1, padx=10, pady=5)
e2.grid(row=1, column=1, padx=10, pady=5)
e3.grid(row=2, column=1, padx=10, pady=5)
e4.grid(row=3, column=1, padx=10, pady=5)
e5.grid(row=4, column=1, padx=10, pady=5)
e6.grid(row=5, column=1, padx=10, pady=5)
e7.grid(row=6, column=1, padx=10, pady=5)




#右下角设备信息组
group2 = LabelFrame(root, text="设备信息",font=("宋体",20),fg="red",labelanchor=N)
group2.place(relx=0.85,rely=0.27)

Label(group2,text="序列号:").grid(row=0,column=0)
Label(group2,text="产品型号:").grid(row=1,column=0)
Label(group2,text="版本:").grid(row=2,column=0)
Label(group2,text="销售日期:").grid(row=3,column=0)
Label(group2,text="保修天数:").grid(row=4,column=0)
Label(group2,text="出场版本:").grid(row=5,column=0)
Label(group2,text="备注:").grid(row=6,column=0)


E1 = Entry(group2)
E2 = Entry(group2)
E3 = Entry(group2)
E4 = Entry(group2)
E5 = Entry(group2)
E6 = Entry(group2)
E7 = Entry(group2)
E1.grid(row=0, column=1, padx=10, pady=5)
E2.grid(row=1, column=1, padx=10, pady=5)
E3.grid(row=2, column=1, padx=10, pady=5)
E4.grid(row=3, column=1, padx=10, pady=5)
E5.grid(row=4, column=1, padx=10, pady=5)
E6.grid(row=5, column=1, padx=10, pady=5)
E7.grid(row=6, column=1, padx=10, pady=5)

Button(group2, text="复制",width=10, command=save2)\
             .grid(row=7, column=0, sticky=W,padx=10,pady=5)
Button(group2, text="黏贴",width=10,command=save2)\
             .grid(row=7, column=1, sticky=E,padx=10,pady=5)
#右下角设备连接组
group3 = LabelFrame(root, text="设备连接",font=("宋体",20),fg="red",labelanchor=N,padx=3,pady=3)
group3.place(relx=0.85,rely=0.57)
#文字
Label(group3,text="IP地址:").grid(row=0,column=0)
Label(group3,text="子网掩码:").grid(row=1,column=0)
Label(group3,text="网关:").grid(row=2,column=0)
Label(group3,text="登录账号:").grid(row=3,column=0)
Label(group3,text="登录密码:").grid(row=4,column=0)
Label(group3,text="交换机编号").grid(row=5,column=0)
Label(group3,text="所属交换机:").grid(row=6,column=0)
Label(group3,text="连接平台:").grid(row=7,column=0)
Label(group3,text="平台版本:").grid(row=8,column=0)

d1 = Entry(group3)
d2 = Entry(group3)
d3 = Entry(group3)
d4 = Entry(group3)
d5 = Entry(group3)
d6 = Entry(group3)
d7 = Entry(group3)
d8 = Entry(group3)
d9 = Entry(group3)

d1.grid(row=0, column=1, padx=10, pady=5)
d2.grid(row=1, column=1, padx=10, pady=5)
d3.grid(row=2, column=1, padx=10, pady=5)
d4.grid(row=3, column=1, padx=10, pady=5)
d5.grid(row=4, column=1, padx=10, pady=5)
d6.grid(row=5, column=1, padx=10, pady=5)
d7.grid(row=6, column=1, padx=10, pady=5)
d8.grid(row=7, column=1, padx=10, pady=5)
d9.grid(row=8, column=1, padx=10, pady=5)


Button(group3, text="复制",width=10, command=save3)\
             .grid(row=9, column=0, sticky=W,padx=10,pady=5)
Button(group3, text="黏贴",width=10,command=save3)\
             .grid(row=9, column=1, sticky=E,padx=10,pady=5)


#左上角设备画板(这一栏做的不好大佬可以帮忙改下)

group4 = LabelFrame(root,text="设备工具栏",font=("宋体",20),labelanchor=N,fg="red")
group4.place(relx=0.01,rely=0.01)


photoA0 = PhotoImage(file="空白.png")
photoA1 = PhotoImage(file="摄像头.png")
photoA2 = PhotoImage(file="存储器.png")
photoA3 = PhotoImage(file="交换机.png")
photoA4 = PhotoImage(file="服务器.png")
photoA5 = PhotoImage(file="解码器.png")
photoA6 = PhotoImage(file="显示屏.png")
photoA7 = PhotoImage(file="路由器.png")
photoB1 = PhotoImage(file="道闸.png")
photoB2 = PhotoImage(file="道闸2.png")
photoB3 = PhotoImage(file="入口机.png")
photoB4 = PhotoImage(file="自助缴费机.png")
photoB5 = PhotoImage(file="车辆检测器.png")
photoB6 = PhotoImage(file="停车诱导.png")
photoB7 = PhotoImage(file="停车屏.png")
photoC1 = PhotoImage(file="报警主机.png")
photoC2 = PhotoImage(file="门磁.png")
photoC3 = PhotoImage(file="门禁一体机.png")
photoC4 = PhotoImage(file="探测器.png")
photoC5 = PhotoImage(file="翼闸.png")


def class1():
    B11 =Button(group4,image=photoA1).grid(row=3, column=1)
    B12 =Button(group4,image=photoA2).grid(row=3, column=2)
    B13 =Button(group4,image=photoA3).grid(row=3, column=3)
    B14 =Button(group4,image=photoA4).grid(row=3, column=4)
    B15 =Button(group4,image=photoA5).grid(row=3, column=5)
    B16 =Button(group4,image=photoA6).grid(row=3, column=6)
    Label(group4,image=photoA0).grid(row=3, column=7)
    Label(group4,image=photoA0).grid(row=3, column=8)
    Label(group4,image=photoA0).grid(row=3, column=9)
    Label(group4,image=photoA0).grid(row=3, column=10)
    Label(group4,image=photoA0).grid(row=3, column=11)
def class2():
    B21 =Button(group4,image=photoB1).grid(row=3, column=1)
    B22 =Button(group4,image=photoB2).grid(row=3, column=2)
    B23 =Button(group4,image=photoB3).grid(row=3, column=3)
    B24 =Button(group4,image=photoB4).grid(row=3, column=4)
    B25 =Button(group4,image=photoB5).grid(row=3, column=5)
    B26 =Button(group4,image=photoB6).grid(row=3, column=6)
    B27 =Button(group4,image=photoB7).grid(row=3, column=7)
    Label(group4,image=photoA0).grid(row=3, column=8)
    Label(group4,image=photoA0).grid(row=3, column=9)
    Label(group4,image=photoA0).grid(row=3, column=10)
    Label(group4,image=photoA0).grid(row=3, column=11)
def class3():
    B31 =Button(group4,image=photoC1).grid(row=3, column=1)
    B32 =B
    utton(group4,image=photoC2).grid(row=3, column=2)
    B33 =Button(group4,image=photoC3).grid(row=3, column=3)
    B34 =Button(group4,image=photoC4).grid(row=3, column=4)
    B44 =Button(group4,image=photoC5).grid(row=3, column=5)
    Label(group4,image=photoA0).grid(row=3, column=6)
    Label(group4,image=photoA0).grid(row=3, column=7)
    Label(group4,image=photoA0).grid(row=3, column=8)
    Label(group4,image=photoA0).grid(row=3, column=9)
    Label(group4,image=photoA0).grid(row=3, column=10)
    Label(group4,image=photoA0).grid(row=3, column=11)
def class4():
    Label(group4,image=photoA0).grid(row=3, column=1)
    Label(group4,image=photoA0).grid(row=3, column=2)
    Label(group4,image=photoA0).grid(row=3, column=3)
    Label(group4,image=photoA0).grid(row=3, column=4)
    Label(group4,image=photoA0).grid(row=3, column=5)
    Label(group4,image=photoA0).grid(row=3, column=6)
    Label(group4,image=photoA0).grid(row=3, column=7)
    Label(group4,image=photoA0).grid(row=3, column=8)
    Label(group4,image=photoA0).grid(row=3, column=9)
    Label(group4,image=photoA0).grid(row=3, column=10)
    Label(group4,image=photoA0).grid(row=3, column=11)

FENLEI = [
    ("请选择设备类型→",1,class4,1),
    ("基础设备",2,class1,2),
    ("停车场设备",3,class2,3),
    ("门禁设备",4,class3,4),
    ("消防设备",5,class4,5),
    ("机器人设备",6,class4,6)]
    
v = IntVar()
v.set(1)
for fenlei, num, num1, num2 in FENLEI:
    Radiobutton(group4,text=fenlei,variable=v, value=num,command=num1).grid(row=1,column=num2)


Label(group4,image=photoA0).grid(row=3, column=1)
Label(group4,image=photoA0).grid(row=3, column=2)
Label(group4,image=photoA0).grid(row=3, column=3)
Label(group4,image=photoA0).grid(row=3, column=4)
Label(group4,image=photoA0).grid(row=3, column=5)
Label(group4,image=photoA0).grid(row=3, column=6)
Label(group4,image=photoA0).grid(row=3, column=7)
Label(group4,image=photoA0).grid(row=3, column=8)
Label(group4,image=photoA0).grid(row=3, column=9)
Label(group4,image=photoA0).grid(row=3, column=10)
Label(group4,image=photoA0).grid(row=3, column=11)


#中间工具栏（还没做功能）
group5 = LabelFrame(root,text="作图工具栏",font=("宋体",20),labelanchor=N,fg="red")
group5.place(relx=0.74,rely=0.01)

photoG1 = PhotoImage(file="铅笔工具.png")
photoG2 = PhotoImage(file="橡皮工具.png")
photoG3 = PhotoImage(file="文字工具.png")
photoG4 = PhotoImage(file="矩形工具.png")
G1 =Button(group5,image=photoG1)
G1.grid(row=1, column=1)
G2 =Button(group5,image=photoG2)
G2.grid(row=1, column=2)
G3 =Button(group5,image=photoG3)
G3.grid(row=1, column=3)
G4 =Button(group5,image=photoG4)
G4.grid(row=1, column=4)

from whiteboard import WhiteBoard

board = WhiteBoard(root)

def choose_line(a):
    board.paint = 'line'

def choose_rect(a):
    board.paint = 'rect'

G1.bind('<Button-1>', choose_line)
G4.bind('<Button-1>', choose_rect)




#运行
mainloop()

import tkinter as tk
import tkinter.messagebox

win = tk.Tk()

win.title("Python GUI")
win.geometry('500x300')


var = tk.StringVar()
label = tk.Label(win, textvariable=var, font=('Arial', 12), width=30, height=2, bg='green')
label.pack()

def click_handle():
    var.set('hit!!!')
    tk.messagebox.showinfo(title='Hi', message='你好！')

btn = tk.Button(win, text='hit me', font=('Arial', 12), width=10, height=1, command=click_handle)
btn.pack(side='left')

entry = tk.Entry(win, show=None, font=('Arial', 12))
entry.pack(side='right')

win.mainloop()
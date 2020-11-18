import wx

"""
应用程序对象管理主事件循环
顶级窗口通常管理最重要的 数据，控制并呈现给用户。
"""

class MyFrame(wx.Frame):
    def __init__(self, image, parent=None, id=1, pos=wx.DefaultPosition, title='Hello, wx Python!'):
        #将原始图像转换为位图
        temp = image.ConvertToBitmap()
        size = temp.GetWidth(), temp.GetHeight()
        wx.Frame.__init__(self, parent, id, title, pos, size)
        self.bmp = wx.StaticBitmap(parent=self, bitmap=temp)

#每个程序至少有一个App和Frame实例
class App(wx.App):
    def OnInit(self):
        #加载图像,以jpg方式
        image = wx.Image('res/show.jpg', wx.BITMAP_TYPE_JPEG)
        self.frame = MyFrame(image)
        self.frame.Show()
        #设定顶级窗口
        self.SetTopWindow(self.frame)
        return True

if __name__ == "__main__":
    app = App()
    app.MainLoop()
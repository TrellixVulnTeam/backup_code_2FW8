import wx
class MyFrame(wx.Frame):
    def __init__(self, image, parent=None, id=-1, pos=wx.DefaultPosition, title='hello, wxPython!'):
        wx.Frame.__init__(self, parent, id, title, pos)
        temp = image.ConvertToBitmap()
        size = temp.GetWidth(), temp.GetHeight()
        self.bmp = wx.StaticBitmap(parent=self, bitmap=temp)

class App(wx.App):
    def OnInit(self):
        image = wx.Image('./img/hello.jpg', wx.BITMAP_TYPE_JPEG)
        self.frame = MyFrame(image)
        self.frame.Show()
        self.SetTopWindow(self.frame)
        return True

if __name__ == "__main__":
    app = App()
    app.MainLoop()
import os
def get_image_arr(folder_name):
    dir = os.listdir(os.path.dirname(__file__) + "/static/{0}".format(folder_name))
    return ["{0}/{1}".format(folder_name, filename) for filename in dir]
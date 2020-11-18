import unittest
import load_image

class TestLoadImage(unittest.TestCase):
    def test_get_image_arr(self):
        arr = load_image.get_image_arr("images/swiper")
        print(arr)

if __name__ == '__main__':
    unittest.main()
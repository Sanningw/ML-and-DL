# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 23:44:18 2018

@author: aa
"""

import numpy as np
from PIL import Image

if __name__ == '__main__':
    image_path = 'C://Users//aa//Pictures//QQ浏览器截图//QQ浏览器截图.jpg'
    height = 300
    
    img = Image.open(image_path)
    img_width, img_height = img.size
    width = 2 * height * img_width // img_height # 假定字符的高度是宽度的2倍
    img = img.resize((width, height), Image.ANTIALIAS)
    pixels = np.array(img.convert('L'))
    print(pixels.shape)
    print(pixels)
    chars = "MNHQ$OC?7>!:-;. "
    N = len(chars)
    step = 256 // N
    print(N)
    result = ''
    for i in range(height):
        for j in range(width):
            result += chars[pixels[i][j] // step]
        result += '\n'
    with open('C://Users//aa//Desktop//text.txt', mode='w') as f:
        f.write(result)

    f.close()
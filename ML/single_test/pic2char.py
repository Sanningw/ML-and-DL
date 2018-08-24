# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 23:44:18 2018

@author: aa
"""

import numpy as np
from PIL import Image

if __name__ == '__main__':
    image_path = 'C://Users//aa//Desktop//111.jpg'
    height = 300  #设置字符行数(set height)
    
    img = Image.open(image_path)    #打开图像
    #print('img =', img )
    img_width, img_height = img.size    #返回图片宽、高
    #print(img.size)
    width = 2 * height * img_width // img_height    
        # 因像素是正方形，故得到宽度后实际与高度相等，
        # 假定字符的高度是宽度的2倍，故宽度需行数乘以2
    #print(width)
    img = img.resize((width, height), Image.ANTIALIAS)    #反走样
    pixels = np.array(img.convert('L'))    #变为灰度图
    print(pixels.shape)
    print(pixels)
    chars = "MNH$QOC?7>!;:-. "    #给定不同复杂度的字符对应不同色彩值
    N = len(chars)
    step = 256 // N    #设置步长
    print(N)
    result = ''
    
    '''针对每一行每一列写入字符'''
    for i in range(height):
        for j in range(width):
            result += chars[pixels[i][j] // step]    
                #取出灰度值除以步长，写入对应字符
        result += '\n'    #行末换行
    with open('C://Users//aa//Desktop//text.txt', 'w') as f:
        f.write(result)
        f.close()
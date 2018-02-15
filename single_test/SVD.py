# -*- coding: utf-8 -*-
"""
Created on Fri Feb  9 23:15:26 2018

@author: aa
"""

import numpy as np
import os
from PIL import Image
import matplotlib.pyplot as plt
import matplotlib as mpl
from pprint import pprint

'''
参数说明
sigma：特征值， u：左特征向量，v：右特征向，K：选取的奇异值个数
'''

def restore1(sigma, u, v, K):
    m = len(u)
    n = len(v[0])
    a = np.zeros((m, n))
    for k in range(K + 1):
        uk = u[:, k].reshape(m, 1)        #取第k列
        vk = v[k].reshape(1, n)           #取第k列
        a += sigma[k] * np.dot(uk, vk)    #取前k个奇异值数乘dot(u, v)
    #a[a < 0] = 0
    #a[a > 255] = 255
    a = a.clip(0, 255)
    return np.rint(a).astype('uint8')    #四舍五入，转换成整数

def restore2(sigma, u, v, K):
    m = len(u)
    n = len(v[0])
    a = np.zeros((m, n))
    for k in range(K+1):
        for i in range(m):
            a[i] += sigma[k] * u[i][k] * v
    a[a < 0] = 0
    a[a > 255] = 255
    return np.rint(a).astype('uint8')

if __name__ == "__main__":
    A = Image.open("D://数据集//小象学院//5.Package//lena.png", 'r')
    print(A)    #命名文件为A
    output_path = r'D://数据集//小象学院//5.Package//SVD_Output'
    if not os.path.exists(output_path):
        os.mkdir(output_path)
    a = np.array(A)    #转为numpy格式
    print(a.shape)
    
    K = 50
    '''对RGB三个通道分别计算SVD'''
    u_r, sigma_r, v_r = np.linalg.svd(a[:, :, 0])
    u_g, sigma_g, v_g = np.linalg.svd(a[:, :, 1])
    u_b, sigma_b, v_b = np.linalg.svd(a[:, :, 2]) 
    plt.figure(figsize = (11, 9), facecolor = 'w')
    
    mpl.rcParams['font.sans-serif'] = ['simHei']
    mpl.rcParams['axes.unicode_minus'] = False
    
    for k in range(1, K + 1):
        print(k)
        R = restore1(sigma_r, u_r, v_r, k)
        G = restore1(sigma_g, u_g, v_g, k)
        B = restore1(sigma_b, u_b, v_b, k)
        I = np.stack((R, G, B), axis = 2)
        Image.fromarray(I).save('%s\\svd_%d.png' % (output_path, k))
        
        if k <= 12:
            plt.subplot(3, 4, k)
            plt.imshow(I)
            plt.axis('off')
            plt.title('奇异值个数：%d' % k)
    plt.suptitle('SVD与图像分解', fontsize=20)
    plt.tight_layout(0.3, rect=(0, 0, 1, 0.92))
    # plt.subplots_adjust(top=0.9)
    plt.show()

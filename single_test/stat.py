# -*- coding: utf-8 -*-
"""
Created on Thu Feb  8 12:23:29 2018

@author: aa
"""

import numpy as np
from scipy import stats
import math
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import seaborn


def calc_statistics(x):
    # 使用numpy函数验证均值、std、偏度、峰度
    mu = np.mean(x, axis = 0)
    sigma = np.std(x, axis = 0)
    skew = stats.skew(x)
    kurtosis = stats.kurtosis(x)
    return mu, sigma, skew, kurtosis


if __name__ == '__main__':
    d = np.random.randn(10000)
    print(d.shape)
    mu, sigma, skew, kurtosis = calc_statistics(d)
    print('均值、标准差、偏度、峰度：', mu, sigma, skew, kurtosis)
    '''绘制一维直方图'''
    mpl.rcParams['font.sans-serif'] = 'SimHei'    #雅黑
    mpl.rcParams['axes.unicode_minus'] = False
    plt.figure(num = 1, facecolor = 'w')
    y1, x1, dummy = plt.hist(d, bins = 50, normed = True, color = 'g',
                             alpha = 0.8, edgecolor = 'k')
    t = np.arange(x1.min(), x1.max(), 0.05)
    y = np.exp(-t ** 2 / 2) / math.sqrt(2 * math.pi)  #sigma为1的标准正态分布
    plt.plot(t, y, 'r-', lw = 2)
    plt.title('高斯分布，样本个数：%d' % d.shape[0])
    plt.grid(True)
    plt.show()
    
    d = np.random.randn(100000, 2)
    mu, sigma, skew, kurtosis = calc_statistics(d)
    print('均值、标准差、偏度、峰度：', mu, sigma, skew, kurtosis)
   
    '''绘制二维图像'''
    N = 100
    density, edges = np.histogramdd(d, bins = [N, N])    #多维直方图
    print('样本总数:', np.sum(density))
    density /= density.max()    #
    x = y = np.arange(N)
    print('x = ', x)
    print('y = ', y)
    t = np.meshgrid(x, y)
    print(t)
    fig = plt.figure(facecolor = 'w')
    ax = fig.add_subplot(111, projection = '3d')
    ax.scatter(t[0], t[1], density, c = 'r', s = 50 * density,
               marker = 'o', depthshade=True, edgecolor = 'k')
    ax.plot_surface(t[0], t[1], density, cmap = cm.Accent,
                    rstride=1, cstride=1, alpha=0.9, lw=0.75)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    plt.title('二元高斯分布，样本个数：%d' % d.shape[0], fontsize=15)
    plt.tight_layout(0.1)
    plt.show()
    
    x1, x2 = np.mgrid[-5:5:51j, -5:5:51j]
    x = np.stack((x1, x2), axis=2)  #按元素进行合并
    #print('x1 =', x1)
    #print('x2 =', x2)
    #print('x =', x)
    
    mpl.rcParams['axes.unicode_minus'] = False
    mpl.rcParams['font.sans-serif'] = 'SimHei'
    plt.figure(figsize=(9, 8), facecolor='w')
    sigma = (np.identity(2), np.diag((3,3)), np.diag((2,5)), np.array(((2,1), (1,5))))
    for i in np.arange(4):
        ax = plt.subplot(2, 2, i+1, projection='3d')
        norm = stats.multivariate_normal((0, 0), sigma[i])  #多元高斯分布，均值为(0,0)，方差为sigma中的值
        y = norm.pdf(x)
        ax.plot_surface(x1, x2, y, cmap=cm.Accent, rstride=2,
                        cstride=2, alpha=0.9, lw=0.3)
        ax.set_xlabel('X')
        ax.set_ylabel('Y')
        ax.set_zlabel('Z')
    plt.suptitle('二元高斯分布方差比较', fontsize=18)
    plt.tight_layout(1.5)
    plt.show()
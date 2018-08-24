# -*- coding: utf-8 -*-
"""
Created on Sat Feb 10 22:14:58 2018

@author: aa
"""

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

'''
stock_max：最高, stock_min：最低, stock_close：收盘, stock_amount：成交
'''

if __name__ == "__main__":
    path = 'D://数据集//小象学院//5.Package//SH600000.txt'
    stock_max, stock_min, stock_close, stock_amount = np.loadtxt(path,delimiter = '\t', skiprows = 2, usecols = (2, 3, 4, 5), unpack = True)
    #以'\t'分隔，跳过前两行、使用3~6列，分列读取
    
    N = 100
    stock_close = stock_close[:N]    #取前100天收盘
    print(stock_close)
    
    n = 10
    weight = np.ones(n)
    weight /= weight.sum()
    #print(weight)
    stock_sma = np.convolve(stock_close, weight, mode = 'valid')    # 卷积计算简单滑动平均
    
    weight = np.linspace(1, 0, n)
    weight = np.exp(weight)
    weight /= weight.sum()
    stock_ema = np.convolve(stock_close, weight, mode = 'valid')    # 卷积计算指数滑动平均
    
    t = np.arange(n-1, N)
    poly = np.polyfit(t, stock_ema, 10)
    print(poly)
    stock_ema_hat = np.polyval(poly, t)
    
    mpl.rcParams['font.sans-serif'] = ['SimHei']
    mpl.rcParams['axes.unicode_minus'] = False
    plt.figure(facecolor='w')
    plt.plot(np.arange(N), stock_close, 'ro-', linewidth=2, label='原始收盘价', mec = 'k')
    t = np.arange(n-1, N)
    plt.plot(t, stock_sma, 'b-', linewidth=2, label='简单移动平均线')
    plt.plot(t, stock_ema, 'g-', linewidth=2, label='指数移动平均线')
    plt.legend(loc='upper right')
    plt.title('股票收盘价与滑动平均线MA', fontsize=15)
    plt.grid(True)
    plt.show()

    print(plt.figure(figsize=(8.8, 6.6), facecolor='w'))
    plt.plot(np.arange(N), stock_close, 'ro-', linewidth=1, label='原始收盘价')
    plt.plot(t, stock_ema, 'g-', linewidth=2, label='指数移动平均线')
    plt.plot(t, stock_ema_hat, '-', color='#FF4040', linewidth=3, label='指数移动平均线估计')
    plt.legend(loc='upper right')
    plt.title('滑动平均线MA的估计', fontsize=15)
    plt.grid(True)
    plt.show()
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 10 22:04:39 2018

@author: aa
"""

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib.finance import candlestick_ohlc


if __name__ == "__main__":
    mpl.rcParams['font.sans-serif'] = ['SimHei']
    mpl.rcParams['axes.unicode_minus'] = False
    
    np.set_printoptions(suppress = True, linewidth = 100, edgeitems = 5)
    path = 'D://数据集//小象学院//5.Package//SH600000.txt'
    data = np.loadtxt(path, dtype = np.float, delimiter = '\t',
                      skiprows=2, usecols=(1, 2, 3, 4))
    data = data[:50]
    N = len(data)
    
    t = np.arange(1, N+1).reshape((-1, 1))
    data = np.hstack((t, data))

    fig, ax = plt.subplots(facecolor='w')
    fig.subplots_adjust(bottom=0.2)
    candlestick_ohlc(ax, data, width=0.6, colorup='r', colordown='b', alpha=0.9)
    plt.xlim((0, N+1))
    plt.grid(b=True)
    plt.title('股票K线图', fontsize=15)
    plt.tight_layout(2)
    plt.show()

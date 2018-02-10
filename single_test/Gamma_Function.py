# -*- coding: utf-8 -*-
"""
Created on Fri Feb  9 22:36:07 2018

@author: aa
"""

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.special import gamma
from scipy.special import factorial

mpl.rcParams['axes.unicode_minus'] = False
mpl.rcParams['font.sans-serif'] = 'SimHei'

if __name__ == '__main__':
    N = 5
    x = np.linspace(0, N, 50)
    y = gamma(x + 1)    #Γ(x) = (x - 1)!，故需要+1
    #print(y)
    plt.figure(facecolor = 'w')
    plt.plot(x, y, 'r-', x, y, 'mo', lw = 2, ms = 7, mec = 'k')
    z = np.arange(0, N + 1)
    f = factorial(z, exact = True)
    print(f)
    plt.plot(z, f, 'go', markersize = 9)
    plt.grid(b = True)
    plt.xlim(-0.1, N + 0.1)
    plt.ylim(0.5, np.max(y) * 1.05)
    plt.xlabel('X', fontsize = 15)
    plt.ylabel('Gamma(X) - 阶乘', fontsize = 16)
    plt.title('阶乘和Gamma函数', fontsize=16)
    plt.show()
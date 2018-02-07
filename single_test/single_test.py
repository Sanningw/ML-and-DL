# -*- coding: utf-8 -*-
"""
Created on Sun Feb  4 23:48:14 2018

@author: aa
"""

import numpy as np
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import time
from scipy.optimize import leastsq
from scipy import stats
import scipy.optimize as opt
import matplotlib.pyplot as plt
from scipy.stats import norm, poisson
from scipy.interpolate import BarycentricInterpolator
from scipy.interpolate import CubicSpline
import scipy as sp
import math
import seaborn

'''绘制正态分布密度函数'''
mpl.rcParams['font.sans-serif'] = [u'SimHei']    #设置字体为雅黑
mpl.rcParams['axes.unicode_minus'] = False

mu = 0      #set μ = 0
sigma = 1   #set σ = 1

x= np.linspace(mu - 3 * sigma, mu + 3 * sigma, 51)    #6σ范围内生成51个点
y = np.exp(-(x - mu) ** 2 / (2 * sigma ** 2)) / (math.sqrt(2 * math.pi) * sigma)
print(x.shape)
print('x = \n', x)
print(y.shape)
print('y = \n', y)

plt.figure(facecolor = 'w')
plt.plot(x, y, 'ro-', lw = 2, mec = 'k')    #设置线宽2，黑色框
plt.xlabel('X', fontsize = 15)
plt.ylabel('Y', fontsize = 15)
plt.title(u'高斯分布', fontsize = 18)
plt.grid(True, ls = ':')    #ls:linestyle, 背景线条类型
plt.show()

'''绘制损失函数'''
plt.figure(figsize = (10, 8))
x = np.linspace(start = -2, stop = 3, num = 1001, dtype = np.float)
y_logit = np.log(1 + np.exp(-x)) / math.log(2)
y_boost = np.exp(-x)
y_01 = x < 0
y_hinge = 1.0 - x
y_hinge[y_hinge < 0] = 0
plt.plot(x, y_logit, 'r-', mec = 'k', label='Logistic Loss', linewidth=2)
plt.plot(x, y_01, 'g-', mec = 'k', label='0/1 Loss', linewidth=2)
plt.plot(x, y_hinge, 'b-', mec = 'k', label='Hinge Loss', linewidth=2)
plt.plot(x, y_boost, 'm--', mec = 'k', label='Adaboost Loss', linewidth=2)
plt.grid(True,ls = '--')
plt.legend(loc='upper right')
plt.show()

'''x^x'''
def f(x):
    y = np.ones_like(x)
    i = x > 0
    y[i] = np.power(x[i], x[i])    #x > 0则 y = x^x
    i = x < 0
    y[i] = np.power(-x[i], -x[i])  #x < 0则 y = -x^-x(对称操作)
    return y
plt.figure(facecolor = 'w')
x = np.linspace(-1.3, 1.3, 101)
print(x.shape)
y = f(x)
plt.plot(x, y, 'g-', label = 'x^x', linewidth = 2)
plt.grid(True, ls = '--')
plt.legend(loc = 'upper left')
plt.show()

'''均匀分布'''
x = np.random.rand(10000)
t = np.arange(len(x))
plt.subplot(211)
plt.hist(x, 30, color = 'b', alpha = 0.5, label = u'均匀分布')    #30个直方的直方图
plt.legend(loc = 'best')
plt.subplot(212)
plt.plot(t, x, 'g.', label = u'均匀分布')                         #t为横轴，x为y轴进行绘制
plt.legend(loc = 'best')
plt.grid()
plt.show()

'''中心极限定理'''
t = 1000
a = np.zeros(10000)
for i in range(t):
    a += np.random.uniform(-5, 5, 10000)
a /= t
plt.hist(a, bins=30, color='g', alpha=0.5, normed=True, label=u'均匀分布叠加')
plt.legend(loc = 'best')
plt.grid(True, ls = '--')
plt.show()

'''泊松分布'''
lamda = 4
p = stats.poisson(lamda)
y = p.rvs(size = 1000)
mx = 30
r = (0, mx)
bins = r[1] - r[0]
plt.figure(figsize=(15, 8), facecolor='w')
plt.subplot(121)
plt.hist(y, bins=bins, range=r, color='g', alpha=0.8, normed=True)
t = np.arange(0, mx+1)
plt.plot(t, p.pmf(t), 'ro-', lw=2)
plt.grid(True)

N = 1000
M = 10000
plt.subplot(122)
a = np.zeros(M, dtype=np.float)
p = stats.poisson(lamda)
for i in np.arange(N):
    a += p.rvs(size=M)
a /= N
plt.hist(a, bins=20, color='g', alpha=0.8, normed=True)
plt.grid(b=True)
plt.show()

'''最小二乘'''
def residual(t, x, y):
    return y - (t[0] * x ** 2 + t[1] * x + t[2])


def residual2(t, x, y):
    print(t[0], t[1])
    return y - (t[0]*np.sin(t[1]*x) + t[2])

x = np.linspace(-2, 2, 50)
A, B, C = 2, 3, -1
y = (A * x ** 2 + B * x + C) + np.random.rand(len(x))*0.75

t = leastsq(residual, [0, 0, 0], args = (x, y))
theta = t[0]
print('真实值：', A, B, C)
print('预测值：', theta)
y_hat = theta[0] * x ** 2 + theta[1] * x + theta[2]
plt.plot(x, y, 'r-', linewidth=2, label=u'Actual')
plt.plot(x, y_hat, 'g-', linewidth=2, label=u'Predict')
plt.legend(loc='upper left')
plt.grid()
plt.show()

x = np.linspace(0, 5, 100)
a = 5
w = 1.5
phi = -2
y = a * np.sin(w * x) + phi + np.random.rand(len(x)) * 0.5

t = leastsq(residual2, [2, 2, 2], args = (x, y))
theta = t[0]
print('真实值：', a, w, phi)
print('预测值：', theta)
y_hat = theta[0] * np.sin(theta[1] * x) + theta[2]
plt.plot(x, y, 'r-', linewidth=2, label='Actual')
plt.plot(x, y_hat, 'g-', linewidth=2, label='Predict')
plt.legend(loc='lower left')
plt.grid()
plt.show()
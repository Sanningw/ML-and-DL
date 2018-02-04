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

def residual(t, x, y):
    return y - (t[0] * x ** 2 + t[1 * x + t[2]])

def residual2(t, x , y):
    print(t[0], t[1])
    return y - (t[0] * np.sin(t[1] * x) + t[2])

def f(x):
    y = np.ones_like(x)
    i = x > 0
    y[i] = np.power(x[i], x[i])
    i = x < 0
    y[i] = np.power(-x[i], -x[i])
    return y

# 5.6 渐开线
t = np.linspace(0, 50, num=1000)
x = t * np.sin(t) + np.cos(t)
y = np.sin(t) - t * np.cos(t)
plt.plot(x, y, 'r-', linewidth=2)
plt.grid()
plt.show()
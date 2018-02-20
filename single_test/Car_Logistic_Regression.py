# -*- coding: utf-8 -*-
"""
Created on Sat Feb 17 21:15:35 2018

@author: aa
"""

import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegressionCV
from sklearn import metrics
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import label_binarize
import matplotlib as mpl
import matplotlib.pyplot as plt

if __name__ == '__main__':
    pd.set_option('display.width', 300)
    pd.set_option('display.max_columns', 300)
    
    data = pd.read_csv('D://Github//ML_Project//single_test//car.data', header = None)
    n_columns = len(data.columns)
    columns = ['buy', 'maintain', 'doors', 'persons', 'boot', 'saftey', 'accept']
    new_columns = dict(list(zip(np.arange(n_columns), columns)))    #0-6进行命名，
    data.rename(columns = new_columns, inplace = True)
    print(data.head(10))
    
    #one-hot
    x = pd.DataFrame()
    for col in columns[: -1]:
        t = pd.get_dummies(data[col])    #对当前col进行one-hot
        t = t.rename(columns = lambda x: col + '_' + str(x))    #col名 + 对应水平
        x = pd.concat((x, t), axis = 1)    #横向合并
    
    y = pd.Categorical(data['accept']).codes    #对'accept'列元素进行汇总，用数字代替
    y[y == 1] = 0
    y[y >= 2] = 1
    
    x, x_test, y, y_test = train_test_split(x, y, test_size = 0.3)    #分割训练/测试集
    #使用交叉验证进行对数回归，惩罚项由lg(10^-3)~lg(10^4), 5折交叉
    clf = LogisticRegressionCV(Cs = np.logspace(-3, 4, 8), cv = 5)
    clf.fit(x, y)
    
    y_hat = clf.predict(x)
    print('训练集精度：', metrics.accuracy_score(y, y_hat))
    y_test_hat = clf.predict(x_test)
    print('测试集精度：', metrics.accuracy_score(y_test, y_test_hat))
    n_class = len(np.unique(y))
    
    if n_class > 2:
        y_test_one_hot = label_binarize(y_test, classes = np.arange(n_class))
    
    

# -*- coding: utf-8 -*-
"""
Created on Sat Feb 24 21:42:11 2018

@author: Li
"""

import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.feature_selection import SelectKBest, SelectPercentile, chi2
from sklearn.linear_model import LogisticRegressionCV
from sklearn import metrics
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures
from sklearn.manifold import TSNE
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

def extend(a, b):
    return 1.05 * a - 0.05 * b, 1.05 * b - 0.05 * a

if __name__ == '__main__':
    stype = 'pca'
    pd.set_option('display.width', 200)
    data = pd.read_csv('D://Git//ML_Project//single_test//iris.data', header=None)
    #columns = np.array(['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'type'])
    columns = np.array(['花萼长度', '花萼宽度', '花瓣长度', '花瓣宽度', '类型'])
    data.rename(columns = dict(list(zip(np.arange(5), columns))), inplace = True)    #修改data列名并替换
    data['类型'] = pd.Categorical(data['类型']).codes    #
    #print(data.head(5))
    x = data[columns[:-1]]
    y = data[columns[-1]]
    
    if stype == 'pca':
        pca = PCA(n_components = 2, whiten = True, random_state = 0)  #保留2个主成分，白化(归一化)
        x = pca.fit_transform(x)    #用x训练PCA并返回将为后的数据
        print('各方向方差：', pca.explained_variance_)    #保留的n个成分各自的方差
        print('方差所占比例：', pca.explained_variance_ratio_)
        x1_label, x2_label = '组分1', '组分2'
        title = '鸢尾花数据PCA'
    else:
        fs = SelectBest(chi2, k = 2)
        fs.fit(x, y)
        idx = fs.get_support(indices = True)
        print('fs.get_support() = ', idx)
        x = x[idx]
        x = x.values    # 为下面使用方便，DataFrame转换成ndarray
        x1_label, x2_label = columns[idx]
        title = '鸢尾花数据特征选择'
    print(x[ : 5])
    cm_light = mpl.colors.ListedColormap(['#77E0A0', '#FF8080', '#A0A0FF'])
    cm_dark = mpl.colors.ListedColormap(['g', 'r', 'b'])
    mpl.rcParams['font.sans-serif'] = 'SimHei'
    mpl.rcParams['axes.unicode_minus'] = False
    plt.figure(facecolor='w')
    plt.scatter(x[:, 0], x[:, 1], s=30, c=y, marker='o', cmap=cm_dark)
    plt.grid(b=True, ls=':', color='k')
    plt.xlabel(x1_label, fontsize=12)
    plt.ylabel(x2_label, fontsize=12)
    plt.title(title, fontsize=15)
    # plt.savefig('1.png')
    plt.show()

    x, x_test, y, y_test = train_test_split(x, y, test_size = 0.3)
    model = Pipeline([
        ('poly', PolynomialFeatures(degree = 2, include_bias = True)),
        ('lr', LogisticRegressionCV(Cs = np.logspace(-3, 4, 8), cv = 5, fit_intercept = False))
    ])
    model.fit(x, y)
    print('最优参数', model.get_params('lr')['lr'].C_)
    y_hat = model.predict(x)
    print('训练级精度：', metrics.accuracy_score(y, y_hat))
    y_test_hat = model.predict(x_test)
    print('测试集精度：', metrics.accuracy_score(y_test, y_test_hat))
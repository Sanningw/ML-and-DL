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
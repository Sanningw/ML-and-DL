# -*- coding: utf-8 -*-
"""
Created on Wed Feb 14 15:18:31 2018

@author: aa
"""

import numpy as np
import pandas as pd
from fuzzywuzzy import fuzz, process

def enum_row(row):    #输出state对应数据
    print(row['state'])
    
def find_state_code(row):    #选取state与states中最接近的元素，截断值为80
    if row['state'] != 0:
        print(process.extractOne(row['state'], states, score_cutoff = 80))
        
def capital(str):
    return str.capitalize()

def correct_state(row):    #选取state与states中最接近的元素并覆盖state
    if row['state'] != 0:
        state = process.extractOne(row['state'], states, score_cutoff = 80)
        if state:
            state_name = state[0]
            #将州名按照空格分开、首字母大写后拼到一起
            return ' '.join(map(capital, state_name.split(' ')))
    return row['state']

def fill_state_code(row):
    if row['state'] != 0:
        state = process.extractOne(row['state'], states, score_cutoff = 80)
        if state:
            state_name = state[0]    #取可能性最高的一个值覆盖原值
            return state_to_code[state_name]
    return ''


if __name__ == '__main__':
    pd.set_option('display.width', 200)    #展示长度限制为200
    data = pd.read_excel('D://Github//ML_Project//single_test//sales.xlsx',
                         sheet_name = 'sheet1', header = 0)
    #print('data.head() = \n', data.head())
    #print('data.tail() = \n', data.tail())
    #print('data.dtypes = \n', data.dtypes)
    #print('data.columns = \n', data.columns)
    for i in data.columns:
        print(i, end = ' ')    #每一循环输出列后用空格分隔，防止另起一行
    print()
    data['total'] = data['Jan'] + data['Feb'] + data['Mar']
    #print(data.head())
    #print(data['Jan'].sum())
    #print(data['Jan'].min())
    #print(data['Jan'].max())
    #print(data['Jan'].mean())
    #
    #print('=========================')
    #
    #s1 = data[['Jan', 'Feb', 'Mar', 'total']].sum()
    #print(s1)
    #s2 = pd.DataFrame(data = s1)
    #print(s2)
    #print(s2.T)
    #print(s2.T.reindex(columns = data.columns))
    #
    #s = pd.DataFrame(data = data[['Jan', 'Feb', 'Mar', 'total']].sum()).T
    #s = s.reindex(columns = data.columns, fill_value = 0)
    #print(s)
    #data = data.append(s, ignore_index = True)
    #data = data.rename(index = {15: 'Total'})
    #print(data.tail())
    
    print('===============apply的使用==================')
    data.apply(enum_row, axis = 1)

    state_to_code = {"VERMONT": "VT", "GEORGIA": "GA", "IOWA": "IA", "Armed Forces Pacific": "AP", "GUAM": "GU",
                     "KANSAS": "KS", "FLORIDA": "FL", "AMERICAN SAMOA": "AS", "NORTH CAROLINA": "NC", "HAWAII": "HI",
                     "NEW YORK": "NY", "CALIFORNIA": "CA", "ALABAMA": "AL", "IDAHO": "ID",
                     "FEDERATED STATES OF MICRONESIA": "FM",
                     "Armed Forces Americas": "AA", "DELAWARE": "DE", "ALASKA": "AK", "ILLINOIS": "IL",
                     "Armed Forces Africa": "AE", "SOUTH DAKOTA": "SD", "CONNECTICUT": "CT", "MONTANA": "MT",
                     "MASSACHUSETTS": "MA",
                     "PUERTO RICO": "PR", "Armed Forces Canada": "AE", "NEW HAMPSHIRE": "NH", "MARYLAND": "MD",
                     "NEW MEXICO": "NM",
                     "MISSISSIPPI": "MS", "TENNESSEE": "TN", "PALAU": "PW", "COLORADO": "CO",
                     "Armed Forces Middle East": "AE",
                     "NEW JERSEY": "NJ", "UTAH": "UT", "MICHIGAN": "MI", "WEST VIRGINIA": "WV", "WASHINGTON": "WA",
                     "MINNESOTA": "MN", "OREGON": "OR", "VIRGINIA": "VA", "VIRGIN ISLANDS": "VI",
                     "MARSHALL ISLANDS": "MH",
                     "WYOMING": "WY", "OHIO": "OH", "SOUTH CAROLINA": "SC", "INDIANA": "IN", "NEVADA": "NV",
                     "LOUISIANA": "LA",
                     "NORTHERN MARIANA ISLANDS": "MP", "NEBRASKA": "NE", "ARIZONA": "AZ", "WISCONSIN": "WI",
                     "NORTH DAKOTA": "ND",
                     "Armed Forces Europe": "AE", "PENNSYLVANIA": "PA", "OKLAHOMA": "OK", "KENTUCKY": "KY",
                     "RHODE ISLAND": "RI",
                     "DISTRICT OF COLUMBIA": "DC", "ARKANSAS": "AR", "MISSOURI": "MO", "TEXAS": "TX", "MAINE": "ME"}
    states = list(state_to_code.keys())
    #print(fuzz.ratio('Python Package', 'PythonPackage'))    #输出字符串相似度(int)
    #print(process.extract('Mississippi', states))    #输出字符串比较结果
    #print(process.extract('Mississipi', states, limit = 3))
    #print(process.extractOne('Mississipi', states))    #输出最像的一个
    data.apply(find_state_code, axis=1)
    
    print('Before Correct State:\n', data['state'])
    data['state'] = data.apply(correct_state, axis=1)
    print('After Correct State:\n', data['state'])
    data.insert(5, 'State Code', np.nan)
    data['State Code'] = data.apply(fill_state_code, axis=1)
    print(data)
    
    #groupby
    print('===============group by===============')
    print(data.groupby('State Code'))
    print('All Columns:\n')
    print(data.groupby('State Code').sum())
    print('Short Columns:\n')
    print(data[['State Code', 'Jan', 'Feb', 'Mar', 'total']].groupby('State Code').sum())
    
    # 写入文件
    data.to_excel('D://Github//ML_Project//single_test//sales_result.xls',
                  sheet_name='Sheet1', index=False)
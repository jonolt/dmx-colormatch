#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jul 11 11:34:22 2020

@author: johannes
"""

import pandas as pd
import numpy as np

def print_nth_dot(i, n=1000):
    if i%n==0:
        print(".", end="")


path_a = "data/adj_megatripar_all.csv"
path_r = "data/adj_megatripar_red.csv"
path_g = "data/adj_megatripar_green.csv"
path_b = "data/adj_megatripar_blue.csv"

df_a = pd.read_csv(path_a, usecols=["r","g","b","c","dmx_ch_1","dmx_ch_2","dmx_ch_3"])
df_r = pd.read_csv(path_r, usecols=["r","g","b","c","dmx_ch_1"])
df_g = pd.read_csv(path_g, usecols=["r","g","b","c","dmx_ch_1"])
df_b = pd.read_csv(path_b, usecols=["r","g","b","c","dmx_ch_1"])

if "df_c" not in locals():
    print("add ", end="")
    df_c = df_a.copy()
    for index, row in df_c.iterrows():
        print_nth_dot(index)
        row.r = df_r.iloc[row.dmx_ch_1].r + df_g.iloc[row.dmx_ch_2].r + df_b.iloc[row.dmx_ch_3].r
        row.g = df_r.iloc[row.dmx_ch_1].g + df_g.iloc[row.dmx_ch_2].g + df_b.iloc[row.dmx_ch_3].g
        row.b = df_r.iloc[row.dmx_ch_1].b + df_g.iloc[row.dmx_ch_2].b + df_b.iloc[row.dmx_ch_3].b
        row.c = df_r.iloc[row.dmx_ch_1].c + df_g.iloc[row.dmx_ch_2].c + df_b.iloc[row.dmx_ch_3].c
    
print("\ndiv ", end="")
df_div = df_a.copy()
df_rel = pd.DataFrame(np.zeros(df_a.shape), columns=df_a.columns, dtype=np.float16)
for i in range(len(df_a)):
    row_div = df_div.iloc[i]
    row_a = df_a.iloc[i]
    row_c = df_c.iloc[i]
    
    print_nth_dot(i)
    row_div.r = row_a.r - row_c.r
    row_div.g = row_a.g - row_c.g
    row_div.b = row_a.b - row_c.b
    row_div.c = row_a.c - row_c.c
    
    row_rel = df_rel.iloc[i]
    row_rel.dmx_ch_1 = row_div.dmx_ch_1
    row_rel.dmx_ch_2 = row_div.dmx_ch_2
    row_rel.dmx_ch_3 = row_div.dmx_ch_3
    row_rel.r = row_div.r/row_c.r
    row_rel.g = row_div.g/row_c.g
    row_rel.b = row_div.b/row_c.b
    row_rel.c = row_div.c/row_c.c


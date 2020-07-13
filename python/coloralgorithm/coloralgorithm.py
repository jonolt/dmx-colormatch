#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 13 21:38:56 2020

@author: johannes
"""

from fixture import FixtureRGB

T_TOT_STEPS = 10

U_NUM_COLORS = 4
Y_NUM_CH = 3  # wird größer


csvpath = "../data/adj_megatripar_all.csv"
csvpaths = (
    "../data/adj_megatripar_red.csv",
    "../data/adj_megatripar_green.csv",
    "../data/adj_megatripar_blue.csv",
)
f = FixtureRGB(csvpaths)


def make_relative(array):
    r = list()
    for i in range(len(array) - 2):
        r.append(array[i] / array[i + 1])
    r.append(array[-2] / array[0])
    return r


org_rgbc = [1508, 1147, 2873, 5526]
org_dmx = [200, 150, 210]

# org_rgb=[1604,1828,1144, 4597]
# org_dmx=[200,	235,	85]


def adjust(dmx, index, diff):
    i = (index + 1) % 3
    if abs(diff) < 0.05:
        return True
    if diff > 0:
        if diff > -1:
            dmx[i] -= 1
        else:
            dmx[i] -= 5
    elif diff < 0:
        if diff < 1:
            dmx[i] += 1
        else:
            dmx[i] += 5
    if dmx[i] < 0:
        dmx[i] = 255
    if dmx[i] > 255:
        dmx[i] = 0

    return False


def iterate(dmx, u_soll_rel, index_abs=0):

    if index_abs >= len(dmx):
        raise ValueError("index must be size dmx")

    index = index_abs + 1

    itersum = 0
    m = 0
    while m < 21:
        index_shifted = (index - 1) % len(dmx)
        u_ist = f.in_out(dmx)
        u_ist_rel = make_relative(u_ist)
        u_diff = u_soll_rel[index_shifted] - u_ist_rel[index_shifted]

        if abs(u_diff) < 0.005 or (m > 0 and m % 20 == 0):
            itersum += m
            index += 1
            m = 0

        if index >= len(dmx):
            index = 0

        if index == index_abs:
            return itersum

        if u_diff > 0:
            if u_diff < 0.1:
                dmx[index] -= 1
            else:
                dmx[index] -= 5
        elif u_diff < 0:
            if u_diff > -0.1:
                dmx[index] += 1
            else:
                dmx[index] += 5

        if dmx[index] < 0:
            dmx[index] = 255
        if dmx[index] > 255:
            dmx[index] = 0

        m += 1

    return -42


def get_max_index(array):
    max_index = 0
    for i in range(len(array)):
        if array[i] > array[max_index]:
            max_index = i
    return max_index


def interate_loop(dmx, u_soll_rel, index_abs=0):
    dmx_old = [0] * len(dmx)
    for n in range(5):
        m = iterate(dmx, u_soll_rel, index_abs=index_abs)
        print(n, m, dmx)
        if dmx == dmx_old:
            break
        dmx_old = dmx.copy()
    else:
        Exception("find_values stuck in loop")


def find_values(u_soll_rel, intesity=255):

    dmx0 = [128, 128, 128]
    dmx = dmx0.copy()

    print("first loop")
    interate_loop(dmx, u_soll_rel, index_abs=0)

    max_index = get_max_index(dmx)
    dmx[max_index] = intesity
    print(f"second loop, max index {max_index}")
    interate_loop(dmx, u_soll_rel, index_abs=max_index)

    return dmx


if __name__ == "__main__":

    u_soll = org_rgbc
    u_soll_rel = make_relative(u_soll)

    # find_values(u_soll_rel)
    find_values(u_soll_rel, intesity=255)

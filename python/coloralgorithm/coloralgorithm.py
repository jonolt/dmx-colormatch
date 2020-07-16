#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from fixture import FixtureRGB
import math
import time
import numpy as np


def rel_diff(cur, ref) -> float:
    if ref == 0:
        return cur
    return (ref - cur) / ref


def get_max_index(array):
    max_index = 0
    for i in range(len(array)):
        if array[i] > array[max_index]:
            max_index = i
    return max_index


def get_min_index(array):
    min_index = 0
    for i in range(len(array)):
        if array[i] < array[min_index]:
            min_index = i
    return min_index


def sign(val):
    return math.copysign(1, val)


def divide_array(array, divisor):
    for i in range(len(array)):
        array[i] = int(array[i] / divisor)


if __name__ == "__main__":

    org_rgbc = [1508, 1147, 2873, 5526]
    org_dmx = [200, 150, 210]

    # org_rgbc = [3333,1186,705,5057]
    # org_dmx = [255, 200, 0]

    # org_rgb=[1604,1828,1144, 4597]
    # org_dmx=[200,	235,	85]

    # org_rgbc = [75,1259,5331,6775]
    # org_dmx = [0,0,255]

    csvpaths = (
        "../data/adj_megatripar_red.csv",
        "../data/adj_megatripar_green.csv",
        "../data/adj_megatripar_blue.csv",
    )
    f = FixtureRGB(csvpaths)

    # ENTER

    ref_abs_rgbc = org_rgbc
    index_abs = 0
    index_ref = 0
    dmx = [0, 0, 0]

    last_dmx1 = -1
    last_dmx2 = -2
    
    last_dif_rel = 42

    matrix = np.zeros((3, 3), float)
    row_sums = np.zeros(3, float)
    rgbc_dmx_ch = np.zeros(len(dmx), int)

    for ref in range(3):
        for var in range(3):
            matrix[ref, var] = rel_diff(ref_abs_rgbc[var], ref_abs_rgbc[ref])
            row_sums[ref] += matrix[ref, var]

    rgbc_index_max = get_max_index(row_sums)

    for ch in range(len(dmx)):
        dmx[ch] = 255
        rgbc_dmx_ch[ch] = f.in_out(dmx)[rgbc_index_max]
        dmx[ch] = 0

    index_abs = 0
    dmx[index_abs] = 255
    index_ref = index_abs

    repetitions = 0

    # LOOP

    while True:

        index_var = (index_ref + 1) % len(dmx)

        if index_var == index_abs:
            index_ref = index_var
            repetitions += 1
            if repetitions == 5:
                break
            continue

        cur_abs_rgbc = f.in_out(dmx)
        cur_rel = rel_diff(cur_abs_rgbc[index_var], cur_abs_rgbc[index_ref])
        dif_rel = cur_rel - matrix[index_ref, index_var]

        print(
            f"{index_abs} {index_ref}/{index_var} {cur_rel:06.3f} {matrix[index_abs, index_var]:06.3f} {dif_rel:+06.3f} ",
            end="",
        )

        factor = abs(dif_rel) * 10
        if factor > 9:
            factor = 9
        dmx[index_var] += int(sign(dif_rel) * (factor + 1))

        if dmx[index_var] > 255:
            print(">255")
            divide_array(dmx, 2)
            dmx[index_var] = 255
            index_abs = index_var
        elif dmx[index_var] < 0:
            print("<0")
            dmx[index_var] = 0
            index_ref = index_var
        #elif last_dmx1 == dmx[index_var] or last_dmx2 == dmx[index_var]:
        #    index_ref = index_var
        elif last_dif_rel < abs(dif_rel):
            print(f"{last_dif_rel} < {abs(dif_rel)}")
            dmx[index_var] = last_dmx1
            index_ref = index_var

            
        last_dmx2 = last_dmx1
        last_dmx1 = dmx[index_var]

        if index_ref == index_var or index_abs == index_var:        
            last_dif_rel = 100
        else:
            last_dif_rel = abs(dif_rel)

        

        print(f"[{dmx[0]:03d},{dmx[1]:03d},{dmx[2]:03d}]")
        time.sleep(0.25)

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

    #org_rgbc = [3333,1186,705,5057]
    #org_dmx = [255, 200, 0]

    #org_rgbc=[1604,1828,1144, 4597]
    #org_dmx=[200,	235,	85]

    #org_rgbc = [75,1259,5331,6775]
    #org_dmx = [0,0,255]

    csvpaths = (
        "../data/adj_megatripar_red.csv",
        "../data/adj_megatripar_green.csv",
        "../data/adj_megatripar_blue.csv",
    )
    f = FixtureRGB(csvpaths)

    # ENTER

    dmx = [0, 0, 0]
    
    last_dif_rel = 0
    dif_rel = 0

    matrix = np.zeros((3, 3), float)
    dmx_best = np.zeros((3,3), int)
    dif_best = np.zeros(3, float)

    index_ch = 0  # index var
    index_base_ch = 0  #index abs

    repetitions = 0
    first_miss = True
    initialized = False
    updown = 5
    # LOOP

    for ref in range(3):
        for var in range(3):
            matrix[ref, var] = rel_diff(org_rgbc[var], org_rgbc[ref])

    def reset():
        global index_ch
        global index_base_ch
        global repetitions
        global first_miss
        global updown
        global dmx
        global initialized
        index_ch = 0
        repetitions = 0
        first_miss = True
        initialized = False
        updown = 5
        dmx = [0, 0, 0]
        dmx[index_base_ch] = 255
        
    reset()

    while True:

        # skip base_ch
        index_ch = index_ch%len(dmx)
        if index_ch == index_base_ch :
            index_ch += 1
            continue
        
        last_dif_rel = dif_rel

        cur_abs_rgbc = f.in_out(dmx)

        dif_rel = pow(rel_diff(cur_abs_rgbc[0], cur_abs_rgbc[1]) - matrix[1, 0], 2)
        dif_rel += pow(rel_diff(cur_abs_rgbc[1], cur_abs_rgbc[2]) - matrix[2, 1], 2)
        dif_rel += pow(rel_diff(cur_abs_rgbc[2], cur_abs_rgbc[0]) - matrix[0, 2], 2)
        
        if not initialized:
            initialized = True
            last_dif_rel = dif_rel
            last_dmx = dmx[index_ch]
            
        print(
            f"{repetitions} {index_base_ch} {index_ch} {last_dif_rel:07.4f} {dif_rel:07.4f} {first_miss} [{dmx[0]:03d},{dmx[1]:03d},{dmx[2]:03d}]",
            end="\n",
        )

        if dif_rel > last_dif_rel:
            dmx[index_ch] = last_dmx
            if first_miss:
                first_miss = False
                updown = -updown
            else:
                first_miss = True
                index_ch += 1
                repetitions += 1
            continue
            
        last_dmx = dmx[index_ch]
        dmx[index_ch] += updown
        
        if dmx[index_ch] > 255:
            dmx[index_ch] = 255
            if first_miss:
                first_miss = False
                updown = -updown
            else:
                first_miss = True
                index_ch += 1
                repetitions += 1
        elif dmx[index_ch] < 0:
            dmx[index_ch] = 0
            if first_miss:
                first_miss = False
                updown = -updown
            else:
                first_miss = True
                index_ch += 1
                repetitions += 1
        
        if repetitions == 10:
            updown = 1
        if repetitions == 30:
            dif_best[index_base_ch] = dif_rel
            for i in range(len(dmx)):
                dmx_best[index_base_ch, i] = dmx[i]
            print(f"Mid Result ({index_base_ch}): {dmx_best[index_base_ch]} with {dif_best[index_base_ch]:07.4f} match")
            index_base_ch += 1
            if index_base_ch==len(dmx):
                break
            reset()
            #input("Enter to continue")
                
    
    best_max_ch = get_min_index(dif_best)
    dmx_final = dmx_best[best_max_ch]
    
    print(f"Final Result: {dmx_final} with {dif_best[best_max_ch]:07.4f} match")
        # print(f"")
        #time.sleep(0.2)

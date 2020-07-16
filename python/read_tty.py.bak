#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May 21 12:50:23 2020

@author: johannes
"""

import time
import pandas as pd
import serial
import csv

try:
    number_of_channels = int(input("Channels To Param [3]: "))
except ValueError:
    number_of_channels = 3
print(number_of_channels)

try:
    dmx_step_size = int(input("DMX step size [10]: "))
except ValueError:
    dmx_step_size = 10
    
try:
    reset = int(input("reset y/n [n]: "))
except ValueError:
    reset = False

print(dmx_step_size)

index = ["r", "g", "b", "c"]
for i in range(number_of_channels):
    index.append(f"dmx_ch_{i+1}")

df = pd.DataFrame(columns=index)

try:
    ser = serial.Serial('/dev/ttyACM1', 9600, timeout=1)
    ser.write("param\n".encode())
    ser.read_until("ack".encode())
    ser.write(f"param_chnanels {number_of_channels}\n".encode())
    ser.read_until("ack".encode())
    ser.write(f"param_dmx_step {dmx_step_size}\n".encode())
    ser.read_until("ack".encode())
    if reset:
        ser.write(f"reset\n".encode())
        ser.read_until("ack".encode())
    with open('orb.csv', 'w', newline='') as csvfile:
        spamwriter = csv.writer(csvfile)
        ser.write("start\n".encode())
        ser.read_until("ack".encode())
        while True:
            try:
                line = ser.readline().decode().rstrip()
                vals = [int(i) for i in line.split(", ")]
                t = time.time()
                spamwriter.writerow([t]+vals)
                df.loc[t] = vals
                print(f"{line} | {vals}")
            except ValueError:
                if line == "PARAM_EXIT":
                    break
                print(f"cathced error for serial {line}")
    
except serial.serialutil.SerialException as ex:
    print(ex)
except KeyboardInterrupt:
    pass
finally:
    ser.write("cancle".encode())
    ser.read_until("ack".encode())
    ser.close()
    df.to_csv("test_dataframe.csv")
    
print("Done")
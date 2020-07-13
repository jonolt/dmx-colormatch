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


def read_tty(file_path, number_of_channels=3, dmx_step_size=10, dmx_start_address=1, reset=True):

    index = ["r", "g", "b", "c"]
    for i in range(number_of_channels):
        index.append(f"dmx_ch_{i+1}")
    
    df = pd.DataFrame(columns=index)
    
    try:
        ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
        ser.write("param\n".encode())
        ser.read_until("ack".encode())
        ser.write(f"param_chnanels {number_of_channels}\n".encode())
        ser.read_until("ack".encode())
        ser.write(f"param_dmx_step {dmx_step_size}\n".encode())
        ser.read_until("ack".encode())
        ser.write(f"dmx_start_address {dmx_start_address}\n".encode())
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
        df.to_csv(file_path)
        
    print("Done")
    
if __name__ == "__main__":
    
    try:
        number_of_channels = int(input("Channels To Param [3]: "))
    except ValueError:
        number_of_channels = 3
    
    try:
        dmx_step_size = int(input("DMX step size [10]: "))
    except ValueError:
        dmx_step_size = 10
        
    try:
        reset = int(input("reset y/n [n]: "))
    except ValueError:
        reset = False
        
    read_tty(number_of_channels=number_of_channels, dmx_step_size=dmx_step_size, reset=reset)
    

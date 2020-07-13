#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  9 21:09:34 2020

@author: johannes
"""

from parametize_tty import read_tty

read_tty("data/adj_megatripar_all.csv", number_of_channels=3, dmx_step_size=10)

read_tty("data/adj_megatripar_red.csv", number_of_channels=1, dmx_step_size=1, dmx_start_address=1)

read_tty("data/adj_megatripar_green.csv", number_of_channels=1, dmx_step_size=1, dmx_start_address=2)

read_tty("data/adj_megatripar_blue.csv", number_of_channels=1, dmx_step_size=1, dmx_start_address=3)

read_tty("data/adj_megatripar_uv.csv", number_of_channels=1, dmx_step_size=1, dmx_start_address=4)
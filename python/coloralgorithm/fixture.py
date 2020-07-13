#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May 21 20:03:12 2020

@author: johannes
"""

import pandas as pd
import numpy as np
from scipy.interpolate import griddata, interp1d


class FixtureRGB2:
    def __init__(self, path_csv):

        self.df = pd.read_csv(path_csv)
        self.dmx_r = 0
        self.dmx_g = 0
        self.dmx_b = 0
        self.delta = 10

    def dmx_write(self, dmx_r, dmx_g, dmx_b):
        self.dmx_r = dmx_r
        self.dmx_g = dmx_g
        self.dmx_b = dmx_b

    def simulate_sensor(self):
        rdf = self.df.loc[
            (self.df["dmx_ch_1"] >= self.dmx_r - self.delta)
            & (self.df["dmx_ch_1"] <= self.dmx_r + self.delta)
            & (self.df["dmx_ch_2"] >= self.dmx_g - self.delta)
            & (self.df["dmx_ch_2"] <= self.dmx_g + self.delta)
            & (self.df["dmx_ch_3"] >= self.dmx_b - self.delta)
            & (self.df["dmx_ch_3"] <= self.dmx_b + self.delta)
        ]
        a = self._interpolate(
            rdf.loc[rdf["dmx_ch_1"] >= self.dmx_r], [self.dmx_g, self.dmx_b]
        )
        b = self._interpolate(
            rdf.loc[rdf["dmx_ch_1"] <= self.dmx_r], [self.dmx_g, self.dmx_b]
        )
        ab = np.concatenate([a, b]).transpose()

        x = [min(rdf["dmx_ch_1"].values), max(rdf["dmx_ch_1"].values)]
        y = ab
        f = interp1d(x, y)
        c = f(self.dmx_r)

        return c

    def _interpolate(self, df, interpolation_points):
        points = df[["dmx_ch_2", "dmx_ch_3"]].values
        values = df[["r", "g", "b"]].values
        xi = np.array(interpolation_points)
        res = griddata(points, values, xi)
        return res

    def in_out(self, dmx):
        self.dmx_write(dmx[0], dmx[1], dmx[2])
        return self.simulate_sensor()


class FixtureRGB:
    def __init__(self, csv_paths):
        path_csv_r, path_csv_g, path_csv_b = csv_paths
        self.df_r = pd.read_csv(path_csv_r)
        self.df_g = pd.read_csv(path_csv_g)
        self.df_b = pd.read_csv(path_csv_b)

    def dmx_write(self, dmx_r, dmx_g, dmx_b):
        self.dmx_r = dmx_r
        self.dmx_g = dmx_g
        self.dmx_b = dmx_b

    def simulate_sensor(self):
        r = (
            self.df_r.iloc[self.dmx_r].r
            + self.df_g.iloc[self.dmx_g].r
            + self.df_b.iloc[self.dmx_b].r
        )
        g = (
            self.df_r.iloc[self.dmx_r].g
            + self.df_g.iloc[self.dmx_g].g
            + self.df_b.iloc[self.dmx_b].g
        )
        b = (
            self.df_r.iloc[self.dmx_r].b
            + self.df_g.iloc[self.dmx_g].b
            + self.df_b.iloc[self.dmx_b].b
        )
        c = (
            self.df_r.iloc[self.dmx_r].c
            + self.df_g.iloc[self.dmx_g].c
            + self.df_b.iloc[self.dmx_b].c
        )
        return r, g, b, c

    def in_out(self, dmx):
        self.dmx_write(*dmx)
        return self.simulate_sensor()


if __name__ == "__main__":
    csvpath = "../data/adj_megatripar_all.csv"
    csvpaths = (
        "../data/adj_megatripar_red.csv",
        "../data/adj_megatripar_green.csv",
        "../data/adj_megatripar_blue.csv",
    )
    f = FixtureRGB(csvpaths)
    f.dmx_write(121, 132, 153)
    z = f.simulate_sensor()

    z0 = f.in_out([0, 0, 0])
    z128 = f.in_out([128, 0, 0])
    z255 = f.in_out([255, 255, 255])

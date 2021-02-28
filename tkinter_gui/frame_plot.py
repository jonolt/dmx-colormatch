import time
import tkinter as tk

import matplotlib
import matplotlib.animation as animation
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.lines import Line2D
from itertools import cycle

matplotlib.use("TkAgg")

prop_cycle = cycle(plt.rcParams["axes.prop_cycle"])


class FramePlot(tk.Frame):
    def __init__(self, master, data):
        super().__init__(master)
        self.config(padx=5, pady=5)

        self.data = data

        scope_lines = [
            Line("ch1", "ch1", subplot=0),
            Line("ch2", "ch2", subplot=0),
            Line("ch3", "ch3", subplot=0),
            Line("ch4", "ch4", subplot=0),
            Line("ch5", "ch5", subplot=0),
            Line("ch6", "ch6", subplot=0),
            Line("score", "score", subplot=0, twin_axis=True, color="k"),
            Line("r", "r", subplot=1, color="r"),
            Line("g", "g", subplot=1, color="g"),
            Line("b", "b", subplot=1, color="b"),
            Line("c", "c", subplot=1, color="k"),
        ]

        self.fig, (self.ax1, self.ax2) = plt.subplots(2, 1)

        self.scope = Scope(self.ax1, self.ax2, self.data, scope_lines)

        canvas = FigureCanvasTkAgg(self.fig, self)
        canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.ani = animation.FuncAnimation(
            self.fig, self.scope.update, None, interval=200, blit=True
        )
        # toolbar = NavigationToolbar2Tk(canvas, master)
        # toolbar.update()


class Line:
    def __init__(self, var_name, display_name, subplot: int, twin_axis=False, **kwargs):
        self.var_name = var_name
        self.display_name = display_name
        self.subplot = subplot
        self.twin_axis = twin_axis
        self.x_data = [0]
        self.y_data = [0]
        if "color" not in kwargs:
            kwargs.update(next(prop_cycle))
        self.line = Line2D(self.x_data, self.y_data, label=self.display_name, **kwargs)

    def update_data(self, time_data, data: pd.DataFrame):
        self.y_data = data[self.var_name].values
        self.x_data = time_data
        self.line.set_data(self.x_data, self.y_data)


class Scope:
    def __init__(self, ax1, ax2, data, lines, fix_steps=1000):
        self.ax1 = ax1
        self.ax1b = self.ax1.twinx()
        self.ax2 = ax2
        self.data = data
        self.fix_steps = fix_steps
        self.lines = dict()
        for line in lines:
            if line.subplot == 0:
                if line.twin_axis:
                    self.ax1b.add_line(line.line)
                else:
                    self.ax1.add_line(line.line)
            else:
                self.ax2.add_line(line.line)
            self.lines[line.var_name] = line
        self.ax1.set_title("DMX Output and Score")
        self.ax1.set_xlim(-60, 0)
        self.ax1.set_ylabel("DMX Output Value")
        self.ax1.set_ylim(-5, 260)
        self.ax1b.set_ylabel("Score")
        self.ax1b.semilogy()
        self.ax1b.set_ylim(0.0000001, 10)
        self.ax2.set_title("Raw Color Sensor Values")
        self.ax2.set_xlim(-60, 0)
        self.ax2.set_ylabel("Color Intensity Value")
        self.ax2.set_ylim(0, pow(2, 14))

        self.ax1.legend(loc="upper left")
        self.ax2.legend(loc="upper left")

    def update(self, _):
        try:
            t1 = time.time()
            data = self.data["~!"].data.last("60S")
            t2 = time.time()
            x = data.index.astype("int64") // 1e9
            t3 = time.time()
            t = x - x[-1]
            t4 = time.time()
            for line in self.lines.values():
                line.update_data(t, data)
            t5 = time.time()
            # print(f"{t2-t1}+{t3-t2}+{t4-t3}+{t5-t4}={t5-t1}")
        except TypeError:
            pass
        return [line.line for line in self.lines.values()]

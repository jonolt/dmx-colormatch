import matplotlib
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import matplotlib.animation as animation
import matplotlib.pyplot as plt
import tkinter as tk

matplotlib.use("TkAgg")


class PlotWindow(tk.Frame):

    def __init__(self, data, master=None):

        self.data = data

        tk.Frame.__init__(self, master)
        label = tk.Label(self, text="Graph Page!")
        label.pack(pady=10, padx=10)

        self.fig, (self.ax1, self.ax3) = plt.subplots(2, 1)

        self.ax1b = self.ax1.twinx()

        canvas = FigureCanvasTkAgg(self.fig, master)
        canvas.draw()
        canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.ani = animation.FuncAnimation(self.fig, self.animate, None, interval=500, blit=False)
        # toolbar = NavigationToolbar2Tk(canvas, master)
        # toolbar.update()

    def animate(self, data):
        data = self.data["~!"].data.last("60S")

        if self.ax1:
            self.ax1.clear()
            self.ax1.plot(data.index, data[["ch1", "ch2", "ch3", "ch4", "ch5", "ch6"]].values)
            self.ax1.set_ylim(-5, 260)
            self.ax1b.clear()
            self.ax1b.plot(data.index, data["score"].values, color="k")
            self.ax1b.set_ylim(0.0000001, 10)
            self.ax1b.semilogy()
        if self.ax3:
            self.ax3.clear()
            # self.ax3.set_ylim(0, 6000)
            self.ax3.plot(data.index, data[["r", "g", "b", "c"]].values)

        return


if __name__ == "__main__":
    root = tk.Tk()
    app = PlotWindow(data=None, master=root)
    ani = animation.FuncAnimation(app.fig, app.animate, interval=40)
    app.mainloop()



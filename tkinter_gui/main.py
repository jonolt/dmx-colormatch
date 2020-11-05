"""GUI using the hardware UI shield structure with serial monitor.

Mainly for Testing and Development of Serial protocol.

"""

import sys
import tkinter as tk
import tkinter.ttk as ttk
from tkinter.font import Font
import serial
import serial.tools.list_ports
import serial.threaded
import enum

import pandas
import datetime
import ploting


class CommandGroup(enum.Enum):
    undefined = (0,)
    status = (1,)
    answer = (2,)


class CommunicationCodes:

    master = None

    def __init__(self, code, description, group=CommandGroup.undefined, enabled=True, log_atr_name=None, data_frame_columns=None):
        self.code = code
        self.description = description
        self.group = group
        self.enabled_default = enabled
        self.log_atr_name = log_atr_name
        if not data_frame_columns:
            data_frame_columns = ["val"]
        self.data = pandas.DataFrame(columns=data_frame_columns)
        self.__enabled_obj = None

    @property
    def enabled_obj(self):
        if self.__enabled_obj is None:
            self.__enabled_obj = tk.BooleanVar(
                master=self.master, value=self.enabled_default
            )
        return self.__enabled_obj

    @property
    def enabled(self):
        if self.__enabled_obj is None:
            return self.enabled_default
        return self.__enabled_obj.get()

    @enabled.setter
    def enabled(self, val: bool):
        if self.__enabled_obj is None:
            self.enabled_default = val
        else:
            self.__enabled_obj.set(val)

    def add_values(self, values: list):
        d = dict()
        i = 0
        for v in values:
            d.update({self.data.columns[i]: v})
            i = i+1
        if d:
            self.data = self.data.append(pandas.Series(data=d, name=datetime.datetime.now()))


codes_status = [
    CommunicationCodes(
        "~RGBC", "rgbc sensor value changed", CommandGroup.status, enabled=False, log_atr_name="values_rgbc", data_frame_columns=["r", "g", "b", "c"]
    ),
    CommunicationCodes(
        "~DMX", "dmx value was changed", CommandGroup.status, enabled=False, log_atr_name="values_dmx", data_frame_columns=["ch1", "ch2", "ch3", "ch4", "ch5", "ch6"]
    ),
    CommunicationCodes(
        "~SCORE", "score", CommandGroup.status, enabled=False, log_atr_name="values_score", data_frame_columns=["score"]
    ),
    CommunicationCodes(
        "~!", "score", CommandGroup.status, enabled=False, log_atr_name="all values", data_frame_columns=["ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "r", "g", "b", "c", "score"]
    ),
    CommunicationCodes("others", "all others will be checked too but is handled extra", CommandGroup.answer),
]


class PrintLines(serial.threaded.LineReader):
    def connection_made(self, transport):
        super(PrintLines, self).connection_made(transport)
        print(f"port {self.transport.serial.port} opened\n")

    def handle_line(self, data):
        print("line received: {}\n".format(repr(data)))

    def write_line(self, text):
        print("writing line: {}\n".format(repr(text)))
        super().write_line(text)

    def connection_lost(self, exc):
        if exc:
            print(exc)
        print("port closed\n")


class Application(tk.Frame):

    DISPLAY_WIDTH = 20
    DISPLAY_HEIGHT = 4

    def __init__(self, master=None):
        super().__init__(master)
        self.master = master
        CommunicationCodes.master = self.master
        self.code_map = {c.code: c for c in codes_status}
        self.filter_popup = None
        self.plot_frame = None

        self.after_ids = list()

        self.master.protocol("WM_DELETE_WINDOW", self.on_closing)

        self.menu_bar = tk.Menu()
        master.config(menu=self.menu_bar)

        serial_menu = tk.Menu(self.menu_bar, tearoff=0)
        serial_menu.add_command(label="Baudrate")
        serial_menu.add_command(label="Device")
        self.menu_bar.add_cascade(label="Serial", menu=serial_menu)

        frames_menu = tk.Menu(self.menu_bar, tearoff=0)
        frames_menu.add_command(label="Plot", command=self.plot_window)
        self.menu_bar.add_cascade(label="Frames", menu=frames_menu)

        help_menu = tk.Menu(self.menu_bar, tearoff=0)
        help_menu.add_command(label="Help Index")
        help_menu.add_command(label="About...")
        self.menu_bar.add_cascade(label="Help", menu=help_menu)

        self.lcd_content = [" " * 64] * 4
        self.lcdFont = tk.font.Font(family="DroidSansMono", size=16)
        self.text_lcd = tk.Text(
            width=20,
            height=4,
            padx=4,
            pady=4,
            font=self.lcdFont,
            state=tk.DISABLED,
            bg="black",
            fg="yellow",
        )
        self.text_lcd.grid(row=0, column=0, columnspan=4, rowspan=3)
        # self.update_lcd_text(1, 0, "Hello")
        # self.update_lcd_text(2, 6, "World")
        # self.write_lcd()

        self.encoder = tk.Scale(master, orient=tk.HORIZONTAL, length=100)  # tk.Spinbox(width=5, font=self.lcdFont)
        self.encoder.grid(
            row=1,
            column=7,
            columnspan=1,
        )
        self.set_encoder_values(0, 100, 5)

        self.button_1 = tk.Button(text="ENC")
        self.button_1.grid(row=2, column=7)

        self.button_2 = tk.Button(text="L")
        self.button_2.grid(row=4, column=6)

        self.button_3 = tk.Button(text="M")
        self.button_3.grid(row=4, column=7)

        self.button_4 = tk.Button(text="R")
        self.button_4.grid(row=4, column=8)

        self.button_5 = tk.Button(text="F1")
        self.button_5.grid(row=4, column=0)

        self.button_6 = tk.Button(text="F2")
        self.button_6.grid(row=4, column=1)

        self.button_7 = tk.Button(text="F3")
        self.button_7.grid(row=4, column=2)

        self.button_8 = tk.Button(text="F4")
        self.button_8.grid(row=4, column=3)

        self.connected = None
        self.button_toggle_connection = tk.Button(
            anchor="c", width=5, command=self.toggle_serial_connection
        )
        self.button_toggle_connection.grid(row=0, column=8)

        self.separator = ttk.Separator(orient=tk.HORIZONTAL)
        self.separator.grid(row=5, column=0, columnspan=9, sticky=tk.E + tk.W, pady=30)

        self.log_frame = tk.Frame()
        self.log_frame.grid(row=6, column=0, columnspan=9)

        self.serial_send_string = tk.StringVar()
        self.serial_send_entry = tk.Entry(
            master=self.log_frame,
            width=50,
            textvariable=self.serial_send_string,
            state="disabled",
        )
        self.serial_send_entry["disabledbackground"] = self.serial_send_entry[
            "background"
        ]
        self.serial_send_entry.grid(row=0, column=0)
        self.serial_send_entry.bind("<Return>", self.serial_send)
        self.serial_send = tk.Button(
            master=self.log_frame,
            text="Send",
            command=self.serial_send,
            state="disabled",
        )
        self.serial_send.grid(row=0, column=1)
        self.serial_clear = tk.Button(
            master=self.log_frame,
            text="Clear",
            command=lambda: self.serial_log.delete(0.0, tk.END),
        )
        self.serial_clear.grid(row=0, column=2)
        self.serial_filter = tk.Button(
            master=self.log_frame, text="Filter", command=self.popup_filter
        )
        self.serial_filter.grid(row=0, column=3)
        self.serial_log = tk.Text(master=self.log_frame)
        self.serial_log.grid(row=1, column=0, columnspan=4)
        self.serial_clear.config(command=self.serial_log.delete(0.0, tk.END))

        self.serial_connection = serial.Serial()
        self.serial_reader_thread = None
        self.serial_text_buffer = str()
        self.update_on_off_button()
        self.write_lcd()

    def set_encoder_values(self, lower, upper, resolution):
        self.encoder["from_"] = lower
        self.encoder["to"] = upper
        self.encoder["tickinterval"] = upper
        self.encoder["resolution"] = resolution

    def plot_window(self):
        if self.plot_frame is None or not self.plot_frame.children:
            tl = tk.Toplevel(self.master)
            self.plot_frame = ploting.PlotWindow(self.code_map, tl)
        else:
            self.plot_frame.destroy()

        return self.plot_frame

    def popup_filter(self):
        if self.filter_popup is None or not self.filter_popup.children:
            self.filter_popup = tk.Toplevel(self.master)
            self.filter_popup.wm_title("Filter")
            # self.filter_popup.geometry("200x400")

            for code in self.code_map.values():
                tk.Checkbutton(
                    self.filter_popup,
                    text=code.code,
                    variable=code.enabled_obj,
                    onvalue=1,
                    offvalue=0,
                ).pack(side="top", anchor="w")

            # b = ttk.Button(win, text="Apply")
            # b.pack()

            b = ttk.Button(
                self.filter_popup, text="Close", command=self.filter_popup.destroy
            )
            b.pack()
        else:
            self.filter_popup.destroy()

        return self.filter_popup

    def update_lcd_text(self, line: int, char: int, text: str):
        self.lcd_content[line - 1] = (
            self.lcd_content[line - 1][0:char]
            + text
            + self.lcd_content[line - 1][char + len(text) : -1]
        )

    def write_lcd(self, pos=None):
        if not pos:
            pos = [0, 0, 0, 0]
        self.text_lcd.delete(0.0, tk.END)
        to_insert = list()
        for line_number in range(len(pos)):
            i = pos[line_number]
            to_insert.append(self.lcd_content[line_number][i : i + 20])
        self.text_lcd.config(state=tk.NORMAL)
        self.text_lcd.insert(0.0, "\n".join(to_insert))
        self.text_lcd.config(state=tk.DISABLED)
        self.after_ids.append(self.master.after(250, self.write_lcd))

    def update_on_off_button(self):
        if self.serial_connection.is_open:
            self.button_toggle_connection.config(text="OFF", bg="red")
        else:
            self.button_toggle_connection.config(text="ON", bg="green")
        self.after_ids.append(self.master.after(100, self.update_on_off_button))

    def toggle_serial_connection(self):
        if self.serial_connection.is_open:
            self.serial_connection.close()
            self.serial_send_entry["state"] = "disabled"
            self.serial_send["state"] = "disabled"
        else:
            if not self.serial_connection.is_open:
                all_devices = serial.tools.list_ports.comports()
                usb_devices = [
                    (d.device, d.name) for d in all_devices if "ACM" in d.name
                ]
                # TODO popup window when multiple ports are open or a pre selection in menu
                if len(usb_devices) == 0:
                    return
                elif len(usb_devices) == 1:
                    device = usb_devices[0]
                else:
                    return
                self.serial_connection.port = device[0]
                self.serial_connection.baudrate = 1000000
                self.serial_connection.open()
                self.read_serial_input()
                self.serial_send_entry["state"] = "normal"
                self.serial_send["state"] = "normal"

    def serial_send(self, event=None):
        text = self.serial_send_string.get()
        if not text.endswith("\n"):
            text = text + "\n"
        self.serial_connection.write(text.encode("ascii"))
        print(f"send: {text}")
        self.serial_send_string.set("")

    def update_intensity(self, text):
        # func will be removed when FSM for display is implemented
        c = int(text.split(" ")[-1])
        value = int(c / 2024 * 90)  # intensity_count/max_count*100%*.9
        # value=int(c)
        c_string = "{0:3d}%".format(value)
        if value > 120:
            c_string = "-" + c_string
        elif value < 80:
            c_string = "+" + c_string
        else:
            c_string = "*" + c_string
        self.update_lcd_text(1, 15, c_string)

    def read_serial_input(self):
        if not self.serial_connection.is_open:
            return
        bytes_to_read = self.serial_connection.in_waiting
        if bytes_to_read > 0:
            try:
                self.serial_text_buffer += self.serial_connection.read(
                    size=bytes_to_read
                ).decode("ascii")
            except UnicodeDecodeError as ex:
                print(ex.reason)
        if "\n" in self.serial_text_buffer:
            text, self.serial_text_buffer = self.serial_text_buffer.split(
                "\n", maxsplit=1
            )
            # print("received: " + text)
            if text.startswith("~RGBC"):
                self.update_intensity(text)
            code = self.code_map.get(text.split(" ", maxsplit=1)[0], self.code_map["others"])
            if code:
                if code.enabled:
                    self.serial_log.insert(tk.END, text + "\n")
                    self.serial_log.see(tk.END)
                try:
                    str_values = text.split(" ")[1:]
                    float_values = [float(val) for val in str_values]
                    code.add_values(float_values)
                except (ValueError, IndexError) as ex:
                    pass

        if self.serial_connection.is_open:
            self.after_ids.append(self.master.after(10, self.read_serial_input))

    def on_closing(self):
        if self.serial_connection.is_open:
            self.serial_connection.close()
        for aid in self.after_ids:
            self.after_cancel(aid)
        self.master.quit()


if __name__ == "__main__":

    root = tk.Tk()
    root.title("UI Shield")
    root.config(padx=30, pady=20)
    app = Application(master=root)
    app.mainloop()

    sys.exit(0)

"""GUI using the hardware UI shield structure with serial monitor.

"""

import datetime
import enum
import sys
import tkinter as tk
import tkinter.ttk as ttk

import pandas
import serial
import serial.threaded
import serial.tools.list_ports

from frame_ui_shield import FrameUiShield
from frame_plot import FramePlot


class CommandGroup(enum.Enum):
    undefined = (0,)
    status = (1,)
    answer = (2,)


class CommunicationCodes:

    master = None

    def __init__(
        self,
        code,
        description,
        group=CommandGroup.undefined,
        enabled=True,
        log_atr_name=None,
        data_frame_columns=None,
    ):
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
            i = i + 1
        if d:
            self.data = self.data.append(
                pandas.Series(data=d, name=datetime.datetime.now())
            )


codes_status = [
    CommunicationCodes(
        "~RGBC",
        "rgbc sensor value changed",
        CommandGroup.status,
        enabled=False,
        log_atr_name="values_rgbc",
        data_frame_columns=["r", "g", "b", "c"],
    ),
    CommunicationCodes(
        "~DMX",
        "dmx value was changed",
        CommandGroup.status,
        enabled=False,
        log_atr_name="values_dmx",
        data_frame_columns=["ch1", "ch2", "ch3", "ch4", "ch5", "ch6"],
    ),
    CommunicationCodes(
        "~SCORE",
        "score",
        CommandGroup.status,
        enabled=False,
        log_atr_name="values_score",
        data_frame_columns=["score"],
    ),
    CommunicationCodes(
        "~!",
        "score",
        CommandGroup.status,
        enabled=False,
        log_atr_name="all values",
        data_frame_columns=[
            "ch1",
            "ch2",
            "ch3",
            "ch4",
            "ch5",
            "ch6",
            "r",
            "g",
            "b",
            "c",
            "score",
        ],
    ),
    CommunicationCodes(
        "others",
        "all others will be checked too but is handled extra",
        CommandGroup.answer,
    ),
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


class StartPage(tk.Frame):
    def __init__(self, master, main):
        super().__init__(master)
        self.main = main
        self.config(padx=5, pady=5)
        self.button_toggle_connection = tk.Button(
            self, anchor="c", width=5, command=self.main.toggle_serial_connection
        )
        self.button_toggle_connection.grid(row=0)
        self.button_send_ref = tk.Button(
            self,
            text="REF",
            anchor="c",
            width=5,
            command=lambda: self.main.serial_send("REF"),
        )
        self.button_send_ref.grid(row=1)
        self.button_send_match = tk.Button(
            self,
            text="MATCH",
            anchor="c",
            width=5,
            command=lambda: self.main.serial_send("MATCH"),
        )
        self.button_send_match.grid(row=2)
        self.button_cancel = tk.Button(
            self,
            text="cancel",
            foreground="red",
            anchor="c",
            width=5,
            command=lambda: self.main.serial_send("c"),
        )
        self.button_cancel.grid(row=3)
        self.label_intensity = tk.Label(self, text="int")
        self.label_intensity.grid(row=0, column=1)


class LogPage(tk.Frame):
    def __init__(self, master, main):
        super().__init__(master)
        self.main = main
        self.config(padx=5, pady=5)

        self.serial_send_string = tk.StringVar()
        self.serial_send_entry = tk.Entry(
            master=self,
            width=50,
            textvariable=self.serial_send_string,
            state="disabled",
        )
        self.serial_send_entry["disabledbackground"] = self.serial_send_entry[
            "background"
        ]
        self.serial_send_entry.grid(row=0, column=0)
        self.serial_send_entry.bind(
            "<Return>",
            lambda event: self.main.serial_send(self.serial_send_string.get()),
        )
        self.serial_send = tk.Button(
            master=self,
            text="Send",
            command=lambda: self.main.serial_send(self.serial_send_string.get()),
            state="disabled",
        )
        self.serial_send.grid(row=0, column=1)
        self.serial_clear = tk.Button(
            master=self,
            text="Clear",
            command=lambda: self.serial_log.delete(0.0, tk.END),
        )
        self.serial_clear.grid(row=0, column=2)
        self.serial_log = tk.Text(master=self)
        self.serial_log.grid(row=1, column=0, columnspan=3)
        self.serial_clear.config(command=self.serial_log.delete(0.0, tk.END))

        self.filter_frame = FilterFrame(self, self.main.code_map)
        self.filter_frame.grid(row=0, rowspan=2, column=3)

        self.main.update_on_off_button()


class FilterFrame(tk.Frame):
    def __init__(self, master, code_map):
        super().__init__(master)
        tk.Label(self, text="Filter").pack(side="top")
        for code in code_map.values():
            tk.Checkbutton(
                self,
                text=code.code,
                variable=code.enabled_obj,
                onvalue=1,
                offvalue=0,
            ).pack(side="top", anchor="w")


class Application(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)
        self.title('dmx-colormatch')
        CommunicationCodes.master = self
        self.code_map = {c.code: c for c in codes_status}

        self.serial_connection = serial.Serial()
        self.serial_reader_thread = None
        self.serial_text_buffer = str()

        self.after_ids = list()

        self.protocol("WM_DELETE_WINDOW", self.on_closing)

        self.notebook_top = ttk.Notebook(self)
        self.start_frame = StartPage(self.notebook_top, self)
        self.ui_shield = FrameUiShield(self.notebook_top)
        self.notebook_top.add(self.start_frame, text="Start")
        self.notebook_top.add(self.ui_shield, text="UI Shield")
        self.notebook_top.pack(fill=tk.BOTH)

        self.notebook_bottom = ttk.Notebook(self)
        self.serial = LogPage(self.notebook_bottom, self)
        self.plot = FramePlot(self.notebook_bottom, self.code_map)
        self.notebook_bottom.add(self.serial, text="Serial")
        self.notebook_bottom.add(self.plot, text="Plot")
        self.notebook_bottom.pack(fill=tk.BOTH)

        self.menu_bar = tk.Menu()
        self.config(menu=self.menu_bar)

        serial_menu = tk.Menu(self.menu_bar, tearoff=0)
        serial_menu.add_command(label="Baudrate")
        serial_menu.add_command(label="Device")
        self.menu_bar.add_cascade(label="Serial", menu=serial_menu)

        help_menu = tk.Menu(self.menu_bar, tearoff=0)
        help_menu.add_command(label="Help Index")
        help_menu.add_command(label="About...")
        self.menu_bar.add_cascade(label="Help", menu=help_menu)

    def update_on_off_button(self):
        if self.serial_connection.is_open:
            self.start_frame.button_toggle_connection.config(text="OFF", bg="red")
        else:
            self.start_frame.button_toggle_connection.config(text="ON", bg="green")
        self.after_ids.append(self.after(100, self.update_on_off_button))

    def toggle_serial_connection(self):
        if self.serial_connection.is_open:
            self.serial_connection.close()
            self.serial.serial_send_entry["state"] = "disabled"
            self.serial.serial_send["state"] = "disabled"
        else:
            if not self.serial_connection.is_open:
                all_devices = serial.tools.list_ports.comports()
                usb_devices = [
                    (d.device, d.name) for d in all_devices if "ACM" in d.name
                ]
                # TODO popup window when multiple ports are open or a pre selection in menu
                if len(usb_devices) == 0:
                    print("no serial device was found")
                    return
                elif len(usb_devices) == 1:
                    device = usb_devices[0]
                else:
                    print("to many serial devices found")
                    return
                self.serial_connection.port = device[0]
                self.serial_connection.baudrate = 1000000
                self.serial_connection.open()
                self.read_serial_input()
                self.serial.serial_send_entry["state"] = "normal"
                self.serial.serial_send["state"] = "normal"

    def serial_send(self, text):
        if not text.endswith("\n"):
            text = text + "\n"
        self.serial_connection.write(text.encode("ascii"))
        print(f"send: {text}")
        self.serial.serial_send_string.set("")

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
        self.start_frame.label_intensity.configure(text=c_string)

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
            if text.startswith("~RGBC"):
                self.update_intensity(text)
            code = self.code_map.get(
                text.split(" ", maxsplit=1)[0], self.code_map["others"]
            )
            if code:
                if code.enabled:
                    self.serial.serial_log.insert(tk.END, text + "\n")
                    self.serial.serial_log.see(tk.END)
                try:
                    str_values = text.split(" ")[1:]
                    float_values = [float(val) for val in str_values]
                    code.add_values(float_values)
                except (ValueError, IndexError):
                    pass

        if self.serial_connection.is_open:
            self.after_ids.append(self.after(10, self.read_serial_input))

    def on_closing(self):
        if self.serial_connection.is_open:
            self.serial_connection.close()
        for aid in self.after_ids:
            self.after_cancel(aid)
        self.quit()


if __name__ == "__main__":
    app = Application()
    app.mainloop()
    sys.exit(0)

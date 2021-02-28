import tkinter as tk
from tkinter.font import Font


class FrameUiShield(tk.Frame):

    DISPLAY_WIDTH = 20
    DISPLAY_HEIGHT = 4

    def __init__(self, master):
        super().__init__(master)
        self.config(padx=5, pady=5)

        self.after_ids = list()

        self.lcd_content = [" " * 64] * 4
        self.lcdFont = tk.font.Font(family="DroidSansMono", size=16)
        self.text_lcd = tk.Text(
            self,
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

        self.encoder = tk.Scale(self, orient=tk.HORIZONTAL, length=100)  # tk.Spinbox(width=5, font=self.lcdFont)
        self.encoder.grid(
            row=1,
            column=7,
            columnspan=1,
        )
        self.set_encoder_values(0, 100, 5)

        self.button_1 = tk.Button(self, text="ENC")
        self.button_1.grid(row=2, column=7)

        self.button_2 = tk.Button(self, text="L")
        self.button_2.grid(row=4, column=6)

        self.button_3 = tk.Button(self, text="M")
        self.button_3.grid(row=4, column=7)

        self.button_4 = tk.Button(self, text="R")
        self.button_4.grid(row=4, column=8)

        self.button_5 = tk.Button(self, text="F1")
        self.button_5.grid(row=4, column=0)

        self.button_6 = tk.Button(self, text="F2")
        self.button_6.grid(row=4, column=1)

        self.button_7 = tk.Button(self, text="F3")
        self.button_7.grid(row=4, column=2)

        self.button_8 = tk.Button(self, text="F4")
        self.button_8.grid(row=4, column=3)

        self.update_lcd_text(1, 0, "  this will be a  ")
        self.update_lcd_text(2, 0, " remote interface ")
        self.update_lcd_text(3, 0, "     for the      ")
        self.update_lcd_text(4, 0, "    UI-Shield     ")
        self.write_lcd()

    def set_encoder_values(self, lower, upper, resolution):
        self.encoder["from_"] = lower
        self.encoder["to"] = upper
        self.encoder["tickinterval"] = upper
        self.encoder["resolution"] = resolution

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

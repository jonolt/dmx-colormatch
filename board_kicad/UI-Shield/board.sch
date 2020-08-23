EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "UI Shield"
Date "2020-08-23"
Rev ""
Comp ""
Comment1 "ERC Warnings because of false pin types of Symbols"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1350 5250 1000 5250
Wire Wire Line
	1350 5350 1000 5350
Wire Wire Line
	3950 5250 4350 5250
Wire Wire Line
	3950 5350 4350 5350
Wire Wire Line
	3950 5450 4350 5450
Wire Wire Line
	3950 5550 4350 5550
Wire Wire Line
	3950 5650 4350 5650
Wire Wire Line
	3950 5950 4350 5950
Text Label 1000 5250 0    50   ~ 0
TX
Text Label 1000 5350 0    50   ~ 0
RX
Text Label 4350 5350 2    50   ~ 0
D3
Text Label 4350 5450 2    50   ~ 0
D4
Text Label 4350 5550 2    50   ~ 0
IO_CS
Text Label 4350 5650 2    50   ~ 0
D6
Text Label 4350 5750 2    50   ~ 0
LCD_RS
Text Label 4350 5850 2    50   ~ 0
LCD_CS
Text Label 4350 5950 2    50   ~ 0
D9
Text Label 4350 6050 2    50   ~ 0
LCD_LED
$Comp
L arduino:Arduino_Uno_Shield XA1
U 1 1 5F31C54A
P 2650 6300
F 0 "XA1" H 2650 7687 60  0000 C CNN
F 1 "Arduino_Shield" H 2650 7581 60  0000 C CNN
F 2 "project:Arduino_Shield_Large" H 4450 10050 60  0001 C CNN
F 3 "https://store.arduino.cc/arduino-uno-rev3" H 4450 10050 60  0001 C CNN
F 4 "Do Not Populate Tag" H 2650 6300 50  0001 C CNN "DNP"
	1    2650 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 7250 3950 7250
Wire Wire Line
	4350 7350 3950 7350
Wire Wire Line
	1350 5950 1000 5950
Wire Wire Line
	1350 6050 1000 6050
Wire Wire Line
	1350 6150 1000 6150
Wire Wire Line
	1350 6250 1000 6250
Wire Wire Line
	1350 6350 1000 6350
Wire Wire Line
	1350 6450 1000 6450
Wire Wire Line
	1350 7350 1200 7350
Wire Wire Line
	1350 5550 1000 5550
Wire Wire Line
	1350 5650 1000 5650
Wire Wire Line
	1350 6550 1000 6550
Text Label 4350 6150 2    50   ~ 0
MOSI
Text Label 4350 6250 2    50   ~ 0
MISO
Text Label 4350 6350 2    50   ~ 0
SCK
Text Label 4350 7250 2    50   ~ 0
~RESET
Text Label 1000 5550 0    50   ~ 0
SCL
Text Label 1000 5650 0    50   ~ 0
SDA
Text Label 1000 5950 0    50   ~ 0
A5
Text Label 1000 6050 0    50   ~ 0
A4
Text Label 1000 6150 0    50   ~ 0
A3
Text Label 1000 6250 0    50   ~ 0
A2
Text Label 1000 6350 0    50   ~ 0
A1
Text Label 1000 6450 0    50   ~ 0
A0
Text Label 1000 6550 0    50   ~ 0
AREF
Text Label 1200 7350 0    50   ~ 0
VIN
Wire Wire Line
	1350 7250 1200 7250
Wire Wire Line
	1350 7150 1200 7150
Wire Wire Line
	1350 6850 1350 6950
Connection ~ 1350 6950
Wire Wire Line
	1350 6950 1350 7050
$Comp
L power:GND #PWR0101
U 1 1 5F373C30
P 1350 6950
F 0 "#PWR0101" H 1350 6700 50  0001 C CNN
F 1 "GND" V 1355 6822 50  0000 R CNN
F 2 "" H 1350 6950 50  0001 C CNN
F 3 "" H 1350 6950 50  0001 C CNN
	1    1350 6950
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0102
U 1 1 5F3747FE
P 1200 7150
F 0 "#PWR0102" H 1200 7000 50  0001 C CNN
F 1 "+3.3V" V 1215 7278 50  0000 L CNN
F 2 "" H 1200 7150 50  0001 C CNN
F 3 "" H 1200 7150 50  0001 C CNN
	1    1200 7150
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 5F3750CB
P 1200 7250
F 0 "#PWR0103" H 1200 7100 50  0001 C CNN
F 1 "+5V" V 1215 7378 50  0000 L CNN
F 2 "" H 1200 7250 50  0001 C CNN
F 3 "" H 1200 7250 50  0001 C CNN
	1    1200 7250
	0    -1   -1   0   
$EndComp
NoConn ~ 1000 5250
NoConn ~ 1000 5350
NoConn ~ 1000 5550
NoConn ~ 1000 5650
NoConn ~ 1000 5950
NoConn ~ 1000 6050
NoConn ~ 1000 6150
NoConn ~ 1000 6250
NoConn ~ 1000 6350
NoConn ~ 1000 6450
NoConn ~ 1000 6550
Text Label 4350 5250 2    50   ~ 0
D2
NoConn ~ 4350 5450
NoConn ~ 4350 5650
NoConn ~ 4350 5950
NoConn ~ 3950 6550
NoConn ~ 3950 6650
NoConn ~ 3950 6750
NoConn ~ 3950 6850
NoConn ~ 3950 6950
NoConn ~ 3950 7050
NoConn ~ 4350 7350
NoConn ~ 1200 7350
Text Label 5900 7500 2    50   ~ 0
IO_INTB
Text Label 5000 7500 0    50   ~ 0
IO_INTA
Wire Wire Line
	5600 7500 5900 7500
Wire Wire Line
	5300 7500 5000 7500
Text Label 5900 7150 2    50   ~ 0
D3
Text Label 5900 6800 2    50   ~ 0
D2
Text Label 5000 7150 0    50   ~ 0
IO_INTB
Text Label 5000 6800 0    50   ~ 0
IO_INTA
Wire Wire Line
	5600 7150 5900 7150
Wire Wire Line
	5300 7150 5000 7150
Wire Wire Line
	5600 6800 5900 6800
Wire Wire Line
	5300 6800 5000 6800
$Comp
L Jumper:SolderJumper_2_Bridged JP2
U 1 1 5F4F6DA6
P 5450 7150
F 0 "JP2" H 5450 7355 50  0000 C CNN
F 1 "SolderJumper_2_Bridged" H 5450 7264 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged2Bar_Pad1.0x1.5mm" H 5450 7150 50  0001 C CNN
F 3 "~" H 5450 7150 50  0001 C CNN
F 4 "Do Not Populate Tag" H 5450 7150 50  0001 C CNN "DNP"
	1    5450 7150
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP3
U 1 1 5F4F60C2
P 5450 6800
F 0 "JP3" H 5450 7005 50  0000 C CNN
F 1 "SolderJumper_2_Bridged" H 5450 6914 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged2Bar_Pad1.0x1.5mm" H 5450 6800 50  0001 C CNN
F 3 "~" H 5450 6800 50  0001 C CNN
F 4 "Do Not Populate Tag" H 5450 6800 50  0001 C CNN "DNP"
	1    5450 6800
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0114
U 1 1 5F64BCAF
P 9850 1350
F 0 "#PWR0114" H 9850 1200 50  0001 C CNN
F 1 "+5V" H 9865 1523 50  0000 C CNN
F 2 "" H 9850 1350 50  0001 C CNN
F 3 "" H 9850 1350 50  0001 C CNN
	1    9850 1350
	1    0    0    -1  
$EndComp
Text Label 8850 3050 0    50   ~ 0
SW4
Text Label 8850 2950 0    50   ~ 0
SW3
Text Label 8850 2850 0    50   ~ 0
SW2
Text Label 8850 2750 0    50   ~ 0
SW1
Text Label 8850 2650 0    50   ~ 0
B
Text Label 8850 2550 0    50   ~ 0
A
Text Label 8850 2250 0    50   ~ 0
LED8
Text Label 8850 2350 0    50   ~ 0
SW8
Text Label 8850 2050 0    50   ~ 0
LED7
Text Label 8850 2150 0    50   ~ 0
SW7
Text Label 8850 1850 0    50   ~ 0
LED6
Text Label 8850 1950 0    50   ~ 0
SW6
Text Label 8850 1650 0    50   ~ 0
LED5
Text Label 8850 1750 0    50   ~ 0
SW5
Wire Wire Line
	9150 3250 8850 3250
Wire Wire Line
	9150 3150 8850 3150
Wire Wire Line
	9150 3050 8850 3050
Wire Wire Line
	9150 2950 8850 2950
Wire Wire Line
	9150 2850 8850 2850
Wire Wire Line
	9150 2750 8850 2750
Wire Wire Line
	9150 2650 8850 2650
Wire Wire Line
	9150 2550 8850 2550
Wire Wire Line
	9150 2350 8850 2350
Wire Wire Line
	9150 2250 8850 2250
Wire Wire Line
	9150 2150 8850 2150
Wire Wire Line
	9150 2050 8850 2050
Wire Wire Line
	9150 1950 8850 1950
Wire Wire Line
	9150 1850 8850 1850
Wire Wire Line
	9150 1750 8850 1750
Wire Wire Line
	9150 1650 8850 1650
Wire Wire Line
	10200 3650 9850 3650
Connection ~ 10200 3650
$Comp
L power:GND #PWR0105
U 1 1 5F381E2E
P 10200 3650
F 0 "#PWR0105" H 10200 3400 50  0001 C CNN
F 1 "GND" H 10205 3477 50  0000 C CNN
F 2 "" H 10200 3650 50  0001 C CNN
F 3 "" H 10200 3650 50  0001 C CNN
	1    10200 3650
	1    0    0    -1  
$EndComp
Text Label 10900 2250 2    50   ~ 0
IO_INTB
Text Label 10900 2350 2    50   ~ 0
IO_INTA
Text Label 10900 2550 2    50   ~ 0
~RESET
Wire Wire Line
	10600 3250 10600 3650
Connection ~ 10600 3250
Wire Wire Line
	10550 3250 10600 3250
Wire Wire Line
	10600 3150 10600 3250
Connection ~ 10600 3150
Wire Wire Line
	10550 3150 10600 3150
Wire Wire Line
	9850 3650 9850 3550
Wire Wire Line
	10600 3650 10200 3650
Wire Wire Line
	10600 3050 10600 3150
Wire Wire Line
	10550 3050 10600 3050
Text Label 10900 1950 2    50   ~ 0
MISO
Text Label 10900 1850 2    50   ~ 0
MOSI
Text Label 10900 1750 2    50   ~ 0
SCK
Text Label 10900 1650 2    50   ~ 0
IO_CS
Wire Wire Line
	10550 2550 10900 2550
Wire Wire Line
	10550 2350 10900 2350
Wire Wire Line
	10550 2250 10900 2250
Wire Wire Line
	10550 1950 10900 1950
Wire Wire Line
	10550 1850 10900 1850
Wire Wire Line
	10550 1750 10900 1750
Wire Wire Line
	10550 1650 10900 1650
$Comp
L Interface_Expansion:MCP23S17_SS U1
U 1 1 5F8C3787
P 9850 2450
F 0 "U1" H 10300 3400 50  0000 C CNN
F 1 "MCP23S17_SS" H 9500 3400 50  0000 C CNN
F 2 "Package_SO:SSOP-28_5.3x10.2mm_P0.65mm" H 10050 1450 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/20001952C.pdf" H 10050 1350 50  0001 L CNN
F 4 "MCP23S17-E/SS" H 9850 2450 50  0001 C CNN "manf#"
	1    9850 2450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3950 6050 4350 6050
Wire Wire Line
	4350 6250 3950 6250
Wire Wire Line
	3950 5850 4350 5850
Wire Wire Line
	3950 5750 4350 5750
Wire Wire Line
	4350 6150 3950 6150
Wire Wire Line
	4350 6350 3950 6350
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5F65983E
P 5200 5300
F 0 "#FLG0101" H 5200 5375 50  0001 C CNN
F 1 "PWR_FLAG" H 5200 5473 50  0000 C CNN
F 2 "" H 5200 5300 50  0001 C CNN
F 3 "~" H 5200 5300 50  0001 C CNN
	1    5200 5300
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5F659E93
P 5600 5300
F 0 "#FLG0102" H 5600 5375 50  0001 C CNN
F 1 "PWR_FLAG" H 5600 5473 50  0000 C CNN
F 2 "" H 5600 5300 50  0001 C CNN
F 3 "~" H 5600 5300 50  0001 C CNN
	1    5600 5300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0115
U 1 1 5F65B9A8
P 5200 5500
F 0 "#PWR0115" H 5200 5350 50  0001 C CNN
F 1 "+3.3V" H 5215 5673 50  0000 C CNN
F 2 "" H 5200 5500 50  0001 C CNN
F 3 "" H 5200 5500 50  0001 C CNN
	1    5200 5500
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0116
U 1 1 5F65C116
P 5600 5500
F 0 "#PWR0116" H 5600 5350 50  0001 C CNN
F 1 "+5V" H 5615 5673 50  0000 C CNN
F 2 "" H 5600 5500 50  0001 C CNN
F 3 "" H 5600 5500 50  0001 C CNN
	1    5600 5500
	-1   0    0    1   
$EndComp
Wire Wire Line
	5200 5300 5200 5500
Wire Wire Line
	5600 5300 5600 5500
Wire Wire Line
	5200 6000 5200 6200
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5F7A71E7
P 5200 6000
F 0 "#FLG0104" H 5200 6075 50  0001 C CNN
F 1 "PWR_FLAG" H 5200 6173 50  0000 C CNN
F 2 "" H 5200 6000 50  0001 C CNN
F 3 "~" H 5200 6000 50  0001 C CNN
	1    5200 6000
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0118
U 1 1 5F79D851
P 5200 6200
F 0 "#PWR0118" H 5200 6050 50  0001 C CNN
F 1 "+12V" H 5215 6373 50  0000 C CNN
F 2 "" H 5200 6200 50  0001 C CNN
F 3 "" H 5200 6200 50  0001 C CNN
	1    5200 6200
	-1   0    0    1   
$EndComp
Wire Wire Line
	5600 6000 5600 6200
$Comp
L power:GND #PWR0117
U 1 1 5F65C8EC
P 5600 6200
F 0 "#PWR0117" H 5600 5950 50  0001 C CNN
F 1 "GND" H 5605 6027 50  0000 C CNN
F 2 "" H 5600 6200 50  0001 C CNN
F 3 "" H 5600 6200 50  0001 C CNN
	1    5600 6200
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 5F65A3E3
P 5600 6000
F 0 "#FLG0103" H 5600 6075 50  0001 C CNN
F 1 "PWR_FLAG" H 5600 6173 50  0000 C CNN
F 2 "" H 5600 6000 50  0001 C CNN
F 3 "~" H 5600 6000 50  0001 C CNN
	1    5600 6000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5F482F4A
P 3700 3750
F 0 "R2" H 3770 3796 50  0000 L CNN
F 1 "240k" H 3770 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3630 3750 50  0001 C CNN
F 3 "~" H 3700 3750 50  0001 C CNN
	1    3700 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5F48353B
P 3700 4150
F 0 "R3" H 3770 4196 50  0000 L CNN
F 1 "27k" H 3770 4105 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3630 4150 50  0001 C CNN
F 3 "~" H 3700 4150 50  0001 C CNN
	1    3700 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5F484D9F
P 4050 3950
F 0 "C5" H 3935 3904 50  0000 R CNN
F 1 "1u" H 3935 3995 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4088 3800 50  0001 C CNN
F 3 "~" H 4050 3950 50  0001 C CNN
	1    4050 3950
	-1   0    0    1   
$EndComp
$Comp
L Device:C C4
U 1 1 5F499B6A
P 1500 3950
F 0 "C4" H 1385 3904 50  0000 R CNN
F 1 "4.7u" H 1385 3995 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1538 3800 50  0001 C CNN
F 3 "~" H 1500 3950 50  0001 C CNN
	1    1500 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3600 2000 3600
Wire Wire Line
	1500 3600 1150 3600
Connection ~ 1500 3600
Wire Wire Line
	3700 4400 3700 4300
Wire Wire Line
	2500 4100 2500 4400
Connection ~ 2500 4400
Wire Wire Line
	2500 4400 3700 4400
Wire Wire Line
	1500 3600 1500 3800
Connection ~ 1500 4400
Wire Wire Line
	1500 4400 1150 4400
Wire Wire Line
	3000 3600 3100 3600
Wire Wire Line
	3500 3600 3700 3600
Wire Wire Line
	3000 3900 3700 3900
Wire Wire Line
	3700 3900 3700 4000
Connection ~ 3700 3900
Wire Wire Line
	3700 3600 4050 3600
Connection ~ 3700 3600
Wire Wire Line
	4050 3600 4050 3800
Wire Wire Line
	4050 4400 3700 4400
Connection ~ 3700 4400
Wire Wire Line
	4050 3600 4200 3600
Connection ~ 4050 3600
$Comp
L power:GND #PWR03
U 1 1 5F599605
P 1150 4400
F 0 "#PWR03" H 1150 4150 50  0001 C CNN
F 1 "GND" V 1155 4272 50  0000 R CNN
F 2 "" H 1150 4400 50  0001 C CNN
F 3 "" H 1150 4400 50  0001 C CNN
	1    1150 4400
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5F599CAF
P 1150 3600
F 0 "#PWR01" H 1150 3450 50  0001 C CNN
F 1 "+5V" V 1165 3728 50  0000 L CNN
F 2 "" H 1150 3600 50  0001 C CNN
F 3 "" H 1150 3600 50  0001 C CNN
	1    1150 3600
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR02
U 1 1 5F59A9A6
P 4700 3600
F 0 "#PWR02" H 4700 3450 50  0001 C CNN
F 1 "+12V" V 4715 3728 50  0000 L CNN
F 2 "" H 4700 3600 50  0001 C CNN
F 3 "" H 4700 3600 50  0001 C CNN
	1    4700 3600
	0    1    1    0   
$EndComp
Wire Wire Line
	4050 4100 4050 4400
$Comp
L Device:R R1
U 1 1 5F5C1A11
P 4350 3600
F 0 "R1" V 4143 3600 50  0000 C CNN
F 1 "100" V 4234 3600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3600 50  0001 C CNN
F 3 "~" H 4350 3600 50  0001 C CNN
	1    4350 3600
	0    1    1    0   
$EndComp
$Comp
L Device:C C6
U 1 1 5F5D063A
P 4600 3950
F 0 "C6" H 4485 3904 50  0000 R CNN
F 1 "2.2u" H 4485 3995 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4638 3800 50  0001 C CNN
F 3 "~" H 4600 3950 50  0001 C CNN
	1    4600 3950
	-1   0    0    1   
$EndComp
Wire Wire Line
	4600 3800 4600 3600
Wire Wire Line
	4600 3600 4500 3600
Wire Wire Line
	4700 3600 4600 3600
Connection ~ 4600 3600
Wire Wire Line
	4050 4400 4600 4400
Wire Wire Line
	4600 4400 4600 4100
Connection ~ 4050 4400
Wire Wire Line
	1500 4100 1500 4400
Wire Wire Line
	2000 3900 1650 3900
Text Label 1650 3900 0    50   ~ 0
LCD_LED
$Comp
L Device:L L1
U 1 1 5F80D6F7
P 2500 3200
F 0 "L1" V 2690 3200 50  0000 C CNN
F 1 "33uH" V 2599 3200 50  0000 C CNN
F 2 "Inductor_SMD:L_1008_2520Metric" H 2500 3200 50  0001 C CNN
F 3 "~" H 2500 3200 50  0001 C CNN
F 4 "1008LS-333XJLC" V 2500 3200 50  0001 C CNN "manf#"
	1    2500 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1500 3200 1500 3600
Wire Wire Line
	2650 3200 3100 3200
Wire Wire Line
	3100 3200 3100 3600
Connection ~ 3100 3600
Wire Wire Line
	3100 3600 3200 3600
$Comp
L Diode:BAT54J D1
U 1 1 5F41485E
P 3350 3600
F 0 "D1" H 3350 3817 50  0000 C CNN
F 1 "BAT54J" H 3350 3726 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-323F" H 3350 3425 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAT54J.pdf" H 3350 3600 50  0001 C CNN
F 4 "BAT54J\\,115" H 3350 3600 50  0001 C CNN "manf#"
	1    3350 3600
	-1   0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0107
U 1 1 5F5D477F
P 2950 1150
F 0 "#PWR0107" H 2950 1000 50  0001 C CNN
F 1 "+5V" V 2965 1278 50  0000 L CNN
F 2 "" H 2950 1150 50  0001 C CNN
F 3 "" H 2950 1150 50  0001 C CNN
	1    2950 1150
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 5F5E6DDE
P 1750 1300
F 0 "C3" V 1650 1400 50  0000 C CNN
F 1 "2.2u" V 1650 1150 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1788 1150 50  0001 C CNN
F 3 "~" H 1750 1300 50  0001 C CNN
	1    1750 1300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5F5F87C6
P 1350 1300
F 0 "#PWR0109" H 1350 1050 50  0001 C CNN
F 1 "GND" V 1355 1172 50  0000 R CNN
F 2 "" H 1350 1300 50  0001 C CNN
F 3 "" H 1350 1300 50  0001 C CNN
	1    1350 1300
	0    1    1    0   
$EndComp
$Comp
L power:+12V #PWR0110
U 1 1 5F61DA17
P 2950 1300
F 0 "#PWR0110" H 2950 1150 50  0001 C CNN
F 1 "+12V" V 2965 1428 50  0000 L CNN
F 2 "" H 2950 1300 50  0001 C CNN
F 3 "" H 2950 1300 50  0001 C CNN
	1    2950 1300
	0    1    1    0   
$EndComp
Wire Wire Line
	1650 1850 1150 1850
Wire Wire Line
	1650 1950 1150 1950
Wire Wire Line
	1650 2050 1150 2050
Wire Wire Line
	1650 2150 1150 2150
Wire Wire Line
	2950 1950 3450 1950
Wire Wire Line
	2950 1850 3500 1850
Wire Wire Line
	3500 1850 3500 2050
$Comp
L power:GND #PWR0111
U 1 1 5F66480B
P 2950 2650
F 0 "#PWR0111" H 2950 2400 50  0001 C CNN
F 1 "GND" V 2955 2522 50  0000 R CNN
F 2 "" H 2950 2650 50  0001 C CNN
F 3 "" H 2950 2650 50  0001 C CNN
	1    2950 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5F666B17
P 3200 2050
F 0 "R4" V 3100 2100 50  0000 R CNN
F 1 "910k" V 3000 2150 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3130 2050 50  0001 C CNN
F 3 "~" H 3200 2050 50  0001 C CNN
	1    3200 2050
	0    1    -1   0   
$EndComp
Wire Wire Line
	2950 2050 3050 2050
Wire Wire Line
	3350 2050 3500 2050
Connection ~ 3500 2050
Text Label 1150 1850 0    50   ~ 0
SCK
Text Label 1150 1950 0    50   ~ 0
MOSI
Text Label 1150 2050 0    50   ~ 0
MISO
Text Label 1150 2150 0    50   ~ 0
LCD_CS
Text Label 3450 1950 2    50   ~ 0
~RESET
$Comp
L EA_Display:EA_OLEDM204 LCD2
U 1 1 5F35CCE7
P 2350 1950
F 0 "LCD2" H 2300 1261 50  0000 C CNN
F 1 "EA_OLEDM204" H 2300 1170 50  0000 C CNN
F 2 "EA_Display:OLEDM204_6GGA" H 2550 1700 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/oledm204-ae.pdf" H 2550 1700 50  0001 C CNN
F 4 "EA OLEDM204-GGA" H 2350 1950 50  0001 C CNN "manf#"
	1    2350 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 2550 2450 2600
Wire Wire Line
	2550 2600 2550 2550
Wire Wire Line
	2950 2600 2950 2650
Wire Wire Line
	2550 2600 2950 2600
Wire Wire Line
	3500 2050 3500 2600
Connection ~ 2550 2600
Connection ~ 2950 2600
Wire Wire Line
	2950 2600 3500 2600
Wire Wire Line
	2450 2600 2550 2600
Wire Wire Line
	2050 1350 2050 1300
Wire Wire Line
	2050 1300 1900 1300
Wire Wire Line
	1600 1300 1400 1300
Wire Wire Line
	6300 1650 5850 1650
Wire Wire Line
	6300 1750 5850 1750
Wire Wire Line
	6300 2650 5850 2650
Wire Wire Line
	6300 2750 5850 2750
Wire Wire Line
	6300 2550 5850 2550
Text Label 5850 1650 0    50   ~ 0
SCK
Text Label 5850 1750 0    50   ~ 0
MOSI
Text Label 5850 2650 0    50   ~ 0
LCD_RS
Text Label 5850 2550 0    50   ~ 0
GND
Text Label 5850 2750 0    50   ~ 0
LCD_CS
$Comp
L EA_Display:EA_DOGM163_with_LED LCD1
U 1 1 5F364471
P 6800 2150
F 0 "LCD1" H 6800 1261 50  0000 C CNN
F 1 "EA_DOGM163_with_LED" H 6800 1170 50  0000 C CNN
F 2 "EA_Display:DOGM162_with_LED" H 6800 2150 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/dog-me.pdf" H 6800 2150 50  0001 C CNN
F 4 "EA DOGM163S-A; EA LED55X31-R" H 6800 2150 50  0001 C CNN "manf#"
	1    6800 2150
	1    0    0    -1  
$EndComp
$Comp
L EA_Display:EA_DOGM163_with_LED LCD1
U 2 1 5F3657C1
P 6400 3700
F 0 "LCD1" H 6400 4015 50  0000 C CNN
F 1 "EA_DOGM163_with_LED" H 6400 3924 50  0000 C CNN
F 2 "EA_Display:DOGM162_with_LED" H 6400 3700 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/dog-me.pdf" H 6400 3700 50  0001 C CNN
	2    6400 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2450 6250 2450
Wire Wire Line
	6250 2450 6250 2350
Wire Wire Line
	6250 1850 6300 1850
Wire Wire Line
	6300 1950 6250 1950
Connection ~ 6250 1950
Wire Wire Line
	6250 1950 6250 1850
Wire Wire Line
	6300 2050 6250 2050
Connection ~ 6250 2050
Wire Wire Line
	6250 2050 6250 1950
Wire Wire Line
	6300 2150 6250 2150
Connection ~ 6250 2150
Wire Wire Line
	6250 2150 6250 2050
Wire Wire Line
	6300 2250 6250 2250
Connection ~ 6250 2250
Wire Wire Line
	6250 2250 6250 2150
Wire Wire Line
	6300 2350 6250 2350
Connection ~ 6250 2350
Wire Wire Line
	6250 2350 6250 2250
$Comp
L power:+5V #PWR0106
U 1 1 5F3E0A13
P 6100 2150
F 0 "#PWR0106" H 6100 2000 50  0001 C CNN
F 1 "+5V" V 6115 2278 50  0000 L CNN
F 2 "" H 6100 2150 50  0001 C CNN
F 3 "" H 6100 2150 50  0001 C CNN
	1    6100 2150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6100 2150 6250 2150
NoConn ~ 7300 1850
NoConn ~ 7300 1950
Text Label 7750 2600 2    50   ~ 0
GND
Wire Wire Line
	7300 2600 7750 2600
Text Label 7750 2700 2    50   ~ 0
~RESET
Wire Wire Line
	7300 2700 7750 2700
Wire Wire Line
	6700 1250 6700 1200
Wire Wire Line
	6700 1200 6800 1200
Wire Wire Line
	6900 1200 6900 1250
Wire Wire Line
	6800 1250 6800 1200
Connection ~ 6800 1200
Wire Wire Line
	6800 1200 6900 1200
Wire Wire Line
	6800 1200 6800 1100
$Comp
L power:+5V #PWR0112
U 1 1 5F492716
P 6800 1100
F 0 "#PWR0112" H 6800 950 50  0001 C CNN
F 1 "+5V" V 6815 1228 50  0000 L CNN
F 2 "" H 6800 1100 50  0001 C CNN
F 3 "" H 6800 1100 50  0001 C CNN
	1    6800 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 5F493D5D
P 6800 3050
F 0 "#PWR0113" H 6800 2800 50  0001 C CNN
F 1 "GND" V 6805 2922 50  0000 R CNN
F 2 "" H 6800 3050 50  0001 C CNN
F 3 "" H 6800 3050 50  0001 C CNN
	1    6800 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3050 6800 2950
$Comp
L Device:Q_NPN_BEC Q1
U 1 1 5F6CBDA7
P 7400 3850
F 0 "Q1" H 7591 3896 50  0000 L CNN
F 1 "BSR14" H 7591 3805 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7600 3950 50  0001 C CNN
F 3 "~" H 7400 3850 50  0001 C CNN
F 4 "Q_NPN_BEC" H 7400 3850 50  0001 C CNN "kind"
F 5 "BSR14" H 7400 3850 50  0001 C CNN "manf#"
	1    7400 3850
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5F6D89F1
P 7050 3650
F 0 "R9" V 6843 3650 50  0000 C CNN
F 1 "20" V 6934 3650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6980 3650 50  0001 C CNN
F 3 "~" H 7050 3650 50  0001 C CNN
	1    7050 3650
	0    1    1    0   
$EndComp
Wire Wire Line
	6750 3650 6900 3650
Wire Wire Line
	7200 3650 7300 3650
Wire Wire Line
	6050 3750 6000 3750
Wire Wire Line
	6000 3900 6850 3900
Wire Wire Line
	6850 3900 6850 3750
Wire Wire Line
	6850 3750 6750 3750
Wire Wire Line
	6000 3750 6000 3900
Wire Wire Line
	6050 3650 5900 3650
$Comp
L power:+5V #PWR04
U 1 1 5F70AE87
P 5900 3650
F 0 "#PWR04" H 5900 3500 50  0001 C CNN
F 1 "+5V" V 5915 3778 50  0000 L CNN
F 2 "" H 5900 3650 50  0001 C CNN
F 3 "" H 5900 3650 50  0001 C CNN
	1    5900 3650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7300 4050 7300 4100
Wire Wire Line
	7300 4100 7650 4100
Wire Wire Line
	7600 3850 7950 3850
Text Label 7950 3850 2    50   ~ 0
LCD_LED
$Comp
L power:GND #PWR05
U 1 1 5F72B92E
P 7650 4100
F 0 "#PWR05" H 7650 3850 50  0001 C CNN
F 1 "GND" V 7655 3972 50  0000 R CNN
F 2 "" H 7650 4100 50  0001 C CNN
F 3 "" H 7650 4100 50  0001 C CNN
	1    7650 4100
	0    -1   1    0   
$EndComp
$Comp
L Switch:SW_Push_LED SW8
U 1 1 5F16E207
P 8450 5750
F 0 "SW8" H 8450 6135 50  0000 C CNN
F 1 "SW_Push_LED" H 8450 6044 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 8450 6050 50  0001 C CNN
F 3 "~" H 8450 6050 50  0001 C CNN
F 4 "3006.2115" H 8450 5750 50  0001 C CNN "manf#"
	1    8450 5750
	0    1    -1   0   
$EndComp
$Comp
L Switch:SW_Push_LED SW7
U 1 1 5F16F097
P 7800 5750
F 0 "SW7" H 7800 6135 50  0000 C CNN
F 1 "SW_Push_LED" H 7800 6044 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 7800 6050 50  0001 C CNN
F 3 "~" H 7800 6050 50  0001 C CNN
F 4 "3006.2115" H 7800 5750 50  0001 C CNN "manf#"
	1    7800 5750
	0    1    -1   0   
$EndComp
$Comp
L Switch:SW_Push_LED SW6
U 1 1 5F16F9E5
P 7150 5750
F 0 "SW6" H 7150 6135 50  0000 C CNN
F 1 "SW_Push_LED" H 7150 6044 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 7150 6050 50  0001 C CNN
F 3 "~" H 7150 6050 50  0001 C CNN
F 4 "3006.2115" H 7150 5750 50  0001 C CNN "manf#"
	1    7150 5750
	0    1    -1   0   
$EndComp
$Comp
L Device:Rotary_Encoder_Switch SW1
U 1 1 5F18F175
P 9800 4850
F 0 "SW1" H 9800 5217 50  0000 C CNN
F 1 "1" H 9800 5126 50  0000 C CNN
F 2 "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm" H 9650 5010 50  0001 C CNN
F 3 "~" H 9800 5110 50  0001 C CNN
F 4 "EC11E15244B2 " H 9800 4850 50  0001 C CNN "manf#"
	1    9800 4850
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push_LED SW5
U 1 1 5F1A2BDE
P 6550 5750
F 0 "SW5" H 6550 6135 50  0000 C CNN
F 1 "SW_Push_LED" H 6550 6044 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 6550 6050 50  0001 C CNN
F 3 "~" H 6550 6050 50  0001 C CNN
F 4 "3006.2115" H 6550 5750 50  0001 C CNN "manf#"
	1    6550 5750
	0    1    -1   0   
$EndComp
Wire Wire Line
	6550 5550 6550 5350
Wire Wire Line
	6650 5550 6650 4600
Wire Wire Line
	7150 5550 7150 5350
Wire Wire Line
	7250 5550 7250 4600
Wire Wire Line
	7800 5550 7800 5350
Wire Wire Line
	7900 5550 7900 4600
Wire Wire Line
	8450 5550 8450 5350
Wire Wire Line
	8550 5550 8550 4600
Wire Wire Line
	6550 5950 6550 6050
Wire Wire Line
	6550 6050 6650 6050
Wire Wire Line
	10300 6050 10300 5950
Wire Wire Line
	9800 5950 9800 6050
Connection ~ 9800 6050
Wire Wire Line
	9800 6050 10300 6050
Wire Wire Line
	9300 5950 9300 6050
Connection ~ 9300 6050
Wire Wire Line
	9300 6050 9800 6050
Wire Wire Line
	8550 5950 8550 6050
Connection ~ 8550 6050
Wire Wire Line
	8550 6050 8900 6050
Wire Wire Line
	8450 5950 8450 6050
Connection ~ 8450 6050
Wire Wire Line
	8450 6050 8550 6050
Wire Wire Line
	7900 5950 7900 6050
Connection ~ 7900 6050
Wire Wire Line
	7900 6050 8450 6050
Wire Wire Line
	7800 5950 7800 6050
Connection ~ 7800 6050
Wire Wire Line
	7800 6050 7900 6050
Wire Wire Line
	7250 5950 7250 6050
Connection ~ 7250 6050
Wire Wire Line
	7250 6050 7800 6050
Wire Wire Line
	7150 5950 7150 6050
Connection ~ 7150 6050
Wire Wire Line
	7150 6050 7250 6050
Wire Wire Line
	6650 5950 6650 6050
Connection ~ 6650 6050
Wire Wire Line
	6650 6050 7150 6050
Wire Wire Line
	8900 6050 8900 6150
Connection ~ 8900 6050
Wire Wire Line
	8900 6050 9300 6050
$Comp
L power:GND #PWR0104
U 1 1 5F380BB8
P 8900 6150
F 0 "#PWR0104" H 8900 5900 50  0001 C CNN
F 1 "GND" H 8905 5977 50  0000 C CNN
F 2 "" H 8900 6150 50  0001 C CNN
F 3 "" H 8900 6150 50  0001 C CNN
	1    8900 6150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5F3840C1
P 6550 5200
F 0 "R5" H 6750 5250 50  0000 R CNN
F 1 "150" H 6750 5150 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6480 5200 50  0001 C CNN
F 3 "~" H 6550 5200 50  0001 C CNN
	1    6550 5200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6550 5050 6550 4600
Wire Wire Line
	7150 5050 7150 4600
Wire Wire Line
	7800 5050 7800 4600
Wire Wire Line
	8450 5050 8450 4600
Wire Wire Line
	9500 4750 9000 4750
Wire Wire Line
	9500 4950 9000 4950
Wire Wire Line
	10100 4750 10700 4750
Wire Wire Line
	10300 6050 10700 6050
Wire Wire Line
	10700 6050 10700 4950
Wire Wire Line
	10100 4950 10700 4950
Connection ~ 10300 6050
Wire Wire Line
	8900 4850 8900 6050
Wire Wire Line
	8900 4850 9500 4850
Text Label 6550 4600 3    50   ~ 0
LED5
Text Label 6650 4600 3    50   ~ 0
SW5
Text Label 7150 4600 3    50   ~ 0
LED6
Text Label 7800 4600 3    50   ~ 0
LED7
Text Label 8450 4600 3    50   ~ 0
LED8
Text Label 7250 4600 3    50   ~ 0
SW6
Text Label 7900 4600 3    50   ~ 0
SW7
Text Label 8550 4600 3    50   ~ 0
SW8
Text Label 10700 4750 2    50   ~ 0
SW1
Text Label 9000 4750 0    50   ~ 0
A
Text Label 9000 4950 0    50   ~ 0
B
$Comp
L Device:R R6
U 1 1 5F557401
P 7150 5200
F 0 "R6" H 7350 5250 50  0000 R CNN
F 1 "150" H 7350 5150 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7080 5200 50  0001 C CNN
F 3 "~" H 7150 5200 50  0001 C CNN
	1    7150 5200
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5F557941
P 8450 5200
F 0 "R8" H 8650 5250 50  0000 R CNN
F 1 "150" H 8650 5150 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8380 5200 50  0001 C CNN
F 3 "~" H 8450 5200 50  0001 C CNN
	1    8450 5200
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5F55764B
P 7800 5200
F 0 "R7" H 8000 5250 50  0000 R CNN
F 1 "150" H 8000 5150 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7730 5200 50  0001 C CNN
F 3 "~" H 7800 5200 50  0001 C CNN
	1    7800 5200
	-1   0    0    -1  
$EndComp
Text Label 10300 5200 3    50   ~ 0
SW4
Text Label 9800 5200 3    50   ~ 0
SW3
Text Label 9300 5200 3    50   ~ 0
SW2
Wire Wire Line
	10300 5550 10300 5200
Wire Wire Line
	9800 5550 9800 5200
Wire Wire Line
	9300 5550 9300 5200
$Comp
L Switch:SW_Push SW4
U 1 1 5F171875
P 10300 5750
F 0 "SW4" H 10300 6035 50  0000 C CNN
F 1 "SW_Push" H 10300 5944 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 10300 5950 50  0001 C CNN
F 3 "~" H 10300 5950 50  0001 C CNN
F 4 "3006.2100" H 10300 5750 50  0001 C CNN "manf#"
	1    10300 5750
	0    1    -1   0   
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 5F1715B9
P 9800 5750
F 0 "SW3" H 9800 6035 50  0000 C CNN
F 1 "SW_Push" H 9800 5944 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 9800 5950 50  0001 C CNN
F 3 "~" H 9800 5950 50  0001 C CNN
F 4 "3006.2100" H 9800 5750 50  0001 C CNN "manf#"
	1    9800 5750
	0    1    -1   0   
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5F170322
P 9300 5750
F 0 "SW2" H 9300 6035 50  0000 C CNN
F 1 "SW_Push" H 9300 5944 50  0000 C CNN
F 2 "project:Marquardt_3006_Series" H 9300 5950 50  0001 C CNN
F 3 "~" H 9300 5950 50  0001 C CNN
F 4 "3006.2100" H 9300 5750 50  0001 C CNN "manf#"
	1    9300 5750
	0    1    -1   0   
$EndComp
Wire Wire Line
	2950 1300 2550 1300
Wire Wire Line
	2550 1300 2550 1350
$Comp
L Device:C C2
U 1 1 5F9585F3
P 1750 1050
F 0 "C2" V 1650 1150 50  0000 C CNN
F 1 "100n" V 1650 900 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1788 900 50  0001 C CNN
F 3 "~" H 1750 1050 50  0001 C CNN
	1    1750 1050
	0    1    1    0   
$EndComp
Wire Wire Line
	1400 1300 1400 1050
Wire Wire Line
	1400 1050 1600 1050
Connection ~ 1400 1300
Wire Wire Line
	1400 1300 1350 1300
Wire Wire Line
	2950 1150 2900 1150
Wire Wire Line
	2850 950  2900 950 
Wire Wire Line
	2900 950  2900 1150
Connection ~ 2900 1150
Wire Wire Line
	2900 1150 2250 1150
Wire Wire Line
	2250 1150 2250 1350
Wire Wire Line
	2350 950  2550 950 
Wire Wire Line
	2350 950  2350 1350
Wire Wire Line
	1900 1050 2450 1050
Wire Wire Line
	2450 1050 2450 1350
$Comp
L Device:C C1
U 1 1 5FA6B24D
P 2700 950
F 0 "C1" V 2600 1050 50  0000 C CNN
F 1 "100n" V 2600 800 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2738 800 50  0001 C CNN
F 3 "~" H 2700 950 50  0001 C CNN
	1    2700 950 
	0    1    1    0   
$EndComp
Wire Notes Line
	700  4600 5200 4600
Wire Notes Line
	5200 4600 5200 650 
Wire Notes Line
	5200 650  650  650 
Wire Notes Line
	650  650  650  4600
Wire Notes Line
	5550 650  8100 650 
Wire Notes Line
	8100 650  8100 4350
Wire Notes Line
	8100 4350 5550 4350
Wire Notes Line
	5550 4350 5550 650 
Text Notes 4500 950  0    50   ~ 0
Display 2: OLED\nEA_OLEDM204\n3x20 Characters
Text Notes 5600 950  0    50   ~ 0
Display 1: LCD\nEA_DOGM_163\n4x20 Characters
Text Notes 5250 950  0    118  ~ 0
OR
Text Notes 5350 3800 1    79   ~ 0
only mount parts for selected display variant
Text Notes 5500 3800 1    59   ~ 0
ignore corresponding courtyard errors in pcbnew
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 5F44175A
P 5450 7500
F 0 "JP1" H 5450 7705 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 5450 7614 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 5450 7500 50  0001 C CNN
F 3 "~" H 5450 7500 50  0001 C CNN
F 4 "Do Not Populate Tag" H 5450 7500 50  0001 C CNN "DNP"
	1    5450 7500
	1    0    0    -1  
$EndComp
$Comp
L project:LM2705 U2
U 1 1 5F487AFB
P 2500 3750
F 0 "U2" H 2500 4165 50  0000 C CNN
F 1 "LM2705" H 2500 4074 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 2500 3750 50  0001 C CNN
F 3 "https://www.ti.com/lit/gpn/lm2705" H 2500 3750 50  0001 C CNN
F 4 "LM2705MF-ADJ/NOPB" H 2500 3750 50  0001 C CNN "manf#"
	1    2500 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3200 2350 3200
Wire Wire Line
	1500 4400 2500 4400
$Comp
L Device:LED D2
U 1 1 5F4721AC
P 9300 3800
F 0 "D2" H 9293 4017 50  0000 C CNN
F 1 "LED" H 9293 3926 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 9300 3800 50  0001 C CNN
F 3 "~" H 9300 3800 50  0001 C CNN
	1    9300 3800
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5F472E6B
P 8800 3800
F 0 "R10" V 8593 3800 50  0000 C CNN
F 1 "560" V 8684 3800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8730 3800 50  0001 C CNN
F 3 "~" H 8800 3800 50  0001 C CNN
	1    8800 3800
	0    -1   1    0   
$EndComp
$Comp
L Device:LED D3
U 1 1 5F47CBE7
P 9300 4200
F 0 "D3" H 9293 4417 50  0000 C CNN
F 1 "LED" H 9293 4326 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 9300 4200 50  0001 C CNN
F 3 "~" H 9300 4200 50  0001 C CNN
	1    9300 4200
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5F47CBF1
P 8800 4200
F 0 "R11" V 8593 4200 50  0000 C CNN
F 1 "560" V 8684 4200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8730 4200 50  0001 C CNN
F 3 "~" H 8800 4200 50  0001 C CNN
	1    8800 4200
	0    -1   1    0   
$EndComp
Wire Wire Line
	9150 3800 8950 3800
Wire Wire Line
	9450 3800 9650 3800
Wire Wire Line
	9650 3800 9650 4000
Wire Wire Line
	9650 4200 9450 4200
Wire Wire Line
	8650 3800 8350 3800
Wire Wire Line
	8650 4200 8350 4200
Text Label 8850 3150 0    50   ~ 0
LED1
Text Label 8850 3250 0    50   ~ 0
LED2
Text Label 8350 3800 0    50   ~ 0
LED1
Text Label 8350 4200 0    50   ~ 0
LED2
Wire Wire Line
	9150 4200 8950 4200
Wire Wire Line
	9650 4000 9750 4000
Connection ~ 9650 4000
Wire Wire Line
	9650 4000 9650 4200
$Comp
L power:GND #PWR06
U 1 1 5F5229F2
P 9750 4000
F 0 "#PWR06" H 9750 3750 50  0001 C CNN
F 1 "GND" V 9755 3872 50  0000 R CNN
F 2 "" H 9750 4000 50  0001 C CNN
F 3 "" H 9750 4000 50  0001 C CNN
	1    9750 4000
	0    -1   -1   0   
$EndComp
$EndSCHEMATC

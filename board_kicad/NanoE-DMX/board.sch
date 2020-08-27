EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "NanoE-DMX"
Date "2020-08-23"
Rev ""
Comp ""
Comment1 "Board can be used as Shield without Arduino Nano Every"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L project:Arduino-Nano_Every U1
U 1 1 5F1AC01A
P 8650 4850
F 0 "U1" H 8300 3600 50  0000 C CNN
F 1 "Arduino_Nano_Every" H 8650 3500 50  0000 C CNN
F 2 "project:Nano_Every_SMD" H 8650 4850 50  0001 C CNN
F 3 "" H 8650 4850 50  0001 C CNN
F 4 "ABX00028" H 8650 4850 50  0001 C CNN "manf#"
	1    8650 4850
	1    0    0    -1  
$EndComp
$Comp
L Interface_UART:MAX487E U31
U 1 1 5F2981B7
P 9050 1750
F 0 "U31" H 9050 2431 50  0000 C CNN
F 1 "MAX487E" H 9050 2340 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 9050 1050 50  0001 C CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX1487E-MAX491E.pdf" H 9050 1800 50  0001 C CNN
F 4 "MAX487ECSA+T" H 9050 1750 50  0001 C CNN "manf#"
	1    9050 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R30
U 1 1 5F29A04C
P 9600 1800
F 0 "R30" H 9670 1846 50  0000 L CNN
F 1 "120" H 9670 1755 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9530 1800 50  0001 C CNN
F 3 "~" H 9600 1800 50  0001 C CNN
	1    9600 1800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J30
U 1 1 5F29A9A1
P 10550 1750
F 0 "J30" H 10630 1792 50  0000 L CNN
F 1 "Conn_01x03" H 10630 1701 50  0000 L CNN
F 2 "Connector_Phoenix_MC:PhoenixContact_MC_1,5_3-G-3.81_1x03_P3.81mm_Horizontal" H 10550 1750 50  0001 C CNN
F 3 "~" H 10550 1750 50  0001 C CNN
F 4 "1721999" H 10550 1750 50  0001 C CNN "manf#"
	1    10550 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 1750 8600 1750
Wire Wire Line
	8600 1850 8650 1850
Wire Wire Line
	8600 1750 8600 1800
Connection ~ 8600 1800
Wire Wire Line
	8600 1800 8600 1850
Wire Wire Line
	9450 1650 9600 1650
Wire Wire Line
	9450 1950 9600 1950
Wire Wire Line
	9600 1950 9950 1950
Wire Wire Line
	9950 1950 9950 1850
Wire Wire Line
	9950 1850 10350 1850
Connection ~ 9600 1950
Wire Wire Line
	9600 1650 9950 1650
Wire Wire Line
	9950 1650 9950 1750
Wire Wire Line
	9950 1750 10350 1750
Connection ~ 9600 1650
Wire Wire Line
	10350 1650 10000 1650
Text Label 10000 1650 0    50   ~ 0
ISO_GND
Text Label 10000 1750 0    50   ~ 0
DMX-
Text Label 10000 1850 0    50   ~ 0
DMX+
Text Label 8150 1650 0    50   ~ 0
ISO_RX
Text Label 8150 1800 0    50   ~ 0
ISO_REDE
Text Label 8150 1950 0    50   ~ 0
ISO_TX
$Comp
L project:TPS2596XX U20
U 1 1 5F271AC6
P 3900 6450
F 0 "U20" H 3875 6865 50  0000 C CNN
F 1 "TPS259630" H 3875 6774 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4050 6450 50  0001 C CNN
F 3 "https://www.ti.com/lit/gpn/tps2596" H 4050 6450 50  0001 C CNN
F 4 "TPS259630DDAR" H 3900 6450 50  0001 C CNN "manf#"
	1    3900 6450
	1    0    0    -1  
$EndComp
$Comp
L Device:C C20
U 1 1 5F2AA9AD
P 3700 7200
F 0 "C20" H 3815 7246 50  0000 L CNN
F 1 "2.2n" H 3815 7155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3738 7050 50  0001 C CNN
F 3 "~" H 3700 7200 50  0001 C CNN
	1    3700 7200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 5F2AB643
P 4500 6950
F 0 "R24" H 4570 6996 50  0000 L CNN
F 1 "910" H 4570 6905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4430 6950 50  0001 C CNN
F 3 "~" H 4500 6950 50  0001 C CNN
	1    4500 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 7350 3050 7100
Wire Wire Line
	3700 7350 4100 7350
Wire Wire Line
	4500 7350 4500 7100
Connection ~ 3700 7350
Wire Wire Line
	4100 7050 4100 7350
Connection ~ 4100 7350
Wire Wire Line
	4400 6650 4500 6650
Wire Wire Line
	4500 6650 4500 6800
Wire Wire Line
	5500 7100 5500 7350
Wire Wire Line
	5100 7350 5100 7100
Connection ~ 5100 7350
Wire Wire Line
	5100 6800 5100 6050
Connection ~ 5100 6050
Wire Wire Line
	5500 6800 5500 6050
Connection ~ 3050 6050
Wire Wire Line
	3050 6800 3050 6650
Wire Wire Line
	2200 6650 2200 6800
Connection ~ 2200 7350
Wire Wire Line
	2200 7350 2200 7100
$Comp
L Device:Q_PMOS_GSD Q20
U 1 1 5F281BA6
P 2200 6150
F 0 "Q20" V 2542 6150 50  0000 C CNN
F 1 "IRLM5203 (PMOS_GSD)" V 2451 6150 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2400 6250 50  0001 C CNN
F 3 "~" H 2200 6150 50  0001 C CNN
F 4 "IRLML5203TRPBF" V 2200 6150 50  0001 C CNN "manf#"
	1    2200 6150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1950 7350 2200 7350
Connection ~ 2200 6650
Wire Wire Line
	2550 6650 2550 6500
Wire Wire Line
	2200 6650 2550 6650
Wire Wire Line
	2200 6350 2200 6650
$Comp
L Device:R R20
U 1 1 5F27E1F6
P 2200 6950
F 0 "R20" H 2270 6996 50  0000 L CNN
F 1 "100k" H 2270 6905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2130 6950 50  0001 C CNN
F 3 "~" H 2200 6950 50  0001 C CNN
	1    2200 6950
	1    0    0    -1  
$EndComp
Text Label 2950 6050 2    50   ~ 0
VCC_EXT
Text Label 2950 7350 2    50   ~ 0
GND
Wire Wire Line
	1950 6150 1950 7350
Wire Wire Line
	1250 6150 1300 6150
Connection ~ 2550 6050
Wire Wire Line
	2550 6200 2550 6050
Wire Wire Line
	1250 6050 1300 6050
Wire Wire Line
	2400 6050 2550 6050
$Comp
L Device:D_Zener D20
U 1 1 5F2A8F20
P 2550 6350
F 0 "D20" V 2504 6430 50  0000 L CNN
F 1 "BZX84C15" V 2595 6430 50  0000 L CNN
F 2 "Diode_SMD:D_SOT-23_ANK" H 2550 6350 50  0001 C CNN
F 3 "~" H 2550 6350 50  0001 C CNN
F 4 "BZX84-C15\\,215" H 2550 6350 50  0001 C CNN "manf#"
	1    2550 6350
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J20
U 1 1 5F2A5A40
P 1050 6150
F 0 "J20" H 1200 6100 50  0000 C CNN
F 1 "Conn_01x02" H 1300 6200 50  0000 C CNN
F 2 "Connector_Phoenix_MC:PhoenixContact_MC_1,5_2-G-3.81_1x02_P3.81mm_Horizontal" H 1050 6150 50  0001 C CNN
F 3 "~" H 1050 6150 50  0001 C CNN
F 4 "1721986" H 1050 6150 50  0001 C CNN "manf#"
	1    1050 6150
	-1   0    0    1   
$EndComp
Text Label 6350 6050 2    50   ~ 0
+5V
Text Label 6350 7350 2    50   ~ 0
GND
Text Label 6350 6650 2    50   ~ 0
CUR
Wire Wire Line
	7150 2950 7650 2950
Wire Wire Line
	7150 3050 7650 3050
Wire Wire Line
	7150 3150 7650 3150
Text Label 7650 3150 2    50   ~ 0
ISO_RX
Text Label 7650 2950 2    50   ~ 0
ISO_REDE
Text Label 7650 3050 2    50   ~ 0
ISO_TX
Wire Wire Line
	6400 3150 6850 3150
Wire Wire Line
	6850 3050 6400 3050
Wire Wire Line
	6850 2950 6400 2950
Text Label 6400 3050 0    50   ~ 0
TX
Text Label 6400 3150 0    50   ~ 0
RX
Text Label 6400 2950 0    50   ~ 0
REDE
$Comp
L Device:R R31
U 1 1 5F335428
P 9600 1400
F 0 "R31" H 9670 1446 50  0000 L CNN
F 1 "560" H 9670 1355 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9530 1400 50  0001 C CNN
F 3 "~" H 9600 1400 50  0001 C CNN
	1    9600 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R32
U 1 1 5F33583F
P 9600 2200
F 0 "R32" H 9670 2246 50  0000 L CNN
F 1 "560" H 9670 2155 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9530 2200 50  0001 C CNN
F 3 "~" H 9600 2200 50  0001 C CNN
	1    9600 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 1250 9600 1000
Wire Wire Line
	9600 1000 9050 1000
Wire Wire Line
	9050 1250 9050 1000
Connection ~ 9050 1000
Wire Wire Line
	9050 2350 9050 2550
Wire Wire Line
	9050 2550 9600 2550
Wire Wire Line
	9600 2550 9600 2350
Connection ~ 9050 2550
Wire Wire Line
	9600 1550 9600 1650
Wire Wire Line
	9600 1950 9600 2050
Wire Wire Line
	9050 2550 7750 2550
Wire Wire Line
	8650 1950 8150 1950
Wire Wire Line
	8600 1800 8150 1800
Wire Wire Line
	8650 1650 8150 1650
Wire Wire Line
	9050 1000 8050 1000
$Comp
L Device:C C30
U 1 1 5F374DE4
P 6200 1650
F 0 "C30" V 6350 1650 50  0000 C CNN
F 1 "100n" V 6450 1650 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 6238 1500 50  0001 C CNN
F 3 "~" H 6200 1650 50  0001 C CNN
	1    6200 1650
	0    1    1    0   
$EndComp
$Comp
L Device:C C31
U 1 1 5F375C64
P 7750 1650
F 0 "C31" V 7900 1650 50  0000 C CNN
F 1 "100n" V 8000 1650 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7788 1500 50  0001 C CNN
F 3 "~" H 7750 1650 50  0001 C CNN
	1    7750 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	6500 1000 6000 1000
Wire Wire Line
	6000 1000 6000 1500
Wire Wire Line
	6000 1650 6050 1650
Wire Wire Line
	6350 1650 6450 1650
Wire Wire Line
	6450 1650 6450 1750
Wire Wire Line
	6450 1750 6500 1750
Connection ~ 6450 1650
Wire Wire Line
	6450 1650 6500 1650
Wire Wire Line
	7500 1650 7550 1650
Wire Wire Line
	7550 1650 7550 1750
Wire Wire Line
	7550 1750 7500 1750
Connection ~ 7550 1650
Wire Wire Line
	7550 1650 7600 1650
Wire Wire Line
	7500 1000 8050 1000
Wire Wire Line
	8050 1000 8050 1500
Wire Wire Line
	8050 1650 7900 1650
$Comp
L project:DCDC-SIP7-1-2-4-6 U32
U 1 1 5F38F64A
P 7000 2350
F 0 "U32" H 7000 2817 50  0000 C CNN
F 1 "RFB-0505S" H 7000 2726 50  0000 C CNN
F 2 "project:SIP7-1-2-4-6" H 6200 3500 50  0001 C CNN
F 3 "" H 6200 3500 50  0001 C CNN
F 4 "RFB-0505S" H 7000 2350 50  0001 C CNN "manf#"
	1    7000 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 1650 6000 2150
Wire Wire Line
	6000 2150 6500 2150
Connection ~ 6000 1650
Wire Wire Line
	7500 2150 7750 2150
Wire Wire Line
	8050 2150 8050 1650
Connection ~ 8050 1650
Wire Wire Line
	6450 1750 6450 2550
Wire Wire Line
	6450 2550 6500 2550
Connection ~ 6450 1750
Wire Wire Line
	7550 1750 7550 2550
Wire Wire Line
	7550 2550 7500 2550
Connection ~ 7550 1750
Connection ~ 8050 1000
Connection ~ 7550 2550
Wire Wire Line
	7750 2200 7750 2150
Connection ~ 7750 2150
Wire Wire Line
	7750 2150 8050 2150
Wire Wire Line
	7750 2500 7750 2550
Connection ~ 7750 2550
Wire Wire Line
	7750 2550 7550 2550
Wire Wire Line
	6500 1500 6000 1500
Connection ~ 6000 1500
Wire Wire Line
	6000 1500 6000 1650
Wire Wire Line
	7500 1500 8050 1500
Connection ~ 8050 1500
Wire Wire Line
	8050 1500 8050 1650
Text Label 8150 1000 0    50   ~ 0
ISO_+5V
Text Label 8150 2550 0    50   ~ 0
ISO_GND
$Comp
L Device:R R130
U 1 1 5F407696
P 7000 2950
F 0 "R130" V 6950 2800 50  0000 R CNN
F 1 "0" V 6950 3100 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 2950 50  0001 C CNN
F 3 "~" H 7000 2950 50  0001 C CNN
	1    7000 2950
	0    1    1    0   
$EndComp
$Comp
L Device:R R131
U 1 1 5F4085B7
P 7000 3050
F 0 "R131" V 6950 2900 50  0000 R CNN
F 1 "0" V 6950 3200 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 3050 50  0001 C CNN
F 3 "~" H 7000 3050 50  0001 C CNN
	1    7000 3050
	0    1    1    0   
$EndComp
$Comp
L Device:R R132
U 1 1 5F408887
P 7000 3150
F 0 "R132" V 6950 3000 50  0000 R CNN
F 1 "0" V 6950 3300 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 3150 50  0001 C CNN
F 3 "~" H 7000 3150 50  0001 C CNN
	1    7000 3150
	0    1    1    0   
$EndComp
Wire Wire Line
	7150 3250 7650 3250
Wire Wire Line
	7150 3350 7650 3350
Text Label 7650 3350 2    50   ~ 0
ISO_GND
Text Label 7650 3250 2    50   ~ 0
ISO_+5V
Wire Wire Line
	6400 3350 6850 3350
Wire Wire Line
	6850 3250 6400 3250
Text Label 6400 3250 0    50   ~ 0
+5V
Text Label 6400 3350 0    50   ~ 0
GND
$Comp
L Device:R R133
U 1 1 5F41893D
P 7000 3250
F 0 "R133" V 6950 3100 50  0000 R CNN
F 1 "0" V 6950 3400 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 3250 50  0001 C CNN
F 3 "~" H 7000 3250 50  0001 C CNN
	1    7000 3250
	0    1    1    0   
$EndComp
$Comp
L Device:R R134
U 1 1 5F418947
P 7000 3350
F 0 "R134" V 6950 3200 50  0000 R CNN
F 1 "0" V 6950 3500 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 3350 50  0001 C CNN
F 3 "~" H 7000 3350 50  0001 C CNN
	1    7000 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	6450 2550 6000 2550
Connection ~ 6450 2550
Text Label 6000 2550 0    50   ~ 0
GND
Text Label 6000 1000 0    50   ~ 0
+5V
Connection ~ 3050 6650
Wire Wire Line
	3050 6650 3350 6650
Connection ~ 3050 7350
Wire Wire Line
	3050 7350 3700 7350
Wire Wire Line
	2200 7350 3050 7350
Wire Wire Line
	4400 6350 4500 6350
Text Label 6350 6350 2    50   ~ 0
~FLT
Wire Wire Line
	6050 1350 6500 1350
Wire Wire Line
	6500 1250 6050 1250
Wire Wire Line
	6500 1150 6050 1150
Text Label 6050 1250 0    50   ~ 0
TX
Text Label 6050 1350 0    50   ~ 0
RX
Text Label 6050 1150 0    50   ~ 0
REDE
Wire Wire Line
	7500 1150 8000 1150
Wire Wire Line
	7500 1250 8000 1250
Wire Wire Line
	7500 1350 8000 1350
Text Label 8000 1350 2    50   ~ 0
ISO_RX
Text Label 8000 1150 2    50   ~ 0
ISO_REDE
Text Label 8000 1250 2    50   ~ 0
ISO_TX
Text Notes 5150 5300 0    50   ~ 0
source indicator
Wire Wire Line
	3050 5350 4100 5350
Text Label 6350 5350 2    50   ~ 0
VIN
Wire Wire Line
	2550 6050 3050 6050
Connection ~ 4500 6350
Text Notes 1450 5650 0    50   ~ 0
Input Stage with\n- reverse voltage protection\n- overvoltage (ov) protection\n- alternate power routing at ov \n   OR undervoltage protection\n\n+5V@4.6<VCC_EXT<5.4\nVIN@5.4<VCC_EXT
$Comp
L Device:R R22
U 1 1 5F2F20B4
P 3050 6500
F 0 "R22" H 3120 6546 50  0000 L CNN
F 1 "6.8k" H 3120 6455 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2980 6500 50  0001 C CNN
F 3 "~" H 3050 6500 50  0001 C CNN
	1    3050 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R23
U 1 1 5F2AAE8C
P 3050 6950
F 0 "R23" H 3120 6996 50  0000 L CNN
F 1 "39k" H 3120 6905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2980 6950 50  0001 C CNN
F 3 "~" H 3050 6950 50  0001 C CNN
	1    3050 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 6050 3250 6050
$Comp
L Device:R R21
U 1 1 5F2A51E6
P 3050 6200
F 0 "R21" H 3120 6246 50  0000 L CNN
F 1 "130k" H 3120 6155 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2980 6200 50  0001 C CNN
F 3 "~" H 3050 6200 50  0001 C CNN
	1    3050 6200
	1    0    0    -1  
$EndComp
Connection ~ 3050 6350
Wire Wire Line
	3350 6350 3050 6350
Wire Wire Line
	8150 4050 7600 4050
Wire Wire Line
	8150 4150 7600 4150
Wire Wire Line
	8150 4350 7600 4350
Wire Wire Line
	8150 4450 7600 4450
Wire Wire Line
	8150 4550 7600 4550
Wire Wire Line
	8150 4650 7600 4650
Wire Wire Line
	8150 4750 7600 4750
Wire Wire Line
	8150 4850 7600 4850
Wire Wire Line
	8150 4950 7600 4950
Wire Wire Line
	8150 5150 7600 5150
Wire Wire Line
	8150 5350 7600 5350
Wire Wire Line
	8150 5450 7600 5450
Wire Wire Line
	8150 5550 7600 5550
Wire Wire Line
	9150 5050 9650 5050
Wire Wire Line
	9150 5150 9650 5150
Wire Wire Line
	9150 5250 9650 5250
Wire Wire Line
	9150 5350 9650 5350
Wire Wire Line
	9150 4850 9650 4850
Wire Wire Line
	9150 4950 9650 4950
Wire Wire Line
	9150 4250 9650 4250
Text Label 7600 4150 0    50   ~ 0
RX
Text Label 7600 4050 0    50   ~ 0
TX
Text Label 7600 5550 0    50   ~ 0
SCK
Text Label 7600 5450 0    50   ~ 0
MISO
Text Label 7600 5350 0    50   ~ 0
MOSI
Text Label 7600 5150 0    50   ~ 0
LCD_LED
Text Label 7600 4450 0    50   ~ 0
D3
Text Label 7600 4350 0    50   ~ 0
D2
Text Label 9650 5250 2    50   ~ 0
SDA
Text Label 9650 5350 2    50   ~ 0
SCL
Text Label 9650 4950 2    50   ~ 0
A1-~FLT
Text Label 9650 4850 2    50   ~ 0
A0-CUR
Text Label 9650 4250 2    50   ~ 0
~RESET
$Comp
L project:ADUM1301 U30
U 1 1 5F3237A2
P 7000 1300
F 0 "U30" H 7000 1867 50  0000 C CNN
F 1 "ADUM1301" H 7000 1776 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_7.5x10.3mm_P1.27mm" H 7000 1500 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM1300_1301.pdf" H 7000 1500 50  0001 C CNN
F 4 "ADUM1301ARWZ" H 7000 1300 50  0001 C CNN "manf#"
	1    7000 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 5050 7600 5050
$Comp
L Device:C C32
U 1 1 5F3CE062
P 7750 2350
F 0 "C32" H 7635 2304 50  0000 R CNN
F 1 "10u" H 7635 2395 50  0000 R CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-15_AVX-H" H 7788 2200 50  0001 C CNN
F 3 "~" H 7750 2350 50  0001 C CNN
	1    7750 2350
	-1   0    0    1   
$EndComp
Text Label 1350 6050 0    50   ~ 0
VCC_IN
$Comp
L Device:D_Schottky D22
U 1 1 5F2C96AC
P 4900 6050
F 0 "D22" H 4900 5950 50  0000 C CNN
F 1 "STPS1L30AFN" H 4900 6150 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 4900 6050 50  0001 C CNN
F 3 "~" H 4900 6050 50  0001 C CNN
F 4 "STPS1L30AFN" H 4900 6050 50  0001 C CNN "manf#"
	1    4900 6050
	-1   0    0    1   
$EndComp
Wire Wire Line
	3050 5350 3050 6050
$Comp
L Device:R R25
U 1 1 5F2FDC75
P 4100 5600
F 0 "R25" H 4170 5646 50  0000 L CNN
F 1 "100k" H 4170 5555 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4030 5600 50  0001 C CNN
F 3 "~" H 4100 5600 50  0001 C CNN
	1    4100 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 5350 4100 5450
$Comp
L Device:R R27
U 1 1 5F34E182
P 5700 5800
F 0 "R27" V 5650 5950 50  0000 L CNN
F 1 "560" V 5800 5750 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5630 5800 50  0001 C CNN
F 3 "~" H 5700 5800 50  0001 C CNN
	1    5700 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	5050 6050 5100 6050
Wire Wire Line
	5100 6050 5500 6050
Wire Wire Line
	4100 5750 4100 5850
Connection ~ 4500 5850
Wire Wire Line
	4500 5850 4500 6350
Wire Wire Line
	4100 7350 4500 7350
Connection ~ 4500 6650
Connection ~ 4500 7350
Connection ~ 4100 5350
Wire Wire Line
	4100 5850 4500 5850
Wire Wire Line
	4500 6350 5950 6350
Wire Wire Line
	5100 7350 5500 7350
$Comp
L Device:LED D24
U 1 1 5F5E3FC8
P 5300 5800
F 0 "D24" H 5450 5750 50  0000 C CNN
F 1 "LED green" H 5300 5900 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5300 5800 50  0001 C CNN
F 3 "~" H 5300 5800 50  0001 C CNN
F 4 "LG R971-KN-1" H 5300 5800 50  0001 C CNN "manf#"
	1    5300 5800
	-1   0    0    1   
$EndComp
Wire Wire Line
	5100 6050 5100 5800
Wire Wire Line
	5100 5800 5150 5800
Wire Wire Line
	5450 5800 5550 5800
Wire Wire Line
	5850 5800 5950 5800
Wire Wire Line
	5950 5800 5950 6350
Connection ~ 5950 6350
Wire Wire Line
	5950 6350 6350 6350
Connection ~ 6050 7350
Wire Wire Line
	6050 7350 6350 7350
Connection ~ 5500 6050
Wire Wire Line
	5500 6050 6350 6050
Connection ~ 5500 7350
Wire Wire Line
	5500 7350 6050 7350
Wire Wire Line
	4500 7350 5100 7350
Wire Wire Line
	4700 5350 6050 5350
Wire Wire Line
	4300 5350 4100 5350
Wire Wire Line
	4500 5650 4500 5850
Wire Wire Line
	6050 5550 6050 7350
Wire Wire Line
	5850 5550 6050 5550
Wire Wire Line
	5450 5550 5550 5550
Wire Wire Line
	4700 5550 5150 5550
$Comp
L Device:LED D23
U 1 1 5F5DB1B7
P 5300 5550
F 0 "D23" H 5450 5500 50  0000 C CNN
F 1 "LED orange" H 5300 5650 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5300 5550 50  0001 C CNN
F 3 "~" H 5300 5550 50  0001 C CNN
F 4 "LO R976-PS-1" H 5300 5550 50  0001 C CNN "manf#"
	1    5300 5550
	-1   0    0    1   
$EndComp
$Comp
L Device:Q_PMOS_GSD Q21
U 1 1 5F7B81E5
P 4500 5450
F 0 "Q21" V 4842 5450 50  0000 C CNN
F 1 "IRLM5203 (PMOS_GSD)" V 4751 5450 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4700 5550 50  0001 C CNN
F 3 "~" H 4500 5450 50  0001 C CNN
F 4 "IRLML5203TRPBF" H 4500 5450 50  0001 C CNN "manf#"
	1    4500 5450
	0    1    -1   0   
$EndComp
$Comp
L Device:R R26
U 1 1 5F728D1A
P 5700 5550
F 0 "R26" V 5650 5700 50  0000 L CNN
F 1 "560" V 5800 5500 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5630 5550 50  0001 C CNN
F 3 "~" H 5700 5550 50  0001 C CNN
	1    5700 5550
	0    1    1    0   
$EndComp
Wire Wire Line
	4400 6050 4700 6050
Wire Wire Line
	4700 5550 4700 6050
Connection ~ 4700 6050
Wire Wire Line
	4700 6050 4750 6050
$Comp
L power:GND #PWR0101
U 1 1 5F3B04B6
P 8650 5850
F 0 "#PWR0101" H 8650 5600 50  0001 C CNN
F 1 "GND" H 8655 5677 50  0000 C CNN
F 2 "" H 8650 5850 50  0001 C CNN
F 3 "" H 8650 5850 50  0001 C CNN
	1    8650 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8550 3850 8550 3550
Wire Wire Line
	8750 3850 8750 3650
Wire Wire Line
	8850 3850 8850 3750
$Comp
L power:+5V #PWR0102
U 1 1 5F3D2A3E
P 8850 3750
F 0 "#PWR0102" H 8850 3600 50  0001 C CNN
F 1 "+5V" H 8865 3923 50  0000 C CNN
F 2 "" H 8850 3750 50  0001 C CNN
F 3 "" H 8850 3750 50  0001 C CNN
	1    8850 3750
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0103
U 1 1 5F3DF513
P 8750 3650
F 0 "#PWR0103" H 8750 3500 50  0001 C CNN
F 1 "+3.3V" H 8765 3823 50  0000 C CNN
F 2 "" H 8750 3650 50  0001 C CNN
F 3 "" H 8750 3650 50  0001 C CNN
	1    8750 3650
	1    0    0    -1  
$EndComp
Text Label 8550 3550 3    50   ~ 0
VIN
$Comp
L power:GND #PWR0104
U 1 1 5F4648EF
P 6050 7350
F 0 "#PWR0104" H 6050 7100 50  0001 C CNN
F 1 "GND" H 6055 7177 50  0000 C CNN
F 2 "" H 6050 7350 50  0001 C CNN
F 3 "" H 6050 7350 50  0001 C CNN
	1    6050 7350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0105
U 1 1 5F46A7EE
P 6350 6050
F 0 "#PWR0105" H 6350 5900 50  0001 C CNN
F 1 "+5V" V 6365 6178 50  0000 L CNN
F 2 "" H 6350 6050 50  0001 C CNN
F 3 "" H 6350 6050 50  0001 C CNN
	1    6350 6050
	0    1    1    0   
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5F470FD7
P 1300 6050
F 0 "#FLG0101" H 1300 6125 50  0001 C CNN
F 1 "PWR_FLAG" H 1300 6223 50  0000 C CNN
F 2 "" H 1300 6050 50  0001 C CNN
F 3 "~" H 1300 6050 50  0001 C CNN
	1    1300 6050
	1    0    0    -1  
$EndComp
Connection ~ 1300 6050
Wire Wire Line
	1300 6050 2000 6050
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5F471A75
P 3250 6050
F 0 "#FLG0102" H 3250 6125 50  0001 C CNN
F 1 "PWR_FLAG" H 3250 6223 50  0000 C CNN
F 2 "" H 3250 6050 50  0001 C CNN
F 3 "~" H 3250 6050 50  0001 C CNN
	1    3250 6050
	1    0    0    -1  
$EndComp
Connection ~ 3250 6050
Wire Wire Line
	3250 6050 3050 6050
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 5F472E9E
P 6050 5350
F 0 "#FLG0103" H 6050 5425 50  0001 C CNN
F 1 "PWR_FLAG" H 6050 5523 50  0000 C CNN
F 2 "" H 6050 5350 50  0001 C CNN
F 3 "~" H 6050 5350 50  0001 C CNN
	1    6050 5350
	1    0    0    -1  
$EndComp
Connection ~ 6050 5350
Wire Wire Line
	6050 5350 6350 5350
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5F478184
P 1300 6150
F 0 "#FLG0104" H 1300 6225 50  0001 C CNN
F 1 "PWR_FLAG" H 1300 6323 50  0000 C CNN
F 2 "" H 1300 6150 50  0001 C CNN
F 3 "~" H 1300 6150 50  0001 C CNN
	1    1300 6150
	-1   0    0    1   
$EndComp
Connection ~ 1300 6150
Wire Wire Line
	1300 6150 1950 6150
$Comp
L Device:C C21
U 1 1 5F349D62
P 5500 6950
F 0 "C21" H 5615 6996 50  0000 L CNN
F 1 "1u" H 5615 6905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5538 6800 50  0001 C CNN
F 3 "~" H 5500 6950 50  0001 C CNN
	1    5500 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 1100 2200 1100
Wire Wire Line
	4900 1100 5350 1100
Wire Wire Line
	4900 1200 5350 1200
Wire Wire Line
	4900 1400 5350 1400
Wire Wire Line
	4900 1500 5350 1500
Wire Wire Line
	4900 1600 5350 1600
Wire Wire Line
	4900 1700 5350 1700
Wire Wire Line
	4900 1800 5350 1800
Wire Wire Line
	4900 1900 5350 1900
Wire Wire Line
	4900 2000 5350 2000
Wire Wire Line
	4900 2100 5350 2100
Wire Wire Line
	2300 1300 1850 1300
Wire Wire Line
	2300 1400 1850 1400
Wire Wire Line
	2300 1900 1850 1900
Wire Wire Line
	2300 2000 1850 2000
Wire Wire Line
	2300 2100 1850 2100
Wire Wire Line
	2300 2200 1850 2200
Wire Wire Line
	2300 2300 1850 2300
Wire Wire Line
	4900 3000 5350 3000
Text Label 1500 1000 0    50   ~ 0
TX
Text Label 1500 1100 0    50   ~ 0
RX
Text Label 1850 1400 0    50   ~ 0
SDA
Text Label 1850 1300 0    50   ~ 0
SCL
Text Label 5350 3000 2    50   ~ 0
~RESET
Text Label 5350 1200 2    50   ~ 0
REDE
Text Label 5350 1300 2    50   ~ 0
IO_CS
Text Label 5350 1500 2    50   ~ 0
LCD_RS
Text Label 5350 1600 2    50   ~ 0
LCD_CS
Text Label 5350 1800 2    50   ~ 0
LCD_LED
Text Label 5350 1900 2    50   ~ 0
MOSI
Text Label 5350 2000 2    50   ~ 0
MISO
Text Label 5350 2100 2    50   ~ 0
SCK
Text Label 1850 2200 0    50   ~ 0
A0-CUR
Text Label 1850 2100 0    50   ~ 0
A1-~FLT
Text Label 1850 2000 0    50   ~ 0
A2
Text Label 1850 1900 0    50   ~ 0
A3
Text Label 1850 2300 0    50   ~ 0
AREF
Wire Wire Line
	9150 4650 9650 4650
Text Label 9650 4650 2    50   ~ 0
AREF
Text Label 9650 5150 2    50   ~ 0
A3
Text Label 9650 5050 2    50   ~ 0
A2
Wire Wire Line
	2300 3100 2150 3100
Wire Wire Line
	2300 2900 2000 2900
Wire Wire Line
	2300 3000 2150 3000
$Comp
L power:+5V #PWR0106
U 1 1 5F443F2A
P 2150 3000
F 0 "#PWR0106" H 2150 2850 50  0001 C CNN
F 1 "+5V" H 2165 3173 50  0000 C CNN
F 2 "" H 2150 3000 50  0001 C CNN
F 3 "" H 2150 3000 50  0001 C CNN
	1    2150 3000
	0    -1   1    0   
$EndComp
$Comp
L power:+3.3V #PWR0107
U 1 1 5F443F30
P 2000 2900
F 0 "#PWR0107" H 2000 2750 50  0001 C CNN
F 1 "+3.3V" H 2015 3073 50  0000 C CNN
F 2 "" H 2000 2900 50  0001 C CNN
F 3 "" H 2000 2900 50  0001 C CNN
	1    2000 2900
	0    -1   1    0   
$EndComp
Text Label 2150 3100 0    50   ~ 0
VIN
Text Label 7600 4750 0    50   ~ 0
D6-~FLT
Text Label 7600 4550 0    50   ~ 0
REDE
Text Label 7600 4650 0    50   ~ 0
IO_CS
Text Label 7600 4850 0    50   ~ 0
LCD_RS
Text Label 7600 4950 0    50   ~ 0
LCD_CS
Wire Wire Line
	5350 1000 4900 1000
Wire Wire Line
	5350 1300 4900 1300
Text Label 5350 1000 2    50   ~ 0
D2
Text Label 5350 1100 2    50   ~ 0
D3
Text Label 5350 1400 2    50   ~ 0
D6-~FLT
Text Label 5350 1700 2    50   ~ 0
D9
Text Label 7600 5050 0    50   ~ 0
D9
$Comp
L arduino:Arduino_Uno_Shield XA1
U 1 1 5F53BAD1
P 3600 2050
F 0 "XA1" H 3600 3437 60  0000 C CNN
F 1 "Arduino_Uno_Shield" H 3600 3331 60  0000 C CNN
F 2 "project:Arduino_Shield" H 5400 5800 60  0001 C CNN
F 3 "https://store.arduino.cc/arduino-uno-rev3" H 5400 5800 60  0001 C CNN
F 4 "Do Not Populate Tag" H 3600 2050 50  0001 C CNN "DNP"
	1    3600 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 2600 2300 2700
Connection ~ 2300 2700
Wire Wire Line
	2300 2700 2300 2800
$Comp
L power:GND #PWR0108
U 1 1 5F6D541E
P 2300 2700
F 0 "#PWR0108" H 2300 2450 50  0001 C CNN
F 1 "GND" H 2305 2527 50  0000 C CNN
F 2 "" H 2300 2700 50  0001 C CNN
F 3 "" H 2300 2700 50  0001 C CNN
	1    2300 2700
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5F713556
P 1700 600
F 0 "J1" V 1700 400 50  0000 R CNN
F 1 "Conn_01x02" V 1550 1500 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1700 600 50  0001 C CNN
F 3 "~" H 1700 600 50  0001 C CNN
	1    1700 600 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1500 1000 1700 1000
Wire Wire Line
	1800 800  1800 1100
Connection ~ 1800 1100
Wire Wire Line
	1800 1100 1500 1100
Wire Wire Line
	1700 800  1700 1000
Connection ~ 1700 1000
Wire Wire Line
	1700 1000 1900 1000
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 5F7495B8
P 2050 1000
F 0 "JP1" H 2050 1205 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2050 1114 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2050 1000 50  0001 C CNN
F 3 "~" H 2050 1000 50  0001 C CNN
F 4 "Do Not Populate Tag" H 2050 1000 50  0001 C CNN "DNP"
	1    2050 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 1000 2300 1000
$Comp
L Jumper:SolderJumper_2_Open JP2
U 1 1 5F749A74
P 2050 1100
F 0 "JP2" H 2050 1305 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2050 1214 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2050 1100 50  0001 C CNN
F 3 "~" H 2050 1100 50  0001 C CNN
F 4 "Do Not Populate Tag" H 2050 1100 50  0001 C CNN "DNP"
	1    2050 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1100 1800 1100
Text Notes 800  700  0    50   ~ 0
Alternative UART Pins\nfor Mega, Due ...
Text Notes 9350 6350 0    50   ~ 0
I2C pins by board SDA/SCL\n-------------------\nNano: A4/A5\n-------------------\nUno, Ethernet: A4/A5->20/21\nMega2560, Due: 20/21\nLeonardo: 2/3->20/21
Wire Wire Line
	9150 5450 9650 5450
Wire Wire Line
	9150 5550 9650 5550
Text Label 9650 5550 2    50   ~ 0
A5
Text Label 9650 5450 2    50   ~ 0
A4
Wire Wire Line
	2300 1700 1850 1700
Wire Wire Line
	2300 1800 1850 1800
Text Label 1850 1800 0    50   ~ 0
A4
Text Label 1850 1700 0    50   ~ 0
A5
Wire Wire Line
	10600 5050 10950 5050
Wire Wire Line
	10200 5050 9850 5050
Wire Wire Line
	10400 5200 10400 5500
Text Label 10400 5500 1    50   ~ 0
~FLT
Text Label 9850 5050 0    50   ~ 0
A1-~FLT
Text Label 10950 5050 2    50   ~ 0
D6-~FLT
$Comp
L Jumper:SolderJumper_2_Bridged JP3
U 1 1 5F4C72A3
P 10400 4600
F 0 "JP3" H 10400 4805 50  0000 C CNN
F 1 "SolderJumper_2_Bridged" H 10400 4714 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_Pad1.0x1.5mm" H 10400 4600 50  0001 C CNN
F 3 "~" H 10400 4600 50  0001 C CNN
F 4 "Do Not Populate Tag" H 10400 4600 50  0001 C CNN "DNP"
	1    10400 4600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10950 4600 10550 4600
Text Label 10950 4600 2    50   ~ 0
CUR
Wire Wire Line
	10250 4600 9850 4600
Text Label 9850 4600 0    50   ~ 0
A0-CUR
$Comp
L Jumper:SolderJumper_3_Bridged12 JP4
U 1 1 5F4F4DFF
P 10400 5050
F 0 "JP4" H 10400 5255 50  0000 C CNN
F 1 "SolderJumper_3_Bridged12" H 10400 5164 50  0000 C CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_Pad1.0x1.5mm" H 10400 5050 50  0001 C CNN
F 3 "~" H 10400 5050 50  0001 C CNN
F 4 "Do Not Populate Tag" H 10400 5050 50  0001 C CNN "DNP"
	1    10400 5050
	1    0    0    -1  
$EndComp
$Comp
L Diode:BAT54J D21
U 1 1 5F4BB325
P 5100 6950
F 0 "D21" V 5054 7030 50  0000 L CNN
F 1 "BAT54J" V 5145 7030 50  0000 L CNN
F 2 "Diode_SMD:D_SOD-323F" H 5100 6775 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAT54J.pdf" H 5100 6950 50  0001 C CNN
F 4 "BAT54J\\,115" H 5100 6950 50  0001 C CNN "manf#"
	1    5100 6950
	0    1    1    0   
$EndComp
$Comp
L project:74LVC2G34 U33
U 1 1 5F4CD637
P 5350 3850
F 0 "U33" H 5325 4117 50  0000 C CNN
F 1 "74LVC2G34" H 5325 4026 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 5350 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 5350 3850 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 5350 3850 50  0001 C CNN "manf#"
	1    5350 3850
	1    0    0    -1  
$EndComp
$Comp
L project:74LVC2G34 U33
U 2 1 5F4CE9A3
P 5350 4300
F 0 "U33" H 5325 4567 50  0000 C CNN
F 1 "74LVC2G34" H 5325 4476 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 5350 4300 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 5350 4300 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 5350 4300 50  0001 C CNN "manf#"
	2    5350 4300
	1    0    0    -1  
$EndComp
$Comp
L project:74LVC2G34 U33
U 3 1 5F4CF7EC
P 5350 4700
F 0 "U33" H 5350 4917 50  0000 C CNN
F 1 "74LVC2G34" H 5350 4826 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 5350 4700 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 5350 4700 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 5350 4700 50  0001 C CNN "manf#"
	3    5350 4700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4500 6650 6350 6650
Wire Wire Line
	5050 3850 4650 3850
Wire Wire Line
	5050 4300 4650 4300
Wire Wire Line
	5050 4700 4650 4700
Wire Wire Line
	5600 3850 5700 3850
Text Label 4650 4300 0    50   ~ 0
ISO_TX
Text Label 4650 3850 0    50   ~ 0
ISO_RX
Text Label 5750 4700 0    50   ~ 0
ISO_+5V
Text Label 4650 4700 0    50   ~ 0
ISO_GND
Wire Wire Line
	6400 3850 6600 3850
Wire Wire Line
	6000 3850 6100 3850
$Comp
L Device:LED D30
U 1 1 5F582C98
P 5850 3850
F 0 "D30" H 5850 3750 50  0000 C CNN
F 1 "LED yellow" H 5850 3950 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5850 3850 50  0001 C CNN
F 3 "~" H 5850 3850 50  0001 C CNN
F 4 "LY R976-PS-36" H 5850 3850 50  0001 C CNN "manf#"
	1    5850 3850
	1    0    0    1   
$EndComp
$Comp
L Device:R R33
U 1 1 5F582CA2
P 6250 3850
F 0 "R33" V 6150 3850 50  0000 C CNN
F 1 "560" V 6350 3800 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6180 3850 50  0001 C CNN
F 3 "~" H 6250 3850 50  0001 C CNN
	1    6250 3850
	0    1    1    0   
$EndComp
Wire Wire Line
	5600 4300 5700 4300
$Comp
L Device:R R34
U 1 1 5F582C7E
P 6250 4300
F 0 "R34" V 6150 4300 50  0000 C CNN
F 1 "560" V 6350 4250 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6180 4300 50  0001 C CNN
F 3 "~" H 6250 4300 50  0001 C CNN
	1    6250 4300
	0    1    1    0   
$EndComp
$Comp
L Device:LED D31
U 1 1 5F582C88
P 5850 4300
F 0 "D31" H 5850 4200 50  0000 C CNN
F 1 "LED yellow" H 5850 4400 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5850 4300 50  0001 C CNN
F 3 "~" H 5850 4300 50  0001 C CNN
F 4 "LY R976-PS-36" H 5850 4300 50  0001 C CNN "manf#"
	1    5850 4300
	1    0    0    1   
$EndComp
Wire Wire Line
	6000 4300 6100 4300
Wire Wire Line
	6400 4300 6600 4300
Wire Wire Line
	5650 4700 6600 4700
Connection ~ 6600 4300
Wire Wire Line
	6600 4300 6600 4700
Wire Wire Line
	6600 3850 6600 4300
$Comp
L project:74LVC2G34 U2
U 1 1 5F6D9816
P 3050 3850
F 0 "U2" H 3025 4117 50  0000 C CNN
F 1 "74LVC2G34" H 3025 4026 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3050 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 3050 3850 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 3050 3850 50  0001 C CNN "manf#"
	1    3050 3850
	1    0    0    -1  
$EndComp
$Comp
L project:74LVC2G34 U2
U 2 1 5F6D9820
P 3050 4300
F 0 "U2" H 3025 4567 50  0000 C CNN
F 1 "74LVC2G34" H 3025 4476 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3050 4300 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 3050 4300 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 3050 4300 50  0001 C CNN "manf#"
	2    3050 4300
	1    0    0    -1  
$EndComp
$Comp
L project:74LVC2G34 U2
U 3 1 5F6D982A
P 3050 4700
F 0 "U2" H 3050 4917 50  0000 C CNN
F 1 "74LVC2G34" H 3050 4826 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3050 4700 50  0001 C CNN
F 3 "http://www.ti.com/lit/sg/scyt129e/scyt129e.pdf" H 3050 4700 50  0001 C CNN
F 4 "SN74LVC2G34DBVR" H 3050 4700 50  0001 C CNN "manf#"
	3    3050 4700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2750 3850 2350 3850
Wire Wire Line
	2750 4300 2350 4300
Wire Wire Line
	2750 4700 2350 4700
Text Label 2350 3850 0    50   ~ 0
SCL
Text Label 2350 4300 0    50   ~ 0
SDA
Text Label 3600 4700 0    50   ~ 0
+5V
Text Label 2350 4700 0    50   ~ 0
GND
Wire Wire Line
	4100 3850 4300 3850
Wire Wire Line
	3700 3850 3800 3850
$Comp
L Device:LED D1
U 1 1 5F6D983E
P 3950 3850
F 0 "D1" H 3950 3750 50  0000 C CNN
F 1 "LED yellow" H 3950 3950 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 3950 3850 50  0001 C CNN
F 3 "~" H 3950 3850 50  0001 C CNN
F 4 "LY R976-PS-36" H 3950 3850 50  0001 C CNN "manf#"
	1    3950 3850
	1    0    0    1   
$EndComp
Wire Wire Line
	3700 4300 3800 4300
Wire Wire Line
	4100 4300 4300 4300
Wire Wire Line
	3350 4700 4300 4700
Connection ~ 4300 4300
Wire Wire Line
	4300 4300 4300 4700
Wire Wire Line
	4300 3850 4300 4300
Wire Wire Line
	3300 4300 3400 4300
Wire Wire Line
	3300 3850 3400 3850
$Comp
L Device:R R2
U 1 1 5F6D9853
P 3550 4300
F 0 "R2" V 3450 4300 50  0000 C CNN
F 1 "560" V 3650 4250 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3480 4300 50  0001 C CNN
F 3 "~" H 3550 4300 50  0001 C CNN
	1    3550 4300
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5F6D9848
P 3550 3850
F 0 "R1" V 3450 3850 50  0000 C CNN
F 1 "560" V 3650 3800 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3480 3850 50  0001 C CNN
F 3 "~" H 3550 3850 50  0001 C CNN
	1    3550 3850
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 5F80D6C1
P 1200 3700
F 0 "R3" V 993 3700 50  0000 C CNN
F 1 "10k" V 1084 3700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 1130 3700 50  0001 C CNN
F 3 "~" H 1200 3700 50  0001 C CNN
	1    1200 3700
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 5F80E3C1
P 1200 4100
F 0 "R4" V 993 4100 50  0000 C CNN
F 1 "10k" V 1084 4100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 1130 4100 50  0001 C CNN
F 3 "~" H 1200 4100 50  0001 C CNN
	1    1200 4100
	0    1    1    0   
$EndComp
Wire Wire Line
	1050 3700 800  3700
Wire Wire Line
	1050 4100 800  4100
Wire Wire Line
	1350 3700 1550 3700
Wire Wire Line
	1350 4100 1550 4100
Text Label 800  3700 0    50   ~ 0
SDA
Text Label 800  4100 0    50   ~ 0
SCL
Wire Wire Line
	1550 3700 1550 3900
Wire Wire Line
	1550 3900 1700 3900
Connection ~ 1550 3900
Wire Wire Line
	1550 3900 1550 4100
$Comp
L power:+5V #PWR01
U 1 1 5F8BD1E6
P 1700 3900
F 0 "#PWR01" H 1700 3750 50  0001 C CNN
F 1 "+5V" H 1715 4073 50  0000 C CNN
F 2 "" H 1700 3900 50  0001 C CNN
F 3 "" H 1700 3900 50  0001 C CNN
	1    1700 3900
	0    1    1    0   
$EndComp
NoConn ~ 4900 3100
NoConn ~ 4900 2300
NoConn ~ 4900 2400
NoConn ~ 4900 2500
NoConn ~ 4900 2600
NoConn ~ 4900 2700
NoConn ~ 4900 2800
$Comp
L Connector_Generic:Conn_01x04 J40
U 1 1 5F457F5E
P 1250 4450
F 0 "J40" H 1330 4442 50  0000 L CNN
F 1 "Conn_01x04" H 1330 4351 50  0000 L CNN
F 2 "Connector_Phoenix_MC:PhoenixContact_MC_1,5_4-G-3.81_1x04_P3.81mm_Horizontal" H 1250 4450 50  0001 C CNN
F 3 "~" H 1250 4450 50  0001 C CNN
F 4 "1722008 " H 1250 4450 50  0001 C CNN "manf#"
	1    1250 4450
	1    0    0    -1  
$EndComp
Text Label 800  4450 0    50   ~ 0
GND
Text Label 800  4350 0    50   ~ 0
+5V
Wire Wire Line
	1050 4450 800  4450
Wire Wire Line
	1050 4350 800  4350
Text Label 800  4550 0    50   ~ 0
SCL
Text Label 800  4650 0    50   ~ 0
SDA
Wire Wire Line
	1050 4650 800  4650
Wire Wire Line
	1050 4550 800  4550
Text Notes 600  7700 0    39   ~ 0
manf#           color       [nm]  V_F\nLH R974-LP-1  Hyper Red  645   1.8\nLG R971-KN-1  Green      570   2.2\nLS R976-NR-1  Super Red  633   2\nLY R976-PS-36 Yellow      588   2\nLO R976-PS-1  Orange     606   2
$Comp
L Device:LED D2
U 1 1 5F6D985D
P 3950 4300
F 0 "D2" H 3950 4200 50  0000 C CNN
F 1 "LED yellow" H 3950 4400 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 3950 4300 50  0001 C CNN
F 3 "~" H 3950 4300 50  0001 C CNN
F 4 "LY R976-PS-36" H 3950 4300 50  0001 C CNN "manf#"
	1    3950 4300
	1    0    0    1   
$EndComp
Wire Wire Line
	8650 2800 8750 2800
$Comp
L Device:LED D32
U 1 1 5F6C6863
P 8900 2800
F 0 "D32" H 8900 2700 50  0000 C CNN
F 1 "LED red" H 8900 2900 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 8900 2800 50  0001 C CNN
F 3 "~" H 8900 2800 50  0001 C CNN
F 4 "LS R976-NR-1" H 8900 2800 50  0001 C CNN "manf#"
	1    8900 2800
	1    0    0    1   
$EndComp
$Comp
L Device:R R35
U 1 1 5F6C6869
P 8500 2800
F 0 "R35" V 8400 2800 50  0000 C CNN
F 1 "560" V 8600 2750 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8430 2800 50  0001 C CNN
F 3 "~" H 8500 2800 50  0001 C CNN
	1    8500 2800
	0    1    1    0   
$EndComp
Wire Wire Line
	7750 2550 7750 2800
Wire Wire Line
	7750 2800 8350 2800
Wire Wire Line
	9050 2800 9650 2800
Text Label 9650 2800 2    50   ~ 0
ISO_+5V
$EndSCHEMATC

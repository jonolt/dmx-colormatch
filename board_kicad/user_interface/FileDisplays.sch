EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR?
U 1 1 5F65BDB0
P 9450 5800
AR Path="/5F65BDB0" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BDB0" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 9450 5550 50  0001 C CNN
F 1 "GND" V 9455 5672 50  0000 R CNN
F 2 "" H 9450 5800 50  0001 C CNN
F 3 "" H 9450 5800 50  0001 C CNN
	1    9450 5800
	0    -1   1    0   
$EndComp
Text Label 9750 5550 2    50   ~ 0
LCD_LED
Wire Wire Line
	9400 5550 9750 5550
Wire Wire Line
	9100 5800 9450 5800
Wire Wire Line
	9100 5750 9100 5800
$Comp
L power:+5V #PWR?
U 1 1 5F65BDBA
P 7700 5350
AR Path="/5F65BDBA" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BDBA" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 7700 5200 50  0001 C CNN
F 1 "+5V" V 7715 5478 50  0000 L CNN
F 2 "" H 7700 5350 50  0001 C CNN
F 3 "" H 7700 5350 50  0001 C CNN
	1    7700 5350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7850 5350 7700 5350
Wire Wire Line
	7800 5450 7800 5600
Wire Wire Line
	8650 5450 8550 5450
Wire Wire Line
	8650 5600 8650 5450
Wire Wire Line
	7800 5600 8650 5600
Wire Wire Line
	7850 5450 7800 5450
Wire Wire Line
	9000 5350 9100 5350
Wire Wire Line
	8550 5350 8700 5350
$Comp
L Device:R R?
U 1 1 5F65BDC8
P 8850 5350
AR Path="/5F65BDC8" Ref="R?"  Part="1" 
AR Path="/5F60E9CD/5F65BDC8" Ref="R?"  Part="1" 
F 0 "R?" V 8643 5350 50  0000 C CNN
F 1 "R" V 8734 5350 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8780 5350 50  0001 C CNN
F 3 "~" H 8850 5350 50  0001 C CNN
	1    8850 5350
	0    1    1    0   
$EndComp
$Comp
L Device:Q_NPN_BEC Q?
U 1 1 5F65BDCE
P 9200 5550
AR Path="/5F65BDCE" Ref="Q?"  Part="1" 
AR Path="/5F60E9CD/5F65BDCE" Ref="Q?"  Part="1" 
F 0 "Q?" H 9391 5596 50  0000 L CNN
F 1 "Q_NPN_BEC" H 9391 5505 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 9400 5650 50  0001 C CNN
F 3 "~" H 9200 5550 50  0001 C CNN
	1    9200 5550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8600 4750 8600 4650
$Comp
L power:GND #PWR?
U 1 1 5F65BDD5
P 8600 4750
AR Path="/5F65BDD5" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BDD5" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 8600 4500 50  0001 C CNN
F 1 "GND" V 8605 4622 50  0000 R CNN
F 2 "" H 8600 4750 50  0001 C CNN
F 3 "" H 8600 4750 50  0001 C CNN
	1    8600 4750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F65BDDB
P 8600 2800
AR Path="/5F65BDDB" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BDDB" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 8600 2650 50  0001 C CNN
F 1 "+5V" V 8615 2928 50  0000 L CNN
F 2 "" H 8600 2800 50  0001 C CNN
F 3 "" H 8600 2800 50  0001 C CNN
	1    8600 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 2900 8600 2800
Wire Wire Line
	8600 2900 8700 2900
Connection ~ 8600 2900
Wire Wire Line
	8600 2950 8600 2900
Wire Wire Line
	8700 2900 8700 2950
Wire Wire Line
	8500 2900 8600 2900
Wire Wire Line
	8500 2950 8500 2900
Wire Wire Line
	9100 4400 9550 4400
Text Label 9550 4400 2    50   ~ 0
~RESET
Wire Wire Line
	9100 4300 9550 4300
Text Label 9550 4300 2    50   ~ 0
GND
NoConn ~ 9100 3650
NoConn ~ 9100 3550
Wire Wire Line
	7900 3850 8050 3850
$Comp
L power:+5V #PWR?
U 1 1 5F65BDEF
P 7900 3850
AR Path="/5F65BDEF" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BDEF" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 7900 3700 50  0001 C CNN
F 1 "+5V" V 7915 3978 50  0000 L CNN
F 2 "" H 7900 3850 50  0001 C CNN
F 3 "" H 7900 3850 50  0001 C CNN
	1    7900 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8050 4050 8050 3950
Connection ~ 8050 4050
Wire Wire Line
	8100 4050 8050 4050
Wire Wire Line
	8050 3950 8050 3850
Connection ~ 8050 3950
Wire Wire Line
	8100 3950 8050 3950
Wire Wire Line
	8050 3850 8050 3750
Connection ~ 8050 3850
Wire Wire Line
	8100 3850 8050 3850
Wire Wire Line
	8050 3750 8050 3650
Connection ~ 8050 3750
Wire Wire Line
	8100 3750 8050 3750
Wire Wire Line
	8050 3650 8050 3550
Connection ~ 8050 3650
Wire Wire Line
	8100 3650 8050 3650
Wire Wire Line
	8050 3550 8100 3550
Wire Wire Line
	8050 4150 8050 4050
Wire Wire Line
	8100 4150 8050 4150
$Comp
L EA_Display:EA_DOGM163_with_LED LCD?
U 2 1 5F65BE07
P 8200 5400
AR Path="/5F65BE07" Ref="LCD?"  Part="2" 
AR Path="/5F60E9CD/5F65BE07" Ref="LCD?"  Part="2" 
F 0 "LCD?" H 8200 5715 50  0000 C CNN
F 1 "EA_DOGM163_with_LED" H 8200 5624 50  0000 C CNN
F 2 "EA_Display:DOGM162_with_LED" H 8200 5400 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/dog-me.pdf" H 8200 5400 50  0001 C CNN
	2    8200 5400
	1    0    0    -1  
$EndComp
$Comp
L EA_Display:EA_DOGM163_with_LED LCD?
U 1 1 5F65BE0D
P 8600 3850
AR Path="/5F65BE0D" Ref="LCD?"  Part="1" 
AR Path="/5F60E9CD/5F65BE0D" Ref="LCD?"  Part="1" 
F 0 "LCD?" H 8600 2961 50  0000 C CNN
F 1 "EA_DOGM163_with_LED" H 8600 2870 50  0000 C CNN
F 2 "EA_Display:DOGM162_with_LED" H 8600 3850 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/dog-me.pdf" H 8600 3850 50  0001 C CNN
	1    8600 3850
	1    0    0    -1  
$EndComp
Text Label 7650 4450 0    50   ~ 0
LCD_CS
Text Label 7650 4250 0    50   ~ 0
GND
Text Label 7650 4350 0    50   ~ 0
LCD_RS
Text Label 7650 3450 0    50   ~ 0
MOSI
Text Label 7650 3350 0    50   ~ 0
SCK
Wire Wire Line
	8100 4250 7650 4250
Wire Wire Line
	8100 4450 7650 4450
Wire Wire Line
	8100 4350 7650 4350
Wire Wire Line
	8100 3450 7650 3450
Wire Wire Line
	8100 3350 7650 3350
Wire Wire Line
	3500 3500 3500 3800
Wire Wire Line
	3700 3600 3700 3800
Wire Wire Line
	3600 2800 3600 2900
Wire Wire Line
	2600 3650 2600 3800
Wire Wire Line
	2750 3650 2600 3650
Wire Wire Line
	3200 3650 3050 3650
Wire Wire Line
	3200 3800 3200 3650
Wire Wire Line
	3400 3150 3400 3800
Connection ~ 3400 3150
Wire Wire Line
	3500 3150 3400 3150
Wire Wire Line
	3400 2950 3400 3150
Wire Wire Line
	3600 3200 3600 3800
Wire Wire Line
	3600 5050 3700 5050
Wire Wire Line
	4100 5050 4650 5050
Connection ~ 4100 5050
Connection ~ 3700 5050
Wire Wire Line
	4650 4500 4650 5050
Wire Wire Line
	3700 5050 4100 5050
Wire Wire Line
	4100 5050 4100 5100
Wire Wire Line
	3700 5050 3700 5000
Wire Wire Line
	3600 5000 3600 5050
$Comp
L EA_Display:EA_OLEDM204 LCD?
U 1 1 5F65BE32
P 3500 4400
AR Path="/5F65BE32" Ref="LCD?"  Part="1" 
AR Path="/5F60E9CD/5F65BE32" Ref="LCD?"  Part="1" 
F 0 "LCD?" H 3450 3711 50  0000 C CNN
F 1 "EA_OLEDM204" H 3450 3620 50  0000 C CNN
F 2 "EA_Display:OLEDM204_6GGA" H 3700 4150 50  0001 C CNN
F 3 "https://www.lcd-module.com/fileadmin/eng/pdf/doma/oledm204-ae.pdf" H 3700 4150 50  0001 C CNN
	1    3500 4400
	1    0    0    -1  
$EndComp
Text Label 4600 4400 2    50   ~ 0
~RESET
Text Label 2300 4600 0    50   ~ 0
LCD_CS
Text Label 2300 4500 0    50   ~ 0
MISO
Text Label 2300 4400 0    50   ~ 0
MOSI
Text Label 2300 4300 0    50   ~ 0
SCK
Connection ~ 4650 4500
Wire Wire Line
	4500 4500 4650 4500
Wire Wire Line
	4100 4500 4200 4500
$Comp
L Device:R R?
U 1 1 5F65BE40
P 4350 4500
AR Path="/5F65BE40" Ref="R?"  Part="1" 
AR Path="/5F60E9CD/5F65BE40" Ref="R?"  Part="1" 
F 0 "R?" V 4250 4450 50  0000 R CNN
F 1 "R" V 4250 4600 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 4500 50  0001 C CNN
F 3 "~" H 4350 4500 50  0001 C CNN
	1    4350 4500
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F65BE46
P 4100 5100
AR Path="/5F65BE46" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BE46" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4100 4850 50  0001 C CNN
F 1 "GND" V 4105 4972 50  0000 R CNN
F 2 "" H 4100 5100 50  0001 C CNN
F 3 "" H 4100 5100 50  0001 C CNN
	1    4100 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 4300 4650 4500
Wire Wire Line
	4100 4300 4650 4300
Wire Wire Line
	4100 4400 4600 4400
Wire Wire Line
	2800 4600 2300 4600
Wire Wire Line
	2800 4500 2300 4500
Wire Wire Line
	2800 4400 2300 4400
Wire Wire Line
	2800 4300 2300 4300
$Comp
L power:+12V #PWR?
U 1 1 5F65BE53
P 3700 3600
AR Path="/5F65BE53" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BE53" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 3700 3450 50  0001 C CNN
F 1 "+12V" V 3715 3728 50  0000 L CNN
F 2 "" H 3700 3600 50  0001 C CNN
F 3 "" H 3700 3600 50  0001 C CNN
	1    3700 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F65BE59
P 2600 3800
AR Path="/5F65BE59" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BE59" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2600 3550 50  0001 C CNN
F 1 "GND" V 2605 3672 50  0000 R CNN
F 2 "" H 2600 3800 50  0001 C CNN
F 3 "" H 2600 3800 50  0001 C CNN
	1    2600 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5F65BE5F
P 2900 3650
AR Path="/5F65BE5F" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BE5F" Ref="C?"  Part="1" 
F 0 "C?" V 2800 3750 50  0000 C CNN
F 1 "2.2u" V 2800 3550 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2938 3500 50  0001 C CNN
F 3 "~" H 2900 3650 50  0001 C CNN
	1    2900 3650
	0    1    1    0   
$EndComp
Wire Wire Line
	3500 3150 3500 3200
$Comp
L power:GND #PWR?
U 1 1 5F65BE66
P 3600 2800
AR Path="/5F65BE66" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BE66" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 3600 2550 50  0001 C CNN
F 1 "GND" V 3605 2672 50  0000 R CNN
F 2 "" H 3600 2800 50  0001 C CNN
F 3 "" H 3600 2800 50  0001 C CNN
	1    3600 2800
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F65BE6C
P 3400 2950
AR Path="/5F65BE6C" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BE6C" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 3400 2800 50  0001 C CNN
F 1 "+5V" V 3415 3078 50  0000 L CNN
F 2 "" H 3400 2950 50  0001 C CNN
F 3 "" H 3400 2950 50  0001 C CNN
	1    3400 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5F65BE72
P 3500 3350
AR Path="/5F65BE72" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BE72" Ref="C?"  Part="1" 
F 0 "C?" H 3385 3304 50  0000 R CNN
F 1 "100n" H 3385 3395 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3538 3200 50  0001 C CNN
F 3 "~" H 3500 3350 50  0001 C CNN
	1    3500 3350
	-1   0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 5F65BE78
P 3600 3050
AR Path="/5F65BE78" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BE78" Ref="C?"  Part="1" 
F 0 "C?" H 3485 3004 50  0000 R CNN
F 1 "100n" H 3485 3095 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3638 2900 50  0001 C CNN
F 3 "~" H 3600 3050 50  0001 C CNN
	1    3600 3050
	-1   0    0    1   
$EndComp
$Comp
L Diode:BAT54J D?
U 1 1 5F65BE7E
P 3900 6450
AR Path="/5F65BE7E" Ref="D?"  Part="1" 
AR Path="/5F60E9CD/5F65BE7E" Ref="D?"  Part="1" 
F 0 "D?" H 3900 6667 50  0000 C CNN
F 1 "BAT54J" H 3900 6576 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-323F" H 3900 6275 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAT54J.pdf" H 3900 6450 50  0001 C CNN
	1    3900 6450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3650 6450 3750 6450
Connection ~ 3650 6450
Wire Wire Line
	3650 6050 3650 6450
Wire Wire Line
	3200 6050 3650 6050
Wire Wire Line
	2050 6050 2050 6450
Wire Wire Line
	2900 6050 2050 6050
$Comp
L Device:L L?
U 1 1 5F65BE8A
P 3050 6050
AR Path="/5F65BE8A" Ref="L?"  Part="1" 
AR Path="/5F60E9CD/5F65BE8A" Ref="L?"  Part="1" 
F 0 "L?" V 3240 6050 50  0000 C CNN
F 1 "47uH" V 3149 6050 50  0000 C CNN
F 2 "Inductor_SMD:L_1008_2520Metric" H 3050 6050 50  0001 C CNN
F 3 "~" H 3050 6050 50  0001 C CNN
	1    3050 6050
	0    -1   -1   0   
$EndComp
Text Label 2200 6750 0    50   ~ 0
LCD_LED
Wire Wire Line
	2550 6750 2200 6750
Wire Wire Line
	2050 6950 2050 7250
Connection ~ 4600 7250
Wire Wire Line
	5150 7250 5150 6950
Wire Wire Line
	4600 7250 5150 7250
Connection ~ 5150 6450
Wire Wire Line
	5250 6450 5150 6450
Wire Wire Line
	5150 6450 5050 6450
Wire Wire Line
	5150 6650 5150 6450
$Comp
L Device:C C?
U 1 1 5F65BE9A
P 5150 6800
AR Path="/5F65BE9A" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BE9A" Ref="C?"  Part="1" 
F 0 "C?" H 5035 6754 50  0000 R CNN
F 1 "2.2u" H 5035 6845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5188 6650 50  0001 C CNN
F 3 "~" H 5150 6800 50  0001 C CNN
	1    5150 6800
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5F65BEA0
P 4900 6450
AR Path="/5F65BEA0" Ref="R?"  Part="1" 
AR Path="/5F60E9CD/5F65BEA0" Ref="R?"  Part="1" 
F 0 "R?" V 4693 6450 50  0000 C CNN
F 1 "100" V 4784 6450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4830 6450 50  0001 C CNN
F 3 "~" H 4900 6450 50  0001 C CNN
	1    4900 6450
	0    1    1    0   
$EndComp
Wire Wire Line
	4600 6950 4600 7250
$Comp
L power:+12V #PWR?
U 1 1 5F65BEA7
P 5250 6450
AR Path="/5F65BEA7" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BEA7" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 5250 6300 50  0001 C CNN
F 1 "+12V" V 5265 6578 50  0000 L CNN
F 2 "" H 5250 6450 50  0001 C CNN
F 3 "" H 5250 6450 50  0001 C CNN
	1    5250 6450
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F65BEAD
P 1700 6450
AR Path="/5F65BEAD" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BEAD" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 1700 6300 50  0001 C CNN
F 1 "+5V" V 1715 6578 50  0000 L CNN
F 2 "" H 1700 6450 50  0001 C CNN
F 3 "" H 1700 6450 50  0001 C CNN
	1    1700 6450
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F65BEB3
P 1700 7250
AR Path="/5F65BEB3" Ref="#PWR?"  Part="1" 
AR Path="/5F60E9CD/5F65BEB3" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 1700 7000 50  0001 C CNN
F 1 "GND" V 1705 7122 50  0000 R CNN
F 2 "" H 1700 7250 50  0001 C CNN
F 3 "" H 1700 7250 50  0001 C CNN
	1    1700 7250
	0    1    1    0   
$EndComp
Connection ~ 4600 6450
Wire Wire Line
	4600 6450 4750 6450
Connection ~ 4250 7250
Wire Wire Line
	4600 7250 4250 7250
Wire Wire Line
	4600 6450 4600 6650
Connection ~ 4250 6450
Wire Wire Line
	4250 6450 4600 6450
Connection ~ 4250 6750
Wire Wire Line
	4250 6750 4250 6850
Wire Wire Line
	3550 6750 4250 6750
Wire Wire Line
	4050 6450 4250 6450
Wire Wire Line
	3550 6450 3650 6450
Wire Wire Line
	2050 7250 1700 7250
Connection ~ 2050 7250
Wire Wire Line
	2050 6450 2050 6650
Connection ~ 3000 7250
Wire Wire Line
	3000 7250 2050 7250
Wire Wire Line
	3100 7250 4250 7250
Connection ~ 3100 7250
Wire Wire Line
	3100 6950 3100 7250
Wire Wire Line
	4250 7250 4250 7150
Wire Wire Line
	3000 7250 3100 7250
Wire Wire Line
	3000 6950 3000 7250
Connection ~ 2050 6450
Wire Wire Line
	2050 6450 1700 6450
Wire Wire Line
	2050 6450 2550 6450
$Comp
L Device:C C?
U 1 1 5F65BED3
P 2050 6800
AR Path="/5F65BED3" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BED3" Ref="C?"  Part="1" 
F 0 "C?" H 1935 6754 50  0000 R CNN
F 1 "4.7u" H 1935 6845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2088 6650 50  0001 C CNN
F 3 "~" H 2050 6800 50  0001 C CNN
	1    2050 6800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5F65BED9
P 4600 6800
AR Path="/5F65BED9" Ref="C?"  Part="1" 
AR Path="/5F60E9CD/5F65BED9" Ref="C?"  Part="1" 
F 0 "C?" H 4485 6754 50  0000 R CNN
F 1 "1u" H 4485 6845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4638 6650 50  0001 C CNN
F 3 "~" H 4600 6800 50  0001 C CNN
	1    4600 6800
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 5F65BEDF
P 4250 7000
AR Path="/5F65BEDF" Ref="R?"  Part="1" 
AR Path="/5F60E9CD/5F65BEDF" Ref="R?"  Part="1" 
F 0 "R?" H 4320 7046 50  0000 L CNN
F 1 "R" H 4320 6955 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4180 7000 50  0001 C CNN
F 3 "~" H 4250 7000 50  0001 C CNN
	1    4250 7000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F65BEE5
P 4250 6600
AR Path="/5F65BEE5" Ref="R?"  Part="1" 
AR Path="/5F60E9CD/5F65BEE5" Ref="R?"  Part="1" 
F 0 "R?" H 4320 6646 50  0000 L CNN
F 1 "R" H 4320 6555 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4180 6600 50  0001 C CNN
F 3 "~" H 4250 6600 50  0001 C CNN
	1    4250 6600
	1    0    0    -1  
$EndComp
$Comp
L project:MAX5026 U?
U 1 1 5F65BEEB
P 3050 6550
AR Path="/5F65BEEB" Ref="U?"  Part="1" 
AR Path="/5F60E9CD/5F65BEEB" Ref="U?"  Part="1" 
F 0 "U?" H 3050 6915 50  0000 C CNN
F 1 "MAX5026" H 3050 6824 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3250 6650 50  0001 C CNN
F 3 "" H 3250 6650 50  0001 C CNN
	1    3050 6550
	1    0    0    -1  
$EndComp
$EndSCHEMATC
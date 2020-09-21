#include <Arduino.h>
#include <SPI.h>

#include <DMXSerial.h>
#include "TCS34725.h"

#include "globals.h"
#include "serial.h"

#include "fsmmain.h"
#include "parandvals.h"

#include "fsmui.h"
#include "AtmButtonExp.h"

#define SPLIT_CHAR ' '

void(* resetFunc) (void) = 0;

void print(String str)
{
    uint8_t bufferLeft = Serial.availableForWrite();
    if(str.length() < bufferLeft)
    {
        Serial.print(str);
    }
}

template <typename T>
String formatValues(T val, const char* formatter)
{
    char buff[SPRINTF_BUFFER_SIZE];
    sprintf(buff, formatter, val);
    return String(buff);
}

template <typename T>
String param_print_values(T _array[], int _size, const char* formatter)
{
    char buff[SPRINTF_BUFFER_SIZE];
    String str_print = "";
    for (int i = 0; i < _size; i++)
    {
        if(i>0 && i<_size)
        {
            str_print += SPLIT_CHAR;
        }
        sprintf(buff, formatter, _array[i]);
        str_print += String(buff);
    }
    return str_print;
}


template <typename T>
uint8_t array_from_string(T target[], String str, uint8_t charsInVal, uint8_t _size)
{
#ifdef _DEBUG
    print("parsing string: " + str + " with " + String(_size) + " argumnets\n");
#endif // _DEBUG
    uint8_t arr_index=0;
    for(unsigned int i = 0; i<str.length(); i++)
    {
        if(str[i]==SPLIT_CHAR)
        {
            String sub_str = str.substring(i+1, i+1+charsInVal);
            //print("arr_index: " + String(arr_index) + "-" + sub_str + "\n");
            target[arr_index] = sub_str.toInt();
            //print("as int: " + String(target[arr_index]) + "\n");
            arr_index++;
            if(arr_index==_size)
            {
                return 0;
            };
            //delay(1);
        }
    }
    return 2;
}

//TODO algorithm to detect reaction time of dmx fixtures
//TODO set boudrate via serial and save in EEPROM

FsmMain fsm_main;
FsmUi fsm_ui;
ParAndVals pav;
AtmButtonExp buttons[8];
Atm_led leds[8];
TCS34725 csensor;

uint16_t tmpRGBC[NUM_SENSOR_VALUES];
uint8_t tmpDMX[NUM_COLOR_CHANNELS];

//inline void initButtons()
//{
//    for (uint8_t i = 0; i<sizeof(BUTTON_MAP); i++)
//    {
////        buttons[i].begin( BUTTON_MAP[i] ).onPress(fsm_ui, i);
//    }
//}
//
//inline void cycleButtons()
//{
//    for (AtmButtonExp sw : buttons)
//    {
////        sw.cycle();
//    }
//}
//
//inline void initLEDs()
//{
//    for (uint8_t i = 0; i<sizeof(LED_MAP); i++)
//    {
//
//    }
//}
//
//inline void cycleLEDs()
//{
//    for (Atm_led d : leds)
//    {
////        d.cycle();
//    }
//}

inline void initSerial()
{
    Serial.begin( 115200 );
    if(pav.GetWaitForSerialFlag()==true)
    {
        //check if SDA and SCL a shortened, if yeas act as waitForSerialFlag is clear
        //wait for any serial input to start;
        while(Serial.available() == 0);
        // then clear the buffer
        while(Serial.available() > 0)
        {
            Serial.read();
        }
        print("~WaitForSerialFlag cleared.\n");
        pav.SetWaitForSerialFlag(false);
    }
}

void updateDmx(uint8_t dmx[])
{
    for(uint8_t i = 0; i<pav.GetcolorChanels(); i++)
    {
        //print("dmx write ch '" + String(pav.GetstartAddress()+i) + "' to value '" + formatValues(dmx[i], F_DMX) + "'\n");
        DMXSerial.write(pav.GetstartAddress()+i, dmx[i]);
        delay(2);
    }
    print("~DMX " + param_print_values(dmx, pav.GetcolorChanels(), F_DMX) + "\n");
}

void readDmx(uint8_t dmx[])
{
    for(uint8_t i = 0; i<pav.GetcolorChanels(); i++)
    {
        dmx[i] = DMXSerial.read(pav.GetstartAddress()+i);
    }
}

inline void readSerial()
{
    String error_msg;
    if(Serial.available()>0)
    {
        String str = Serial.readStringUntil('\n');
        str.trim();
        // reset microcontoller
        if(str.equals("RESET"))
        {
            print(">resetting ...\n");
            Serial.flush();
            resetFunc();
            return;
        }
        // set wait for serial flag
        else if(str.equals("WFS") || str.equals("wait for serial, please"))
        {
            print("~WaitForSerialFlag set.\n");
            pav.SetWaitForSerialFlag(true);
            return;
        }
        //set value of address channel (Syntax: DMX ADD VAL)
        else if(str.startsWith("DMX#"))
        {
            uint8_t add = str.substring(5,8).toInt();
            if (add>=DMX_ADD_MIN && add<=DMX_ADD_MAX)
            {
                uint8_t val = str.substring(9,12).toInt();
                if(val>=DMX_VAL_MIN && val<=DMX_VAL_MAX)
                {
                    DMXSerial.write(add, val);
                    print("#DMX address '" + formatValues(add, F_DMX) + "' set to '" + formatValues(val, F_VAL) + "'\n" );
                    return;
                }
                error_msg = "value '" + str.substring(5,8) + "' is not a channel valid number (001-255)";
            }
            error_msg = "value '" + str.substring(9,12) + "' is not a channel valid number (000-254)";
        }
        else if(str.startsWith("DMX&"))
        {
            // TODO check input is valid
            int8_t ch = str.substring(5,8).toInt();
            int16_t add = pav.GetstartAddress() + ch - 1;
            if (add>=DMX_ADD_MIN && ch<=DMX_ADD_MAX)
            {

                uint8_t val = str.substring(9,12).toInt();
                if(val>=DMX_VAL_MIN && val<=DMX_VAL_MAX)
                {
                    DMXSerial.write(add, val);
                    print("&DMX channel '" + formatValues(ch, F_DMX) + "' set to '" + formatValues(val, F_VAL) + "'\n" );
                    return;
                }
                error_msg = "value '" + str.substring(5,8) + "' is not a channel valid number (001-255)";
            }
            error_msg = "value '" + str.substring(9,12) + "' is not a channel valid number (000-254)";
        }
        //reset all channels to 0
        else if(str.startsWith("DMX*"))
        {
            for(int add=DMX_ADD_MIN; add<=DMX_ADD_MAX; add++)
            {
                DMXSerial.write(add, 0);
            }
            print("*DMX all channels set to 0\n");
            return;
        }
        // get current dmx output, ommiting 0 except color channels
        else if(str.startsWith("DMX?"))
        {
            print("?DMX (ADD/CH) VAL)\n");
            uint8_t dmx_lower = pav.GetstartAddress();
            uint8_t dmx_upper = dmx_lower + pav.GetcolorChanels();
            for(int add=DMX_ADD_MIN; add<=DMX_ADD_MAX; add++)
            {
                uint8_t val = DMXSerial.read(add);
                if(val>0 || (add>=dmx_lower && add<dmx_upper))
                {
                    print("  " + formatValues(add, F_DMX) + "/" + formatValues(add+dmx_lower-1, F_DMX) + " " + formatValues(val, F_VAL) + "\n");
                }
            }
            return;
        }
        // set dmx channels with cuurrent global setting (nuber of channels, start address)
        else if(str.startsWith("DMX"))
        {
            uint8_t dmx_vals[NUM_COLOR_CHANNELS];
            uint8_t arrayExitCode = array_from_string(dmx_vals, str.substring(3), 3, pav.GetcolorChanels());
            if(arrayExitCode==0)
            {
                print(">DMX " + param_print_values(dmx_vals, pav.GetcolorChanels(), F_DMX) + "\n");
                updateDmx(dmx_vals);
                return;
            }
            error_msg = "exit code " + String(arrayExitCode) + "parsing string: " + str;
        }
        //get number of color channels
        else if(str.startsWith("NCH?"))
        {
            print("?NCH " + formatValues(pav.GetcolorChanels(), F_CH) + "\n");
            return;
        }
        // set number of color channels
        else if(str.startsWith("NCH"))
        {
            uint8_t n_ch = str.substring(4).toInt();
            if (n_ch>0 && n_ch<=NUM_COLOR_CHANNELS)
            {
                pav.SetcolorChanels(n_ch);
                print(">NCH " + formatValues(pav.GetcolorChanels(), F_CH) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4) + "' is not a channel valid number (1-8)";
        }
        // get dmx start address
        else if(str.startsWith("ADD?"))
        {
            print("?ADD " + formatValues(pav.GetstartAddress(), F_DMX) + "\n");
            return;
        }
        // set dmx start address
        else if(str.startsWith("ADD"))
        {
            uint8_t add = str.substring(4, 7).toInt();
            if (add>=DMX_ADD_MIN && DMX_ADD_MAX<=255)
            {
                pav.SetstartAddress(add);
                print(">ADD " + formatValues(pav.GetstartAddress(), F_DMX) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4, 7) + "' is not a valid address number (001-255)";
        }
        // get active register
        else if(str.startsWith("REG?"))
        {
            print("?REG " + formatValues(pav.GetActiveRegister(), F_REG) + "\n");
            return;
        }
        // set active register
        else if(str.startsWith("REG"))
        {
            uint8_t reg = str.substring(4,6).toInt();
            if(reg>0 && reg<=NUM_REGISTER)
            {
                pav.SetActiveRegister(reg);
                print(">REG " + formatValues(pav.GetActiveRegister(), F_REG) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4,6) + "' is not a valid register number (01-16)";
        }
        // return register rgbc values of active register
        else if(str.equals("RRGBC?"))
        {
            pav.GetRegRgbc(tmpRGBC);
            print("?RRGBC " + param_print_values(tmpRGBC, NUM_SENSOR_VALUES, F_RGBC) + "\n");
            return;
        }
        // return register dmx values of active register
        else if(str.equals("RDMX?"))
        {
            pav.GetRegDmx(tmpDMX);
            print("?RDMX " + param_print_values(tmpDMX, pav.GetcolorChanels(), F_DMX) + "\n");
            return;
        }
        // send register dmx values to dmx output
        else if(str.equals("RDMX!"))
        {
            pav.GetRegDmx(tmpDMX);
            print("!RDMX " + param_print_values(tmpDMX, pav.GetcolorChanels(), F_DMX) + "\n");
            updateDmx(tmpDMX);
            return;
        }
//        else if (str.equals("REF"))
//        {
//
//        }
//        else if (str.equals("MATCH"))
//        {
//
//        }
        else
        {
            print("ERROR: invalid string: " + str + "\n");
            return;
        }
        print("ERROR: parsing string '" + str + "': " + error_msg + "\n");
    }
}

inline void initSensor()
{
    while (!csensor.begin())
    {
        print("No TCS34725 found ... check your connections\n");
        delay(1000);
    }
    print("Found sensor at I2C-Address " + String(csensor.getSensorAddress()) + "\n");
    csensor.setIntegrationTime(4.8);
}

void setup()
{
    //DO read wait for serial flag from EEPROM
    pav = ParAndVals();
    initSerial();

    print("DMXE; Version " + String(VERSION) + "\n");

    DMXSerial.init(DMXController, REDE);

    initSensor();
    //DO init expander
//    initButtons();
//    initLEDs();
    //DO init diplay
    fsm_main = FsmMain();
    //fsm_ui = FsmUi();
    print("setup done, continue to main loop\n");
}

inline void addToRGBSum()
{
    for(uint8_t i=0; i<NUM_SENSOR_VALUES; i++)
    {
        pav.sum_rgbc[i] += pav.rgbc[i];
    }
    pav.sumCount++;
}

inline void clearRGBSum()
{
    pav.sumCount = 0;
    for(uint8_t i=0; i<NUM_SENSOR_VALUES; i++)
    {
        pav.sum_rgbc[i] = 0;
    }
}

void loop()
{

    csensor.startIntegration();
    //DO read registers IO expander
//    cycleButtons();
//    cycleLEDs();

    readSerial();
    //fsm_ui.cycle();
    while(!csensor.is_integrated());
    csensor.read_data_rgbc(pav.rgbc);
    //print(param_print_values(rgbc)+"\n");
    addToRGBSum();
    //print(String(pav.sumCount) + param_print_values(pav.sum_rgbc)+"\n");

    //if(pav.sum_rgbc[3] > pav.sumThreshold || pav.sumCount >= pav.sumMaxCount){
    if(pav.sumCount < pav.sumMaxCount)
    {
        return;
    }

    fsm_main.cycle();
    print("~RGBC " + param_print_values(pav.sum_rgbc, NUM_SENSOR_VALUES, F_RGBC)+ "\n");
    clearRGBSum();

    //delay(10);
    //IF sensor reading is done
    //fsm_main.cycle();
    //DO update values in RAM/EEPROM
    //DO write DMX output
    //DO send serial monitor
}

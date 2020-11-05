//TODO algorithm to detect reaction time of dmx fixtures
//TODO set boudrate via serial and save in EEPROM

#include <Arduino.h>
#include <SPI.h>

#include <DMXSerial.h>
#include "TCS34725.h"

#include "globals.h"

#include "mainmachine.h"
#include "parandvals.h"


void(* resetFunc) (void) = 0;

MainMachine mainMachine;
ParAndVals pav;
TCS34725 csensor;

uint16_t tmpRGBC[NUM_SENSOR_VALUES];
uint8_t tmpDMX[NUM_COLOR_CHANNELS];

String tmp_dmx_str;

void print(String str)
{
    uint8_t bufferLeft = Serial.availableForWrite();
    if(str.length() < bufferLeft)
    {
        Serial.print(str);
    }
}

inline void initSerial()
{
    Serial.begin( 1000000 );
    if(pav.getWaitForSerialFlag()==true)
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
        pav.setWaitForSerialFlag(false);
    }
}

void updateDmx(uint8_t dmx[])
{
    bool dmx_changed = false;
    for(uint8_t i = 0; i<pav.getNumColorChannel(); i++)
    {
        if(DMXSerial.read(pav.getDmxAddress()+i)!=dmx[i])
        {
            DMXSerial.write(pav.getDmxAddress()+i, dmx[i]);
            dmx_changed = true;
        }
    }
    if(dmx_changed)
    {
        print("~DMX " + param_print_values(dmx, pav.getNumColorChannel(), F_DMX) + "\n");
    }
}

void readDmx(uint8_t dmx[])
{
    for(uint8_t i = 0; i<pav.getNumColorChannel(); i++)
    {
        dmx[i] = DMXSerial.read(pav.getDmxAddress()+i);
    }
}


inline void readSerial()
{
    String error_msg;
    if(Serial.available()>0)
    {
        String str = Serial.readStringUntil('\n');
        str.trim();
        if(str.equals("CANCLE") || str.equals("c"))
        {
            print("cancle\n");
            mainMachine.cmd_stop();
            return;
        }
        if(mainMachine.state() != mainMachine.IDLE)
        {
            print("device busy\n");
            return;
        }
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
            pav.setWaitForSerialFlag(true);
            return;
        }
        //set value of address
        else if(str.startsWith("DMX#"))    // TODO if address in color range also write pav
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
        //set value of channel
        else if(str.startsWith("DMX&"))  // TODO if ch in color range also write pav
        {
            // TODO check input is valid
            int8_t ch = str.substring(5,8).toInt();
            int16_t add = pav.getDmxAddress() + ch - 1;
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
            pav.resetCDmx();
            pav.resetCDmx();
            print("*DMX all channels set to 0\n");
            return;
        }
        // get current dmx output, ommiting 0 except color channels
        else if(str.startsWith("DMX?"))
        {
            print("?DMX (ADD/CH) VAL)\n");
            uint8_t dmx_lower = pav.getDmxAddress();
            uint8_t dmx_upper = dmx_lower + pav.getNumColorChannel();
            for(int add=DMX_ADD_MIN; add<=DMX_ADD_MAX; add++)
            {
                uint8_t val = DMXSerial.read(add);
                if(val>0 || (add>=dmx_lower && add<dmx_upper))
                {
                    print("  " + formatValues(add, F_DMX) + "/" + formatValues(add+dmx_lower-1, F_DMX) + SPLIT_CHAR + formatValues(val, F_VAL) + "\n");
                }
            }
            return;
        }
        // set dmx channels with cuurrent global setting (nuber of channels, start address)
        else if(str.startsWith("DMX"))
        {
            uint8_t dmx_vals[NUM_COLOR_CHANNELS];
            uint8_t arrayExitCode = array_from_string(dmx_vals, str.substring(3), 3, pav.getNumColorChannel());
            if(arrayExitCode==0)
            {
                print(">DMX " + param_print_values(dmx_vals, pav.getNumColorChannel(), F_DMX) + "\n");
                copyArray(pav.cDmx, dmx_vals, NUM_COLOR_CHANNELS);
                updateDmx(dmx_vals);
                return;
            }
            error_msg = "exit code " + String(arrayExitCode) + "parsing string: " + str;
        }
        //get number of color channels
        else if(str.startsWith("NCH?"))
        {
            print("?NCH " + formatValues(pav.getNumColorChannel(), F_CH) + "\n");
            return;
        }
        // set number of color channels
        else if(str.startsWith("NCH"))
        {
            uint8_t n_ch = str.substring(4).toInt();
            if (n_ch>0 && n_ch<=NUM_COLOR_CHANNELS)
            {
                pav.setNumColorChannels(n_ch);
                print(">NCH " + formatValues(pav.getNumColorChannel(), F_CH) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4) + "' is not a channel valid number (1-8)";
        }
        // get dmx start address
        else if(str.startsWith("ADD?"))
        {
            print("?ADD " + formatValues(pav.getDmxAddress(), F_DMX) + "\n");
            return;
        }
        // set dmx start address
        else if(str.startsWith("ADD"))
        {
            uint8_t add = str.substring(4, 7).toInt();
            if (add>=DMX_ADD_MIN && DMX_ADD_MAX<=255)
            {
                pav.setDmxAddress(add);
                print(">ADD " + formatValues(pav.getDmxAddress(), F_DMX) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4, 7) + "' is not a valid address number (001-255)";
        }
        // get active register
        else if(str.startsWith("REG?"))
        {
            print("?REG " + formatValues(pav.getActiveRegister(), F_REG) + "\n");
            return;
        }
        // set active register
        else if(str.startsWith("REG"))
        {
            uint8_t reg = str.substring(4,6).toInt();
            if(reg>0 && reg<=NUM_REGISTER)
            {
                pav.setActiveRegister(reg);
                print(">REG " + formatValues(pav.getActiveRegister(), F_REG) + "\n");
                return;
            }
            error_msg = "value '" + str.substring(4,6) + "' is not a valid register number (01-16)";
        }
        // return register rgbc values of active register
        else if(str.equals("RRGBC?"))
        {
            pav.getRegRgbc(tmpRGBC);
            print("?RRGBC " + param_print_values(tmpRGBC, NUM_SENSOR_VALUES, F_RGBC) + "\n");
            return;
        }
        // return register dmx values of active register
        else if(str.equals("RDMX?"))
        {
            pav.getRegDmx(tmpDMX);
            print("?RDMX " + param_print_values(tmpDMX, pav.getNumColorChannel(), F_DMX) + "\n");
            return;
        }
        // send register dmx values to dmx output
        else if(str.equals("RDMX!"))
        {
            pav.getRegDmx(tmpDMX);
            print("!RDMX " + param_print_values(tmpDMX, pav.getNumColorChannel(), F_DMX) + "\n");
            copyArray(pav.cDmx, tmpDMX, pav.getNumColorChannel());
            return;
        }
        else if (str.equals("REF"))
        {
            mainMachine.trigger(mainMachine.EVT_CMD_REF);
            return;
        }
        else if (str.equals("MATCH"))
        {
            mainMachine.cmd_match();
            return;
        }
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
    csensor.setIntegrationTime(48);
}

void setup()
{

    pav = ParAndVals();
    initSerial();

    print("DMXE; Version " + String(VERSION) + "\n");

    DMXSerial.init(DMXController, REDE);

    initSensor();
    mainMachine.trace( Serial );
    mainMachine.begin( &pav );

    print("setup done, continue to main loop\n");

}

void loop()
{
    csensor.startIntegration();
    // do time intensive stuff here
    readSerial();

    uint16_t rgbcReference[4];
    pav.getRegRgbc(rgbcReference);
    for (int ref_val = 0; ref_val < 3; ref_val++)
    {
        for (int var = 0; var < 3; var++)
        {
            pav.targetRelVals[ref_val][var] = relDiff(rgbcReference[var], rgbcReference[3]);
        }
    }

    readDmx(tmpDMX);
    tmp_dmx_str = param_print_values(tmpDMX, NUM_COLOR_CHANNELS, F_DMX);

    pav.last_score = pav.score;

    while(!csensor.is_integrated())
    {
        // maybe do some stuff here or just wait
    }
    csensor.read_data_rgbc(pav.rgbc);

    pav.score = pow(relDiff(pav.rgbc[0], pav.rgbc[3]) - pav.targetRelVals[1][0], 2);
    pav.score += pow(relDiff(pav.rgbc[1], pav.rgbc[3]) - pav.targetRelVals[2][1], 2);
    pav.score += pow(relDiff(pav.rgbc[2], pav.rgbc[3]) - pav.targetRelVals[0][2], 2);

    // at this point, score, dmx and rgbx are biased to the same time frame

    mainMachine.cycle();

    updateDmx(pav.cDmx);
    unsigned long waitEndTime = micros() + pav.fixtureReactionTime_us;

    // do time intensive stuff here
    print("~RGBC " + param_print_values(pav.rgbc, NUM_SENSOR_VALUES, F_RGBC)+ "\n");
    if (pav.score >= 0)  // indicates if match is running
    {
        print("~SCORE " + String(pav.score, 8) + "\n");
    }

    print("~! ");
    print(tmp_dmx_str + " ");
    print(param_print_values(pav.rgbc, NUM_SENSOR_VALUES, F_RGBC) + " ");
    print(String(pav.score, 8) + "\n");

    while (micros() < waitEndTime)
    {
        // maybe do some stuff here or just wait
    }
}

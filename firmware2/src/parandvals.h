#ifndef PAR_AND_VALS_H
#define PAR_AND_VALS_H

#include <EEPROM.h>
#include <stdint.h>

#include "globals.h"
/*EEPROM structure
* 000-030: see conatnts
* 031-255: saves for rgbc (8B) and dmx values (6B)
*/

template <typename T>
void copyArray(T to[], T from[], uint8_t size_of_to)
{
    for(uint8_t i=0; i<size_of_to; i++)
    {
        to[i] = from[i];
    }
}

template <typename T>
void writeToEeprom(T a, uint8_t size, uint8_t add)
{
    uint8_t sizeData = sizeof(a);
    for(int i=0; i<size; i++)
    {
        EEPROM.put(add + i*sizeData, a[i]);
    }
}

template <typename T>
void readFromEeprom(T a, uint8_t size, uint8_t add)
{
    uint8_t sizeData = sizeof(a);
    for(int i=0; i<size; i++)
    {
        EEPROM.get(add + i*sizeData, a[i]);
    }
}

const uint8_t ADD_COLOR_CHANELS = 0;
const uint8_t ADD_START_ADDRESS = 1;
const uint8_t ADD_REF_REGISTER = 2;
const uint8_t ADD_WAIT_FOR_SERIAL = 3;
const uint8_t ADD_START_VALUES = 31;

//TODO insert value changed mechanic

class ParAndVals
{
public:

    ParAndVals();
    //ParAndVals(void *print);

    // parameters (wriiten to EPPROM)
    uint8_t GetcolorChanels()
    {
        return colorChanels;
    }
    void SetcolorChanels(uint8_t val)
    {
        colorChanels = val;
        EEPROM.update(ADD_COLOR_CHANELS, colorChanels);
//        print("#CCH " + formatValues(colorChanels, F_CH) + "\n");
    }
    uint8_t GetstartAddress()
    {
        return startAddress;
    }
    void SetstartAddress(uint8_t val)
    {
        startAddress = val;
        EEPROM.update(ADD_START_ADDRESS, startAddress);
//        print("#ADD " + formatValues(startAddress, F_DMX) + "\n");
    }
    bool GetWaitForSerialFlag()
    {
        return (bool) EEPROM.read(ADD_WAIT_FOR_SERIAL);
    }
    void SetWaitForSerialFlag(bool val)
    {
        waitForSerialFlag = val;
        EEPROM.update(ADD_WAIT_FOR_SERIAL, (uint8_t) waitForSerialFlag);
//        print("#WFS " + String(waitForSerialFlag) + "\n");
    }

    uint8_t GetActiveRegister()
    {
        return activeRegister;
    }
    void SetActiveRegister(uint8_t val)
    {
        activeRegister = val;
        EEPROM.update(ADD_REF_REGISTER, activeRegister);
//        print("#REG " + formatValues(activeRegister, F_REG));
    }

    // directly saved in EEPROM ass they are no accessed very frequently
    void GetRegRgbc(uint16_t rgbc[])
    {
        readFromEeprom(rgbc, 4, activeRegister*14+ADD_START_VALUES);
    }
    void SetRegRgbc(uint16_t rgbc[])
    {
        writeToEeprom(rgbc, 4, activeRegister*14+ADD_START_VALUES);
    }
    void GetRegDmx(uint8_t dmx[])
    {
        readFromEeprom(dmx, 6, activeRegister*14+8+ADD_START_VALUES);
    }
    void SetRegDmx(uint8_t dmx[])
    {
        writeToEeprom(dmx, 6, activeRegister*14+8+ADD_START_VALUES);
    }

    uint8_t matchDmx[6][6];
    float matchScore[6];

    uint16_t sumThreshold = 1000;
    uint8_t sumMaxCount = 5;
    uint8_t sumCount;
    uint8_t dmx[4];
    uint16_t rgbc[4];
    uint16_t sum_rgbc[4];

protected:
    uint8_t colorChanels;
    uint8_t startAddress;
    bool waitForSerialFlag;

    uint8_t intensity;
    uint8_t score;

    uint8_t activeRegister;

private:
};

#endif // PAR_AND_VALS_H

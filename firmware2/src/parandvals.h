#ifndef PAR_AND_VALS_H
#define PAR_AND_VALS_H

#include <EEPROM.h>
#include <stdint.h>

#include "globals.h"
#include "Arduino.h"

//TODO insert value changed mechanic

class ParAndVals
{
public:

    ParAndVals();

// parameters stored im RAM and saved in EPPROM
    uint8_t getNumColorChannel()
    {
        return numColorChannels;
    }
    void setNumColorChannels(uint8_t val)
    {
        numColorChannels = val;
        EEPROM.update(ADD_NUM_COLOR_CHANNELS, numColorChannels);
//        print("#CCH " + formatValues(numColorChannels, F_CH) + "\n");
    }
    uint8_t getDmxAddress()
    {
        return dmxAddress;
    }
    void setDmxAddress(uint8_t val)
    {
        dmxAddress = val;
        EEPROM.update(ADD_DMX_ADDRESS, dmxAddress);
//        print("#ADD " + formatValues(dmxAddress, F_DMX) + "\n");
    }
    uint8_t getActiveRegister()
    {
        return activeRegister;
    }
    void setActiveRegister(uint8_t val)
    {
        activeRegister = val;
        EEPROM.update(ADD_CURRENT_REGISTER, activeRegister);
        //TODO add her ref val calculation
//        print("#REG " + formatValues(activeRegister, F_REG));
    }

// directly saved in EEPROM as they are no accessed very frequently
    bool getWaitForSerialFlag()
    {
        return (bool) EEPROM.read(ADD_WAIT_FOR_SERIAL);
    }
    void setWaitForSerialFlag(bool val)
    {
        EEPROM.update(ADD_WAIT_FOR_SERIAL, (uint8_t) val);
//        print("#WFS " + String(waitForSerialFlag) + "\n");
    }
    void getRegRgbc(uint16_t rgbc[])
    {
        readFromEeprom(rgbc, NUM_SENSOR_VALUES, getRegisterAddress(OFFSET_COLOR_CHANNELS));
    }
    void setRegRgbc(uint16_t rgbc[])
    {
        writeToEeprom(rgbc, NUM_SENSOR_VALUES, getRegisterAddress(OFFSET_COLOR_CHANNELS));
    }
    void getRegDmx(uint8_t dmx[])
    {
        readFromEeprom(dmx, NUM_COLOR_CHANNELS, getRegisterAddress(OFFSET_SENSOR_VALUES));
    }
    void setRegDmx(uint8_t dmx[])
    {
        writeToEeprom(dmx, NUM_COLOR_CHANNELS, getRegisterAddress(OFFSET_SENSOR_VALUES));
    }

    void resetMatchArrays();
    uint8_t matchDmx[NUM_COLOR_CHANNELS][NUM_COLOR_CHANNELS];
    float matchScore[NUM_COLOR_CHANNELS];

    void resetCDmx();
    uint8_t cDmx[NUM_COLOR_CHANNELS];

    uint32_t fixtureReactionTime_us;
    uint16_t rgbc[NUM_SENSOR_VALUES];
    uint8_t intensity;
    float score;
    float last_score;
    float targetRelVals[3][3] = { };  // target values for match

protected:
    uint8_t numColorChannels;
    uint8_t dmxAddress;
    uint8_t activeRegister;
    bool waitForSerialFlag;

private:
    inline uint8_t getRegisterAddress(uint8_t offset){
//        Serial.print("active register: ");
//        Serial.print(activeRegister);
//        Serial.print("/");
//        Serial.print(getActiveRegister());
//        Serial.print(" eeprom address: ");
//        Serial.println(ADD_FIRST_REGISTER+(activeRegister-1)*BYTES_PER_REGISTER+offset);
        return ADD_FIRST_REGISTER+(activeRegister-1)*BYTES_PER_REGISTER+offset;
    }
};

#endif // PAR_AND_VALS_H

#include "parandvals.h"

ParAndVals::ParAndVals()
{
    numColorChannels = EEPROM.read(ADD_NUM_COLOR_CHANNELS);
    dmxAddress = EEPROM.read(ADD_DMX_ADDRESS);
    activeRegister = EEPROM.read(ADD_CURRENT_REGISTER);
    waitForSerialFlag = (bool) EEPROM.read(ADD_WAIT_FOR_SERIAL);
    fixtureReactionTime_us = 100000;
    score = -1;
    resetCDmx();
}

void ParAndVals::resetMatchArrays(){
        memset(matchDmx, 0, NUM_COLOR_CHANNELS*NUM_COLOR_CHANNELS);
        memset(matchScore, 1, NUM_COLOR_CHANNELS);
    }

void ParAndVals::resetCDmx()
{
    memset(cDmx, 0, NUM_COLOR_CHANNELS);
}

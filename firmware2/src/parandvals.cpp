#include "parandvals.h"

ParAndVals::ParAndVals()
{
    colorChanels = EEPROM.read(ADD_COLOR_CHANELS);
    startAddress = EEPROM.read(ADD_START_ADDRESS);
    refRegister = EEPROM.read(ADD_REF_REGISTER);
    waitForSerialFlag = (bool) EEPROM.read(ADD_WAIT_FOR_SERIAL);
}

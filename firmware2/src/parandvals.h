#ifndef PAR_AND_VALS_H
#define PAR_AND_VALS_H

#include <EEPROM.h>
#include <stdint.h>

const uint8_t ADD_COLOR_CHANELS = 0;
const uint8_t ADD_START_ADDRESS = 1;
const uint8_t ADD_REF_REGISTER = 2;
const uint8_t ADD_WAIT_FOR_SERIAL = 3;

//TODO insert value changed mechanic

class ParAndVals
{
    public:
        ParAndVals();

        // parameters (wriiten to EPPROM)
        uint8_t GetcolorChanels() { return colorChanels; }
        void SetcolorChanels(uint8_t val) {
            colorChanels = val;
            EEPROM.update(ADD_COLOR_CHANELS, colorChanels);
        }
        uint8_t GetstartAddress() { return startAddress; }
        void SetstartAddress(uint8_t val) {
            startAddress = val;
            EEPROM.update(ADD_START_ADDRESS, startAddress);
        }
        uint8_t GetrefRegister() { return refRegister; }
        void SetrefRegister(uint8_t val) {
            refRegister = val;
            EEPROM.update(ADD_REF_REGISTER, refRegister);
        }
        uint8_t GetWaitForSerialFlag() { return waitForSerialFlag; }
        void SetWaitForSerialFlag(uint8_t val) {
            waitForSerialFlag = val;
            EEPROM.update(ADD_WAIT_FOR_SERIAL, waitForSerialFlag);
        }

        // values (only in RAM)
        uint8_t Getintensity() { return intensity; }
        void Setintensity(uint8_t val) { intensity = val; }
        uint8_t Getscore() { return score; }
        void Setscore(uint8_t val) { score = val; }

    protected:
        uint8_t colorChanels;
        uint8_t startAddress;
        uint8_t refRegister;
        bool waitForSerialFlag;

        uint8_t intensity;
        uint8_t score;

    private:
};

#endif // PAR_AND_VALS_H

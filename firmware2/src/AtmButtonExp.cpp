#include "AtmButtonExp.h"

void AtmButtonExp::pinMode(uint8_t pin, PinMode mode){
    if(pin<pinOffset){
        pinMode(pin, mode);
    }else{
        //do nothing
    }
}

PinStatus AtmButtonExp::digitalRead(uint8_t pin){
    if(pin<pinOffset){
        return digitalRead(pin);
    }else{
        uint8_t posBit = (pin-pinOffset)%8;
        uint8_t posByte = pin%8;
        return GetBit(bytes[posByte], posBit);
    }
}

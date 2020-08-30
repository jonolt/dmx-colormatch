#ifndef ATM_BUTTON_EXP_H
#define ATM_BUTTON_EXP_H

#include "Automaton.h"

#define GetBit(data,y)    ( (data>>y) & 1)    /** Return Data.Y value   **/
#define SetBit(data,y)    data |= (1 << y)    /** Set Data.Y   to 1    **/
#define ClearBit(data,y)  data &= ~(1 << y)   /** Clear Data.Y to 0    **/

static const uint8_t EA0 = 100;
static const uint8_t EA1 = 101;
static const uint8_t EA2 = 102;
static const uint8_t EA3 = 103;
static const uint8_t EA4 = 104;
static const uint8_t EA5 = 105;
static const uint8_t EA6 = 106;
static const uint8_t EA7 = 107;

static const uint8_t EB0 = 108;
static const uint8_t EB1 = 109;
static const uint8_t EB2 = 110;
static const uint8_t EB3 = 111;
static const uint8_t EB4 = 112;
static const uint8_t EB5 = 113;
static const uint8_t EB6 = 114;
static const uint8_t EB7 = 115;

class Atm_button_exp : Atm_button
{

public:
    uint8_t pinOffset = 100;
    uint8_t bytes[2];
    void pinMode(uint8_t pin, PinMode mode);
    PinStatus digitalReadCustom(uint8_t pin);
};

#endif // ATM_BUTTON_EXP_H

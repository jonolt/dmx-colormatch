#include <Arduino.h>
#include <SPI.h>

#include "fsmmain.h"
#include "parandvals.h"

#include "fsmui.h"
#include "AtmButtonExp.h"


FsmMain fsm_main;
FsmUi fsm_ui;
ParAndVals parAndVals;
bool waitForSerialFlag;

void setup(){
    //DO read wait for serial flag from EEPROM
    parAndVals = ParAndVals();
    Serial.begin( 9600 );
    if(parAndVals.GetWaitForSerialFlag()){
        while(Serial.available() == 0);
    }
    //init expander
    //DO init diplay
    fsm_main = FsmMain();
    fsm_ui = FsmUi();
}

void loop(){
    //DO read sensor
    //DO read registers IO expander
    //DO read serial
    fsm_ui.cycle();
    //IF sensor reading is done
    fsm_main.cycle();
    //DO update values in RAM/EEPROM
    //DO write DMX output
    //DO send serial monitor
}

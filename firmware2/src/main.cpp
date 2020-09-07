#include <Arduino.h>
#include <SPI.h>

#include <DMXSerial.h>
#include "TCS34725.h"

#include "fsmmain.h"
#include "parandvals.h"

#include "fsmui.h"
#include "AtmButtonExp.h"

#define REDE 4

void(* resetFunc) (void) = 0;

FsmMain fsm_main;
FsmUi fsm_ui;
ParAndVals parAndVals;
TCS34725 csensor;
bool serialAvailable = false;
uint8_t serialBytesDroped = 0;

uint16_t rgbc[4];
uint16_t sum_rgbc[4];


String param_print_values(uint16_t rgbc[]) {
  char buff[32];
  String str_print;
  for (int i = 0; i < 4; i++) {
    sprintf(buff, ", %05d", rgbc[i]);
    str_print += buff;
  }
  return str_print;
}

void print(String str){
    if(serialAvailable){
        uint8_t bufferLeft = Serial.availableForWrite();
        if(str.length() < bufferLeft){
            Serial.print(str);
        }else{
            serialBytesDroped = str.length();
        }
    }
}


void setup(){
    //DO read wait for serial flag from EEPROM
    parAndVals = ParAndVals();
    Serial.begin( 9600 );
    if(parAndVals.GetWaitForSerialFlag()==true){
        //check if SDA and SCL a shortened, if yeas act as waitForSerialFlag is clear
        print("waiting for any serial input to start\n");
        while(Serial.available() == 0);
        serialAvailable = true;
        print("WaitForSerialFlag cleared\n");
        parAndVals.SetWaitForSerialFlag(false);
    }
    DMXSerial.init(DMXController, REDE);
    csensor.begin();
    csensor.setIntegrationTime(4.8);
        //init expander
    //DO init diplay
    fsm_main = FsmMain();
    //fsm_ui = FsmUi();

    DMXSerial.write(1, 255);
    print("\n\n##### setup done, going to main loop #####\n\n");
}

void loop(){
    //DO read sensor
    csensor.startIntegration();
    //DO read registers IO expander
    //DO read serial
    if(Serial.available()>0){
        serialAvailable=true;
        String str = Serial.readStringUntil('\n');
        if(str=="reset"){
            resetFunc();
        }else if(str=="wait for serial, please" || str=="wfs"){
            print("WaitForSerialFlag set\n");
            parAndVals.SetWaitForSerialFlag(true);
        }
        DMXSerial.write(1, random(256));
        DMXSerial.write(2, random(256));
        DMXSerial.write(3, random(256));
    }
    //fsm_ui.cycle();
    while(!csensor.is_integrated());
    csensor.read_data_rgbc(rgbc);
    print(param_print_values(rgbc)+"\n");
    delay(100);
    //IF sensor reading is done
    //fsm_main.cycle();
    //DO update values in RAM/EEPROM
    //DO write DMX output
    //DO send serial monitor
}

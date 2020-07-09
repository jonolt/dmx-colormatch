#include <Arduino.h>
#include <DMXSerial.h>

#include "fsm.h"

#include "TCS34725.h"

#define SERIAL_TERMINATOR '\n'  // TODO move to global

#define TCS_INTEGRATION_TIME 48
#define TCS_HEADROOM .3

Fsm fsm;
TCS34725 tcs = TCS34725();

enum mode_t {
  MODE_SERIAL,
  MODE_SINGLE,
};

enum mode_t mode;

//extern uint8_t param_chnanels;

void setState(int state) {
  Serial.print("Set State: ");
  Serial.println(state);  
  fsm.trigger(state);
  // Serial.print("/");
  // Serial.println(fsm.state());  
}

void setup() {
  mode=MODE_SERIAL;
  Serial.begin( 9600 );
  DMXSerial.init(DMXController, 4);
  if (tcs.begin(0x29)) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
  }
  tcs.setIntegrationTime(TCS_INTEGRATION_TIME);
  Serial.println("Board Started");
  fsm.begin();
}

void loop() {
  if(Serial.available()){
    String str = Serial.readStringUntil(SERIAL_TERMINATOR);
    Serial.print("recived: ");
    Serial.print(str);
    Serial.print(" ->");
    if (fsm.state() == fsm.IDLE) {
      if (str == "ref") {
        setState(fsm.REFERENCE);
      } else if (str == "match") {
        setState(fsm.MATCH);
      } else if (str == "param") {
        if (mode == MODE_SERIAL) {
          setState(fsm.PARAM);
        } else{
          Serial.print("--> mode not supported in standalone");
        }
      } else {
        Serial.println(" --> str not recognized");
      }
    } else if (str == "cancle" || str == "c") {
      Serial.println(" --> current action cancled");
      setState(fsm.IDLE);
    } else if (fsm.state() == fsm.PARAM) {
        param_read_serial(str);
    } else {
      Serial.print("Device busy. Current state is '");
      Serial.print(fsm.state());
      Serial.println("'.");
    }
  }
  //fsm.trace(Serial);
  fsm.cycle();
}

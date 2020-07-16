#include <Arduino.h>
#include <DMXSerial.h>

#include "fsm.h"

#include "TCS34725.h"

#define SERIAL_TERMINATOR '\n'  // TODO move to global

#define TCS_INTEGRATION_TIME 48
#define TCS_HEADROOM .3

Fsm fsm;
TCS34725 tcs = TCS34725();
uint8_t dmx_ch_count = 3;
uint8_t dmx_start_address = 1;

enum mode_t {
  MODE_SERIAL,
  MODE_SINGLE,
};

enum mode_t mode;

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
        Serial.println("ack");
        fsm.trigger(fsm.CMD_REF);
      } else if (str == "match") {
        Serial.println("ack");
        fsm.trigger(fsm.CMD_MATCH);
      } else if (str == "param") {
        if (mode == MODE_SERIAL) {
          Serial.println("ack");
          fsm.trigger(fsm.CMD_PARAM);
        } else{
          Serial.print("--> mode not supported in standalone");
        }
      } else if (str.startsWith("dmx_ch")) {
        uint8_t num = (uint8_t) extract_int(str, dmx_ch_count);
        if(num < 10){
          dmx_ch_count = num;
          Serial.println("ack");
        }else{
          Serial.println("nack");
        }
      } else if (str.startsWith("dmx_add")) {
        uint16_t num = (uint16_t) extract_int(str, dmx_ch_count);
        if(num < 255 && num > 0){
          dmx_start_address = num;
          Serial.println("ack");
        }else{
          Serial.println("nack");
        }
      } else {
        Serial.println(" --> str not recognized");
      }
    } else if (str == "cancle" || str == "c") {
      Serial.println("ack");
      Serial.println(" --> current action cancled");
      fsm.trigger(fsm.CMD_STOP);
    } else if (fsm.state() == fsm.PARAM) {
        if(param_read_serial(str)){
          Serial.println("ack");
        }
    } else {
      Serial.print("Device busy. Current state is '");
      Serial.print(fsm.state());
      Serial.println("'.");
    }
  }
  fsm.trace(Serial);
  fsm.cycle();
}

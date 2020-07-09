#include "fsm.h"
#include "util.h"

void setup_setup() {
  Serial.println("setup_setup");
  tcs.setGain(TCS34725_GAIN_1X);
  write_dmx_all_on();
  delay(2000);
}

void setup_run() {
  Serial.println("setup_run");
  write_dmx_all_off();
  setState(statePrev);
}
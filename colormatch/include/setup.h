# include "fsm.h"

void setup_setup() {
  Serial.println("setup_setup");
  setState(statePrev);
}

void setup_run() {
  Serial.println("setup_run");
  // do nothing
}
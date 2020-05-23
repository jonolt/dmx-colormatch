# include "fsm.h"

void reference_setup() {
  Serial.println("reference_setup");
}

void reference_run() {
  Serial.println("reference_run");
  setState(WAITING);
}
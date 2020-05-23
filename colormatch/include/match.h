# include "fsm.h"

void match_setup() {
  Serial.println("colormatch_setup");
}

void match_run() {
  Serial.println("colormatch_run");
  setState(WAITING);
}
# include "fsm.h"

void parametrize_setup() {
  Serial.println("parametrize_setup");
}

void parametrize_run() {
  Serial.println("parametrize_run");
  setState(WAITING);
}

#include <Arduino.h>
#include "fsm.h"
#include "setup.h"
#include "referecnce.h"
#include "match.h"
#include "parametrize.h"

#define DEBUG true

// PIN ASIGNEMENTS
#define PIN_MODE_SELECTION 10

// VARIABLES
#define SERIAL_BAUDRATE 9600
#define SERIAL_TERMINATOR '\n'

void setup() {
  //read mode
  pinMode(PIN_MODE_SELECTION, INPUT_PULLUP);
  if (digitalRead(PIN_MODE_SELECTION)) {
    mode = MODE_SERIAL;
  } else {
    mode = MODE_SINGLE;
  }

  //setup
  setState(WAITING);
  if (mode == MODE_SERIAL || mode == DEBUG) {
    Serial.begin(SERIAL_BAUDRATE);
    Serial.println("Serial Initialized");
  }

}

void loop() {

  if (Serial.available() > 0) {
    String str = Serial.readStringUntil(SERIAL_TERMINATOR);
    if (stateCur == WAITING) {
      if (str == "ref") {
        setState(REFERENCE);
      } else if (str == "match") {
        setState(COLORMATCH);
      } else if (str == "param") {
        if (mode == MODE_SERIAL) {
          setState(PARAMETRIZE);
        }
      } else if (str == "setup") {
        setState(SETUP);
      } else {
        Serial.print(str);
        Serial.println(" --> str not recognized");
      }
    } else if (str == "cancle") {
      setState(WAITING);
    } else {
      Serial.print("Device busy. Current state is '");
      Serial.print(stateCur);
      Serial.println("'.");
    }
  }

  switch (stateCur) {
    case WAITING:
      break;
    case REFERENCE:
      if (statePrev == WAITING) {
        setState(SETUP);
      } else {
        runner(&reference_setup, &reference_run);
      }
      break;
    case COLORMATCH:
      if (statePrev == WAITING) {
        setState(SETUP);
      } else {
        runner(&match_setup, &match_run);
      }
      break;
    case PARAMETRIZE:
      runner(&parametrize_setup, &parametrize_run);
      break;
    case SETUP:
      runner(&setup_setup, &setup_run);
      break;
  }  // switch (stateCur)
}  // loop

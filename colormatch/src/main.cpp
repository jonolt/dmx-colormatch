#include <Arduino.h>
#include <DMXSerial.h>

#include "TCS34725.h"
#include "fsm.h"
#include "setup.h"
#include "referecnce.h"
#include "match.h"
#include "parametrize.h"


#define DEBUG true

// PIN ASIGNEMENTS
#define PIN_MODE_SELECTION 10
#define PIN_LED 13

// DEFINES
#define SERIAL_BAUDRATE 9600
#define SERIAL_TERMINATOR '\n'

#define TCS_INTEGRATION_TIME 48
#define TCS_HEADROOM .3

#define DMX_MAX 255
#define DMX_MIN 0
#define DMX_STEPS 10

// FUNCTIONS
void print_values();

// VARIABLES
enum mode_t mode;
enum state_t stateCur;
enum state_t statePrev;

TCS34725 tcs;
uint16_t r, g, b, c = 0;
float r_n, g_n, b_n, c_n = 0;
float integration_time;
uint8_t dmx_cur[] = {0, 0, 0}; //TODO alocate a max of 7 channels
uint8_t dmx_old[] = {0, 0, 0};
uint8_t dmxIncStep = DMX_STEPS;

void setup() {

  //read mode
  pinMode(PIN_MODE_SELECTION, INPUT_PULLUP);
  if (digitalRead(PIN_MODE_SELECTION)) {
    mode = MODE_SERIAL;
  } else {
    mode = MODE_SINGLE;
  }

  setState(WAITING);
  if (mode == MODE_SERIAL || mode == DEBUG) {
    pinMode(PIN_LED, OUTPUT);
    digitalWrite(PIN_LED, HIGH);
    while(!Serial);
    Serial.begin(SERIAL_BAUDRATE);
    Serial.println("Serial Initialized");
  } 

  tcs = TCS34725();
  if (tcs.begin(0x29)) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
  }
  tcs.setIntegrationTime(TCS_INTEGRATION_TIME);

  DMXSerial.init(DMXController, 4);
  DMXSerial.write(2, 50);

}

void loop() {

  delay(100);
  DMXSerial.write(4, 255);

  if (Serial.available() > 0) {
    String str = Serial.readStringUntil(SERIAL_TERMINATOR);
    Serial.print("recived: ");
    Serial.println(str);
    if (stateCur == WAITING) {
      if (str == "ref") {
        setState(REFERENCE);
      } else if (str == "match") {
        setState(COLORMATCH);
      } else if (str == "param") {
        if (mode == MODE_SERIAL) {
          setState(PARAMETRIZE);
        }
      } else if (str == "calibrate") {
        setState(CALIBRATE);
      } else {
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
      DMXSerial.write(2, 50);
      DMXSerial.write(3, 50);
      break;
    case REFERENCE:
      write_dmx_all_off();
      DMXSerial.write(1, 255);
      delay(1000);
      setState(WAITING);
      break;
    case COLORMATCH:
      write_dmx_all_off();
      DMXSerial.write(2, 255);
      delay(1000);
      setState(WAITING);
      break;
    case PARAMETRIZE:
      //DMXSerial.write(3, 255);
      //delay(1000);
      runner(&parametrize_setup, &parametrize_run);
      break;
    case CALIBRATE:
      write_dmx_all_on();
      delay(1000);
      setState(WAITING);
      break;
    case DMXMASTER:
      write_dmx_all_off();
      delay(1000);
      setState(WAITING);
      break;
  }  // switch (stateCur)
}  // loop


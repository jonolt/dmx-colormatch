#ifndef _COLORMATCH_UTIL_H_
#define _COLORMATCH_UTIL_H_

#include <DMXSerial.h>

#define LOOPS 100  // legacy for testing

extern uint16_t r, g, b, c;
extern float r_n, g_n, b_n, c_n;
extern float integration_time;
extern TCS34725 tcs;
extern uint8_t dmx_cur[];
extern uint8_t dmx_old[];

uint8_t _hold_count = 0;



void print_values() {
  char logString[128];
  //sprintf(logString, "%4d,  %08ld, %08ld, %08ld, %08ld, %03d, %03d, %03d", (int)(integration_time*100), (uint32_t)(r_n*100), (uint32_t)(g_n*100), (uint32_t)(b_n*100), (uint32_t)(c_n*100), dmx_old[0]*100, dmx_old[1]*100, dmx_old[2]*100);
  sprintf(logString, "%08ld, %08ld, %08ld, %08ld, %03d, %03d, %03d", (uint32_t)(r_n/g_n*100), (uint32_t)(g_n/b_n*100), (uint32_t)(b_n/r_n*100), (uint32_t)(c_n*1), dmx_old[0], dmx_old[1], dmx_old[2]);
 
  Serial.println(logString);
}

void write_dmx(uint8_t values[3]) {
  DMXSerial.write(1, values[0]);
  DMXSerial.write(2, values[1]);
  DMXSerial.write(3, values[2]);
}

void write_dmx_all_on(){
    DMXSerial.write(1, 255);
    DMXSerial.write(2, 255);
    DMXSerial.write(3, 255);
}

void write_dmx_all_off(){
    DMXSerial.write(1, 0);
    DMXSerial.write(2, 0);
    DMXSerial.write(3, 0); 
    DMXSerial.write(4, 0);
}

void increase_dmx_value(uint8_t index, uint8_t inc_step) {
  uint16_t val = dmx_cur[index];
  val = val + inc_step;
  if (val > (uint16_t)255 && val < (uint16_t)255 + inc_step) {
    val = 255;
  }
  if (val == (uint16_t)255 + inc_step) {
    val = 0;
  }
  if (val > 255) {
    val = 0;
  }
  _hold_count = LOOPS;
  dmx_cur[index] = val;
}

bool increase_dmx_values(uint8_t inc_step) {
  if (_hold_count == 0) {
    increase_dmx_value(2, inc_step);
    if (dmx_cur[2] == 0) {
      increase_dmx_value(1, inc_step);
      if (dmx_cur[1] == 0) {
        increase_dmx_value(0, inc_step);
        if (dmx_cur[0] == 0){
          Serial.println("finished");
          return false;
        }
      }
    }
  } else {
    _hold_count--;
  }
  return true;
}

#endif
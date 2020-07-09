#include "fsm.h"
#include "TCS34725.h"
#include "util.h"

extern uint16_t r, g, b, c;
extern float r_n, g_n, b_n, c_n;
extern float integration_time;
extern TCS34725 tcs;
extern uint8_t dmx_cur[];
extern uint8_t dmx_old[];
extern uint8_t dmxIncStep;

void parametrize_setup() {
  Serial.println("parametrize_setup");
  dmx_cur[0]=100;
  dmx_cur[1]=100;
  write_dmx_all_off();
}

void parametrize_run2() {
  Serial.println("parametrize_run");
  setState(WAITING);
}

void parametrize_run() {
  tcs.startIntegration();
  //do computing send old values from previous loop
  print_values();
  dmx_old[0] = dmx_cur[0];
  dmx_old[1] = dmx_cur[1];
  dmx_old[2] = dmx_cur[2];
  //increase_dmx_value(3, DMX_STEPS);
  if(!increase_dmx_values(dmxIncStep)){
    setState(WAITING);
    return;
  }
  //wait until integration is finished
  while (!tcs.is_integrated());
  integration_time = tcs.integrate_2_min_norm(1024, &r_n, &g_n, &b_n, &c_n);
  // Serial.print(" > ");
  // Serial.print(dmx_old[0]);
  // Serial.print("/");
  // Serial.print(dmx_old[1]);
  // Serial.print("/");
  // Serial.println(dmx_old[2]);
  //write dmx new (use the time of serial out)
  write_dmx(dmx_cur);
  delay(10);
}

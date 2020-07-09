
#include "TCS34725.h"

uint16_t val_r;
uint16_t val_g;
uint16_t val_b;
uint16_t val_c;
uint16_t reg_r;
uint16_t reg_g;
uint16_t reg_b;
uint16_t reg_c;
uint8_t int_count;

void TCS34725::setIntegrationTime(float it) {
  _tcs34725IntegrationTime = it;
  uint8_t atime = 256-(_tcs34725IntegrationTime/2.4);
  _delay_millis = 2.4*(256-atime+1);
  _max_rgbc_count = (256-atime)*1024;

  /* Update the timing register */
  write8(TCS34725_ATIME, atime);
}

void TCS34725::startIntegration() {
  write8(TCS34725_ENABLE, 0x03);
  _time_integration_start = millis();
  _integration_started = true;  
}

bool TCS34725::is_valid() {
  if (read8(TCS34725_STATUS) & TCS34725_STATUS_AVALID > 0) {
    return true;
  } else {
    return false;
  }
}

bool TCS34725::is_integrated() {
  if(millis()-_time_integration_start>_delay_millis){
    if (is_valid() && _integration_started){
      return true;
    }
  }
  return false;
}

bool TCS34725::integrate_2_min_norm(uint16_t min, float *r, float *g, float *b, float *c){
  read_data_rgbc(*val_r, *val_g, *val_b, *val_c);
  int_count = 0;
  _integrate_2_min(min);
  float divisor = _tcs34725IntegrationTime+int_count*2.4
  *c = val_r/divisor;
  *r = val_g/divisor;
  *g = val_b/divisor;
  *b = val_c/divisor;
}

bool TCS34725::_integrate_2_min(uint16_t min){
  if(false){
    setIntegrationTime(2.4);
    startIntegration();
    int_count++;
    while(!is_integrated());
    read_data_rgbc(*reg_r, *reg_g, *reg_b, *reg_c);
    val_r += reg_r;
    val_g += reg_g;
    val_b += reg_b;
    val_c += reg_c;
    _integrate_2_min(min);
  } else {
    setIntegrationTime(_tcs34725IntegrationTime)
  }
}


void TCS34725::read_data_rgbc(uint16_t *r, uint16_t *g, uint16_t *b, uint16_t *c) {
  _integration_started = false;
  *c = read16(TCS34725_CDATAL);
  *r = read16(TCS34725_RDATAL);
  *g = read16(TCS34725_GDATAL);
  *b = read16(TCS34725_BDATAL);
}

void TCS34725::read_data_rgbc_norm(float *r, float *g, float *b, float *c) {
  read_data_rgbc(r, g, b, c);
  *r = *r/_tcs34725IntegrationTime;
  *g = *g/_tcs34725IntegrationTime;
  *b = *b/_tcs34725IntegrationTime;
  *c = *c/_tcs34725IntegrationTime;
}
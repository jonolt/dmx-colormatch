
#include "fsm.h"

Fsm & Fsm::begin() {

    const static state_t state_table[] PROGMEM = {
    /*                   ON_ENTER    ON_LOOP    ON_EXIT  CMD_STOP   CMD_PARAM   ELSE */
    /* IDLE      */      ENT_IDLE,        -1,        -1,        -1,    PARAM,    -1,
    /* PARAM     */     ENT_PARAM,LOOP_PARAM,EXIT_PARAM,      IDLE,       -1,    -1,
    /* MASTER    */            -1,        -1,        -1,      IDLE,       -1,    -1,
    /* REFERENCE */            -1,        -1,        -1,      IDLE,       -1,    -1,
    /* MATCH     */            -1,        -1,        -1,      IDLE,       -1,    -1,
    };

    Machine::begin( state_table, ELSE );
    timer.set(5000);
    return *this;
}

int Fsm::event( int id ) {
  // switch (id)
  // {
  //   case CMD_STOP:
  //     Serial.println("CMD_STOP");
  //     return 1;
  //   case CMD_PARAM:
  //     Serial.println("CMD_PARAM");
  //     return 1;
  // }
  return 0;
}

void Fsm::action( int id ) {
  if(id!=ENT_IDLE){
    digitalWrite( LED_BUILTIN, HIGH );
  }
  switch ( id ) {
    case ENT_IDLE:
  	  digitalWrite( LED_BUILTIN, LOW );
  	  return;
    case ENT_PARAM:
      param_enter();
      return;  // wait for serial and start command containing number of channels
    case LOOP_PARAM:
      if(!param_loop()){
        Fsm::trigger(Fsm::CMD_STOP);
      }
  	  return;
    case EXIT_PARAM:
      param_exit();
  	  return;
    }
}

// Fsm & Fsm::trace( Stream & stream ) {
//   Machine::setTrace( &stream, atm_serial_debug::trace,
//     "FSM\0CMD_STOP\0CMD_PARAM\0ELSE\0IDLE\0PARAM\0MASTER\0REFERENCE\0MATCH");
//   return *this;
// }

#define DMX_HOLD_COUNT 0

uint8_t param_chnanels = 4;
uint8_t param_dmx_step = 10;
uint8_t param_hold_count = 0;


extern TCS34725 tcs;
//uint8_t dmx_r, dmx_g, dmx_b = 0;
uint8_t dmx_cur[10] = { };  // init all to zero
uint8_t dmx_old[10] = { };  // init all to zero
uint16_t r, g, b, c = 0;
//uint8_t dmx_cur[] = {0, 0, 0};
//uint8_t dmx_old[] = {0, 0, 0};
uint8_t hold_counter = 0;
bool wait_for_start = true;
bool finished = false;

void param_enter(){
    Serial.println("PARAM_ENTER");
    write_dmx_on();
    dmx_cur[10] = { };  // init all to zero
    dmx_old[10] = { };  // init all to zero
    hold_counter = 0;
    wait_for_start = true;
    finished = false;
    return;
}

bool param_loop(){

  if (wait_for_start){
    return true;
  }

  tcs.startIntegration();
  //do computing send old values from previous loop
  print_values();
  for(int i = 0; i<param_chnanels; i++){
    dmx_old[i] = dmx_cur[i];
  }
  //increase_dmx_value(3, DMX_STEPS);
  increase_dmx_values(param_dmx_step);
  //wait until integration is finished
  while (!tcs.is_integrated());
  //write dmx new (use the time of serial out)
  write_dmx(dmx_cur);
  tcs.read_data_rgbc(&r, &g, &b, &c);
  delay(2);

  if(finished){
    print_values();
    return false;
  }

  return true;

}

void param_exit(){
    Serial.println("PARAM_EXIT");
    wait_for_start = true;
    write_dmx_off();
    return;
}

void param_read_serial(String str){
    // expected String: 'start param X'
    if(str.startsWith("start")){
        wait_for_start = false;
    } else if (str.startsWith("param_chnanels")){
        param_chnanels = extract_int(str, param_chnanels);
    } else if ( str.startsWith("param_dmx_step")){
        param_dmx_step = extract_int(str, param_dmx_step);
    } else if ( str.startsWith("param_hold_count")){
        param_hold_count = extract_int(str, param_hold_count);
    }
}

uint8_t extract_int(String str, uint8_t defaultInt){
  String numString;
  bool inStartsWith = true;
  for (uint8_t i = 0; i < str.length(); i++){
    char numChar = str.charAt(i);
    if(inStartsWith){
      if(isDigit(numChar)){
        inStartsWith = false;
      } else {
        continue;
      }
    }
    if (isDigit(numChar)){
      numString += numChar;
      continue;
    }
    break;
  }
  return numString.toInt();
}

void increase_dmx_values(uint8_t inc_step) {
  if (hold_counter == 0) {
    for(int i = param_chnanels; i >= 0; i--){
      // Serial.print("Increase: ");
      // Serial.print(i);
      // Serial.print("/");
      // Serial.println(param_chnanels);
      if (dmx_cur[i] == 0){
        if(i>0){
          increase_dmx_value(i-1, inc_step);
        } else {
          finished = true;
        }
        continue;
      }
      break;
    }
  } else {
    hold_counter--;
  }
}

void increase_dmx_value(uint8_t index, uint8_t inc_step) {
  uint16_t val = dmx_cur[index];
  val = val + inc_step;
  if (val > (uint8_t)255 && val < (uint8_t)(255 + inc_step)) {
    val = 255;
  }
  if (val == (uint8_t)(255 + inc_step)) {
    val = 0;
  }
  if (val > (uint8_t)255) {
    val = 0;
  }
  hold_counter = param_hold_count;
  dmx_cur[index] = val;
}


void write_dmx(uint8_t values[3]) {
  DMXSerial.write(1, values[0]);
  DMXSerial.write(2, values[1]);
  DMXSerial.write(3, values[2]);
}

void write_dmx_on() {
  DMXSerial.write(1, 255);
  DMXSerial.write(2, 255);
  DMXSerial.write(3, 255);
}

void write_dmx_off() {
  DMXSerial.write(1, 0);
  DMXSerial.write(2, 0);
  DMXSerial.write(3, 0);
}

void print_values() {
  char buff[32];
  sprintf(buff, "%05d, %05d, %05d, %05d", r, g, b, c);
  String str_print = buff;
  for(int i = 0; i < param_chnanels; i++){
    sprintf(buff, ", %03d", dmx_old[i]);
    str_print += buff;
  }
  Serial.println(str_print);
}

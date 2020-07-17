
#include "fsm.h"

Fsm & Fsm::begin() {

    const static state_t state_table[] PROGMEM = {
    /*                    ON_ENTER      ON_LOOP      ON_EXIT   CMD_STOP   CMD_PARAM    CMD_REF  CMD_MATCH    ELSE */
    /* IDLE      */       ENT_IDLE,          -1,          -1,      IDLE,      PARAM, REFERENCE,     MATCH,     -1,
    /* PARAM     */      ENT_PARAM,  LOOP_PARAM,  EXIT_PARAM,      IDLE,         -1,        -1,        -1,     -1,
    /* REFERENCE */       ENT_REF,     LOOP_REF,    EXIT_REF,      IDLE,         -1,        -1,        -1,     -1,
    /* MATCH     */     ENT_MATCH,   LOOP_MATCH,  EXIT_MATCH,      IDLE,         -1,        -1,        -1,     -1,
    };

    Machine::begin( state_table, ELSE );
    timer.set(5000);
    return *this;
}

int Fsm::event( int id ) {
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
      if(param_loop()){
        Fsm::trigger(Fsm::CMD_STOP);
      }
  	  return;
    case EXIT_PARAM:
      param_exit();
  	  return;
    case ENT_REF:
      reference_enter();
      return;
    case LOOP_REF:
      if(reference_loop()){
        Fsm::trigger(Fsm::CMD_STOP);
      }
      return;
    case EXIT_REF:
      reference_exit();
      return;
    case ENT_MATCH:
      match_enter();
      return;
    case LOOP_MATCH:
      if(match_loop()){
        Fsm::trigger(Fsm::CMD_STOP);
      }
      return;
    case EXIT_MATCH:
      match_exit();
      return;
  }
}

Fsm & Fsm::trace( Stream & stream ) {
  Machine::setTrace( &stream, atm_serial_debug::trace,
    "FSM\0CMD_STOP\0CMD_PARAM\0CMD_REF\0CMD_MATCH\0ELSE\0IDLE\0PARAM\0REFERENCE\0MATCH");
  return *this;
}


// general

extern TCS34725 tcs;
extern uint8_t dmx_ch_count;
extern uint8_t dmx_start_address;

uint8_t dmx_cur[10] = { };  // init all to zero
uint8_t dmx_old[10] = { };  // init all to zero
uint16_t r, g, b, c = 0;
uint16_t *rgbc[] = {&r, &g, &b, &c};

// reference
int ref_eeaddr = 0;
int ref_count = 0;

uint64_t rgbc64[4] = { };
uint16_t rgbc_reference[4] = { };

// match
uint8_t index_ch;
uint8_t index_base_ch = 0;
uint8_t last_dmx;
double dif_rel;
float last_dif_rel;
uint8_t repetitions;
bool first_miss;
bool initialized;
int8_t updown;
int8_t direction = 1;

float matrix[3][3] = { };
uint8_t dmx_best[10][10] = { };
float dif_best[10] = { };

void reset_match(){
  index_ch = 0;
  repetitions = 0;
  first_miss = true;
  initialized = false;
  updown = 5;
  memset(dmx_cur, 0, sizeof(dmx_cur));
  dmx_cur[index_base_ch] = 255;
}

void match_enter(){

  read_reference(ref_eeaddr);

  Serial.println("MATCH_ENTER");
  Serial.println(dmx_ch_count);

  for(int ref=0; ref<3; ref++){
    for(int var=0; var<3; var++){
      matrix[ref][var] = rel_diff(rgbc_reference[var], rgbc_reference[ref]);
    }
  }
  Serial.print(matrix[0][0]);
  Serial.print(" ");
  Serial.print(matrix[0][1]);
  Serial.print(" ");
  Serial.println(matrix[0][2]);
  Serial.print(matrix[1][0]);
  Serial.print(" ");
  Serial.print(matrix[1][1]);
  Serial.print(" ");
  Serial.println(matrix[1][2]);
  Serial.print(matrix[2][0]);
  Serial.print(" ");
  Serial.print(matrix[2][1]);
  Serial.print(" ");
  Serial.println(matrix[2][2]);
  
  //write_dmx_off();
  //delay(20);
  //tcs.adjust_background_scan();

  index_base_ch = 0;
  reset_match();

  Serial.println(sprintf_dmx_values(dmx_cur));

  Serial.println("MATCH_ENTER_EXIT");
}


bool match_loop(){   // iterate loop

  write_dmx(dmx_cur);
  delay(20);

  index_ch = index_ch%dmx_ch_count;
  if (index_ch == index_base_ch){
    index_ch++;
    return false;
  }

  last_dif_rel = dif_rel;

  tcs.startIntegration();
  while(!tcs.is_integrated());
  tcs.read_data_rgbc(&r, &g, &b, &c);

  char buff[8];
  String str = "[ ";
  for(int i = 0; i < 4; i++){
    sprintf(buff, ", %06d", (int) *rgbc[i]);
    str+= buff;
  }
  str += " ]  ";
  Serial.print(str);

  dif_rel = pow(rel_diff(r, g) - matrix[1][0], 2);
  dif_rel += pow(rel_diff(g, b) - matrix[2][1], 2);
  dif_rel += pow(rel_diff(b, r) - matrix[0][2], 2);

  if (!initialized){
    initialized = true;
    last_dif_rel = dif_rel;
    last_dmx = dmx_cur[index_ch];
  }

  Serial.print("Running [");
  Serial.print(repetitions);
  Serial.print("/");
  Serial.print(index_ch);
  Serial.print("]: ");
  Serial.print(sprintf_dmx_values(dmx_cur));
  Serial.print(", with score ");
  Serial.println(dif_rel);

  if (dif_rel>last_dif_rel){
    Serial.print("BIGGER INCICDENT: ");
    Serial.println(first_miss);
    dmx_cur[index_ch] = last_dmx;
    match_handler();
  }
  else{
    last_dmx = dmx_cur[index_ch];
    int16_t dmx = dmx_cur[index_ch] + updown;
  
    if (dmx > 255){
      dmx_cur[index_ch] = 255;
      match_handler();
    }else if(dmx<0){
      dmx_cur[index_ch] = 0;
      match_handler();
    }else{
      dmx_cur[index_ch] = (uint8_t) dmx;
    }
  }

  if (repetitions == 10 && dif_rel < 42){
    updown = 1;
  }
  if (repetitions >= 30){
    dif_best[index_base_ch] = dif_rel;
    for(uint8_t ch=0; ch<dmx_ch_count; ch++){
      dmx_best[index_base_ch][ch] = dmx_cur[ch];
    }
    
    Serial.print("Channel [");
    Serial.print(index_base_ch);
    Serial.print("]: ");
    Serial.print(sprintf_dmx_values(dmx_cur));
    Serial.print(", with score ");
    Serial.println(dif_rel);

    index_base_ch += 1;
    if (index_base_ch>=dmx_ch_count){
      return true;
    }

    reset_match();
  } 

  return false;

}

void match_exit(){
  Serial.println("MATCH_EXIT");

  uint8_t best_max_ch = get_min_index(dif_best, dmx_ch_count);
  for(uint8_t ch=0; ch<dmx_ch_count; ch++){
    dmx_cur[ch] = dmx_best[best_max_ch][ch];
  }
  write_dmx(dmx_cur);

  Serial.print("Best Match:   ");
  Serial.print(sprintf_dmx_values(dmx_cur));
  Serial.print(", with score ");
  Serial.println(dif_best[best_max_ch]);

  //tcs.adjust_background_clear();

}

void match_handler(){
  if(first_miss){
    first_miss = false;
    updown = -updown;
  }else{
    first_miss = true;
    index_ch++;
    repetitions++;
    initialized=false;
  }
}

String sprintf_dmx_values(uint8_t *dmx) {
  char buff[6];
  String str = "[ ";
  for(int i = 0; i < dmx_ch_count; i++){
    sprintf(buff, ", %03d", dmx[i]);
    str+= buff;
  }
  str += " ]";
  return str;
} 

float rel_diff(float a, float b){
  if(b == 0){
    return b;
  }
  return (b-a)/b;
}

uint8_t get_max_index(float dmx[]){
  uint8_t max_index = 0;
  for (uint8_t i=0; i<(uint8_t)sizeof(&dmx); i++){
    if (dmx[i] > dmx[max_index]){
      max_index = i;
    }
  }
  return max_index;
}

uint8_t get_min_index(float *list, uint8_t size){
  uint8_t min_index = 0;
  for (uint8_t i=1; i<size; i++){
    if (list[i] < list[min_index]){
      min_index = i;
    }
  }
  return min_index;
}

uint8_t get_max_index(uint8_t dmx[]){
  uint8_t max_index = 0;
  for (uint8_t i=0; i<(uint8_t)sizeof(&dmx); i++){
    if (dmx[i] > dmx[max_index]){
      max_index = i;
    }
  }
  return max_index;
}

void reference_enter(){
  Serial.println("REFERENCE_ENTER");
  memset(rgbc64, 0, sizeof(rgbc64));
  ref_count = 0;
}

bool reference_loop(){
  Serial.println("REFERENCE_LOOP");
  //tcs.integrate_2_min_norm(1024, &r, &g, &b, &c);
  tcs.startIntegration();
  while (!tcs.is_integrated());
  tcs.read_data_rgbc(&r, &g, &b, &c);
  rgbc_reference[0] = r;
  rgbc_reference[1] = g;
  rgbc_reference[2] = b;
  rgbc_reference[3] = c;
  return true;
  // for(uint8_t a=0; a<4; a++){
  //   rgbc64[a] = rgbc64[a] + (uint64_t) *rgbc[a];
  // }
  // Serial.print(ref_count);
  // Serial.print(": ");
  // Serial.print(r);
  // Serial.print(", ");
  // Serial.print(g);
  // Serial.print(", ");
  // Serial.print(b);
  // Serial.print(", ");
  // Serial.println(c);
  // ref_count++;
  // if(ref_count>=10){
  //   return true;
  // }
  // return false;
}

void reference_exit(){
  Serial.println("REFERENCE_EXIT");
  for (uint8_t a=0; a<4; a++){
  //   rgbc_reference[a] = (uint16_t) rgbc64[a]/10;
  //   Serial.print("exit ");
    Serial.println(rgbc_reference[a]);
  }
  save_reference(ref_eeaddr);
}

void save_reference(uint16_t address){
  for(uint8_t a=0; a<4; a++){
    EEPROM.put(address+a*2, rgbc_reference[a]);
  }
  for(int i=0; i<4; i++){
    Serial.print("save ");
    Serial.println(rgbc_reference[i]);
    Serial.println(EEPROM.get(address+i*2, rgbc_reference[i]));
  }
}

void read_reference(uint16_t address){
  for(uint8_t a=0; a<4; a++){
    rgbc_reference[a] = EEPROM.get(address+a*2, rgbc_reference[a]);
    Serial.print("load");
    Serial.println(rgbc_reference[a]);
  }
}

// param

uint8_t param_chnanels = dmx_ch_count;
uint8_t param_dmx_step = 10;
uint8_t param_hold_count = 0;

uint8_t hold_counter = 0;
bool wait_for_start = true;
uint32_t loop_count = 0;
bool finished = false;

void param_enter(){
    Serial.println("PARAM_ENTER");
    write_dmx_on();
    return;
}

bool param_loop(){

  if (wait_for_start){
    return true;
  }

  loop_count++;

  if (loop_count == 1){
    write_dmx_off();
    delay(10);
  }

  tcs.startIntegration();
  //do computing send old values from previous loop

  if(loop_count > 1){
    param_print_values();
  }
  
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
  delay(20);

  if(finished){
    param_print_values();
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

bool param_read_serial(String str){
    if(str.startsWith("start")){
        wait_for_start = false;
        return true;
    } else if (str.startsWith("param_chnanels")){
        write_dmx_off();
        param_chnanels = extract_int(str, param_chnanels);
        write_dmx_on();
    } else if ( str.startsWith("param_dmx_step")){
        param_dmx_step = extract_int(str, param_dmx_step);
    } else if ( str.startsWith("param_hold_count")){
        param_hold_count = extract_int(str, param_hold_count);
    } else if ( str.startsWith("dmx_start_address")){
        dmx_start_address = extract_int(str, dmx_start_address);
    } else if ( str.startsWith("reset")) {
        // do nothing, reset will be called below. 
    } else {
      return false;
    }
    param_reset();
    return true;
}

void param_reset(){
  for (uint8_t i = 0; i < sizeof(dmx_cur); i++){
    dmx_cur[i] = 0;
    dmx_old[i] = 0;
  }  
  hold_counter = 0;
  wait_for_start = true;
  loop_count = 0;
  finished = false;
}

int64_t extract_int(String str, int64_t defaultInt){
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
  if (val > (uint16_t)255 && val < (uint16_t)(255 + inc_step)) {
    val = 255;
  }
  if (val == (uint16_t)(255 + inc_step)) {
    val = 0;
  }
  if (val > (uint16_t)255) {
    val = 0;
  }
  hold_counter = param_hold_count;
  dmx_cur[index] = val;
}

void write_dmx(uint8_t values[]) {
  for(int i = 0; i < param_chnanels; i++){
    DMXSerial.write(i+dmx_start_address, values[i]);
  }
}

void write_dmx_all(uint8_t val) {
  for(int i = 0; i < param_chnanels; i++){
    DMXSerial.write(i+dmx_start_address, val);
  }
}

void write_dmx_on() {
  write_dmx_all(255);
}

void write_dmx_off() {
  //write_dmx_all(0);
  for(int i = 1; i <= 255; i++){
    DMXSerial.write(i, 0);
  }
}

void param_print_values() {
  char buff[32];
  sprintf(buff, "%05d, %05d, %05d, %05d", r, g, b, c);
  String str_print = buff;
  for(int i = 0; i < param_chnanels; i++){
    sprintf(buff, ", %03d", dmx_old[i]);
    str_print += buff;
  }
  Serial.println(str_print);
} 


#include "fsm.h"

Fsm & Fsm::begin() {

    const static state_t state_table[] PROGMEM = {
    /*                    ON_ENTER      ON_LOOP      ON_EXIT   CMD_STOP   CMD_PARAM    CMD_REF  CMD_MATCH   EVT_MD   ELSE */
    /* IDLE      */       ENT_IDLE,          -1,          -1,      IDLE,      PARAM, REFERENCE,     MATCH,      -1,    -1,
    /* PARAM     */      ENT_PARAM,  LOOP_PARAM,  EXIT_PARAM,      IDLE,         -1,        -1,        -1,      -1,    -1,
    /* REFERENCE */       ENT_REF,     LOOP_REF,    EXIT_REF,      IDLE,         -1,        -1,        -1,      -1,    -1,
    /* MATCH     */     ENT_MATCH,   LOOP_MATCH,  EXIT_MATCH,      IDLE,         -1,        -1,        -1,  MATCH2,    -1,
    /* MATCH2    */    ENT_MATCH2,  LOOP_MATCH2,          -1,      IDLE,         -1,        -1,        -1,      -1,    -1,
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
      Fsm::trigger(Fsm::EVT_MD);
      return;
    case ENT_MATCH2:
      match2_enter();
      return;
    case LOOP_MATCH2:
      if(!match2_loop()){
        Fsm::trigger(Fsm::CMD_STOP);
      }
      return;
  }
}

Fsm & Fsm::trace( Stream & stream ) {
  Machine::setTrace( &stream, atm_serial_debug::trace,
    "FSM\0CMD_STOP\0CMD_PARAM\0CMD_REF\0CMD_MATCH\0EVT_MD\0ELSE\0IDLE\0PARAM\0REFERENCE\0MATCH\0MATCH2");
  return *this;
}


// general

extern TCS34725 tcs;

uint8_t dmx_cur[10] = { };  // init all to zero
uint8_t dmx_old[10] = { };  // init all to zero
uint8_t dmx_start_address = 1;
uint16_t r, g, b, c = 0;
uint16_t *rgbc[] = {&r, &g, &b, &c};

// reference
int ref_eeaddr = 0;
int ref_count = 0;

uint64_t rgbc64[4] = { };
uint16_t rgbc_reference[4] = { };

// match

uint8_t dmx_color_ch = 3;
uint8_t index_abs = 0;
uint8_t index_ref = 0;
uint8_t index_var = 0;
// dmx_cur
uint8_t last_dmx1 = -1;
uint8_t last_dmx2 = -2;
uint8_t repetitions = 0;

float matrix[3][3] = { };
float row_sums[3] = { };
float rgbc_dmx_ch[10] = { };

void match_enter(){

  read_reference(ref_eeaddr);

  Serial.println("MATCH_ENTER");
  last_dmx1 = -1;
  last_dmx2 = -2;
  memset(row_sums, 0, sizeof(row_sums));
  memset(rgbc_dmx_ch, 0, sizeof(row_sums));
  for(int ref=0; ref<3; ref++){
    for(int var=0; var<3; var++){
      matrix[ref][var] = rel_diff(rgbc_reference[var], rgbc_reference[ref]);
      row_sums[ref] = row_sums[ref] + matrix[ref][var];
    }
  }
  uint8_t rgbc_index_max = get_max_index(row_sums);

  for(uint8_t ch=0; ch<dmx_color_ch; ch++){
    dmx_cur[ch] = 255;
    write_dmx(dmx_cur);
    delay(2);
    //tcs.integrate_2_min_norm(1024, &r, &g, &b, &c);
    tcs.startIntegration();
    while(!tcs.is_integrated());
    dmx_cur[ch] = 0;
    tcs.read_data_rgbc(&r, &g, &b, &c);
    rgbc_dmx_ch[ch] = *rgbc[rgbc_index_max];
  }

  index_abs = get_max_index(rgbc_dmx_ch);
  dmx_cur[index_abs] = 255;
  index_ref = index_abs;
  
  repetitions = 0;

  Serial.println("MATCH_ENTER_EXIT");
}

bool match_loop(){   // iterate loop

  index_var = (index_ref+1)%dmx_color_ch;

  if(index_var == index_abs){
    index_ref = index_var;
    repetitions++;
    return repetitions == 10 ? true : false;
  }

  tcs.startIntegration();
  while(!tcs.is_integrated());
  tcs.read_data_rgbc(&r, &g, &b, &c);

  float cur_rel = rel_diff(*rgbc[index_var], *rgbc[index_ref]);
  float dif_rel = cur_rel - matrix[index_ref][index_var];

  int dmx = dmx_cur[index_var];

  Serial.print(index_ref);
  Serial.print("/");
  Serial.print(index_var);
  Serial.print(" ");
  Serial.print(cur_rel);
  Serial.print(" ");
  Serial.print(matrix[index_ref][index_var]);
  Serial.print(" ");
  Serial.print(dif_rel);

  int factor = (int) abs(dif_rel)*10;
  if( factor > 9){
    factor = 9;
  }

  dmx = dmx + int(sgn(dif_rel))*(factor+1);

  if(dmx > 255){
      divide_dmx_cur_by(2);
      memset(dmx_cur, 0, sizeof(dmx_cur));
      dmx = 255;
      index_abs = index_var;
      repetitions -= 2;
  }else if(dmx < 0){
      dmx = 0;
      index_ref = index_var;
      repetitions += 1;
  }else if(last_dmx1 == dmx || last_dmx2 == dmx){
      index_ref = index_var;
      repetitions += 2;
  }else{
      last_dmx2 = last_dmx1;
      last_dmx1 = dmx;
  }

  dmx_cur[index_var] = (uint8_t) dmx;
  write_dmx(dmx_cur);

  Serial.print(" [");
  for(uint8_t ch=0; ch<dmx_color_ch; ch++){
    Serial.print(dmx_cur[ch]);
    Serial.print(", ");
  }
  Serial.println("]");

  return false;

}

void match_exit(){
  Serial.println("MATCH_EXIT");
}

void match2_enter(){
  Serial.println("MATCH2_ENTER");
}

bool match2_loop(){
  return true;
}

void divide_dmx_cur_by(uint8_t divisor){
  for(uint8_t i=0; i<dmx_color_ch; i++){
    dmx_cur[i] = (int) dmx_cur[i]/divisor;
  }
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
  for(uint8_t a=0; a<4; a++){
    rgbc64[a] = rgbc64[a] + (uint64_t) *rgbc[a];
  }
  Serial.print(ref_count);
  Serial.print(": ");
  Serial.print(r);
  Serial.print(", ");
  Serial.print(g);
  Serial.print(", ");
  Serial.print(b);
  Serial.print(", ");
  Serial.println(c);
  ref_count++;
  if(ref_count>=10){
    return true;
  }
  return false;
}

void reference_exit(){
  Serial.println("REFERENCE_EXIT");
  for (uint8_t a=0; a<4; a++){
    rgbc_reference[a] = (uint16_t) rgbc64[a]/10;
    Serial.print("exit ");
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

uint8_t param_chnanels = 4;
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
    print_values();
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

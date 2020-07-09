#ifndef _FSM_H_
#define _FSM_H_

#define SERIAL_TERMINATOR '\n'  // TODO move to global

enum mode_t {
  MODE_SERIAL,
  MODE_SINGLE,
};

enum state_t {
  WAITING,
  REFERENCE,
  COLORMATCH,
  PARAMETRIZE,
  CALIBRATE,
  DMXMASTER,
};

void setState(enum state_t stateNew);
void pullInput();

extern enum mode_t mode;
extern enum state_t stateCur;
extern enum state_t statePrev;

bool state_setup[5];  // num element in state_t


void delayPullInput(unsigned long time_ms){
  unsigned long delayStartTime = millis();
  while(millis()-delayStartTime>time_ms){
    pullInput();
  }
}

void pullInput(){
  if (Serial.available() > 0) {
    String str = Serial.readStringUntil(SERIAL_TERMINATOR);
    Serial.print("recived: ");
    Serial.print(str);
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
      Serial.println(" --> current action cancled");
      setState(WAITING);
    } else {
      Serial.print("Device busy. Current state is '");
      Serial.print(stateCur);
      Serial.println("'.");
    }
  }
}


void runner(void (*func_setup)(), void (*func_run)()) {
  //char logString[256];
  //sprintf(logString, "%1d-%1d: %1d, %1d, %1d, %1d, %1d", stateCur, statePrev, state_setup[0], state_setup[1], state_setup[2], state_setup[3], state_setup[4]);
  //Serial.println(logString);
  if (state_setup[stateCur] == false) {
    state_setup[stateCur] = true;
    func_setup();
  } else {
    func_run();
  }
}

void setState(enum state_t stateNew) {
  Serial.print("Set State: ");
  Serial.println(stateNew);
  statePrev = stateCur;
  state_setup[stateCur] = false;
  stateCur = stateNew;
}

# endif

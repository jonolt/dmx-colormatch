#ifndef _FSM_H_
#define _FSM_H_

enum mode_t {
  MODE_SERIAL,
  MODE_SINGLE,
};

enum state_t {
  WAITING,
  REFERENCE,
  COLORMATCH,
  PARAMETRIZE,
  SETUP,
  DMXMASTER,
};

enum mode_t mode;
enum state_t stateCur;
enum state_t statePrev;
bool state_setup[5];  // num element in state_t

void runner(void (*func_setup)(), void (*func_run)()) {
  if (state_setup[stateCur] == false) {
    state_setup[stateCur] = true;
    func_setup();
  } else {
    func_run();
  }
}

void setState(enum state_t stateNew) {
  statePrev = stateCur;
  state_setup[stateCur] = false;
  stateCur = stateNew;
}

# endif

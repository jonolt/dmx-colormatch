#include "fsmui.h"

FsmUi & FsmUi::begin() {
  const static state_t state_table[] PROGMEM = {
    /*            ON_ENTER    ON_LOOP  ON_EXIT  SW1     SW2     SW3     SW4     SW5     SW6     SW7     SW8     ELSE */
    /* IDLE    */       -1,        -1,      -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,
    /* PAGE_1  */    ENT_1,    LOOP_1,  EXIT_1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,
    /* PAGE_2  */    ENT_2,    LOOP_2,  EXIT_2,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,
    /* PAGE_3  */    ENT_3,    LOOP_3,  EXIT_3,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,
    /* PAGE_4  */    ENT_4,    LOOP_4,  EXIT_4,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,
  };
  Machine::begin( state_table, ELSE );
  return *this;
}

int FsmUi::event( int id ) {
   return 0;
}

void FsmUi::action( int id ) {
  switch ( id ) {
  	case ENT_1 :
  	  return;
  	case LOOP_1 :
  	  return;
   }
}

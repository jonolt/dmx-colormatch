//#pragma once
#ifndef _FSM_H_
#define _FSM_H_

#include <Arduino.h>
#include <Automaton.h>
#include "TCS34725.h"
#include <DMXSerial.h>

class Fsm: public Machine {

  public:
    Fsm( void ) : Machine() {};

    atm_timer_millis timer;

    enum { IDLE, PARAM, MASTER, REFERENCE, MATCH }; // STATES
    enum { CMD_STOP, CMD_PARAM, ELSE }; // EVENTS
    enum { ENT_IDLE, ENT_PARAM, LOOP_PARAM, EXIT_PARAM }; // ACTIONS
	
    Fsm & begin();
    //Fsm & trace( Stream & stream );
    int event( int id ); 
    void action( int id ); 


};

uint8_t extract_int(String str, uint8_t defaultInt);

void param_enter();
bool param_loop();
void param_exit();
void param_read_serial(String str);

void increase_dmx_values(uint8_t inc_step);
void increase_dmx_value(uint8_t index, uint8_t inc_step);
void print_values();
void write_dmx(uint8_t values[3]);
void write_dmx_on();
void write_dmx_off();

#endif
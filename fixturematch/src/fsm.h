//#pragma once
#ifndef _FSM_H_
#define _FSM_H_

#include <Arduino.h>
#include <EEPROM.h>
#include <Automaton.h>
#include "TCS34725.h"
#include <DMXSerial.h>

class Fsm: public Machine {

  public:
    Fsm( void ) : Machine() {};

    atm_timer_millis timer;

    enum { IDLE, PARAM, REFERENCE, MATCH, MATCH2 }; // STATES
    enum { CMD_STOP, CMD_PARAM, CMD_REF, CMD_MATCH, ELSE }; // EVENTS
    enum { ENT_IDLE, ENT_PARAM, LOOP_PARAM, EXIT_PARAM, ENT_REF, LOOP_REF, EXIT_REF, ENT_MATCH, LOOP_MATCH, EXIT_MATCH}; // ACTIONS
	
    Fsm & begin();
    Fsm & trace( Stream & stream );
    int event( int id ); 
    void action( int id ); 


};

uint8_t extract_int(String str, uint8_t defaultInt);
void save_reference(uint16_t address);
void read_reference(uint16_t address);
void make_relative(float target[3], uint16_t source[4]);
uint8_t get_max_index(uint8_t dmx[]);
uint8_t get_max_index(float dmx[]);
bool compareArray(uint8_t a[],uint8_t b[]);
float rel_diff(float a, float b);
void divide_dmx_cur_by(uint8_t divisor);

void match_enter();
bool match_loop();
void match_exit();

void reference_enter();
bool reference_loop();
void reference_exit();

void param_enter();
bool param_loop();
void param_exit();
void param_reset();
bool param_read_serial(String str);

void increase_dmx_values(uint8_t inc_step);
void increase_dmx_value(uint8_t index, uint8_t inc_step);
void print_values();
void write_dmx(uint8_t values[3]);
void write_dmx_all();
void write_dmx_on();
void write_dmx_off();

template <typename T> int sgn(T val) {
    return (T(0) < val) - (val < T(0));
}

#endif
#pragma once

#include <Automaton.h>
#include "parandvals.h"
#include "globals.h"

class MainMachine: public Machine
{

public:
    enum { IDLE, REF, PARAM, MATCH, LINITY, ENVIR }; // STATES
    enum { EVT_CMD_STOP, EVT_CMD_REF, EVT_CMD_PARAM, EVT_CMD_MATCH, EVT_CMD_LINITY, EVT_CMD_ENVIR, ELSE }; // EVENTS
    MainMachine( void ) : Machine() {};
    MainMachine& begin( ParAndVals *pav );
    MainMachine& trace( Stream & stream );
    MainMachine& trigger( int event );
    int state( void );
    MainMachine& cmd_stop( void );
    MainMachine& cmd_ref( void );
    MainMachine& cmd_param( void );
    MainMachine& cmd_match( void );
    MainMachine& cmd_linity( void );
    MainMachine& cmd_envir( void );

protected:

    bool firstLoop = true;

    ParAndVals *pav;

    float score;
    float lastScore;
    int16_t dmxChValue;
    uint8_t lastDmxChValue;
    uint8_t refCChannel;
    uint8_t varCChannel;
    uint8_t repetitions;
    bool first_miss;
    int8_t updown;
    float targetRelVals[3][3] = { };  // target values for match
    uint8_t resDmx[NUM_COLOR_CHANNELS][NUM_COLOR_CHANNELS];
    float resScore[NUM_COLOR_CHANNELS];

    void match_reset();
    void match_enter();
    bool match_loop();
    void match_exit();

    void reference_enter();

private:
    enum { ENT_IDLE, ENT_REF, ENT_PARAM, LP_PARAM, EXT_PARAM, ENT_MATCH, LP_MATCH, EXT_MATCH, ENT_LINITY, LP_LINITY, EXT_LINITY, ENT_ENVIR }; // ACTIONS
    int event( int id );
    void action( int id );

};


/*
Automaton::ATML::begin - Automaton Markup Language

<?xml version="1.0" encoding="UTF-8"?>
<machines>
  <machine name="MainMachine">
    <states>
      <IDLE index="0" on_enter="ENT_IDLE">
        <EVT_CMD_REF>REF</EVT_CMD_REF>
        <EVT_CMD_PARAM>PARAM</EVT_CMD_PARAM>
        <EVT_CMD_MATCH>MATCH</EVT_CMD_MATCH>
        <EVT_CMD_LINITY>LINITY</EVT_CMD_LINITY>
        <EVT_CMD_ENVIR>ENVIR</EVT_CMD_ENVIR>
      </IDLE>
      <REF index="1" on_enter="ENT_REF">
        <EVT_CMD_STOP>IDLE</EVT_CMD_STOP>
      </REF>
      <PARAM index="2" on_enter="ENT_PARAM" on_loop="LP_PARAM" on_exit="EXT_PARAM">
        <EVT_CMD_STOP>IDLE</EVT_CMD_STOP>
      </PARAM>
      <MATCH index="3" on_enter="ENT_MATCH" on_loop="LP_MATCH" on_exit="EXT_MATCH">
        <EVT_CMD_STOP>IDLE</EVT_CMD_STOP>
      </MATCH>
      <LINITY index="4" on_enter="ENT_LINITY" on_loop="LP_LINITY" on_exit="EXT_LINITY">
        <EVT_CMD_STOP>IDLE</EVT_CMD_STOP>
      </LINITY>
      <ENVIR index="5" on_enter="ENT_ENVIR">
        <EVT_CMD_STOP>IDLE</EVT_CMD_STOP>
      </ENVIR>
    </states>
    <events>
      <EVT_CMD_STOP index="0" access="MIXED"/>
      <EVT_CMD_REF index="1" access="MIXED"/>
      <EVT_CMD_PARAM index="2" access="MIXED"/>
      <EVT_CMD_MATCH index="3" access="MIXED"/>
      <EVT_CMD_LINITY index="4" access="MIXED"/>
      <EVT_CMD_ENVIR index="5" access="MIXED"/>
    </events>
    <connectors>
    </connectors>
    <methods>
    </methods>
  </machine>
</machines>

Automaton::ATML::end
*/


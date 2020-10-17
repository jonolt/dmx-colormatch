#include "mainmachine.h"
/* Add optional parameters for the state machine to begin()
 * Add extra initialization code
 */

MainMachine& MainMachine::begin( ParAndVals *pav )
{
    MainMachine::pav = pav;
    // clang-format off
    const static state_t state_table[] PROGMEM =
    {
        /*             ON_ENTER    ON_LOOP     ON_EXIT  EVT_CMD_STOP  EVT_CMD_REF  EVT_CMD_PARAM  EVT_CMD_MATCH  EVT_CMD_LINITY  EVT_CMD_ENVIR  ELSE */
        /*   IDLE */   ENT_IDLE,        -1,         -1,           -1,         REF,         PARAM,         MATCH,         LINITY,         ENVIR,   -1,
        /*    REF */    ENT_REF,        -1,         -1,         IDLE,          -1,            -1,            -1,             -1,            -1,   -1,
        /*  PARAM */  ENT_PARAM,  LP_PARAM,  EXT_PARAM,         IDLE,          -1,            -1,            -1,             -1,            -1,   -1,
        /*  MATCH */  ENT_MATCH,  LP_MATCH,  EXT_MATCH,         IDLE,          -1,            -1,            -1,             -1,            -1,   -1,
        /* LINITY */ ENT_LINITY, LP_LINITY, EXT_LINITY,         IDLE,          -1,            -1,            -1,             -1,            -1,   -1,
        /*  ENVIR */  ENT_ENVIR,        -1,         -1,         IDLE,          -1,            -1,            -1,             -1,            -1,   -1,
    };
    // clang-format on
    Machine::begin( state_table, ELSE );
    return *this;
}

/* Add C++ code for each internally handled event (input)
 * The code must return 1 to trigger the event
 */

int MainMachine::event( int id )
{
    switch ( id )
    {
    case EVT_CMD_STOP:
        return 0;
    case EVT_CMD_REF:
        return 0;
    case EVT_CMD_PARAM:
        return 0;
    case EVT_CMD_MATCH:
        return 0;
    case EVT_CMD_LINITY:
        return 0;
    case EVT_CMD_ENVIR:
        return 0;
    }
    return 0;
}

/* Add C++ code for each action
 * This generates the 'output' for the state machine
 */

void MainMachine::action( int id )
{
    switch ( id )
    {
    case ENT_IDLE:
        return;
    case ENT_REF:
        reference_enter();
        return;
    case ENT_PARAM:
        return;
    case LP_PARAM:
        return;
    case EXT_PARAM:
        return;
    case ENT_MATCH:
        firstLoop = true;
        match_enter();
        return;
    case LP_MATCH:
        if(firstLoop)
        {
            firstLoop = false;
            return;
        }
        if (match_loop())
        {
            MainMachine::cmd_stop();
        }
        return;
    case EXT_MATCH:
        match_exit();
        return;
    case ENT_LINITY:
        return;
    case LP_LINITY:
        return;
    case EXT_LINITY:
        return;
    case ENT_ENVIR:
        return;
    }
}

/* Optionally override the default trigger() method
 * Control how your machine processes triggers
 */

MainMachine& MainMachine::trigger( int event )
{
    Machine::trigger( event );
    return *this;
}

/* Optionally override the default state() method
 * Control what the machine returns when another process requests its state
 */

int MainMachine::state( void )
{
    return Machine::state();
}

/* Nothing customizable below this line
 ************************************************************************************************
*/

/* Public event methods
 *
 */

MainMachine& MainMachine::cmd_stop()
{
    trigger( EVT_CMD_STOP );
    return *this;
}

MainMachine& MainMachine::cmd_ref()
{
    trigger( EVT_CMD_REF );
    return *this;
}

MainMachine& MainMachine::cmd_param()
{
    trigger( EVT_CMD_PARAM );
    return *this;
}

MainMachine& MainMachine::cmd_match()
{
    trigger( EVT_CMD_MATCH );
    return *this;
}

MainMachine& MainMachine::cmd_linity()
{
    trigger( EVT_CMD_LINITY );
    return *this;
}

MainMachine& MainMachine::cmd_envir()
{
    trigger( EVT_CMD_ENVIR );
    return *this;
}

/* State trace method
 * Sets the symbol table and the default logging method for serial monitoring
 */

MainMachine& MainMachine::trace( Stream & stream )
{
    Machine::setTrace( &stream, atm_serial_debug::trace,
                       "MAINMACHINE\0EVT_CMD_STOP\0EVT_CMD_REF\0EVT_CMD_PARAM\0EVT_CMD_MATCH\0EVT_CMD_LINITY\0EVT_CMD_ENVIR\0ELSE\0IDLE\0REF\0PARAM\0MATCH\0LINITY\0ENVIR" );
    return *this;
}

// #### code ####

void MainMachine::match_reset()
{
    varCChannel = refCChannel + 1;
    repetitions = 0;
    first_miss = true;
    updown = 5;
    pav->resetMatchArrays();
    pav->resetCDmx();
    pav->cDmx[refCChannel] = 255;
    score = -1.0;  // will be moved to last score at beginning of loop
    dmxChValue = 0;
}

void MainMachine::match_enter()
{
    uint16_t rgbcReference[4];
    pav->getRegRgbc(rgbcReference);
    for (int ref_val = 0; ref_val < 3; ref_val++)
    {
        for (int var = 0; var < 3; var++)
        {
            targetRelVals[ref_val][var] = relDiff(rgbcReference[var], rgbcReference[3]);
        }
    }
    refCChannel = 0;
    match_reset();
}

bool MainMachine::match_loop()
{

    lastScore = score;

    score = pow(relDiff(pav->rgbc[0], pav->rgbc[3]) - targetRelVals[1][0], 2);
    score += pow(relDiff(pav->rgbc[1], pav->rgbc[3]) - targetRelVals[2][1], 2);
    score += pow(relDiff(pav->rgbc[2], pav->rgbc[3]) - targetRelVals[0][2], 2);

//    Serial.print("refCChannel: ");
//    Serial.print(refCChannel);
//    Serial.print("  varCChannel: ");
//    Serial.print(varCChannel);
//    Serial.print("  score(last): ");
//    Serial.print(score, 8);
//    Serial.print(" (");
//    Serial.print(lastScore, 8);
//    Serial.print(")  first miss: ");
//    Serial.print(first_miss);
//    Serial.print("  repetitions: ");
//    Serial.print(repetitions);
//    Serial.print("   ");

    if (lastScore >= 0 && score > lastScore)
    {
        dmxChValue = (int16_t) lastDmxChValue;
    }
    else
    {
        lastDmxChValue = (uint8_t) dmxChValue;
        dmxChValue = dmxChValue + (int16_t) updown;

        if (dmxChValue > 255)
        {
            dmxChValue = 255;
        }
        else if (dmxChValue < 0)
        {
            dmxChValue = 0;
        }
        else
        {
            goto exit;
        }

    }

    if (first_miss)
    {
        first_miss = false;
        updown = -updown;
        goto exit;
    }

    // second miss. move to next color channel and initilaize parameters
    first_miss = true;
    varCChannel++;
    varCChannel = varCChannel % pav->getNumColorChannel();
    dmxChValue = pav->cDmx[varCChannel];
    lastDmxChValue = dmxChValue;

    if(varCChannel != refCChannel)
    {
        goto exit;
    }

    // reached reference color chanel. check (exit) conditions continue
    repetitions++;
    varCChannel++;
    varCChannel = varCChannel % pav->getNumColorChannel();
    dmxChValue = pav->cDmx[varCChannel];
    lastDmxChValue = dmxChValue;

    if (repetitions == 5)  // TODO add score condition
    {
        updown = 1;
    }
    else if (repetitions == 15)  // TODO add score condition
    {
        resScore[refCChannel] = score;
        copyArray(resDmx[refCChannel], pav->cDmx, NUM_COLOR_CHANNELS);
        refCChannel++;
        if(refCChannel==pav->getNumColorChannel())
        {
            return true;

        }
        match_reset();
    }

exit:
    pav->score = score;
    pav->cDmx[varCChannel] = (uint8_t) dmxChValue;
    return false;

}

void MainMachine::match_exit()
{

    uint8_t best_max_ch = get_min_index(resScore, pav->getNumColorChannel());
    uint8_t tmp[NUM_COLOR_CHANNELS];
    copyArray(tmp, resDmx[best_max_ch], NUM_COLOR_CHANNELS);
    pav->setRegDmx(tmp);
    pav->score = -1.0;

    Serial.print("Best Match (");
    Serial.print(best_max_ch);
    Serial.print(":   ");
    Serial.print(param_print_values(resDmx[refCChannel], pav->getNumColorChannel(), F_DMX));
    Serial.print(", with score ");
    Serial.println(resScore[best_max_ch], 10);


}

void MainMachine::reference_enter()
{
    pav->setRegRgbc(pav->rgbc);
    cmd_stop();
}




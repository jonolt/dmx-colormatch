#ifndef FSM_UI_H
#define FSM_UI_H

#include <Automaton.h>

class FsmUi: public Machine
{
    public:
        FsmUi( void ) : Machine() {};

        enum { PAGE_1, PAGE_2, PAGE_3, PAGE_4, PAGE_5 }; // STATES
        enum { SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, ELSE }; // EVENTS
        enum { ENT_1, LOOP_1, EXIT_1, ENT_2, LOOP_2, EXIT_2, ENT_3, LOOP_3, EXIT_3, ENT_4, LOOP_4, EXIT_4,}; // ACTIONS

        FsmUi & begin();
        FsmUi & trace( Stream & stream );
        int event( int id );
        void action( int id );

    protected:

    private:
};

#endif // FSM_UI_H

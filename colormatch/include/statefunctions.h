#include <DMXSerial>

#include "util"

void state_calibrate(){
    write_dmx_all_on();
    delayPullINput(2000);
    write_dmx_all_of();
}
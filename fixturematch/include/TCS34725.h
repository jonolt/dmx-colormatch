#ifndef _TCS34725EXT_H_
#define _TCS34725EXT_H_

#include <Adafruit_TCS34725.h>


class TCS34725 : public Adafruit_TCS34725 {

    public:
        //void setIntegrationTime(float it);  // overwriting this will break some functions
        //void startIntegration();
        //bool is_valid();
        //bool is_integrated();
        //void read_data_rgbc(uint16_t *r, uint16_t *g, uint16_t *b, uint16_t *c);

        uint16_t background_r = 0;
        uint16_t background_g = 0;
        uint16_t background_b = 0;
        uint16_t background_c = 0;

        void adjust_background_scan(uint16_t min_val=1024){
            TCS34725::integrate_2_min_norm(min_val, &background_r, &background_c, &background_b, &background_b);
        }

        void adjust_background_clear(){
            background_r = 0;
            background_g = 0;
            background_b = 0;
            background_c = 0;
        }

        void _setIntegrationTime(uint8_t atime) {
            _delay_millis = 2.4*(256-atime+1);
            _max_rgbc_count = (256-atime)*1024;
            /* Update the timing register */
            write8(TCS34725_ATIME, atime);
        }

        void setIntegrationTime(float it) {
            _tcs34725IntegrationTime = it;
            uint8_t atime = 256-(_tcs34725IntegrationTime/2.4);
            _setIntegrationTime(atime);
        }

        void startIntegration() {
            write8(TCS34725_ENABLE, 0x03);
            _time_integration_start = millis();
            _integration_started = true;  
        }

        bool is_valid() {
            if (read8(TCS34725_STATUS) && TCS34725_STATUS_AVALID > 0) {
                return true;
            } else {
                return false;
            }
        }

        bool is_integrated() {
            if(millis()-_time_integration_start > _delay_millis){
                if (is_valid() && _integration_started){
                    //_integration_started = false;
                    write8(TCS34725_ENABLE, 0x01);
                    return true;
                }
            }
            return false;
        }

        void read_data_rgbc(uint16_t *r, uint16_t *g, uint16_t *b, uint16_t *c) {
            _integration_started = false;
            *c = read16(TCS34725_CDATAL) - background_r;
            *r = read16(TCS34725_RDATAL) - background_g;
            *g = read16(TCS34725_GDATAL) - background_b;
            *b = read16(TCS34725_BDATAL) - background_c;
        }

        //void read_data_rgbc_norm(float *r, float *g, float *b, float *c) {
        //    read_data_rgbc(&reg_r, &reg_g, &reg_b, &reg_c);
        //    *r = (float)reg_r/_tcs34725IntegrationTime;
        //    *g = (float)reg_g/_tcs34725IntegrationTime;
        //    *b = (float)reg_b/_tcs34725IntegrationTime;
        //    *c = (float)reg_c/_tcs34725IntegrationTime;
        //}

        void _integrate_2_min(uint16_t min){
            uint16_t reg_r, reg_g, reg_b, reg_c;
            if(int_count<=100 && max(max(val_r, val_g), val_b)<min){
                setIntegrationTime(24);
                delay(0);
                startIntegration();
                int_count++;
                while(!is_integrated());
                read_data_rgbc(&reg_r, &reg_g, &reg_b, &reg_c);
                // Serial.print(int_count);
                // Serial.print(": ");
                // Serial.print(val_r);
                // Serial.print("/");
                // Serial.print(reg_r);
                // Serial.print(", ");
                // Serial.print(val_g);
                // Serial.print("/");
                // Serial.print(reg_g);
                // Serial.print(", ");
                // Serial.print(val_b);
                // Serial.print("/");
                // Serial.print(reg_b);
                // Serial.print(", ");
                // Serial.print(val_c);
                // Serial.print("/");
                // Serial.println(reg_c);
                val_r += reg_r;
                val_g += reg_g;
                val_b += reg_b;
                val_c += reg_c;
                _integrate_2_min(min);
            } else {
                setIntegrationTime(48);
                delay(1);
            }
        }

        float integrate_2_min_norm(uint16_t min, uint16_t *r, uint16_t *g, uint16_t *b, uint16_t *c){
            while(!is_integrated());
            read_data_rgbc(&val_r, &val_g, &val_b, &val_c);
            int_count = 0;
            _integrate_2_min(min);
            setIntegrationTime(48);
            float divisor = _tcs34725IntegrationTime+int_count*24;
            *r = (uint16_t)(val_r/divisor);
            *g = (uint16_t)(val_g/divisor);
            *b = (uint16_t)(val_b/divisor);
            *c = (uint16_t)(val_c/divisor);
            // Serial.print(int_count);
            // Serial.print("/");
            // Serial.print(divisor);
            // Serial.print(": ");
            // Serial.print(val_r);
            // Serial.print("/");
            // Serial.print(*r);
            // Serial.print(", ");
            // Serial.print(val_g);
            // Serial.print("/");
            // Serial.print(*g);
            // Serial.print(", ");
            // Serial.print(val_b);
            // Serial.print("/");
            // Serial.print(*b);
            // Serial.print(", ");
            // Serial.print(val_c);
            // Serial.print("/");
            // Serial.print(*c);
            return divisor;
        }        

    private:
        float _tcs34725IntegrationTime;  // overwriting this will break some functions
        uint16_t _max_rgbc_count;
        unsigned long _delay_millis;
        unsigned long _time_integration_start;
        bool _integration_started;
        uint16_t val_r, val_g, val_b, val_c;
        uint8_t int_count;
};

#endif

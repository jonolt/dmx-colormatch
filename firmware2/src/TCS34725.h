#ifndef _TCS34725EXT_H_
#define _TCS34725EXT_H_

#include <Adafruit_TCS34725.h>
#include <Wire.h>

/* modified (subclassed) Adafruit_TCS34725  librtary optimized for speed
   everthing not needed for project is not made public and may be brocken
   its a bit of a mass as some important variables are private and not protected
*/

class TCS34725 : private Adafruit_TCS34725
{

public:

    boolean begin(uint8_t addr, TwoWire *theWire)
    {
        _i2caddr = addr;
        _wire = theWire;
        return Adafruit_TCS34725::begin(addr);
    }
    boolean begin(uint8_t addr)
    {
        _i2caddr = addr;
        _wire = &Wire;
        return Adafruit_TCS34725::begin(_i2caddr);
    }
    boolean begin()
    {
        return TCS34725::begin(TCS34725_ADDRESS);
    }

    void setGain(tcs34725Gain_t gain)
    {
        Adafruit_TCS34725::setGain(gain);
    };

    uint16_t background_rgbc[4];

    void adjust_background_scan()
    {
        //To be implemented, problem how to handle different integration times
    }

    void adjust_background_clear()
    {
        background_rgbc[0] = 0;
        background_rgbc[1] = 0;
        background_rgbc[2] = 0;
        background_rgbc[3] = 0;
    }

    void _setIntegrationTime(uint8_t atime)
    {
        //time for integration(256 - atime) + init time (+1) of 2.4 ms
        _delay_micros = 2.56 * 1000 * (256 - atime + 1);
        _max_rgbc_count = (256 - atime) * 1024;
        /* Update the timing register */
        write8(TCS34725_ATIME, atime);
//        Serial.print("atime is: ");
//        Serial.print(atime);
//        Serial.print("; set delay_millis: ");
//        Serial.print(_delay_micros);
//        Serial.print("; _max_rgbc_count is: ");
//        Serial.println(_max_rgbc_count);
    }

    void setIntegrationTime(float it)
    {
        _tcs34725IntegrationTime = it;
        uint8_t atime = 256 - (_tcs34725IntegrationTime / 2.4);
        _setIntegrationTime(atime);
    }

    void startIntegration()
    {
        write8(TCS34725_ENABLE, TCS34725_ENABLE_PON | TCS34725_ENABLE_AEN);  //!WEN, AEN
        _time_integration_finished = micros() + _delay_micros;
    }

    bool is_integrated(bool check_valid = false)
    {
        if (micros() > _time_integration_finished)
        {
            return true;
        }
        return false;
    }

    void read_data_rgbc(uint16_t rgbc[])
    {
        //needs 1.2ms instead of 2.25ms to read data from sensor (with mega2650)
        _wire->beginTransmission(0x29);
        _wire->write( 0xA0 | TCS34725_CDATAL);
        _wire->endTransmission();
        _wire->requestFrom(0x29, 8);
        for (int c = 3; c < 7; c++)
        {
            while (_wire->available() == 0);
            uint8_t l = _wire->read();
            while (_wire->available() == 0);
            uint8_t h = _wire->read();
            rgbc[c % 4] = h;
            rgbc[c % 4] <<= 8;
            rgbc[c % 4] |= l;
            rgbc[c % 4] -= background_rgbc[c % 4];
        }
    }

    void read_data_rgbc_old(uint16_t rgbc[])
    {
        rgbc[3] = read16(TCS34725_CDATAL) - background_rgbc[3];
        rgbc[0] = read16(TCS34725_RDATAL) - background_rgbc[0];
        rgbc[1] = read16(TCS34725_GDATAL) - background_rgbc[1];
        rgbc[2] = read16(TCS34725_BDATAL) - background_rgbc[2];
    }

    uint16_t getMaxRgbcCount()
    {
        return _max_rgbc_count;
    }

    uint8_t getSensorAddress()
    {
        return _i2caddr;
    }

protected:
    uint8_t _i2caddr = 0x29;
    TwoWire *_wire;
    float _tcs34725IntegrationTime;
    uint16_t _max_rgbc_count;
    unsigned long _delay_micros;
    unsigned long _time_integration_finished;
};

#endif

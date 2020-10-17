#ifndef GLOBALS_H
#define GLOBALS_H

#include <stdint.h>
#include <WString.h>
#include <EEPROM.h>

//version
const String VERSION = "0.0.1";

//pins
const uint8_t REDE = 4;

//data
const uint8_t NUM_REGISTER = 16;  //one based
const uint8_t NUM_COLOR_CHANNELS = 6;
const uint8_t NUM_SENSOR_VALUES = 4;
const uint8_t BYTES_PER_REGISTER = 14;  //=4*uint16+6*uint8

//printing
const uint16_t SPRINTF_BUFFER_SIZE = 32;
const char F_DMX[] = "%03d";
const char F_RGBC[] = "%05d";
const char F_REG[] = "%02d";
const char F_CH[] = "%01d";
const char F_VAL[] = "%03d";

//dmx
const uint8_t DMX_CH_MIN = 1;
const uint8_t DMX_CH_MAX = 64;
const uint8_t DMX_ADD_MIN = 1;
const uint8_t DMX_ADD_MAX = 255;
const uint8_t DMX_VAL_MIN = 0;
const uint8_t DMX_VAL_MAX = 255;

//eeprom
const uint8_t ADD_NUM_COLOR_CHANNELS = 0;      // uint8_t: number of color channels in current fixture
const uint8_t ADD_DMX_ADDRESS = 1;             // uint8_t: start address of fixture
const uint8_t ADD_DMX_COLOR_CHANNEL_MAP = 4;   // uint64_t: bool map on which channel are the colors MSB=ch1, LSB=ch64
const uint8_t ADD_CURRENT_REGISTER = 2;        // uint8_t: current working register
const uint8_t ADD_WAIT_FOR_SERIAL = 3;         // uint8_t: wait for serial connection flag
const uint8_t ADD_FIRST_REGISTER = 31;         // uint8_t: first address of registers

//serial
const char SPLIT_CHAR = ' ';


//templates

template <typename T>
void writeToEeprom(T a, uint8_t size, uint8_t add)
{
    uint8_t sizeData = sizeof(a);
    for(int i=0; i<size; i++)
    {
        EEPROM.put(add + i*sizeData, a[i]);
    }
}

template <typename T>
void readFromEeprom(T a, uint8_t size, uint8_t add)
{
    uint8_t sizeData = sizeof(a);
    for(int i=0; i<size; i++)
    {
        EEPROM.get(add + i*sizeData, a[i]);
    }
}

template <typename T>
void copyArray(T to[], T from[], uint8_t size_of_to)
{
    for(uint8_t i=0; i<size_of_to; i++)
    {
        to[i] = from[i];
    }
}

template <typename T>
String formatValues(T val, const char* formatter)
{
    char buff[SPRINTF_BUFFER_SIZE];
    sprintf(buff, formatter, val);
    return String(buff);
}

template <typename T>
String param_print_values(T _array[], int _size, const char* formatter)
{
    char buff[SPRINTF_BUFFER_SIZE];
    String str_print = "";
    for (int i = 0; i < _size; i++)
    {
        if(i>0 && i<_size)
        {
            str_print += SPLIT_CHAR;
        }
        sprintf(buff, formatter, _array[i]);
        str_print += String(buff);
    }
    return str_print;
}

template <typename T>
uint8_t array_from_string(T target[], String str, uint8_t charsInVal, uint8_t _size)
{
    uint8_t arr_index=0;
    for(unsigned int i = 0; i<str.length(); i++)
    {
        if(str[i]==SPLIT_CHAR)
        {
            String sub_str = str.substring(i+1, i+1+charsInVal);
            target[arr_index] = sub_str.toInt();
            arr_index++;
            if(arr_index==_size)
            {
                return 0;
            };
        }
    }
    return 2;
}

template <typename T>
float relDiff(T a, T b) {
    float fa = (float) a;
    float fb = (float) b;
  if (fb == 0) {
    return fb;
  }
  return (fb - fa) / fb;
}

template <typename T>
uint8_t get_min_index(T *list, uint8_t size)
{
    uint8_t min_index = 0;
    for (uint8_t i = 1; i < size; i++)
    {
        if (list[i] < list[min_index])
        {
            min_index = i;
        }
    }
    return min_index;
}

#endif  // GLOBALS_H

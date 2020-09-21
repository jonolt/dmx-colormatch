#ifndef GLOBALS_H
#define GLOBALS_H

#include <stdint.h>
#include <WString.h>

const String VERSION = "0.0.1";

//pins
const uint8_t REDE = 4;
//const uint8_t BUTTON_MAP[] = { EA2, EA3, EA4, EA5, EB1, EB3, EB5, EB7 };
//const uint8_t LED_MAP[] = { EB0, EB2, EB4, EB6, EA6, EA7 };

//data
const uint8_t NUM_REGISTER = 16;  //one based
const uint8_t NUM_COLOR_CHANNELS = 6;
const uint8_t NUM_SENSOR_VALUES = 4;

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

//
//template <typename T>
//String formatValues(T val, const char* formatter){
//    char buff[SPRINTF_BUFFER_SIZE];
//    sprintf(buff, formatter, val);
//    return String(buff);
//}
//
//template <typename T>
//String param_print_values(T array[], int size, const char* formatter)
//{
//    char buff[SPRINTF_BUFFER_SIZE];
//    String str_print;
//    for (int i = 0; i < size; i++)
//    {
//        if(i<size)
//        {
//            str_print += " ";
//        }
//        sprintf(buff, formatter, array[i]);
//        str_print += buff;
//    }
//    return str_print;
//}
//
//
//template <typename T>
//void array_from_string(T target[], String str, uint8_t charsInVal, uint8_t size)
//{
//    uint8_t arr_index=0;
//    for(unsigned int i = 0; i<str.length(); i++)
//    {
//        if(str[i]==' ')
//        {
//            String sub_str = str.substring(i+1, i+1+charsInVal);
//            target[arr_index] = sub_str.toInt();
//            arr_index++;
//            if(arr_index==size)
//            {
//                return;
//            };
//        }
//    }
//}
#endif  // GLOBALS_H

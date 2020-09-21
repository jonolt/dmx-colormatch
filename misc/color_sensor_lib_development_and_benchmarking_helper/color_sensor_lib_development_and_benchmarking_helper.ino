

#include <Wire.h>
#include "TCS34725.h"

#define TEST_PIN 6

TCS34725 sensor;
uint16_t rgbc[4];
uint16_t sum_rgbc[4];


void param_print_values(uint16_t rgbc[]) {
  char buff[32];
  String str_print;
  for (int i = 0; i < 4; i++) {
    sprintf(buff, ", %05d", rgbc[i]);
    str_print += buff;
  }
  Serial.println(str_print);
}

int64_t extract_int(String str) {
  String numString;
  bool inStartsWith = true;
  for (uint8_t i = 0; i < str.length(); i++) {
    char numChar = str.charAt(i);
    if (inStartsWith) {
      if (isDigit(numChar)) {
        inStartsWith = false;
      } else {
        continue;
      }
    }
    if (isDigit(numChar)) {
      numString += numChar;
      continue;
    }
    break;
  }
  return numString.toInt();
}

void setup() {
  pinMode(TEST_PIN, OUTPUT);
  digitalWrite(TEST_PIN, HIGH);
  Wire.setClock(400000);
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin( 115200 );
  sensor = TCS34725();
  if (sensor.begin()) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
  }
  sensor.adjust_background_clear();
  sensor.setIntegrationTime(2.4);
  sensor.setIntegrationTime(4.8);
  sensor.setIntegrationTime(7.2);
  sensor.setIntegrationTime(9.6);
  sensor.setIntegrationTime(12);
  sensor.setIntegrationTime(24);
  sensor.setIntegrationTime(4.8);
  sensor.setGain(TCS34725_GAIN_1X);
}

int i = 15;
unsigned long t_start = 0;
bool old_mode = false;
bool check_valid = false;

void loop() {
  if(Serial.available()){
    String str = Serial.readString();
    if (str=="o\n"){
      old_mode = true;
    }else if (str=="n\n"){
      old_mode = false;
    }else{
      int64_t x = extract_int(str);
      sensor.setIntegrationTime(2.4*x);
    }
  }
  //digitalWrite(TEST_PIN, LOW);
  sensor.startIntegration();  
  while(!sensor.is_integrated())
  if(old_mode==false){
    digitalWrite(TEST_PIN, HIGH);
    sensor.read_data_rgbc(rgbc);
  }else{
    digitalWrite(TEST_PIN, HIGH);
    sensor.read_data_rgbc_old(rgbc);
  }
  digitalWrite(TEST_PIN, LOW);
  param_print_values(rgbc);
  //digitalWrite(TEST_PIN, HIGH);
}

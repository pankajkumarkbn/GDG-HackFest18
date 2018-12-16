#include <dht.h>
#include <SoftwareSerial.h>
dht DHT;
String data, data1;
SoftwareSerial node(8,9);
int temp,humi;

const int xpin = 1;                  // x-axis
const int ypin = 2;                  // y-axis
const int zpin = 3;                  // z-axis 



void setup(){
  Serial.begin(9600);
  node.begin(9600);
  DHT.read11(A5);

}

void loop()
{
 int x = analogRead(xpin);  //read from xpin
int y = analogRead(ypin);  //read from ypin
int z = analogRead(zpin);  //read from zpin 
  humi=DHT.humidity;
  temp=DHT.temperature;

float zero_G = 512.0; //ADC is 0~1023  the zero g output equal to Vs/2
                      //ADXL335 power supply by Vs 3.3V
float scale = 102.3;  //ADXL335330 Sensitivity is 330mv/g
                       //330 * 1024/3.3/1000 

                       
  //Serial.print("Temperature = ");
  //Serial.print(temp);
  //Serial.print("Humidity = ");
  //Serial.print(humi);


float a = (((float)x - 331.5)/65*9.8);  //print x value on serial monitor
float b = (((float)y - 329.5)/68.5*9.8);  //print y value on serial monitor
float c = (((float)z - 340)/68*9.8);  //print z value on serial monitor


  //data = String(":") + String(temp) + String(":")+String(humi);
  //data1 = String(a) + String(":") + String(b) + String(":") + String(c);
  
  data = String(" ") + String(temp) + String(" ") + String(a) + String(" ") + String(b) + String(" ") + String(c);
  
  Serial.println(data);
  node.println(data);
  delay(1000);
}

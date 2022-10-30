#include <Servo.h>
#include <ESP8266WiFi.h>
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
#define WIFI_SSID "KCCOEMSR_Staff"
#define WIFI_PASSWORD "12345678"

/* 2. Define the API Key */
#define API_KEY "AIzaSyDuSnIKGC9nLUr1VZTWMzZkbClLwM4kNZ4"

/* 3. Define the RTDB URL */
#define DATABASE_URL "justpark-21caa-default-rtdb.firebaseio.com" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "manishtalele1410@gmail.com"
#define USER_PASSWORD "Talele@1234"

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

unsigned long count = 0;

Servo myservo;     // create servo object to control a servo
#define echoPin D7  // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin D8  //attach pin D3 Arduino to pin Trig of HC-SR04

// IR sensor port init
int IRSensor1 = D1;   // slot 1 = 8
int IRSensor2 = D2;   // slot 2 = 9
int IRSensor3 = D3;  // slot 3 = 10
int IRSensor4 = D4;  //slot 4 = 11
int IRSensor5 = D5;  // slot 5 = 12
int statusSensor1 = digitalRead(IRSensor1);
int statusSensor2 = digitalRead(IRSensor2);
int statusSensor3 = digitalRead(IRSensor3);
int statusSensor4 = digitalRead(IRSensor4);
int statusSensor5 = digitalRead(IRSensor5);
// defines variables
long duration;  // variable for the duration of sound wave travel
int distance;   // variable for the distance measurement


// twelve servo objects can be created on most boards
int pos = 90;       // variable to store the servo position
int servoPort = D6;  // servo motor port
bool doorState = false;
bool checkSlot = true;

void setup() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

#if defined(ESP8266)
  fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 */, 2048 /* Tx buffer size in bytes from 512 - 16384 */);
#endif
  fbdo.setResponseSize(2048);

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  Firebase.setDoubleDigits(5);
  config.timeout.serverResponse = 10 * 1000;

  pinMode(trigPin, OUTPUT);   // Sets the trigPin as an OUTPUT
  pinMode(echoPin, INPUT);    // Sets the echoPin as an INPUT
  Serial.begin(9600);         // // Serial Communication is starting with 9600 of baudrate speed
  myservo.attach(servoPort);  // attaches the servo on pin to the servo object
  myservo.write(pos);
  // pinMode(IRSensor1, INPUT);
  // pinMode(IRSensor2, INPUT);
  // pinMode(IRSensor3, INPUT);
  // pinMode(IRSensor4, INPUT);
  // pinMode(IRSensor5, INPUT);
  setIRSensor();
}

void setIRSensor() {
  pinMode(IRSensor1, INPUT);
  pinMode(IRSensor2, INPUT);
  pinMode(IRSensor3, INPUT);
  pinMode(IRSensor4, INPUT);
  pinMode(IRSensor5, INPUT);
}

void getStatusSensor() {
  statusSensor1 = digitalRead(IRSensor1);
  statusSensor2 = digitalRead(IRSensor2);
  statusSensor3 = digitalRead(IRSensor3);
  statusSensor4 = digitalRead(IRSensor4);
  statusSensor5 = digitalRead(IRSensor5);

  
  if (statusSensor1 == 0) {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/0"), true);
  } else {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/0"), false);
  }

  if (statusSensor2 == 0) {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/1"), true);
  } else {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/1"), false);
  }

  if (statusSensor3 == 0) {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/2"), true);
  } else {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/2"), false);
  }

  if (statusSensor4 == 0) {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/3"), true);
  } else {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/3"), false);
  }
  
  if (statusSensor5 == 0) {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/4"), true);
  } else {
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/Slots/4"), false);
  }

}



void loop() {
  getStatusSensor();
  GetDistance();
  GetStatus();
  if (distance <= 6 && checkSlot) {
    Serial.print("Distance: ");
    Serial.print(distance);
    Serial.println(" cm");
    Serial.println(statusSensor1);
    Serial.println(statusSensor2);
    Serial.println(statusSensor3);
    Serial.println(statusSensor4);
    Serial.println(statusSensor5);
    OpenDoor();
  }
  

  if (distance > 10 && doorState) {
    CloseDoor();
  }
}


void GetStatus() {
  if (statusSensor1 == 0 && statusSensor2 == 0 && statusSensor3 == 0 && statusSensor4 == 0 && statusSensor5 == 0) {
    checkSlot = false;
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/available"), false);
  } else {
    checkSlot = true;
    Firebase.RTDB.setBool(&fbdo, F("/Parking/0/available"), true);
  }

  
}

void GetDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(1000);
  // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(1000);
  digitalWrite(trigPin, LOW);
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  // Calculating the distance
  distance = duration * 0.034 / 2;  // Speed of sound wave divided by 2 (go and back)
}


void OpenDoor() {

  for (pos = pos; pos >= 0; pos -= 1) {  // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    myservo.write(pos);  // tell servo to go to position in variable 'pos'
    delay(15);           // waits 15ms for the servo to reach the position
  }
  doorState = true;
}
void CloseDoor() {
  for (pos = 0; pos <= 90; pos += 1) {  // goes from 180 degrees to 0 degrees
    myservo.write(pos);                 // tell servo to go to position in variable 'pos'
    delay(15);                          // waits 15ms for the servo to reach the position
  }
  doorState = false;
}
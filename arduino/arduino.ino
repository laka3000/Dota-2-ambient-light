//any questions contact me @ alexandre.karpinski.m@gmail.com or PM me: /u/laka_r

const int d = 6, h = 5, m = 3; //Red, green and blue LEDs, be sure to use PWM ports
int incomingByte;

void setup() {
  Serial.begin(9600); //starts serial communication with processing
  pinMode(d, OUTPUT);
  pinMode(h, OUTPUT);
  pinMode(m, OUTPUT);
}

void loop()
{
  if (Serial.available() > 0)
  {
    incomingByte = Serial.read(); //reads the bytes coming from processing
    //Death indicator
    if (incomingByte == 'A')
    {
      analogWrite(h, 0);
      analogWrite(m, 0);
      analogWrite(d, 255);
    } 
    if (incomingByte == 'B')
    {
      analogWrite(d, 0);
    }

    //Blue LED for mana
    if (incomingByte == '1')
    {
      analogWrite(m, 255);
    }
    if (incomingByte == '2')
    {
      analogWrite(m, 223);
    }
    if (incomingByte == '3')
    {
      analogWrite(m, 191);
    }
    if (incomingByte == '4')
    {
      analogWrite(m, 159);
    }
    if (incomingByte == '5')
    {
      analogWrite(m, 127);
    }
    if (incomingByte == '6')
    {
      analogWrite(m, 101);
    }
    if (incomingByte == '7')
    {
      analogWrite(m, 75);
    }
    if (incomingByte == '8')
    {
      analogWrite(m, 49);
    }
    if (incomingByte == '9')
    {
      analogWrite(m, 17);
    }
    if (incomingByte == '0')
    {
      digitalWrite(m, LOW);
    }


  //Green LED for health
    if (incomingByte == 'a')
    {
      analogWrite(h, 255);
    }
    if (incomingByte == 'b')
    {
      analogWrite(h, 223);
    }
    if (incomingByte == 'c')
    {
      analogWrite(h, 191);
    }
    if (incomingByte == 'd')
    {
      analogWrite(h, 159);
    }
    if (incomingByte == 'e')
    {
      analogWrite(h, 127);
    }
    if (incomingByte == 'f')
    {
      analogWrite(h, 101);
    }
    if (incomingByte == 'g')
    {
      analogWrite(h, 75);
    }
    if (incomingByte == 'h')
    {
      analogWrite(h, 49);
    }
    if (incomingByte == 'i')
    {
      analogWrite(h, 17);
    }
    if (incomingByte == 'j')
    {
      digitalWrite(h, LOW);
    }
  }
}









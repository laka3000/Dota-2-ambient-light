//any questions contact me @ alexandre.karpinski.m@gmail.com or PM me: /u/laka_r

//it works perfectly with Processing 2, haven't tried it with Processing 3 yet, but should be fine

//this code was made before 7.00, and haven't been updated to fit the new UI yet!

import com.onformative.screencapturer.*; //screen capturing library, available on the Processing/libraries on the repository
import processing.serial.*; 
ScreenCapturer capturer;
Serial port; 
int capturerSizeX = 480, capturerSizeY = 30;
int capturerSizeSlice = capturerSizeX/10;  //divides the capturerSizeX by 10, to use it's portions instead of predefined values, like the older version

void setup()
{
  size(480, 30); //canvas size, use the same as the Capturer, has to be set manually, because Processing doesn't let you use variables
  
  capturer = new ScreenCapturer(capturerSizeX, capturerSizeY, 470, 619, 25); //defines the screen capture, (size X, size Y, position X, position Y, frame rate). My resolution is 1366x768, change values if you need
  println(Serial.list()); 
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw()
{
  image(capturer.getImage(), 0, 0);
  readred(); //functions for reading the pixel colors
  readgreen();
  readblue();
}


void readgreen()
{
  //reads the color on the positions (X, Y), writes bytes to serial according to value

  int capturerHealthY = 5; // Y location that is going to be captured, be careful not to pick a pixel that might contain text! Pick something above or bellow the HP/mana text
  
  color a = get(capturerSizeX - 5, capturerHealthY); // you can change the 5 to another value, this is the rightmost pixel on the bar, doesn't have to be exact
  color b = get(capturerSizeSlice*9, capturerHealthY);
  color c = get(capturerSizeSlice*8, capturerHealthY);
  color d = get(capturerSizeSlice*7, capturerHealthY);
  color e = get(capturerSizeSlice*6, capturerHealthY);
  color f = get(capturerSizeSlice*5, capturerHealthY);
  color g = get(capturerSizeSlice*4, capturerHealthY);
  color h = get(capturerSizeSlice*3, capturerHealthY);
  color i = get(capturerSizeSlice*2, capturerHealthY);
  color j = get(capturerSizeSlice, capturerHealthY);
  
  int greenBrightness = 20; //this is the "brightness" that the code is going to use, you can change it if it doesn't work properly
  
  if (green(a) > greenBrightness) //gets the brightness of the color Green on the color variable "a"
  {
    port.write('a'); //sends the byte 'a' to arduino, and so on, see rest of the if tree. Each byte represents a situation on the bar
  } else if (green(b) < greenBrightness && green(c) > greenBrightness)
  {
    port.write('b');
  } else if (green(c) < greenBrightness && green(d) > greenBrightness)
  {
    port.write('c');
  } else if (green(d) < greenBrightness && green(e) > greenBrightness)
  {
    port.write('d');
  } else if (green(e) < greenBrightness && green(f) > greenBrightness)
  {
    port.write('e');
  } else if (green(f) < greenBrightness && green(g) > greenBrightness)
  {
    port.write('f');
  } else if (green(g) < greenBrightness && green(h) > greenBrightness)
  {
    port.write('g');
  } else if (green(h) < greenBrightness && green(i) > greenBrightness)
  {
    port.write('h');
  } else if (green(i) < greenBrightness && green(j) > greenBrightness)
  {
    port.write('i');
  } else if (green(j) < greenBrightness)
  {
    port.write('j');
  }
}



void readblue()
{
  int capturerManaY = 25; // Y location that is going to be captured, be careful not to pick a pixel that might contain text! Pick something above or bellow the HP/mana text
  
  color A = get(capturerSizeX - 5, capturerManaY);
  color B = get(capturerSizeSlice*9, capturerManaY);
  color C = get(capturerSizeSlice*8, capturerManaY);
  color D = get(capturerSizeSlice*7, capturerManaY);
  color E = get(capturerSizeSlice*6, capturerManaY);
  color F = get(capturerSizeSlice*5, capturerManaY);
  color G = get(capturerSizeSlice*4, capturerManaY);
  color H = get(capturerSizeSlice*3, capturerManaY);
  color I = get(capturerSizeSlice*2, capturerManaY);
  color J = get(capturerSizeSlice, capturerManaY);
  
  int blueBrightness = 120; //this is the "brightness" that the code is going to use, you can change it if it doesn't work properly
  
  if (blue(A) > blueBrightness)
  {
    port.write('1');
  } else if (blue(B) < blueBrightness && blue(C) > blueBrightness)
  {
    port.write('2');
  } else if (blue(C) < blueBrightness && blue(D) > blueBrightness)
  {
    port.write('3');
  } else if (blue(D) < blueBrightness && blue(E) > blueBrightness)
  {
    port.write('4');
  } else if (blue(E) < blueBrightness && blue(F) > blueBrightness)
  {
    port.write('5');
  } else if (blue(F) < blueBrightness && blue(G) > blueBrightness)
  {
    port.write('6');
  } else if (blue(G) < blueBrightness && blue(H) > blueBrightness)
  {
    port.write('7');
  } else if (blue(H) < blueBrightness && blue(I) > blueBrightness)
  {
    port.write('8');
  } else if (blue(I) < blueBrightness && blue(J) > blueBrightness)
  {
    port.write('9');
  } else if (blue(J) < blueBrightness)
  {
    port.write('0');
  }
}


void readred()
{ // this is going to send a byte if the bar is red. On the new 7.0 UI, try to pick somewhere that have text, since it is red
  color a = get(capturerSizeSlice, 30);
  
  if (red(a) > 160 && red(a) < 190 && green(a) > 0 && green(a) < 21 && blue(a) > 0 && blue(a) < 21)
  {
    port.write('A');
  } else
  {
    port.write('B');
  }
}

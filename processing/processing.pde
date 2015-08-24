//any questions contact me @ alexandre.karpinski.m@gmail.com or PM me: /u/laka_r
import com.onformative.screencapturer.*; //screen capturing library, you can download it at http://www.onformative.com/lab/screencapturer/
import processing.serial.*; 
ScreenCapturer capturer;
Serial port; 
void setup()
{
  size(480, 30); //canvas size
  capturer = new ScreenCapturer(480, 30, 470, 619, 25); //defines the screen capture, (size X, size Y, position X, position Y, frame rate). My resolution is 1366x768, change values if you need
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
  color a = get(440, 5);
  color b = get(402, 5);
  color c = get(364, 5);
  color d = get(326, 5);
  color e = get(292, 5);
  color f = get(190, 5);
  color g = get(142, 5);
  color h = get(104, 5);
  color i = get(70, 5);
  color j = get(40, 5);
  if (green(a) > 20) //gets the value of green on the color "a"
  {
    port.write('a'); //sends the byte 'a' to arduino, see if trees on the code
  } else if (green(b) < 20 && green(c) > 20)
  {
    port.write('b');
  } else if (green(c) < 20 && green(d) > 20)
  {
    port.write('c');
  } else if (green(d) < 20 && green(e) > 20)
  {
    port.write('d');
  } else if (green(e) < 20 && green(f) > 20)
  {
    port.write('e');
  } else if (green(f) < 20 && green(g) > 20)
  {
    port.write('f');
  } else if (green(g) < 20 && green(h) > 20)
  {
    port.write('g');
  } else if (green(h) < 20 && green(i) > 20)
  {
    port.write('h');
  } else if (green(i) < 20 && green(j) > 20)
  {
    port.write('i');
  } else if (green(j) < 20)
  {
    port.write('j');
  }
}

void readblue()
{
  color A = get(450, 25);
  color B = get(405, 25);
  color C = get(360, 25);
  color D = get(315, 25);
  color E = get(275, 25);
  color F = get(210, 25);
  color G = get(158, 25);
  color H = get(106, 25);
  color I = get(70, 25);
  color J = get(40, 25);
  if (blue(A) > 120)
  {
    port.write('1');
  } else if (blue(B) < 120 && blue(C) > 120)
  {
    port.write('2');
  } else if (blue(C) < 120 && blue(D) > 120)
  {
    port.write('3');
  } else if (blue(D) < 120 && blue(E) > 120)
  {
    port.write('4');
  } else if (blue(E) < 120 && blue(F) > 120)
  {
    port.write('5');
  } else if (blue(F) < 120 && blue(G) > 120)
  {
    port.write('6');
  } else if (blue(G) < 120 && blue(H) > 120)
  {
    port.write('7');
  } else if (blue(H) < 120 && blue(I) > 120)
  {
    port.write('8');
  } else if (blue(I) < 120 && blue(J) > 120)
  {
    port.write('9');
  } else if (blue(J) < 120)
  {
    port.write('0');
  }
}


void readred()
{
  color a = get(45, 20);
  if (red(a) > 160 && red(a) < 190 && green(a) > 0 && green(a) < 21 && blue(a) > 0 && blue(a) < 21)
  {
    port.write('A');
  } else
  {
    port.write('B');
  }
}


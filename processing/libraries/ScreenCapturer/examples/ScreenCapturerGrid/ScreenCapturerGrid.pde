import com.onformative.screencapturer.*;

//this example needs the PeasyCam Library
//http://mrfeinberg.com/peasycam/
import peasy.*;
PeasyCam cam;

ScreenCapturer capturer;
PImage capture; 

void setup() {
  size(600, 600, P3D);
  capturer = new ScreenCapturer(width, height, 30);
  capture = createImage(width, height, RGB);

  cam = new PeasyCam(this, 100);
}

void draw() {
  background(0);
  translate(-width/2, -height/2);
  lights();

  int steps = 10;
  capture = capturer.getImage();
  for (int i = 0; i<width/steps;i++) {
    for (int j = 0; j<height/steps;j++) {
      pushMatrix();
      color c = capture.get(i*steps, j*steps);
      fill(c);
      noStroke();
      float z = brightness(c);
 //   float z = saturation(c);
 
      translate(i*steps, j*steps, z);
      box(steps-2);
      popMatrix();
    }
  }
}


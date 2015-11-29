import com.onformative.screencapturer.*;
import processing.opengl.*;

//this example needs the PeasyCam Library
//http://mrfeinberg.com/peasycam/
import peasy.*;

TexturedWorld world;
ScreenCapturer capturer;
PImage capture;
PeasyCam cam;

public void setup() {
  size(600, 600, OPENGL);
  cam = new PeasyCam(this, 500);
  
  capturer = new ScreenCapturer(400, 400, 30);
  
  world = new TexturedWorld(this, capture, 800);
  world.initializeSphere(35);
}

public void draw() {
  background(0);
  //lights();
  
  capture = capturer.getImage();
  world.renderGlobe();
}


import com.onformative.screencapturer.*;

ScreenCapturer capturer;
void setup() {
  size(600, 600);
  capturer = new ScreenCapturer(width, height, 30);
}

void draw() {
  image(capturer.getImage(), 0, 0);
}


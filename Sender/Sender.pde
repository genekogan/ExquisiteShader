import oscP5.*;
import netP5.*;

String REMOTE_IP = "127.0.0.1";
String NAME = "Gene";
int REMOTE_PORT = 12001;

OscP5 oscP5;
NetAddress location;
float xvalue;

void setup() {
  size(400,400);
  frameRate(25);

  oscP5 = new OscP5(this, 9000);
  location = new NetAddress(REMOTE_IP, REMOTE_PORT);
  
  register();
}


void draw() {
  background(0);  
  stroke(0, 255, 0);
  strokeWeight(2);
  line(xvalue * width, 0, xvalue * width, height);
}

void mouseMoved() {
  xvalue = map(mouseX, 0, width, 0, 1);
  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/shady/"+NAME);
  msg.add(xvalue);
  oscP5.send(msg, location); 
}

void register() {
  OscMessage msg = new OscMessage("/register");
  msg.add(NAME);
  oscP5.send(msg, location); 
}
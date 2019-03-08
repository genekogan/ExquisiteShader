import controlP5.*;
import oscP5.*;
import netP5.*;

int NUM_VALUES = 25;
String REMOTE_IP = "127.0.0.1";
String NAME = "Gene";
int REMOTE_PORT = 12001;

ControlP5 cp5;
OscP5 oscP5;
NetAddress location;
boolean ready;

void setup() {
  size(480, 480);
  frameRate(30);
  ready = false;

  oscP5 = new OscP5(this, 9000);
  location = new NetAddress(REMOTE_IP, REMOTE_PORT);

  cp5 = new ControlP5(this);
  int h = int((height-22.0)/NUM_VALUES);
  for (int i=0; i<NUM_VALUES; i++) {
    cp5.addSlider("value"+nfs(i+1, 3, 0)).setPosition(20,20+h*i).setRange(0,1).setWidth(400).setHeight(h-2);
  }

  register(); 
  ready = true;
}

void controlEvent(ControlEvent theEvent) {
  if (!ready) {
    return;
  }
  //println("id "+theEvent.getController().getId());
  sendOsc();
}

void draw() {
  background(0);  
}

void sendOsc() {
  OscMessage msg = new OscMessage("/shady/"+NAME);
  for (int i=0; i<NUM_VALUES; i++) {
    float value = cp5.getController("value"+nfs(i+1, 3, 0)).getValue();
    msg.add(value);
  }
  oscP5.send(msg, location);
}

void register() {
  OscMessage msg = new OscMessage("/register");
  msg.add(NAME);
  msg.add(NUM_VALUES);
  oscP5.send(msg, location);
}

void oscEvent(OscMessage msg) {
  String address = msg.addrPattern();
  if (address.equals("/wek/outputs")) {
    for (int i=0; i<NUM_VALUES; i++) {
      float value = msg.get(i).floatValue();
      cp5.getController("value"+nfs(i, 3, 0)).setValue(value);      
    }
  }
}

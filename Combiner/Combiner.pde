import oscP5.*;
import netP5.*;

int RECEIVE_PORT = 12001;
int SEND_PORT = 5761;
String REMOTE_IP = "127.0.0.1";
float VALUE_MIN = -3;
float VALUE_MAX = +3;


OscP5 oscP5;
NetAddress location;
PGraphics pg;
ArrayList<Sender> senders;
ArrayList<Float> allValues;
boolean drawingSenders;
boolean timeAuto;
int idxShader = -1;
boolean readyToSend = false;

void setup() {
  size(1280, 720, P2D);

  drawingSenders = false;
  timeAuto = false;
  allValues = new ArrayList<Float>();
  for (int i=0; i<512; i++) {
    allValues.add(random(1));
  }

  senders = new ArrayList<Sender>();
  pg = createGraphics(width, height, P2D);
  oscP5 = new OscP5(this, RECEIVE_PORT);
  location = new NetAddress(REMOTE_IP, SEND_PORT);
}

void draw() {
  if (readyToSend) {
    sendToOf();
    readyToSend = false;
  }
    
  drawSenders();
  
  pushStyle();
  stroke(255);
  fill(255);
  strokeWeight(1);
  for (int i=0; i<512; i++) {
    float x = map(i, 0, 512, 0, width);
    float y = 100 * allValues.get(i);
    line(x, height, x, height-y);
  }
  popStyle();

}

void keyPressed() {
  if (key=='d') {
    drawingSenders = !drawingSenders;
  } else if (key=='t') {
    timeAuto = !timeAuto;
  } else if (key==' ') {
    sendToOf();
  } else if (keyCode==LEFT) {
  } else if (keyCode==RIGHT) {
  }
}

void drawSenders() {
  background(0);
  pushMatrix();
  translate(100, 100);
  textAlign(CENTER);
  for (int s=0; s<senders.size(); s++) {
    String name = senders.get(s).name;
    float x = map(s%5, 0, 5, 0, width);
    float y = map(floor(s/5), 0, 5, 0, height);
    pushMatrix();
    pushStyle();
    translate(x, y);
    fill(0, 100, 0);
    rect(-100, 0, 200, 100);
    int n = senders.get(s).numValues;
    for (int i=0; i<n; i++) {
      float val = senders.get(s).values.get(i);
      float y2 = map(i, 0, n-1, 10, 90);
      //stroke(0);
      //strokeWeight(5);
      //line(-98, y2, 98, y2);
      noStroke();
      fill(255);
      ellipse(map(val, 0, 1, -90, 90), y2, 10, 10);
    }
    fill(255);
    textSize(20);
    text(name, 0, -5);
    popStyle();
    popMatrix();
  }
  popMatrix();
}

void oscEvent(OscMessage msg) {
  String address = msg.addrPattern();
  if (address.equals("/register")) {
    String name = msg.get(0).stringValue();
    int numValues = msg.get(1).intValue();
    senders.add(new Sender(name, numValues));
  }
  else {
    int nTotal = 0;
    for (int s=0; s<senders.size(); s++) {
      String name = senders.get(s).name;
      int numValues = senders.get(s).numValues;
      if (address.equals("/shady/"+name)) {
        for (int i=0; i<numValues; i++) {
          float value = msg.get(i).floatValue();
          int idxS = nTotal + i;
          senders.get(s).setValue(i, value);
          allValues.set(idxS, senders.get(s).getValue(i));
        }
        readyToSend = true;
      }
      nTotal += numValues;
    }
  }
}

void sendToOf() {
  OscMessage msg = new OscMessage("/z");
  for (int i=0; i<512; i++) {
    float value = map(allValues.get(i), 0, 1, VALUE_MIN, VALUE_MAX);
    msg.add(value);
  }
  oscP5.send(msg, location);
}

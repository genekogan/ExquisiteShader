import oscP5.*;
import netP5.*;

int RECEIVE_PORT = 12001;

OscP5 oscP5;
PGraphics pg;
ArrayList<Sender> senders;
ArrayList<Shader> shaders;
Shader shady;
boolean drawingSenders;
boolean timeAuto;
int idxShader = -1;

void setup() {
  size(1920, 1080, P2D);

  drawingSenders = false;
  timeAuto = false;

  senders = new ArrayList<Sender>();
  pg = createGraphics(width, height, P2D);
  oscP5 = new OscP5(this, RECEIVE_PORT);
  
  setupShaders();
  randomizeShaders();
  setShader(0);
}

void draw() {
  if (drawingSenders) {
    drawSenders();
  }
  else {
    drawShader();
  }
}

void keyPressed() {
  if (key=='d') {
    drawingSenders = !drawingSenders;
  } else if (key=='t') {
    timeAuto = !timeAuto;
  } else if (key=='r') {
    randomizeShaders();
  } else if (keyCode==LEFT) {
    //setShader((idxShader+shaders.size()-1)%shaders.size());
  } else if (keyCode==RIGHT) {
    //setShader((idxShader+1)%shaders.size());
  }
}

void drawShader() {
  shady.update();
   
  pg.beginDraw();
  pg.shader(shady.pshader);
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();
  
  background(0);
  image(pg, 0, 0); 
}

void drawSenders() {
  background(0);
  pushMatrix();
  translate(100, 100);
  textAlign(CENTER);
  for (int s=0; s<senders.size(); s++) {
    String name = senders.get(s).name;
    float val = senders.get(s).value;
    float x = map(s%5, 0, 5, 0, width);
    float y = map(floor(s/5), 0, 5, 0, height);
    pushMatrix();
    pushStyle();
    translate(x, y);
    fill(0, 100, 0);
    ellipse(0, 0, 200, 100);
    fill(255);
    ellipse(map(val, 0, 1, -100, 100), 0, 10, 10);
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
    senders.add(new Sender(name));
  }
  else {
    for (int s=0; s<senders.size(); s++) {
      String name = senders.get(s).name;
      if (address.equals("/shady/"+name)) {
        float value = msg.get(0).floatValue();
        int idxP = timeAuto ? s+1 : s;
        senders.get(s).value = value;
        shady.setParameterLerp(idxP, value);
      }
    }
  }
}
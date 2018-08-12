void setupShaders() 
{
  Shader newShader;
  shaders = new ArrayList<Shader>();
  
  // blobby
  newShader = new Shader("sinewave.glsl");
  newShader.addParameter("p1", 0.0001, 5);
  newShader.addParameter("p2", 0.0001, 5);
  newShader.addParameter("p3", 0.0001, 5);
  newShader.addParameter("p4", 0.0001, 8);
  newShader.addParameter("p5", 0.0001, 5);
  newShader.addParameter("p6", 0.0001, 5);
  newShader.addParameter("p7", 0.0001, 5);
  newShader.addParameter("p8", 0.0001, 5);
  newShader.addParameter("p9", 0.0001, 4);
  newShader.addParameter("p10", 0.0001, 4);
  newShader.addParameter("p11", 0.0001, 5);
  newShader.addParameter("p12", 0.0001, 6);
  newShader.addParameter("p13", 0.0001, 5);
  newShader.addParameter("p14", 0.0001, 4);
  newShader.addParameter("p15", 0.0001, 6);
  shaders.add(newShader);
  
 
  /*
  newShader = new Shader("monjori.glsl");
  newShader.addParameter("p1", 0,1);
  newShader.addParameter("p2", 390,410);
  newShader.addParameter("p3", 390,410);
  newShader.addParameter("p4", 190,210);
  newShader.addParameter("p5", 190,210);
  newShader.addParameter("p6", 25,40);
  newShader.addParameter("p7", 40,50);
  newShader.addParameter("p8", 750,900);
  newShader.addParameter("p9", 120,170);
  newShader.addParameter("p10", 210,220);
  newShader.addParameter("p11", 145,150);
  newShader.addParameter("p12", 333,367);
  newShader.addParameter("p13", 110,120);
  newShader.addParameter("p14", 8,9);
  newShader.addParameter("p15", 0.45,0.55);
  shaders.add(newShader);
  */
}

void randomizeShaders() {
  for (Shader shader : shaders) {
    shader.randomize();
  }
}

void setShader(int idxNextShader) {
  idxShader = idxNextShader;
  shady = shaders.get(idxShader); 
}
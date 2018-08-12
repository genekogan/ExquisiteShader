class Shader
{
  String path;
  PShader pshader;
  ArrayList<Param> parameters;
  
  Shader(String path) {
    this.path = path;
    pshader = loadShader(path);
    parameters = new ArrayList<Param>();
  }
  
  void addParameter(String name, float minVal, float maxVal) {
    Param param = new Param(name, minVal, maxVal);
    parameters.add(param);
  }
  
  void setParameterLerp(int idx, float value) {
    parameters.get(idx).setLerp(value);
  }
  
  void update() {
    float time = (float) millis()/1000.0; 
    if (!timeAuto) {
      time = parameters.get(0).value;
    }
    pshader.set("time", time);
    pshader.set("resolution", float(width), float(height));
    int p0 = timeAuto ? 0 : 1;
    for (int p=p0; p<parameters.size(); p++) {
      pshader.set(parameters.get(p).name, parameters.get(p).value);
    }
  }
  
  void randomize() {
    for (Param p : parameters) {
      p.setLerp(random(1));
    }
  }
}
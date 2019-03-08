class Sender {
  
  String name;
  ArrayList<Float> values;
  int numValues;
  
  Sender(String name, int numValues) {
    this.name = name;
    this.numValues = numValues;
    this.values = new ArrayList<Float>();
    for (int i=0; i<numValues; i++) {
      values.add(0.0);
    }
  }
  
  void setValue(int idx, float value) {
    values.set(idx, value);
  }
  
  float getValue(int idx) {
    return values.get(idx);
  }
}

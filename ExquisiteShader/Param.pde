class Param 
{
  String name;
  float value;
  float minValue, maxValue;
  
  Param(String name, float minValue, float maxValue) {
    this.name = name;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = 0.5 * (minValue + maxValue);
  }

  void setLerp(float lvalue) {
    this.value = map(lvalue, 0, 1, minValue, maxValue);
  }
  
  void set(float value) {
    this.value = value;
  }
}
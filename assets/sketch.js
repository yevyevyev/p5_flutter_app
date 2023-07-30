function setup() {
  createCanvas(screenWidth, screenHeight, WEBGL);
  describe('the light is partially ambient and partially directional');
}
function draw() {
  background(0);
  lights();
  rotateX(millis() / 1000);
  rotateY(millis() / 1000);
  rotateZ(millis() / 1000);
  box();
}
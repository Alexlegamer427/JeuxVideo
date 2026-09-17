//Par Alexis Grenier

class Player {
  PVector position;
  float speed;
  float radius;

  Player(float x, float y, float radius) {
    this.position = new PVector(x, y);
    this.radius = radius;
    this.speed = 4;
  }

  void update() {
   
    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        position.x -= speed;
      }
      if (key == 'd' || key == 'D') {
        position.x += speed;
      }
    }

    position.x = constrain(position.x, radius, width - radius);
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    fill(220, 30, 30);
    rectMode(CENTER);
    rect(position.x, position.y, radius * 2, radius * 2);
  }

  
  PVector getPosition() {
    return position;
  }
}

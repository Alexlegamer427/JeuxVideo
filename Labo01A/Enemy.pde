//Par Alexis Grenier

class Enemy {

  PVector anchor;       
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float restLength;      // longueur de repos
  float maxLength;       // longueur maximale 
  float kActif;          // raideur actif
  float kRepos;          // raideur repos
  float damping;         // amortissement
  float propagation;     // perte de force


  float activationDistance;
  float deactivationDistance;
  String state; // "REPOS", "ACTIF" de dispo


  boolean avantDernierChiffrePair = false;

  float radius;

  Enemy(float anchorX, float anchorY, float restLength, float radius, float lenghtMult) {
    this.anchor = new PVector(anchorX, anchorY);
    this.restLength = restLength;
    this.maxLength = restLength * lenghtMult; 
    this.position = new PVector(anchorX, anchorY + restLength);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.mass = 1;
    
    this.kActif = 0.03;   // souple -> étirement ++
    this.kRepos = 0.15;   // rigide -> retour rapide
    this.damping = 0.9; //etouffement
    
    this.radius = radius;

    // valeurs par défaut
    this.activationDistance = 150;
    this.deactivationDistance = 220;
    this.propagation = 0.5;

    this.state = "REPOS";
  }

  //methode du lab parametrable
  void setDistance(float activation, float deactivation) {
    this.activationDistance = activation;
    this.deactivationDistance = deactivation;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void checkState(Player player) {
    float d = PVector.dist(position, player.getPosition());

    if (state.equals("REPOS") && d < activationDistance) {
      state = "ACTIF";
    } else if (state.equals("ACTIF") && d > deactivationDistance) {
      state = "REPOS";
    }
  }

  void update(Player player) {
    checkState(player);

    applyForce(new PVector(0, 0.4 * mass));

    if (state.equals("ACTIF")) {
      PVector attaque = PVector.sub(player.getPosition(), position);
      attaque.setMag(1.2);
      applyForce(attaque);
    }

    //Hooke - elastique
    float k = state.equals("ACTIF") ? kActif : kRepos;
    PVector spring = PVector.sub(position, anchor);
    float currentLength = spring.mag();
    float stretch = currentLength - restLength;
    spring.normalize();
    spring.mult(-1 * k * stretch);
    applyForce(spring);

    
    velocity.add(acceleration);
    velocity.mult(damping);
    position.add(velocity);
    acceleration.mult(0);

    //contrainte on limite
    PVector fromAnchor = PVector.sub(position, anchor);
    if (fromAnchor.mag() > maxLength) {
      fromAnchor.setMag(maxLength);
      position = PVector.add(anchor, fromAnchor);
      velocity.mult(this.propagation);  //reduit la force 
    }
  }

  // Debug -> pour du visible au labo
  void displayDebug() {
    noFill();
    strokeWeight(1);

    stroke(255, 150, 0); 
    ellipse(position.x, position.y, activationDistance * 2, activationDistance * 2);

    stroke(0, 150, 255); 
    ellipse(position.x, position.y, deactivationDistance * 2, deactivationDistance * 2);
  }

  void display() {
    
    stroke(20, 60, 20); 
    ellipse(anchor.x, anchor.y, 10, 10);
     
    stroke(120);
    strokeWeight(2);
    line(anchor.x, anchor.y, position.x, position.y);

    noStroke();
    if (state.equals("ACTIF")) {
      fill(220, 50, 50); 
    } else {
      fill(90); 
    }

    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}

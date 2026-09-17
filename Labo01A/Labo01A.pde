//Par Alexis Grenier 6308958

Player player;
Enemy enemy;

int activeRadius = 160;
int restRadius = 190;
int cordRestLength = 160;
float cordLengthMult = 1.8; // longueur en rest vs actif 



void setup() {
  size(800, 400);
  player = new Player(width / 2, height - 50, 20);
  enemy = new Enemy(width / 2, 30, cordRestLength, 25, cordLengthMult); // (position corde x , y ,longeur corde, tailleEnnemie, multiplicateurTailleCordeActive) 
  
  enemy.setDistance(activeRadius, restRadius);
}

void draw() {
  background(240);

  player.update();
  enemy.update(player);

  enemy.displayDebug(); //pour les radius de detection
  player.display();
  enemy.display();
}

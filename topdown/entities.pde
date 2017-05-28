abstract class Entity extends DynamicObject {
  float health, power;
  
  Entity(float x, float y) {super(x, y);}
  
  boolean isAlive() {return health > 0.0;}
  
  abstract void update();
  
  abstract void getHit(float damage);
  
  // abstract void drawObject();
}


class Player extends Entity {
  
  PImage img = loadImage("Player.png");
  float[][] moves = { {10, 0} , {-10, 0},
                      {10, 10} , {-10, 10},
                      {0, 10} , {0, -10},
                      {-10, -10} , {10, -10} };
  
  public Player(float x, float y) {
    super(x, y);
    yVelocity = 0;
    xVelocity = 0;
    health = 10.0;
    power = 1.0;
  }
  
  void getHit(float damage) {}
  
  void update() {}
  
  void drawObject() {
    fill(0, 0, 255);
    //pushMatrix();
    //translate(xPos, yPos);
    //rotate(HALF_PI);
    //image(img, xPos, yPos, 20, 20);
    //popMatrix();
    ellipse(xPos, yPos, 10, 10);
  }
  
  void attack () {
    rectMode(CENTER);
    fill(0, 0, 255);
     rect(xPos, yPos, 10, 10);
    for (float[] ary : moves) {
      rect(xPos + ary[0], yPos + ary[1], 10, 10);
    }
    rectMode(CORNER);
  }
  
}


class Enemy extends Entity {
  Enemy(float x, float y) {
    super(x, y);
    xVelocity = 0.5;
    yVelocity = 0.5;
  }
  
  void getHit(float damage) {
    health -= damage;
  }
  
  void drawObject() {
    fill(255, 0, 0);
    rect(xPos, yPos, 10, 10);
  }
  
  void update() {
    PriorityQueue pq = new PriorityQueue();
    int toPlayer = (int)(Math.abs(xPos - p.xPos) + Math.abs(yPos - p.yPos));
    /*Node(Location, prev Node, distTraveled, distLeft, astar?)*/
    pq.add(new Node(new Location(xPos, yPos), null, 0, toPlayer, true));
    if(xPos < p.xPos) xPos += xVelocity;
    else if(xPos > p.xPos) xPos -= xVelocity;
    if(yPos < p.yPos) yPos += yVelocity;
    else if(yPos > p.yPos) yPos -= yVelocity;
  }
}
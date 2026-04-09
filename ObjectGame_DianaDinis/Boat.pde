class Boat
{
  float boatX;
  float boatY;
  
  float fishingLineX;
  float fishingLineY; 
  
  int speed;
  
  boolean upPressed, downPressed, leftPressed, rightPressed; 
  
  Boat()
  {
    boatX = width/2;
    boatY = 100;
    speed = 3;
    fishingLineY = boatY+40;
    fishingLineX = boatX+40;
  }
  
  void display()
  {
    // draw boat
    fill(0);
    rect(boatX, boatY, 60, 20);
    
    // draw fishing line
    stroke(0);
    strokeWeight(3);
    line(boatX+40,boatY-30,boatX+40,fishingLineY);
    
    // 
    stroke(0,255,20);
    strokeWeight(10);
    point(boatX+40, fishingLineY);
  }
  
  void update()
  {
    // boat movement
    if (leftPressed)  boatX -= speed;
    if (rightPressed) boatX += speed;
    
    // fishing line movement 
    if (upPressed)    fishingLineY -= speed;
    if (downPressed)  fishingLineY += speed;
    // prevent fishing line from going to space
    fishingLineY = constrain(fishingLineY,boatY,height);
  }
}

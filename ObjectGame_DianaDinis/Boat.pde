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
    fishingLineX = boatX+50;
  }
  
  void display()
  {
    // draw fishing line
    stroke(140);
    strokeWeight(3);
    line(boatX+50,boatY-30,fishingLineX,fishingLineY);
    
    // draw fishing rod
    stroke(150,95,2);
    strokeWeight(3);
    line(boatX+20,boatY+5,boatX+50,boatY-30);

    // draw lure
    stroke(185,10,10);
    strokeWeight(10);
    point(fishingLineX, fishingLineY);
    
    // draw boat
    noStroke();
    fill(140,65,65);
    arc(boatX, boatY, 80, 30, 0, PI);
    
    // draw sail
    fill(255);
    triangle(boatX,boatY-50,boatX,boatY-20,boatX+20,boatY-20);
    stroke(140,65,65);
    strokeWeight(5);
    line(boatX,boatY,boatX,boatY-50);
  }
  
  void update()
  {
    // boat movement
    if (leftPressed)  
    {
      boatX -= speed;
      fishingLineX -= speed;
    }
    if (rightPressed)
    {
      boatX += speed;
      fishingLineX += speed;
    }
    
    
    // fishing line movement 
    if (upPressed)    fishingLineY -= speed;
    if (downPressed)  fishingLineY += speed;
    // prevent fishing line from going to space
    fishingLineY = constrain(fishingLineY,boatY,height);
    boatX = constrain(boatX, -10, width+10);
    fishingLineX = constrain(fishingLineX, 40, width+60);
  }
}

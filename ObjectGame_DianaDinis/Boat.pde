class Boat
{
  float boatX;
  float boatY;
  
  float fishingLineX;
  float fishingLineY; 
  
  int boatSpeed;
  int reelSpeed;
  
  int lureColor;
    
  boolean upPressed, downPressed, leftPressed, rightPressed; 
  
  Boat()
  {
    boatX = width/2;
    boatY = 100;
    boatSpeed = 3;
    reelSpeed = 3;
    fishingLineY = boatY+40;
    fishingLineX = boatX+50;
    lureColor = color(185,10,10);
  }
  
  void display()
  {
    // draw fishing line
    stroke(140); // grey
    strokeWeight(3);
    line(boatX+50,boatY-30,fishingLineX,fishingLineY);
    
    // draw fishing rod
    stroke(150,95,2); // light brown
    strokeWeight(3);
    line(boatX+20,boatY+5,boatX+50,boatY-30);

    // draw lure
    stroke(lureColor); //red
    strokeWeight(10);
    point(fishingLineX, fishingLineY);
    
    // draw boat
    noStroke();
    fill(140,65,65); // reddish brown
    arc(boatX, boatY, 80, 30, 0, PI);
    
    // draw sail
    fill(255); //white
    triangle(boatX,boatY-50,boatX,boatY-20,boatX+20,boatY-20);
    stroke(140,65,65); // reddish brown
    strokeWeight(5);
    line(boatX,boatY,boatX,boatY-50);
  }
  
  void update()
  {
    // boat movement
    if (leftPressed)  
    {
      boatX -= boatSpeed;
      fishingLineX -= boatSpeed;
    }
    if (rightPressed)
    {
      boatX += boatSpeed;
      fishingLineX += boatSpeed;
    }
    
    
    // fishing line movement 
    if (upPressed)    fishingLineY -= reelSpeed;
    if (downPressed)  fishingLineY += reelSpeed;
    // prevent fishing line from going to space
    fishingLineY = constrain(fishingLineY,boatY,height);
    // prevent boat and fishing line from going off screen
    boatX = constrain(boatX, -10, width+10);
    fishingLineX = constrain(fishingLineX, 40, width+60);
  }
  
  void boatReset()
  {
    boatX = width/2;
    boatY = 100;
    boatSpeed = 3;
    reelSpeed = 3;
    fishingLineY = boatY+40;
    fishingLineX = boatX+50;
    lureColor = color(185,10,10);
  }
}

Timer timer;
Boat boat;
ArrayList<Fish> fishes;

boolean gameStart = false;
boolean gameOver = false;
boolean canCatch = true;
int fishCounter = 0;

void setup()
{
  size(400, 400);
  //fullScreen();
  rectMode(CENTER);
  timer = new Timer();
  boat = new Boat();
  fishes = new ArrayList<Fish>();
}

void draw()
{
  background(200, 255, 255);
  if (gameStart)
  {
    timer.display();
    spawnAndUpdateFish();
    boat.display();
    boat.update();
    if (timer.secDown <= 0)
    {
      background(0); // placeholder
      timer.secDown = 0;
      gameStart = false;
      gameOver = true;
    }
  } 
  else if (!gameStart && !gameOver)
  {
    startScreen();
  } 
  else if (gameOver)
  {
    endScreen();
  }
}


//////////
// Fish //
//////////
void spawnAndUpdateFish()
{
  // spawn new fish every 30 frames
  if (frameCount % 30 == 0)
  {
    Fish f = new Fish();
    fishes.add(f);
  }

  // move and draw fish
  for (int i = fishes.size() - 1; i >= 0; i--)
  {
    fishes.get(i).update();
    fishes.get(i).display();
    canCatch = false;
    
    for (int j = 0; j < fishes.size(); j++)
    {
      if (fishes.get(j).caught) {
        canCatch = true;
        break;
      }
    }
    

    if (fishCollision(i))
    {
      //fishes.get(i).fishColor = color(255, 0, 0);
      //fishes.get(i).display();

      if (fishes.get(i).caught == false && !canCatch)
      {
        if(fishes.get(i).size >= 18)
        {
           boat.reelSpeed = 1; 
        }
        else if(fishes.get(i).size >= 14 && fishes.get(i).size <= 17)
        {
           boat.reelSpeed = 2; 
        }
        else
        {
           boat.reelSpeed = 3; 
        }
        boat.lureColor = color(0,1);
        fishes.get(i).setCaught();
      }
    }
    removeFish(i);
  }
}

boolean fishCollision(int i)
{
    // fish collision
    // followed tutorial from Jeffrey Thompson
    // https://www.jeffreythompson.org/collision-detection/point-rect.php
   return boat.fishingLineX+5 >= fishes.get(i).position.x &&
      boat.fishingLineX-5 <= (fishes.get(i).position.x + fishes.get(i).size) &&
      boat.fishingLineY+5 >= fishes.get(i).position.y &&
      boat.fishingLineY-5 <= fishes.get(i).position.y + fishes.get(i).size;  
}

void removeFish(int i)
{
    // remove off screen fish
    if (fishes.get(i).position.x <= -10 && !fishes.get(i).caught ||
      fishes.get(i).position.x >= width+10 && !fishes.get(i).caught)
    {
      fishes.remove(i);
    } 
    // remove caught fish after being reeled up
    else if (fishes.get(i).caught == true)
    {
      fishes.get(i).reelFish();
      if (fishes.get(i).position.y == 100)
      {
        fishes.remove(i);
        fishCounter++;
        canCatch = true;
        boat.reelSpeed = 3;
        boat.lureColor = color(185,10,10);
      }
    } 
}

//////////////
// Controls //
//////////////
void keyPressed()
{
  if (!gameStart && !gameOver)
  {
    gameStart = true;
    timer.startTimer();
  } 
  else if (!gameOver && gameStart)
  {
    if (key == 'W' || key == 'w') boat.upPressed = true;
    if (key == 'S' || key == 's') boat.downPressed = true;
    if (key == 'A' || key == 'a') boat.leftPressed = true;
    if (key == 'D' || key == 'd') boat.rightPressed = true;
  }
}

void keyReleased()
{
  if (!gameOver && gameStart)
  {
    if (key == 'W' || key == 'w') boat.upPressed = false;
    if (key == 'S' || key == 's') boat.downPressed = false;
    if (key == 'A' || key == 'a') boat.leftPressed = false;
    if (key == 'D' || key == 'd') boat.rightPressed = false;
  }
}

void mousePressed()
{
  if (gameOver && mouseX >= 175 && mouseX <= 225 && mouseY >= 175 && mouseY <= 225)
  {
    retry();
  }
}

//////////////////////////
// Game State Functions //
//////////////////////////
void startScreen()
{
  background(155);
  fill(0);
  text("Press any key to Start", 150, 200);
}

void endScreen()
{
  background(100, 100, 100);
  fill(0);
  text("Game Over", 150, 100);
  fill(0, 0, 255); // blue rect as placeholder for retry button
  noStroke();
  rect(width/2, height/2, 50, 50);
}

void retry()
{
  gameOver = false;
}

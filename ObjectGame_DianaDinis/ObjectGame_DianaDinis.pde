/* 
    Game Information - Fishing
    
    Click the play button to begin.
    Move the boat left and right with A and D keys
    Move the fishing line up and down with W and S keys
    When the lure collides with a fish, you've caught it!
    Reel it in with W. Big fish take longer to reel but are worth more points!
    5 for big fish, 3 for medium fish, 1 for small fish.
    You've got 1 minute to catch as many as possible. Aim for a high score!
    Click the Retry button after time up to return to Start
*/

// object variables
Timer timer;
Boat boat;
ArrayList<Fish> fishes;

// game state variables
boolean gameStart = false;
boolean gameOver = false;

// fish related variables
boolean canCatch = true;
int fishScore = 0;

void setup()
{
  size(400, 400);
  rectMode(CENTER);
  // initialize objects
  timer = new Timer();
  boat = new Boat();
  fishes = new ArrayList<Fish>();
}

void draw()
{
  background(200, 255, 255); // light blue
  
  // water
  noStroke();
  fill(10,155,245); // blue
  rect(width/2,260,width,300);
  
  spawnAndUpdateFish(); // draw fish, allows for old fish to be removed 
  // once game started, draw all elements
  if (gameStart)
  {
    timer.display();
    boat.display();
    boat.update();

    drawScore();
    // when time runs out end game
    if (timer.secDown <= 0)
    {
      timer.secDown = 0;
      gameStart = false;
      gameOver = true;
    }
  } 
  // display start screen if game hasn't begun
  else if (!gameStart && !gameOver)
  {
    startScreen();
  } 
  // display end screen once game ends
  else if (gameOver)
  {
    endScreen();
  }
}

///////////////////
// Score Display //
///////////////////
void drawScore()
{
  fill(0);
  textSize(20);
  
  if(!gameOver)
  {
    text(fishScore, 5, 30);
  }
  else if(gameOver)
  {
    text("Final Score: " + fishScore, 150, 30);
  }
}

//////////
// Fish //
//////////
void spawnAndUpdateFish()
{
  // spawn new fish every 30 frames
  if (frameCount % 30 == 0 && gameStart)
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

    // checks if fish can be caught, prevents catching multiple fish at once
    for (int j = 0; j < fishes.size(); j++)
    {
      if (fishes.get(j).caught)
      {
        canCatch = true;
        break;
      }
    }

    // checks if fish and lure have collided
    if (fishCollision(i))
    {
      // checks if fish has not already been caught
      if (fishes.get(i).caught == false && !canCatch)
      {
        // changes reel speed based on fish size
        if (fishes.get(i).size >= 18)
        {
          boat.reelSpeed = 1;
        } 
        else if (fishes.get(i).size >= 14 && fishes.get(i).size <= 17)
        {
          boat.reelSpeed = 2;
        } 
        else
        {
          boat.reelSpeed = 3;
        }
        // hide lure
        boat.lureColor = color(0, 1);
        // fish is caught
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
  // remove fish if game is over
  if(gameOver)
  {
    fishes.remove(i); 
  }
  // remove off screen fish
  else if (fishes.get(i).position.x <= -10 && !fishes.get(i).caught ||
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
      // calculate score based off fish size
      if (fishes.get(i).size <= 13)
      {
        fishScore += 1;
      } 
      else if (fishes.get(i).size <= 17 && fishes.get(i).size >= 14)
      {
        fishScore += 3;
      } 
      else if (fishes.get(i).size >= 18)
      {
        fishScore += 5;
      }
      fishes.remove(i);
      canCatch = true; // reset catching ability
      boat.reelSpeed = 3; // reset reel speed
      boat.lureColor = color(185, 10, 10); // reset lure color
    }
  } 
}

//////////////
// Controls //
//////////////
void keyPressed()
{
  if (!gameOver && gameStart)
  {
    if (key == 'W' || key == 'w') boat.upPressed = true;
    if (key == 'S' || key == 's') boat.downPressed = true;
    if (key == 'A' || key == 'a') boat.leftPressed = true;
    if (key == 'D' || key == 'd') boat.rightPressed = true;
  }
}

void keyReleased()
{
  if (key == 'W' || key == 'w') boat.upPressed = false;
  if (key == 'S' || key == 's') boat.downPressed = false;
  if (key == 'A' || key == 'a') boat.leftPressed = false;
  if (key == 'D' || key == 'd') boat.rightPressed = false;
}

void mousePressed()
{
  if (!gameStart && !gameOver &&
    mouseX >= 165 && mouseX <= 240 && mouseY >= 210 && mouseY <= 290)
  {
    gameStart = true;
    timer.startTimer();
  }

  if (gameOver && mouseX >= 165 && mouseX <= 240 && mouseY >= 210 && mouseY <= 290)
  {
    retry();
  }
}

//////////////////////////
// Game State Functions //
//////////////////////////
void startScreen()
{
  // simple sunrise scene
  noStroke();
  background(200, 255, 255);
  fill(145,225,240); // light blue
  rect(width/2, 75, width, 50);
  fill(0,180,215); // blue
  rect(width/2, 25, width, 50);
  fill(255,215,165); // orange
  rect(width/2, 125, width, 50);
  fill(255,175,175); // red
  ellipse(width/2, 150, 50,50);
  fill(0,150,215); // darker blue
  rect(width/2, 275, width, 250);
  drawStartButton();
}

void drawStartButton()
{
  fill(5, 130, 40); //green
  rect(width/2, 250, 75, 75, 15);
  fill(240, 220, 25); // gold
  triangle(180, 225, 180, 275, 225, 250);
}

void endScreen()
{
  // simple sunset scene
  noStroke();
  fill(245,195,225); // light pink
  rect(width/2, 75, width, 50);
  fill(215,145,170); // pink
  rect(width/2, 25, width, 50);
  fill(255,185,100); // orange
  rect(width/2, 125, width, 50);
  fill(250,220,45); // yellow
  ellipse(width/2, 150, 50,50);
  fill(95,145,235); // purple blue
  rect(width/2, 275, width, 250);
  drawRetryButton();
  drawScore();
}

void drawRetryButton()
{
  fill(5, 130, 40); //green
  rect(width/2, 250, 75, 75, 15);
  fill(250,220,45);
  ellipse(width/2,250,60,59);
  fill(5, 130, 40); // green to blend with background 
  ellipse(width/2,250,39,40);
  rect(185,270,25,25); // rect to cut off part of ellipse to make arrow
  fill(250,220,45);
  triangle(191,250,186,276,164,261); // arrow head
}

void retry()
{
  gameOver = false;
  fishScore = 0;
  boat.boatReset();
}

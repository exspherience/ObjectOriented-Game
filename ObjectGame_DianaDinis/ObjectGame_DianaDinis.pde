Timer timer;
Boat boat;

boolean gameStart = false;
boolean gameOver = false;

void setup()
{
  size(400, 400);
  //fullScreen();
  rectMode(CENTER);
  timer = new Timer();
  boat = new Boat();
}

void draw()
{
  background(200, 255, 255);
  if (gameStart)
  {
    timer.display();
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
  rect(width/2, height/2, 50, 50);
}

void retry()
{
  gameOver = false;
}

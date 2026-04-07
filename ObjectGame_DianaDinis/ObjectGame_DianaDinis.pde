Timer timer;
boolean gameStart = false;
boolean gameOver = false;

void setup()
{
  size(400, 400);
  //fullScreen();
  timer = new Timer();
}

void draw()
{
  background(200, 255, 255);
  if (gameStart)
  {
    timer.display();
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

void keyPressed()
{
  if (!gameStart && !gameOver)
  {
    gameStart = true;
    timer.startTimer();
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
  rectMode(CENTER);
  rect(width/2, height/2, 50, 50);
}

void retry()
{
  gameOver = false;
}

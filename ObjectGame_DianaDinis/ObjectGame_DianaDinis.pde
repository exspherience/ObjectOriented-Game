Timer timer;
boolean gameStart = false;

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
    }
  }
}

void keyPressed()
{
  if (!gameStart)
  {
    gameStart = true;
    timer.startTimer();
  }
}

Timer timer;

void setup()
{
  size(400,400);
  //fullScreen();
  timer = new Timer();
}

void draw()
{
  background(200,255,255);
  timer.display();
  
  if(timer.secDown <= 0)
  {
    background(0); // placeholder 
  }
}

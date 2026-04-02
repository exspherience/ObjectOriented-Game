class Timer
{
  int interval;
  int secDown;
  int elapsed;

  Timer()
  {
    interval = 120000; //120 seconds
  }

  void display()
  {
    calculateTime();
    // displays time as text
    fill(0);
    textSize(20);
    text(secDown, 5, 20);
  }

  void calculateTime()
  {
    elapsed = millis()/1000; // set elapsed time in seconds
    secDown = interval/1000 - elapsed; // decrease seconds
  }
}

class Timer
{
  int interval;
  int secDown;
  int elapsed;
  int startTime;

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
    elapsed = millis()/1000;
    secDown = interval/1000 - (elapsed - startTime); // decrease seconds
  }
  
  void startTimer()
  {
    startTime = millis()/1000;
  }
}

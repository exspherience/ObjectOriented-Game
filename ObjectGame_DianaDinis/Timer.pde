class Timer
{
  float interval;
  float secDown;
  float elapsed;
  float startTime;
  float timerLength;

  Timer()
  {
    interval = 60000; // 1 minute default time, change this to make the game longer or shorter
    
  }

  void display()
  {
    calculateTime();
    // displays time as rectangle
    noStroke();
    fill(0,140,40); // dark green
    rect(0, 0, timerLength-1, 10); // rect along top instead of text timer
  }

  void calculateTime()
  {
    elapsed = millis()/1000;
    secDown = interval/1000 - (elapsed - startTime); // decrease seconds
    // calculates length of timer, decreases it every second
    // math makes it so timer reaches starts at width and will end at 0 when timer ends
    timerLength = secDown * ((width/(interval/1000))*2); 
  }
  
  void startTimer()
  {
    // starts the timer using millis, calculates it so its in seconds
    startTime = millis()/1000;
  }
}

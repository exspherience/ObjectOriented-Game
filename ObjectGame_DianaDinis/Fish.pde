class Fish
{
  // vectors for movement
  PVector position;
  PVector velocity;
  PVector acceleration;

  float spawnX; // x position for fish spawn location
  float size;
  
  color fishColor;
  boolean caught;
 
  Fish()
  {
    // make fish spawn on edges of screen
    if(random(1) > 0.5) spawnX = width;
    else spawnX = 0;
    
    size = random(10,20); // randomize fish size
    
    // set Pvectors
    position = new PVector(spawnX, random(150, height-20)); // spawn at spawnX and random height below 150
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    size = random(10,30);
    fishColor = color(0,255,0);
  }
  
  void update()
  {
    // set horizontal acceleration
    if (frameCount % 30 == 0)
    {
      // move right with some minor variation if fish start on left side
      if(spawnX == 0) 
      {
        acceleration.set(random(-0.1,0.2),0);
      }
      // move left with minor variation if fish start on right
      else
      {
        acceleration.set(random(-0.2,0.1), 0);
      }
    }
    velocity.add(acceleration);
    position.add(velocity);
    
    // limit total velocity so fish don't go too fast
    velocity.limit(3);
  }
  
  // draw fish
  void display()
  {
    fill(0);
    text(fishCounter, 5, 50);
      
    noStroke();
    fill(fishColor);
    ellipse(position.x, position.y, size+20,  size);
    
    fill(0, 50);
    rect(position.x, position.y, size+20, size);
  }

  void setCaught()
  {
    caught = true;
  } 
  
  void reelFish()
  {
    velocity.set(0, 0);
    acceleration.set(0, 0);
    position.set(boat.boatX+40, boat.fishingLineY);
  }
  
}

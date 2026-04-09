class Fish
{
  // vectors for movement
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float accelDirection;
  float spawnX;
  float size;
  
  Fish()
  {
    if(random(1) > 0.5) spawnX = width;
    else spawnX = 0;
    
    size = random(10,20);
    
    position = new PVector(spawnX, random(150, height-20));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    size = random(10,30);
  }
  
  void update()
  {
    if (frameCount % 30 == 0)
    {
      if(spawnX == 0) 
      {
        acceleration.set(random(-0.1,0.2),0);
      }
      else
      {
        acceleration.set(random(-0.2,0.1), 0);
      }
    }
    velocity.add(acceleration);
    position.add(velocity);
    
    velocity.limit(3);
  }
  
  void display()
  {
    noStroke();
    fill(100);
    ellipse(position.x, position.y, size+20,  size-5);
  }
  
}

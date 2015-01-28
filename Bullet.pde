class Bullet extends GameObject
{
  float x, y;
  boolean bulletAlive;
  Bullet()
  {
    x = width / 2;
    y = height / 2;
    direction = 0;
    bulletAlive = true;
  }
  
  void update()
  {
    speed = 10.0f;
    if (direction == 0)
    {
      y -= speed;
    }
    if (direction == 1)
    {
      y += speed;
    }
    if (direction == 2)
    {
      x -= speed;
    }    
    if (direction == 3)
    {
      x += speed;
    }
    
    for(int j = 0; j < obstacles.size(); j++)
    {
      if(x+1 >= obstacles.get(j).pos.x && x-1 <= obstacles.get(j).pos.x +50)
      {
        if(y+1 >= obstacles.get(j).pos.y && y-1 <= obstacles.get(j).pos.y + 50)
        {
          bulletAlive=false;
        }
      }
    }
    for(int j = 0; j < zombies.size(); j++)
    {
      if(x+1 >= zombies.get(j).pos.x && x-1 <= zombies.get(j).pos.x +20)
      {
        if(y+1 >= zombies.get(j).pos.y && y-1 <= zombies.get(j).pos.y + 20)
        {
          bulletAlive=false;
          zombies.get(j).zombieAlive=false;
        }
      }
    }
    
    
    if(x > width)    
    {
    x = 0;
    }
    if(x < 0)    
    {
    x = width;
    }    
    if(y > height)    
    {
    y = 0;
    }   
    if(y < 0)    
    {
    y = height;
    }  
    
  }
  void display()
  {
    pushMatrix();
    fill(0);
    stroke(0);
    translate(x,y);
    if(direction == 0 || direction == 1)
    { 
      line(0, - 5, 0, 5);
    }
    if(direction == 2 || direction == 3)
    {
      line(-5, 0, 5, 0);
    }
    popMatrix();
  }
}

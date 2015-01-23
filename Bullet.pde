class Bullet
{
  float x, y;
  int direction;
  color colour;
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
    float speed = 10.0f;
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
    
    for(int i = 0; i < bullets.size(); i++)
    {
      for(int j = 0; j < obstacles.size(); j++)
      {
        if(x > obstacles.get(j).pos.x && x < obstacles.get(j).pos.x +50)
        {
          if(y > obstacles.get(j).pos.y && y < obstacles.get(j).pos.y + 50)
          {
            bulletAlive=false;
          }
        }
      }
      for(int j = 0; j < zombies.size(); j++)
      {
        if(x >= zombies.get(j).pos.x && x <= zombies.get(j).pos.x +20)
        {
          if(y >= zombies.get(j).pos.y && y <= zombies.get(j).pos.y + 20)
          {
            bulletAlive=false;
          }
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
    translate(x, y);
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

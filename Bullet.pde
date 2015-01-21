class Bullet
{
  float x, y;
  int direction;
  color colour;
  Bullet()
  {
    x = width / 2;
    y = height / 2;
    direction = 0;
    
  }
  void move()
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

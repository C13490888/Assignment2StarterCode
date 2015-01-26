class Zombie
{
  PVector pos;
  color colour;
  int target;
  float speed;
  int direction;
  PImage Zombie;
  PImage[] zombie = new PImage[4];
  boolean zombieAlive;
  
  Zombie()
  {
   pos = new PVector(width / 2, height / 2);
   zombieAlive = true;
   direction = 0;
  }
  
  
  void display()
  {    
    stroke(colour);
    fill(colour);    
    image(Zombie,pos.x, pos.y, 20, 20);
  } 
  
  void update()
  {
    if(players.get(target).pos.y < pos.y)
    {
      pos.y -= speed;
      direction = 0;
      Zombie = zombie[0];
    }
    if(players.get(target).pos.y > pos.y)
    {
      pos.y += speed;
      direction = 1;
      Zombie = zombie[1];
    }
    if(players.get(target).pos.x < pos.x)
    {
      pos.x -= speed;
      direction = 2;
      Zombie = zombie[2];
    }    
    if(players.get(target).pos.x > pos.x)
    {
      pos.x += speed;
      direction = 3;
      Zombie = zombie[3];
    }
    
    if(target == 0)
    {
      if(dist(pos.x, pos.y, players.get(1).pos.x, players.get(1).pos.y) < dist(pos.x, pos.y, players.get(target).pos.x, players.get(target).pos.y)*1.5)
      {
        target = 1;
      }
    }
    if(target == 1)
    {
      if(dist(pos.x, pos.y, players.get(0).pos.x, players.get(0).pos.y) < dist(pos.x, pos.y, players.get(target).pos.x, players.get(target).pos.y)*1.5)
      {
        target = 0;
      }
    }
    
    
    for(int j = 0; j < obstacles.size(); j++)
    {
      if((pos.x >= obstacles.get(j).pos.x && pos.x <= obstacles.get(j).pos.x + 50) || (pos.x + 20 >= obstacles.get(j).pos.x && pos.x + 20 <= obstacles.get(j).pos.x + 50))
      {
        if(pos.y >= obstacles.get(j).pos.y && pos.y <= obstacles.get(j).pos.y + 50)
        {
          pos.y += speed;
        }
        if(pos.y +20 >= obstacles.get(j).pos.y && pos.y + 20 <= obstacles.get(j).pos.y + 50)
        {
          pos.y -= speed;
        }
      }
      if((pos.y >= obstacles.get(j).pos.y && pos.y <= obstacles.get(j).pos.y + 50) || (pos.y +20 >= obstacles.get(j).pos.y && pos.y +20 <= obstacles.get(j).pos.y + 50))
      {
        if(pos.x >= obstacles.get(j).pos.x && pos.x <= obstacles.get(j).pos.x + 50)
        {
          pos.x += speed + .1;
        } 
        if(pos.x + 20 >= obstacles.get(j).pos.x && pos.x + 20 <= obstacles.get(j).pos.x + 50)
        {
          pos.x -= speed + .1;
        }
      }
    }
  }   
}

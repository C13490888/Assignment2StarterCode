class Zombie extends GameObject
{
  color colour;
  int target;
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
    image(Sprite,pos.x, pos.y, 20, 20);
  } 
  
  void update()
  {
    if(players.get(target).pos.x <= pos.x)
    {
      pos.x -= speed;
      direction = 2;
      Sprite = sprite[2];
    }    
    if(players.get(target).pos.x >= pos.x)
    {
      pos.x += speed;
      direction = 3;
      Sprite = sprite[3];
    }
    if(players.get(target).pos.y <= pos.y)
    {
      pos.y -= speed;
      direction = 0;
      Sprite = sprite[0];
    }
    if(players.get(target).pos.y >= pos.y)
    {
      pos.y += speed;
      direction = 1;
      Sprite = sprite[1];
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

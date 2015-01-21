class Zombie
{
  PVector pos;
  color colour;
  int target;
  float speed;
  
  Zombie()
  {
   pos = new PVector(width / 2, height / 2);
  }
  
  void display()
  {    
    stroke(colour);
    fill(colour);    
    rect(pos.x, pos.y, 20, 20);
  } 
  
  void update()
  {
    for(int i = 0; i < zombies.size(); i++)
    {
      if(players.get(zombies.get(i).target).pos.y < zombies.get(i).pos.y)
      {
        zombies.get(i).pos.y -= zombies.get(i).speed;
      }
      if(players.get(zombies.get(i).target).pos.y > zombies.get(i).pos.y)
      {
        zombies.get(i).pos.y += zombies.get(i).speed;
      }
      if(players.get(zombies.get(i).target).pos.x < zombies.get(i).pos.x)
      {
        zombies.get(i).pos.x -= zombies.get(i).speed;
      }    
      if(players.get(zombies.get(i).target).pos.x > zombies.get(i).pos.x)
      {
        zombies.get(i).pos.x += zombies.get(i).speed;
      }
      
      
      for(int j = 0; j < obstacles.size(); j++)
      {
        if((zombies.get(i).pos.x >= obstacles.get(j).pos.x && zombies.get(i).pos.x <= obstacles.get(j).pos.x + 50) || (zombies.get(i).pos.x + 20 >= obstacles.get(j).pos.x && zombies.get(i).pos.x + 20 <= obstacles.get(j).pos.x + 50))
        {
          if(zombies.get(i).pos.y >= obstacles.get(j).pos.y && zombies.get(i).pos.y <= obstacles.get(j).pos.y + 50)
          {
            zombies.get(i).pos.y += zombies.get(i).speed;
          }
          if(zombies.get(i).pos.y +20 >= obstacles.get(j).pos.y && zombies.get(i).pos.y + 20 <= obstacles.get(j).pos.y + 50)
          {
            zombies.get(i).pos.y -= zombies.get(i).speed;
          }
        }
        if((zombies.get(i).pos.y >= obstacles.get(j).pos.y && zombies.get(i).pos.y <= obstacles.get(j).pos.y + 50) || (zombies.get(i).pos.y +20 >= obstacles.get(j).pos.y && zombies.get(i).pos.y +20 <= obstacles.get(j).pos.y + 50))
        {
          if(zombies.get(i).pos.x >= obstacles.get(j).pos.x && zombies.get(i).pos.x <= obstacles.get(j).pos.x + 50)
          {
            zombies.get(i).pos.x += zombies.get(i).speed+.1;
          }    
          if(zombies.get(i).pos.x + 20 >= obstacles.get(j).pos.x && zombies.get(i).pos.x + 20 <= obstacles.get(j).pos.x + 50)
          {
            zombies.get(i).pos.x -= zombies.get(i).speed+.1;
          }
        }
      }
    }
  }   
}

class PowerUp extends GameObject
{
  int powerTimer;
  boolean powerUpAlive;
  boolean speedUp;
  boolean speedDown;
  boolean spawnUp;
  boolean spawnDown;
  
  PowerUp()
  {
    pos = new PVector(width / 2, height / 2);
    powerUpAlive = true;
    speedUp = false;
    speedDown = false;
    spawnUp = false;
    spawnDown= false;
    powerTimer = 0;
  }
  
  void display()
  {
    stroke(colour);
    fill(colour);
    image(Sprite, pos.x, pos.y, 20, 20);
  }
  
  void update()
  {
    
    if(powerTimer == 900)
    {
      powerUpAlive = false;
    }
    
    for(int j = 0; j < players.size(); j++)
    {
      if((pos.x >= players.get(j).pos.x && pos.x <= players.get(j).pos.x + 20) || (pos.x + 20 >= players.get(j).pos.x && pos.x + 20 <= players.get(j).pos.x + 20))
      {
        if(pos.y >= players.get(j).pos.y && pos.y <= players.get(j).pos.y + 20)
        {
          powerUpAlive = false;
        }
        if(pos.y +20 >= players.get(j).pos.y && pos.y + 20 <= players.get(j).pos.y + 20)
        {
          powerUpAlive = false;
        }
      }
      if((pos.y >= players.get(j).pos.y && pos.y <= players.get(j).pos.y + 20) || (pos.y +20 >= players.get(j).pos.y && pos.y +20 <= players.get(j).pos.y + 0))
      {
        if(pos.x >= players.get(j).pos.x && pos.x <= players.get(j).pos.x + 20)
        {
          powerUpAlive = false;
        } 
        if(pos.x + 20 >= players.get(j).pos.x && pos.x + 20 <= players.get(j).pos.x + 20)
        {
          powerUpAlive = false;
        }
      }
    }
    
    
    powerTimer++;
  }
  
}

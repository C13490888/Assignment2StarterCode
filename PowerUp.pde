class PowerUp extends GameObject
{
  int powerTimer;
  boolean powerUpAlive;
  boolean speedDown;
  boolean speedUp;
  boolean spawnDown;
  boolean spawnUp;
  boolean powerSet;
  int playerActivated;
  
  PowerUp()
  {
    pos = new PVector(width / 2, height / 2);
    powerUpAlive = true;
    speedDown = false;
    speedUp = false;
    spawnDown= false;
    spawnUp = false;
    powerSet = false;
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
    //Makes powers available for pickup for 15 seconds
    if(powerTimer == 900)
    {
      powerUpAlive = false;
    }
    
    //checks collision for players for them to be activated
    for(int j = 0; j < players.size(); j++)
    {
      if((pos.x >= players.get(j).pos.x && pos.x <= players.get(j).pos.x + 20) || (pos.x + 20 >= players.get(j).pos.x && pos.x + 20 <= players.get(j).pos.x + 20))
      {
        if(pos.y >= players.get(j).pos.y && pos.y <= players.get(j).pos.y + 20)
        {
          powerUpAlive = false;
          powerSet = true;
          playerActivated = players.get(j).index;
        }
        if(pos.y +20 >= players.get(j).pos.y && pos.y + 20 <= players.get(j).pos.y + 20)
        {
          powerUpAlive = false;
          powerSet = true;
          playerActivated = players.get(j).index;
        }
      }
      if((pos.y >= players.get(j).pos.y && pos.y <= players.get(j).pos.y + 20) || (pos.y +20 >= players.get(j).pos.y && pos.y +20 <= players.get(j).pos.y + 0))
      {
        if(pos.x >= players.get(j).pos.x && pos.x <= players.get(j).pos.x + 20)
        {
          powerUpAlive = false;
          powerSet = true;
          playerActivated = players.get(j).index;
        } 
        if(pos.x + 20 >= players.get(j).pos.x && pos.x + 20 <= players.get(j).pos.x + 20)
        {
          powerUpAlive = false;
          powerSet = true;
          playerActivated = players.get(j).index;
        }
      }
    }
    
    //checks which power has been activated
    if(powerSet)
    {
      if(Sprite == PowerUp[0])
      {
        speedDown = true;
      }
      else if(Sprite == PowerUp[1])
      {
        speedUp = true;
      }
      else if(Sprite == PowerUp[2])
      {
        spawnDown = true;
      }
      else if(Sprite == PowerUp[3])
      {
        spawnUp = true;
      }
      powerSet = false;
    }
    
    //resets the speed of zombies and slows all current zombies
    if(speedDown)
    {
      for(int i = 0; i < zombies.size(); i++)
      {
        zombies.get(i).speed = 0.1f;
        zombieSpeed = .1f;
      }
    }
    //Increases the player who activated it's speed
    else if(speedUp)
    {
       players.get(playerActivated).speed *= 1.5;
    }
    //kills half of the zombies and resets the spawn rate.
    else if(spawnDown)
    {
      for(int i = 0; i < zombies.size()/2; i++)
      {
        zombies.remove(i);
        zombieSpawnRate = 1f;
      }
    }
    //Spawns another half amount of zombies and increases spawn rate
    else if(spawnUp)
    {
      zombieSpawnRate *= 1.5;
      for(int i = 0; i < zombies.size()/2; i++)
      {
        setUpZombies();
      }
    }
    
    powerTimer++;
  }
  
}

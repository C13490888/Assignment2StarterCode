class Player extends GameObject
{
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  float fireRate;
  float rateCounter;
  boolean playerAlive;
  boolean playerToZombieSet;
  int playerTarget;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    fireRate = 5;
    rateCounter = 0;
    direction = 0;
    speed = 2;
    playerAlive = true;
    playerToZombieSet = false;
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
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
          pos.x += speed +.1;
        }    
        if(pos.x + 20 >= obstacles.get(j).pos.x && pos.x + 20 <= obstacles.get(j).pos.x + 50)
        {
          pos.x -= speed +.1;
        }
      }
    }
    
    if(pos.x > width)    
    {
      pos.x = 0;
    }
    if(pos.x < 0)    
    {
      pos.x = width;
    }    
    if(pos.y > height)    
    {
      pos.y = 0;
    }   
    if(pos.y < 0)    
    {
      pos.y = height;
    }  
    
    if(playerAlive)
    {
      if (checkKey(up))
      {
        pos.y -= speed;
        direction = 0;
        Sprite = sprite[0];
      }
      if (checkKey(down))
      {
        pos.y += speed;
        direction = 1;
        Sprite = sprite[1];
      }
      if (checkKey(left))
      {
        pos.x -= speed;
        direction = 2;
        Sprite = sprite[2];
      }    
      if (checkKey(right))
      {
        pos.x += speed;
        direction = 3;
        Sprite = sprite[3];
      }
      
      for(int j = 0; j < bullets.size(); j++)
      {
        if(bullets.get(j).x+1 >= pos.x && bullets.get(j).x-1 <= pos.x +20)
        {
          if(bullets.get(j).y+1 >= pos.y && bullets.get(j).y-1 <= pos.y + 20)
          {
            {
              bullets.get(j).bulletAlive = false;
              playerAlive=false;
              Sprite = Zombie[0];
            }
          }
        }
      }
      
      for(int j = 0; j < zombies.size(); j++)
      {
        if((pos.x >= zombies.get(j).pos.x && pos.x <= zombies.get(j).pos.x + 20) || (pos.x + 20 >= zombies.get(j).pos.x && pos.x + 20 <= zombies.get(j).pos.x + 20))
        {
          if(pos.y >= zombies.get(j).pos.y && pos.y <= zombies.get(j).pos.y + 20)
          {
            playerAlive = false;
            Sprite = Zombie[0];
          }
          if(pos.y +20 >= zombies.get(j).pos.y && pos.y + 20 <= zombies.get(j).pos.y + 20)
          {
            playerAlive = false;
            Sprite = Zombie[0];
          }
        }
        if((pos.y >= zombies.get(j).pos.y && pos.y <= zombies.get(j).pos.y + 20) || (pos.y +20 >= zombies.get(j).pos.y && pos.y +20 <= zombies.get(j).pos.y + 0))
        {
          if(pos.x >= zombies.get(j).pos.x && pos.x <= zombies.get(j).pos.x + 20)
          {
            playerAlive = false;
            Sprite = Zombie[0];
          } 
          if(pos.x + 20 >= zombies.get(j).pos.x && pos.x + 20 <= zombies.get(j).pos.x + 20)
          {
            playerAlive = false;
            Sprite = Zombie[0];
          }
        }
        if(zombies.get(j).target == 0)
        {
          if(players.get(1).playerAlive)
          {
            if(dist(zombies.get(j).pos.x, zombies.get(j).pos.y, players.get(1).pos.x, players.get(1).pos.y) < dist(zombies.get(j).pos.x, zombies.get(j).pos.y, players.get(zombies.get(j).target).pos.x, players.get(zombies.get(j).target).pos.y)*1.5)
            {
              zombies.get(j).target = 1;
            }
          }
        }
        if(zombies.get(j).target == 1)
        {
          if(players.get(0).playerAlive)
          {
            if(dist(zombies.get(j).pos.x, zombies.get(j).pos.y, players.get(0).pos.x, players.get(0).pos.y) < dist(zombies.get(j).pos.x, zombies.get(j).pos.y, players.get(zombies.get(j).target).pos.x, players.get(zombies.get(j).target).pos.y)*1.5)
            {
              zombies.get(j).target = 0;
            }
          }
        }
      }
      
      if (checkKey(start))
      {
        println("Player " + index + " start");
      }
      if (checkKey(button1))
      {
        if(rateCounter > (60/fireRate))
        {
          Bullet bullet = new Bullet();
          if(direction == 0)
          { 
            bullet.x = pos.x +10;
            bullet.y = pos.y;
          }
          if(direction == 1)
          {
            bullet.x = pos.x + 10;
            bullet.y = pos.y + 20;
          }
          if(direction == 2)
          {
            bullet.x = pos.x;
            bullet.y = pos.y + 10;
          }
          if(direction == 3)
          {
            bullet.x = pos.x + 20;
            bullet.y = pos.y + 10;
          }
          bullet.direction = direction;
          bullets.add(bullet);
          rateCounter = 0;
         }
       }
      
      if (checkKey(button2))
      {
        println("Player " + index + " butt2");
      }   
      rateCounter++; 
    }
    if(!playerAlive)
    {
      if(!playerToZombieSet)
      {
        for(int i = 0; i < zombies.size(); i++)
        {
          if(zombies.get(i).target == index)
          {
            if(index == 0)
            {
              zombies.get(i).target = 1;
              playerTarget  = 1;
            }
            else if(index == 1)
            {
              zombies.get(i).target = 0;
              playerTarget  = 0;
            }
          }
        }
        boolean playerGapExists = false;
        while(playerGapExists == false)
        {
          int spawnGapCounter = 0;
          int obstacleGapCounter = 0;
          int playerGapCounter = 0;
          float zombieX = random(0,width-20);
          float zombieY = random(0,height-20);
          for(int j = 0; j < obstacles.size(); j++)
          {
            if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, zombieX, zombieY) > 50)
            {
              obstacleGapCounter++;
            }                
          }
          for(int j = 0; j < players.size(); j++)
          {
            if(dist(players.get(j).pos.x, players.get(j).pos.y, zombieX, zombieY) > 500)
            {
              playerGapCounter++;
            }                
          }
          for(int j = 0; j < zombies.size(); j++)
          {
            if(dist(zombies.get(j).pos.x, zombies.get(j).pos.y, zombieX, zombieY) > 100)
            {
              spawnGapCounter++;
            }                
          }
          if(obstacleGapCounter == obstacles.size() && playerGapCounter == 1 && spawnGapCounter == zombies.size())
          {
            playerGapExists = true;
            pos.x = zombieX;
            pos.y = zombieY;
            playerToZombieSet = true;
          }
        } 
      }
      if (checkKey(up))
      {
        pos.y -= speed;
        direction = 0;
        Sprite = Zombie[0];
      }
      if (checkKey(down))
      {
        pos.y += speed;
        direction = 1;
        Sprite = Zombie[1];
      }
      if (checkKey(left))
      {
        pos.x -= speed;
        direction = 2;
        Sprite = Zombie[2];
      }    
      if (checkKey(right))
      {
        pos.x += speed;
        direction = 3;
        Sprite = Zombie[3];
      }
      
      if (checkKey(start))
      {
        println("Player " + index + " start");
      }
     
      if((pos.x >= players.get(playerTarget).pos.x && pos.x <= players.get(playerTarget).pos.x + 20) || (pos.x + 20 >= players.get(playerTarget).pos.x && pos.x + 20 <= players.get(playerTarget).pos.x + 20))
      {
        if(pos.y >= players.get(playerTarget).pos.y && pos.y <= players.get(playerTarget).pos.y + 20)
        {
          players.get(playerTarget).playerAlive = false;
          players.get(playerTarget).Sprite = Zombie[0];
        }
        if(pos.y +20 >= players.get(playerTarget).pos.y && pos.y + 20 <= players.get(playerTarget).pos.y + 20)
        {
          players.get(playerTarget).playerAlive = false;
          players.get(playerTarget).Sprite = Zombie[0];
        }
      }
      if((pos.y >= players.get(playerTarget).pos.y && pos.y <= players.get(playerTarget).pos.y + 20) || (pos.y +20 >= players.get(playerTarget).pos.y && pos.y +20 <= players.get(playerTarget).pos.y + 0))
      {
        if(pos.x >= players.get(playerTarget).pos.x && pos.x <= players.get(playerTarget).pos.x + 20)
        {
          players.get(playerTarget).playerAlive = false;
          players.get(playerTarget).Sprite = Zombie[0];
        } 
        if(pos.x + 20 >= players.get(playerTarget).pos.x && pos.x + 20 <= players.get(playerTarget).pos.x + 20)
        {
          players.get(playerTarget).playerAlive = false;
          players.get(playerTarget).Sprite = Zombie[0];
        }
      }
      
      for(int j = 0; j < bullets.size(); j++)
      {
        if(bullets.get(j).x+1 >= pos.x && bullets.get(j).x-1 <= pos.x +20)
        {
          if(bullets.get(j).y+1 >= pos.y && bullets.get(j).y-1 <= pos.y + 20)
          {
            {
              bullets.get(j).bulletAlive = false;
              playerToZombieSet = false;
              killCounter++;
            }
          }
        }
      }
      
    }
  }
  
  void display()
  {    
    
    stroke(colour);
    fill(colour);
    image(Sprite, pos.x, pos.y, 20, 20);
  }  
}

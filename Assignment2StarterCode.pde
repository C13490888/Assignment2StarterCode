/*
    DIT OOP Assignment 2
    By Aaron Brien
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Zombie> zombies = new ArrayList<Zombie>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

boolean[] keys = new boolean[526];

void setup()
{
  size(500, 500);
  setUpPlayerControllers();
  setUpObstacles();
  setUpZombies();
}

void draw()
{
  background(255);
  
  for(Obstacle obstacle:obstacles)
  {
    obstacle.display();
  }
  
  for(Player player:players)
  {
    player.update();
    player.display();
  }
  
  for(Zombie zombie:zombies)
  {
    zombie.display();
    zombie.update();
  }
  
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpObstacles()
{
  for(int i = 0 ; i < 10; i ++)  
  {
    if(i== 0)
    {
      Obstacle o = new Obstacle();
      o.pos.x = random(30,420);
      o.pos.y = random(30,420);
      obstacles.add(o);
    }
    else
    {
      boolean playerGapExists = false;
      Obstacle o = new Obstacle();
      while(playerGapExists == false)
      {
        int obstacleGapCounter = 0;
        int playerGapCounter = 0;
        o.pos.x = random(30,420);
        o.pos.y = random(30,420);
        for(int j = 0; j < i; j++)
        {
          if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, o.pos.x, o.pos.y) > 100)
          {
            obstacleGapCounter++;
          }                
        }
        for(int j = 0; j < 2; j++)
        {
          if(dist(players.get(j).pos.x, players.get(j).pos.y, o.pos.x, o.pos.y) > 50)
          {
            playerGapCounter++;
          }                
        }
        if(obstacleGapCounter == i && playerGapCounter == 2)
        {
          playerGapExists = true;
          obstacles.add(o);
        }
      }
    }
  }
} 

void setUpPlayerControllers()
{
  color[] colarray = new color[5];
  colarray[0] = color(0,0,255);
  colarray[1] = color(255,0,0);
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , colarray[i]
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
   players.add(p);         
  }
}

void setUpZombies()
{
  
  for(int i = 0 ; i < 5; i ++)  
  {
    boolean zombieGapExists = false;
    Zombie z = new Zombie();
    while(zombieGapExists == false)
    {
      int zombieGapCounter = 0;
      int obstacleGapCounter = 0;
      int playerGapCounter = 0;
      z.pos.x = random(0,480);
      z.pos.y = random(0,480);
      z.colour = color(0,255,0);
      z.target = int(random(0,2));
      for(int j = 0; j < obstacles.size(); j++)
      {
        if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, z.pos.x, z.pos.y) > 50)
        {
          obstacleGapCounter++;
        }                
      }
      for(int j = 0; j < players.size(); j++)
      {
        if(dist(players.get(j).pos.x, players.get(j).pos.y, z.pos.x, z.pos.y) > 50)
        {
          playerGapCounter++;
        }                
      }
      for(int j = 0; j < zombies.size(); j++)
      {
        if(dist(zombies.get(j).pos.x, zombies.get(j).pos.y, z.pos.x, z.pos.y) > 100)
        {
          zombieGapCounter++;
        }                
      }
      if(obstacleGapCounter == obstacles.size() && playerGapCounter == players.size() && zombieGapCounter == zombies.size())
      {
        zombieGapExists = true;
        zombies.add(z);
      }
    }    
  }
}

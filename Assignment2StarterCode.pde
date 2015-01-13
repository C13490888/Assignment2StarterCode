/*
    DIT OOP Assignment 2
    By Aaron Brien
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

boolean[] keys = new boolean[526];

void setup()
{
  size(500, 500);
  setUpPlayerControllers();
  setUpObstacles();
}

void draw()
{
    background(255);
  for(Player player:players)
  {
    player.update();
    player.display();
  }
  
  for(Obstacle obstacle:obstacles)
  {
    obstacle.display();
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
  for(int i = 0 ; i < 20; i ++)  
  {
    if(i== 0)
    {
      Obstacle o = new Obstacle();
      o.pos.x = random(0,450);
      o.pos.y = random(0,450);
      obstacles.add(o);
    }
    else
    {
      boolean playerGapExists = false;
      Obstacle o = new Obstacle();
      while(playerGapExists == false)
      {
        int gapCounter = 0;
        o.pos.x = random(0,450);
        o.pos.y = random(0,450);
        for(int j = 0; j < i; j++)
        {
          if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, o.pos.x, o.pos.y) > 100)
          {
            gapCounter++;
          }                
        }
        if(gapCounter == i)
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

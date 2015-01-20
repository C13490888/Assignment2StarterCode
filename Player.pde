class Player
{
  PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
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
    for(int i = 0; i < players.size(); i++)
    {
      for(int j = 0; j < obstacles.size(); j++)
      {
        if((players.get(i).pos.x >= obstacles.get(j).pos.x && players.get(i).pos.x <= obstacles.get(j).pos.x + 50) || (players.get(i).pos.x + 20 >= obstacles.get(j).pos.x && players.get(i).pos.x + 20 <= obstacles.get(j).pos.x + 50))
        {
          if(players.get(i).pos.y >= obstacles.get(j).pos.y && players.get(i).pos.y <= obstacles.get(j).pos.y + 50)
          {
            players.get(i).pos.y += 2;
          }
          if(players.get(i).pos.y +20 >= obstacles.get(j).pos.y && players.get(i).pos.y + 20 <= obstacles.get(j).pos.y + 50)
          {
            players.get(i).pos.y -= 2;
          }
        }
        if((players.get(i).pos.y >= obstacles.get(j).pos.y && players.get(i).pos.y <= obstacles.get(j).pos.y + 50) || (players.get(i).pos.y +20 >= obstacles.get(j).pos.y && players.get(i).pos.y +20 <= obstacles.get(j).pos.y + 50))
        {
          if(players.get(i).pos.x >= obstacles.get(j).pos.x && players.get(i).pos.x <= obstacles.get(j).pos.x + 50)
          {
            players.get(i).pos.x += 2;
          }    
          if(players.get(i).pos.x + 20 >= obstacles.get(j).pos.x && players.get(i).pos.x + 20 <= obstacles.get(j).pos.x + 50)
          {
            players.get(i).pos.x -= 2;
          }
        }
      }
    }
    
    for(int i = 0; i < players.size(); i++)
    {
      if(players.get(i).pos.x + 20 >= width)
      {
        players.get(i).pos.x -= 2;
      }
      if(players.get(i).pos.x <= 0)
      {
        players.get(i).pos.x += 2;
      }
      if(players.get(i).pos.y + 20 >= height)
      {
        players.get(i).pos.y -= 2;
      }
      if(players.get(i).pos.y <= 0)
      {
        players.get(i).pos.y += 2;
      }
    }
    
    
    if (checkKey(up))
    {
      pos.y -= 2;
    }
    if (checkKey(down))
    {
      pos.y += 2;
    }
    if (checkKey(left))
    {
      pos.x -= 2;
    }    
    if (checkKey(right))
    {
      pos.x += 2;
    }
    
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }    
  }
  
  void display()
  {    
    stroke(colour);
    fill(colour);    
    rect(pos.x, pos.y, 20, 20);
  }  
}

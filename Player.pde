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
  float fireRate;
  int direction;
  PImage Player;
  PImage[] player = new PImage[4];
  float rateCounter;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    fireRate = 5;
    rateCounter = 0;
    direction = 0;
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
          pos.y += 2;
        }
        if(pos.y +20 >= obstacles.get(j).pos.y && pos.y + 20 <= obstacles.get(j).pos.y + 50)
        {
          pos.y -= 2;
        }
      }
      if((pos.y >= obstacles.get(j).pos.y && pos.y <= obstacles.get(j).pos.y + 50) || (pos.y +20 >= obstacles.get(j).pos.y && pos.y +20 <= obstacles.get(j).pos.y + 50))
      {
        if(pos.x >= obstacles.get(j).pos.x && pos.x <= obstacles.get(j).pos.x + 50)
        {
          pos.x += 2;
        }    
        if(pos.x + 20 >= obstacles.get(j).pos.x && pos.x + 20 <= obstacles.get(j).pos.x + 50)
        {
          pos.x -= 2;
        }
      }
    }
    
    if(pos.x + 20 >= width)
    {
      pos.x -= 2;
    }
    if(pos.x <= 0)
    {
      pos.x += 2;
    }
    if(pos.y + 20 >= height)
    {
      pos.y -= 2;
    }
    if(pos.y <= 0)
    {
      pos.y += 2;
    }
    
    
    if (checkKey(up))
    {
      pos.y -= 2;
      direction = 0;
      Player = player[0];
    }
    if (checkKey(down))
    {
      pos.y += 2;
      direction = 1;
      Player = player[1];
    }
    if (checkKey(left))
    {
      pos.x -= 2;
      direction = 2;
      Player = player[2];
    }    
    if (checkKey(right))
    {
      pos.x += 2;
      direction = 3;
      Player = player[3];
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
  
  void display()
  {    
    
    stroke(colour);
    fill(colour); 
    image(Player, pos.x, pos.y, 20, 20);
  }  
}

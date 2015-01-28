/*
    DIT OOP Assignment 2
    By Aaron Brien
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
    Credit for music to: Vulcan Kijder and John Murphy.
    PS: When either player dies turn them into a zombie.
*/

//Loading in sprites for players, zombies, powerups and splashscreens respectively.
PImage[] Player1 = new PImage[4];
PImage[] Player2 = new PImage[4];
PImage[] Zombie = new PImage[4];
PImage[] PowerUp = new PImage[4];
PImage Splash;
PImage End;

//declaring music
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer player;
AudioInput input;


//for fullscreen and devmode window size
boolean devMode = false;
boolean sketchFullScreen() {
  return ! devMode;
}

//Declaring arrayLists
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Zombie> zombies = new ArrayList<Zombie>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();

//Declaring global variables for game
float zombieSpeed = .1f;
float zombieSpawnRate = 1f;
float spawnCounter = 0;
int killCounter;
int score;
int scoreCounter;
int scoreMultiplier;
int[] oldHighScore;
boolean[] keys = new boolean[526];
int powerupCounter = 0;
int powerGenerator = 500;
int powerPicker = 0;
int menumode;

void setup()
{
  //Checks whether to go full screen or devmode for size
  if (devMode)
  {
    size(1280, 1024);
  }
  else
  {
    size(displayWidth, displayHeight);
  }
  
  //Loads images into image arrays
  for(int i = 0; i < 4; i++)
  {
    Player1[i] = loadImage(i + "Player1.png");
    Player2[i] = loadImage(i + "Player2.png");
    Zombie[i] = loadImage(i + "Zombie.png");
    PowerUp[i] =  loadImage(i + "powerUp.png");
  }
  
  //Loads splash and end screens
  Splash = loadImage("splashscreen.png");
  End = loadImage("gameover.png");
  
  //Loads music file
  minim = new Minim(this);
  player = minim.loadFile("houseinheartbeat.mp3");
  input = minim.getLineIn();
  player.play();
  
  //Assigns global variables and sets up obstacles, pplayers and zombies
  setUpPlayerControllers();
  setUpObstacles();
  setUpZombies();
  menumode = 0;
  scoreCounter = 0;
  score = 1;
  scoreMultiplier = 2;
  killCounter = 0;
  Highscore();
}

void draw()
{
  
  if(menumode == 0) //Splash Screen
  {
    image(Splash, 0, 0, width,height);
    if(checkKey(players.get(0).start) || checkKey(players.get(1).start))
    {
      menumode = 1;
    }
  }
  else if(menumode == 1) //Actual Game
  { 
    background(255);
    //Multiplies score as game goes on
    if(scoreCounter == 1800)
    {
      scoreMultiplier++;
    }
    
    //Displays obstacles
    for(Obstacle obstacle:obstacles)
    {
      obstacle.display();
    }
    
    //Displays players
    for(int i = 0; i < players.size(); i++)
    {
      players.get(i).update();
      players.get(i).display();
      if(!players.get(0).playerAlive && !players.get(1).playerAlive)
      {
        menumode = 2; //Checks if both players are alive or not, else game over
      }
    }
    
    //Displays zombies and removes them if they have been killed
    for(int i = 0; i < zombies.size(); i++)
    {
      zombies.get(i).update();
      zombies.get(i).display();
      if(!zombies.get(i).zombieAlive)
      {
        zombies.remove(i);
        score += scoreMultiplier;
        killCounter++;
      }
    }
    
    //displays powerups and removes them if they are no longer available
    for(int i = 0; i < powerups.size(); i++)
    {
      powerups.get(i).update();
      powerups.get(i).display();
      if(!powerups.get(i).powerUpAlive)
      {
        powerups.remove(i);
      }
    }
    
    //displays bullets and removes the mif they hit an object
    for(int i = 0; i < bullets.size(); i++)
    {
      bullets.get(i).display();
      bullets.get(i).update();
      if(!bullets.get(i).bulletAlive)
      {
        bullets.remove(i);
      }
    }
    
    //Increases the zombie spawn rate and speed as the game goes on
    if(spawnCounter > (60/zombieSpawnRate))
    {
      setUpZombies();
      zombieSpawnRate *= 1.001;
      spawnCounter = 0;
      zombieSpeed *= 1.01;
      if(zombieSpeed >= .8)
      {
        zombieSpeed = 1;
      }
    }
    spawnCounter++;
    
    //Spawns a powerup if the random number is selected
    powerPicker = int(random(0,1001));
    if(powerPicker == powerGenerator)
    {
      spawnPowerUp();
    }
    
    //displays score
    fill(255,0,0);
    text("score: "+score, (width/2)-20, 10);
  }
  else if(menumode == 2) //Game over screen
  {
    image(End, 0, 0, width, height);
    newHighScore();
    fill(255,0,0);
    textSize(20);
    text(score, (width/2)-20, height-height/4);
    //displays old high score or new high score
    if(score > oldHighScore[0])
    {
      text(score, (width - width/6), height/2);
    }
    else
    {
      text(oldHighScore[0], (width - width/6), height/2);
    }
    text(killCounter, width/8, height/2);
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
  //This for loop uses counters and booleans to make sure that obstacles spawn a certain distance away from each other and players
  //So that theres no overlapping
  for(int i = 0 ; i < 50; i ++)  
  {
    if(i== 0)
    {
      Obstacle o = new Obstacle();
      o.pos.x = random(30,width - 80);
      o.pos.y = random(30,width - 80);
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
        o.pos.x = random(30,width - 80);
        o.pos.y = random(30,height - 80);
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
    //Loads player sprites
    for(int j = 0; j < 4; j++)
    {
      if(i == 0)
      {
        p.sprite[j] = Player1[j];
        p.Sprite = Player1[0];
      }
      if(i == 1)
      {
        p.sprite[j] = Player2[j];
        p.Sprite = Player2[0];
      }
    }
    players.add(p);         
  }
}

void setUpZombies()
{
  //This for loop uses booleans and counters to make sure zombies spawn away from obstacles, players and each other
  for(int i = 0 ; i < 1; i ++)  
  {
    boolean zombieGapExists = false;
    Zombie z = new Zombie();
    while(zombieGapExists == false)
    {
      int zombieGapCounter = 0;
      int obstacleGapCounter = 0;
      int playerGapCounter = 0;
      z.pos.x = random(0,width-20);
      z.pos.y = random(0,height-20);
      z.colour = color(0,255,0);
      z.target = int(random(0,2));
      z.speed = ((float)random(zombieSpeed,zombieSpeed*2));
      for(int j = 0; j < obstacles.size(); j++)
      {
        if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, z.pos.x, z.pos.y) > 50)
        {
          obstacleGapCounter++;
        }                
      }
      for(int j = 0; j < players.size(); j++)
      {
        if(dist(players.get(j).pos.x, players.get(j).pos.y, z.pos.x, z.pos.y) > 150)
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
        //loading sprites
        for(int j = 0; j < 4; j++)
        {
          z.sprite[j] = Zombie[j];
          z.Sprite = Zombie[0];
        }
        zombies.add(z);
      }
    }    
  }
}

void spawnPowerUp()
{
  //this powerup makes sure powerups spawn a certain distance away from zombies, obstacles, powers and each other
  for(int i = 0 ; i < 1; i ++)  
  {
    boolean powerGapExists = false;
    PowerUp p = new PowerUp();
    while(powerGapExists == false)
    {
      int zombieGapCounter = 0;
      int obstacleGapCounter = 0;
      int playerGapCounter = 0;
      int powerGapCounter = 0;
      p.pos.x = random(0,width-20);
      p.pos.y = random(0,height-20);
      p.Sprite = PowerUp[int(random(0,4))];
      for(int j = 0; j < obstacles.size(); j++)
      {
        if(dist(obstacles.get(j).pos.x, obstacles.get(j).pos.y, p.pos.x, p.pos.y) > 50)
        {
          obstacleGapCounter++;
        }                
      }
      for(int j = 0; j < players.size(); j++)
      {
        if(dist(players.get(j).pos.x, players.get(j).pos.y, p.pos.x, p.pos.y) > 150)
        {
          playerGapCounter++;
        }                
      }
      for(int j = 0; j < zombies.size(); j++)
      {
        if(dist(zombies.get(j).pos.x, zombies.get(j).pos.y, p.pos.x, p.pos.y) > 100)
        {
          zombieGapCounter++;
        }                
      }
      for(int j = 0; j < powerups.size(); j++)
      {
        if(dist(powerups.get(j).pos.x, powerups.get(j).pos.y, p.pos.x, p.pos.y) > 500)
        {
          powerGapCounter++;
        }   
      }
      if(obstacleGapCounter == obstacles.size() && playerGapCounter == players.size() && zombieGapCounter == zombies.size() && powerGapCounter == powerups.size())
      {
        powerGapExists = true;
        powerups.add(p);
      }
    }    
  }
}

//This function loads the old high score
void Highscore()
{
  String[] hBuffer = loadStrings("highscore.txt");
  
  oldHighScore = int(hBuffer);

}

//If the players score for this game is higher than the current high score, it is set as the new high score
void newHighScore()
{
  if(score > oldHighScore[0])
  {
    String[] hBuffer = new String[1];
    hBuffer[0] = str(score);
    saveStrings("highscore.txt",hBuffer);
  }
}

class Obstacle
{
  PVector pos;
  
  Obstacle()
  {
    pos = new PVector(width / 2, height / 2);
  }
  
  void display()
  {    
    stroke(0);
    fill(0);    
    rect(pos.x, pos.y, 50, 50);
  } 
}

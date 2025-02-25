
class animation
{
  PShape frames[];
  PVector pos = new PVector(), size = new PVector();
  boolean absolute;
  long lastAktivation;
  int dt = 50, totalTime;
  
  
  animation(int i_frameCount, String paths[])
  {
    frames = new PShape[i_frameCount];
    
    for(int i = 0; i < i_frameCount; i++)
    {
      frames[i] = loadShape(paths[i]);
    }
    
    totalTime = dt * i_frameCount;
  }
  
   animation(int i_frameCount, int i_frameRate, String paths[])
  {
    frames = new PShape[i_frameCount];
    
    for(int i = 0; i < i_frameCount; i++)
    {
      frames[i] = loadShape(paths[i]);
    }
    
    dt = 1000 / i_frameRate;
    totalTime = dt * i_frameCount;
  }
  
  void activate(float i_posX, float i_posY,float i_sizeX, float i_sizeY)
  {
    pos.x = i_posX;
    pos.y = i_posY;
    
    size.x = i_sizeX;
    size.y = i_sizeY;
    
    lastAktivation = millis();
    absolute = false;
  }
  
  void activate(int i_posX, int i_posY,int i_sizeX, int i_sizeY)
  {
    pos.x = i_posX;
    pos.y = i_posY;
    
    size.x = i_sizeX;
    size.y = i_sizeY;
    
    lastAktivation = millis();
    absolute = true;
  }
  
  void render()
  {
    if(lastAktivation != 0 && millis() - lastAktivation < totalTime)
    {
      int frame = (int) ((millis() - lastAktivation)/dt);
      if(absolute)
      {
        shape(frames[frame], pos.x, pos.y, size.x, size.y);
      }
      else
      {
        shape(frames[frame], pos.x * width, pos.y * height, size.x * width, size.y * height);
      }
    }
  }
  
}
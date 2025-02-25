

class layoutArray
{
  PVector pos = new PVector(), size = new PVector();
  int amount;
  miniLayout lays[] = new miniLayout[9];
  
  layoutArray(String path, float x, float y, float dx, float dy, color c[])
  {
    lays[0] = new miniLayout(path, x             , y, dx * 0.495, dy, c);
    lays[1] = new miniLayout(path, x + dx * 0.505, y, dx * 0.495, dy, c);
    lays[2] = new miniLayout(path, x             , y, dx * 0.32666, dy, c);
    lays[3] = new miniLayout(path, x +dx * 0.33666, y, dx * 0.32666, dy, c);
    lays[4] = new miniLayout(path, x +dx * 0.67333, y, dx * 0.32666, dy, c);
    lays[5] = new miniLayout(path, x             , y, dx * 0.2425, dy, c);
    lays[6] = new miniLayout(path, x +dx * 0.2525, y, dx * 0.2425, dy, c);
    lays[7] = new miniLayout(path, x +dx * 0.5050, y, dx * 0.2425, dy, c);
    lays[8] = new miniLayout(path, x +dx * 0.7575, y, dx * 0.2425, dy, c);
  }
  
  void render()
  {
    switch(amount)
    {
      case 2: 
        lays[0].render();
        lays[1].render();
      break;
      case 3:
        lays[2].render();
        lays[3].render();
        lays[4].render();
      break;
      case 4:
        lays[5].render();
        lays[6].render();
        lays[7].render();
        lays[8].render();
      break;
    }
  }
  
  void checkStats()
  {
    switch(amount)
    {
      case 2: 
        lays[0].checkStats();
        lays[1].checkStats();
      break;
      case 3:
        lays[2].checkStats();
        lays[3].checkStats();
        lays[4].checkStats();
      break;
      case 4:
        lays[5].checkStats();
        lays[6].checkStats();
        lays[7].checkStats();
        lays[8].checkStats();
      break;
    }
  }
  
};

String explosionFrames[] = 
{
  "resources/game/grafiks/explosion/frame0.svg",
  "resources/game/grafiks/explosion/frame1.svg",
  "resources/game/grafiks/explosion/frame2.svg",
  "resources/game/grafiks/explosion/frame3.svg",
  "resources/game/grafiks/explosion/frame4.svg",
  "resources/game/grafiks/explosion/frame5.svg",
  "resources/game/grafiks/explosion/frame6.svg",
  "resources/game/grafiks/explosion/frame7.svg",
  "resources/game/grafiks/explosion/frame8.svg",
  "resources/game/grafiks/explosion/frame9.svg"
};


class game
{
  animation explosion[] = new animation[21];
  PShape eyesUp;
  PShape eyesDown;
  PShape eyesLeft;
  PShape eyesRight;
  PShape powerUpS;
  
  //***************************************//
  
  PVector pos = new PVector();
  PVector size = new PVector();
  color colors[] = new color[2];
  
  
  //**********Game Varibles****************//
  intVector head[][] = new intVector[21][500];
  intVector apple[] = new intVector[1024];
  intVector power = new intVector();
  intVector movement[] = new intVector[21];
  long lastMove[] = new long[21];
  int activPowers[][] =  new int[21][2];
  long lastPower = 0;
  animation explotion[] = new animation[21];
  boolean playerLeft[] = new boolean[21];
  int wallKaos[] = { 0 , 0 };
  boolean tempWall;
  boolean standStill = false;
  int eaten;
  
  
  //**********Game Setings*****************//
  
  int appleAmount;
  boolean powerUp;
  boolean wales;
  int player;
  int ai;
  color pColor[] = new color[21];
  int tilesize;
  int tileCount[] = new int[2];
  int spacing[] = new int[2];
  int startSize;
  boolean diagonal;
  boolean waveMode;
  int diff = 0;
  
  
  
  game(float x, float y, float dx, float dy, color i_c[])
  {
    pos.x = x;
    pos.y = y;
    size.x = dx;
    size.y = dy;
    
    colors = i_c;
    
    eyesUp = loadShape("resources/game/grafiks/eyesUp.svg");
    eyesDown = loadShape("resources/game/grafiks/eyesDown.svg");
    eyesLeft = loadShape("resources/game/grafiks/eyesLeft.svg");
    eyesRight = loadShape("resources/game/grafiks/eyesRight.svg");
    powerUpS = loadShape("resources/game/grafiks/powerUp.svg");
    
    for(int i = 0; i < 21; i++)
    {
      explosion[i] = new animation(10,30,explosionFrames);
    }
    
    for(int p = 0; p < 21; p++)
    {
      for(int h = 0; h < 500; h++)
      {
          head[p][h] = new intVector();
      }
      movement[p] = new intVector();
    }
    for(int a = 0; a < 1024; a++)
    {
      apple[a] = new intVector();
    }
  }
  
  void startGame(int i_appleAmount, int i_player, int i_ai, int i_startSize, int i_tilesize, int i_diff, boolean i_wales, boolean i_powerUp, boolean i_diagonal, boolean i_waveMode, color i_pColor[])
  {
    for(int i = 0; i < 21; i++)
    {
      pColor[i] = i_pColor[i];
    }
    
    appleAmount = i_appleAmount;
    powerUp  = i_powerUp;
    wales  = i_wales;
    tempWall = wales;
    player = i_player;
    ai = i_ai;
    tilesize = i_tilesize;
    startSize = i_startSize;
    diagonal = i_diagonal;
    waveMode = i_waveMode;
    diff = i_diff;
    
    tileCount[0] = int(size.x * width/tilesize);
    tileCount[1] = int(size.y * height/tilesize);
    
    spacing[0] = int(size.x * width - floor(size.x * width));
    spacing[1] = int(size.y * height - floor(size.y * height));
    
    if(wales)
    {
     tileCount[0] -= 2;
     tileCount[1] -= 2;
    }
    
    
    restart();
  }
  
  void restart()
  {
    for(int p = 0; p < player + ai; p++)
    {
      playerLeft[p] = true;
      activPowers[p][0] = 0;
      activPowers[p][1] = 0;
    }
    for(int p =  player + ai; p < 21; p++)
    {
      playerLeft[p] = false;
      
    }
    power.x = -100;
    power.y = 0;
    
    eaten = 0;
    
    wallKaos[0] = 0;
    wallKaos[1] = 0;
    lastPower = millis();
    
    for(int p = 0; p < player + ai; p++)
    {
      head[p][0].z = startSize;
      switch(p)
      {
        case 0: 
        if(player == 1)
        {
          head[p][0].x = tileCount[0] / 2 ;
          head[p][0].y = tileCount[1] / 2 ;
        }
        else
        {
          head[p][0].x = tileCount[0] / 6 ;
          head[p][0].y = tileCount[1] / 2 ;
        } 
          movement[p].x = 0;
          movement[p].y = -1;
        
        break;
        case 1: 
          head[p][0].x = tileCount[0] * 5 / 6 ;
          head[p][0].y = tileCount[1] / 2 ;
          
          movement[p].x = 0;
          movement[p].y = 1;
        break;
        case 2: 
          head[p][0].x = tileCount[0] / 2;
          head[p][0].y = tileCount[1] * 5 / 6;
          
          movement[p].x = -1;
          movement[p].y = 0;
        break;
        case 3: 
          head[p][0].x = tileCount[0] / 2;
          head[p][0].y = tileCount[1] / 6;
          
          movement[p].x = 1;
          movement[p].y = 0;
        break;
        case 4: 
          head[p][0].x = tileCount[0] * 2 / 3;
          head[p][0].y = tileCount[1] / 2;
          
          movement[p].x = 0;
          movement[p].y = 1;
        break;
        case 5: 
          head[p][0].x = tileCount[0] / 3;
          head[p][0].y = tileCount[1] / 2;
          
          movement[p].x = 0;
          movement[p].y = -1;
        break;
        case 6: 
          head[p][0].x = tileCount[0] / 2;
          head[p][0].y = tileCount[1] / 3;
          
          movement[p].x = 1;
          movement[p].y = 0;
        break;
        case 7: 
          head[p][0].x = tileCount[0] / 2;
          head[p][0].y = tileCount[1] * 2 / 3;
          
          movement[p].x = -1;
          movement[p].y = 0;
        break;
        default: break;
      }
      for(int h = 1; h < startSize; h++)
      {
        head[p][h].x = head[p][h-1].x - movement[p].x;
        head[p][h].y = head[p][h-1].y - movement[p].y;
      }
    }
    for(int p =  player + ai; p < 21; p++)
    {
      for(int h = 0; h < 200;h++)
      {
        head[p][h].x = -200;
        head[p][h].y = -200;
      }
          
      movement[p].x = 0;
      movement[p].y = 0;
    }
    
    for(int a = 0; a < appleAmount; a++)
    {
      resetApple(a);
    }
    
  }
  
  void resetApple(int index)
  {
    boolean redo = true;
      while(redo)
      {
        redo = false;
        apple[index].x = (int) random(1,tileCount[0]-1);
        apple[index].y = (int) random(1,tileCount[1]-1);
        
        for(int p = 0; p < (player + ai); p++)
        {
          for(int h = 0; h < head[p][0].z; h++)
          {
            if(head[p][h].x == apple[index].x && head[p][h].y == apple[index].y)
            {
              redo = true;
            }
          }
          
        }
      }
    
  }
  
  void travel()
  {
    standStill = true;
    for(int p = 0; p < player + ai;p++)
    {
        int timeS = 200 *(4 * (int)( sqrt(20 * head[p][0].z)) / tilesize + 10) / min(tileCount[0], tileCount[1]);
        
        if(!playerLeft[p])
        {
          timeS /= 10;
        }
        if(activPowers[p][0] == 4)
        {
          timeS *= 1.8;
        }
        if(activPowers[p][0] == 5)
        {
          timeS /= 2;
        }
        if(activPowers[p][0] == 1 && (p < player || !waveMode))
        {
          timeS /= 1.8;
        }
        if(activPowers[p][0] == 6)
        {
          timeS *= 4;
        }
        if(movement[p].y != 0 && movement[p].x != 0)
        {
          timeS *= 1.4142f;
        }
        
        if( timeS <= (millis() - lastMove[p] ))
        {
          lastMove[p] = millis(); 
          for(int h = head[p][0].z - 1; h >= 0 ; h--)
          {
            if (h!=0 && (movement[p].x != 0 || movement[p].y != 0))
            {
              head[p][h].x = head[p][h-1].x;
              head[p][h].y = head[p][h-1].y;
            }
            else if (playerLeft[p])
            {
              if(abs(movement[p].x) == 2 || abs(movement[p].y) == 2)
                println("Fatal error");
              else
                head[p][0].add(movement[p]);
              
              if(!wales || activPowers[p][0] == 1)
              {
                if(head[p][0].x < 0)
                  head[p][0].x = tileCount[0] - 1;
                else if(head[p][0].x >= tileCount[0])
                  head[p][0].x = 0;
                
                if(head[p][0].y < 0)
                  head[p][0].y = tileCount[1] - 1;
                else if(head[p][0].y >= tileCount[1])
                  head[p][0].y = 0;
              }
            }    
            else if(!(movement[p].x != 0 || movement[p].y != 0))
            {
              log("Error:movement out of index.");
            }
          }
        }
      
    }
    standStill = false;
  }
  
  boolean winning()
  {
    int left = 0;
    for(int p = 0; p < player + ai; p++)
    {
      if(playerLeft[p])
      {
        left++;
      }
    }
    if(left <= 1)
    {
      return true;
    }
    else
    {
      return false;
    }
    
  }
  
  int winner()
  {
    int left = 5;
    for(int p = 0; p < player + ai; p++)
    {
      if(playerLeft[p])
      {
        left = p;
      }
    }
    
    return left;
  }
  
  boolean input()
  {
    if(keyPressed)
    {
      if(key == '~')
      {
        activPowers[0][0] = 1;
        activPowers[0][1] = 1000000;
      }
    }
    if(player > 0 && !standStill)
    {
      for(int p = 0; p < player; p++)
      {
    if(!diagonal)
    {
      if(standStill)
        return false;
      
      if(cont[p] == 1)
      {
      
      if (keyz[12]  && (head[p][0].y-1) != head[p][1].y && movement[p].y != 1)
      {
        movement[p].y = -1;
        movement[p].x = 0;
      }
      if (keyz[13]  && (head[p][0].y+1) != head[p][1].y && movement[p].y != -1)
      {
        movement[p].y = 1;
        movement[p].x = 0;
      }
      if (keyz[14]  && (head[p][0].x-1) != head[p][1].x && movement[p].x != 1)
      {
        movement[p].y = 0;
        movement[p].x = -1;
      }
      if (keyz[15]  && (head[p][0].x+1) != head[p][1].x && movement[p].x != -1)
      {
        movement[p].y = 0;
        movement[p].x = 1;
      }
      if(standStill)
        return false;
      }
       
      if(cont[p] == 0)
      {
       
      if (keyz[0]  && (head[p][0].y-1) != head[p][1].y && movement[p].y != 1)
      {
        movement[p].y = -1;
        movement[p].x = 0;
      }
      if (keyz[1]  && (head[p][0].y+1) != head[p][1].y && movement[p].y != -1)
      {
        movement[p].y = 1;
        movement[p].x = 0;
      }
      if (keyz[2]  && (head[p][0].x-1) != head[p][1].x && movement[p].x != 1)
      {
        movement[p].y = 0;
        movement[p].x = -1;
      }
      if (keyz[3]  && (head[p][0].x+1) != head[p][1].x && movement[p].x != -1)
      {
        movement[p].y = 0;
        movement[p].x = 1;
      }
      if(standStill)
        return false;
      }
        
      if(cont[p] == 2)
      {
       
      if (keyz[4]  && (head[p][0].y-1) != head[p][1].y && movement[p].y != 1)
      {
        movement[p].y = -1;
        movement[p].x = 0;
      }
      if (keyz[5]  && (head[p][0].y+1) != head[p][1].y && movement[p].y != -1)
      {
        movement[p].y = 1;
        movement[p].x = 0;
      }
      if (keyz[6]  && (head[p][0].x-1) != head[p][1].x && movement[p].x != 1)
      {
        movement[p].y = 0;
        movement[p].x = -1;
      }
      if (keyz[7]  && (head[p][0].x+1) != head[p][1].x && movement[p].x != -1)
      {
        movement[p].y = 0;
        movement[p].x = 1;
      }
          if(standStill)
        return false;
      }
        
     if(cont[p] == 3)
     {
       
      if (keyz[8]  && (head[p][0].y-1) != head[p][1].y && movement[p].y != 1)
      {
        movement[p].y = -1;
        movement[p].x = 0;
      }
      if (keyz[9]  && (head[p][0].y+1) != head[p][1].y && movement[p].y != -1)
      {
        movement[p].y = 1;
        movement[p].x = 0;
      }
      if (keyz[10]  && (head[p][0].x-1) != head[p][1].x && movement[p].x != 1)
      {
        movement[p].y = 0;
        movement[p].x = -1;
      }
      if (keyz[11]  && (head[p][0].x+1) != head[p][1].x && movement[p].x != -1)
      {
        movement[p].y = 0;
        movement[p].x = 1;
      }
      if(standStill)
        return false;
            
     }
       
    }
    else
    {
    
      if(cont[p] == 1)
      {
      
      if (keyz[12]  && (head[p][0].y-1) != head[p][1].y)
      {
        movement[p].y = -1;
      }
      if (keyz[13]  && (head[p][0].y+1) != head[p][1].y)
      {
        movement[p].y = 1;
      }
      if (keyz[14]  && (head[p][0].x-1) != head[p][1].x)
      {
        movement[p].x = -1;
      }
      if (keyz[15]  && (head[p][0].x+1) != head[p][1].x)
      {
        movement[p].x = 1;
      }
      if(standStill)
        return false;
      
      if(!keyz[12] && !keyz[13] && movement[p].x != 0)
        movement[p].y = 0;
        
      if(!keyz[14] && !keyz[15] && movement[p].y != 0)
        movement[p].x = 0;
      }
       
      if(cont[p] == 0)
      {
       
      if (keyz[0]  && (head[p][0].y-1) != head[p][1].y)
      {
        movement[p].y = -1;
      }
      if (keyz[1]  && (head[p][0].y+1) != head[p][1].y)
      {
        movement[p].y = 1;
      }
      if (keyz[2]  && (head[p][0].x-1) != head[p][1].x)
      {
        movement[p].x = -1;
      }
      if (keyz[3]  && (head[p][0].x+1) != head[p][1].x)
      {
        movement[p].x = 1;
      }
      if(standStill)
        return false;
        
        if(!keyz[0] && !keyz[1] && movement[p].x != 0)
        movement[p].y = 0;
        
      if(!keyz[2] && !keyz[3] && movement[p].y != 0)
        movement[p].x = 0;
      }
        
      if(cont[p] == 2)
      {
       
      if (keyz[4]  && (head[p][0].y-1) != head[p][1].y)
      {
        movement[p].y = -1;
      }
      if (keyz[5]  && (head[p][0].y+1) != head[p][1].y)
      {
        movement[p].y = 1;
      }
      if (keyz[6]  && (head[p][0].x-1) != head[p][1].x)
      {
        movement[p].x = -1;
      }
      if (keyz[7]  && (head[p][0].x+1) != head[p][1].x)
      {
        movement[p].x = 1;
      }
          if(standStill)
        return false;
        
        if(!keyz[4] && !keyz[5] && movement[p].x != 0)
        movement[p].y = 0;
        
      if(!keyz[6] && !keyz[7] && movement[p].y != 0)
        movement[p].x = 0;
      }
        
     if(cont[p] == 3)
     {
       
      if (keyz[8]  && (head[p][0].y-1) != head[p][1].y)
      {
        movement[p].y = -1;
      }
      if (keyz[9]  && (head[p][0].y+1) != head[p][1].y)
      {
        movement[p].y = 1;
      }
      if (keyz[10]  && (head[p][0].x-1) != head[p][1].x)
      {
        movement[p].x = -1;
      }
      if (keyz[11]  && (head[p][0].x+1) != head[p][1].x)
      {
        movement[p].x = 1;
      }
      if(standStill)
        return false;
        
        if(!keyz[8] && !keyz[9] && movement[p].x != 0)
        movement[p].y = 0;
        
      if(!keyz[10] && !keyz[11] && movement[p].y != 0)
        movement[p].x = 0;
            
     }
       
    }
    }
    }
    return true;
  }
  
  void aiMove()
  {
    int angle[] = new int[21];
    for(int i = 0; i < 21; i++)
    {
      if(movement[i].x == 1)
        angle[i] = 0;
      else if(movement[i].x == -1)
        angle[i] = 180;
      else if(movement[i].y == -1)
        angle[i] = 90;
      else if(movement[i].y == 1)
        angle[i] = 270;
    }
    for(int i = player; i < (player + ai);i++)
    {
      if(playerLeft[i])
      {
      int goUp = 20;
      int goDown = 20;
      int goLeft = 20;
      int goRigth = 20;
      //**************up
      for(int y = 1; y < 7; y++)
      {
        boolean found = false;
        for(int x = -y; x < y+1; x++)
        {
          for(int p = 0; p < (player + ai); p++)
          {
            if((angle[p] != 90 || y <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < head[p][0].z; h++)
              {
                if(head[i][0].x+x == head[p][h].x && head[i][0].y-y == head[p][h].y)
                {
                  if(abs(x)+abs(y) < goUp && (random(-3,3) <= diff || p == i))
                  {
                    goUp = abs(x) + abs(y);
                    found = true; 
                  }
                  if(diff > 0)
                  {
                  if(abs(x) == 1 && abs(y) == 1 && angle[p] == (90 + (90 * x))&& p != i && h == 0)
                  {
                    goUp = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goUp = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goUp = -3;
                  }
                  }
                }
              }
            }
          }
        }
        if(head[i][0].y - y < 0)
        {
          if((wales || wallKaos[0] != 0) && activPowers[i][0] != 1)
          {
            goUp = y;
            if(y == 1)
            {
              goUp = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //****************************************down
      for(int y = 1; y < 7; y++)
      {
        boolean found = false;
        for(int x = -y; x < y+1; x++)
        {
          for(int p = 0; p < (player + ai); p++)
          {
            if((angle[p] != 270 || y <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < head[p][0].z; h++)
              {
                if(head[i][0].x+x == head[p][h].x && head[i][0].y+y == head[p][h].y)
                {
                  if(abs(x)+abs(y) < goDown && (random(-3,3) <= diff || p == i))
                  {
                    goDown = abs(x) + abs(y);
                    found = true;
                  }
                  if(diff > 0)
                  {
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (90 + (90 * x))&& p != i && h == 0)
                  {
                    goDown = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goDown= 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goDown = -3;
                  }
                  }
                }
              }
            }
          }
        }
        if(head[i][0].y + y > (wales ? tileCount[1] - 2 : tileCount[1]))
        {
          if((wales || wallKaos[0] != 0) && activPowers[i][0] != 1)
          {
            goDown = y;
            if(y == 1)
            {
              goDown = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //***************************left
      for(int x = 1; x < 7; x++)
      {
        boolean found = false;
        for(int y = -x; y < x+1; y++)
        {
          for(int p = 0; p < (player + ai); p++)
          {
            if((angle[p] != 180 || x <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < head[p][0].z; h++)
              {
                if(head[i][0].x-x == head[p][h].x && head[i][0].y+y == head[p][h].y)
                {
                  if(abs(x)+abs(y) < goLeft && (random(-3,3) <= diff || p == i))
                  {
                    goLeft = abs(x) + abs(y);
                    found = true;
                  }
                  if(diff > 0)
                  {
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (180 - (90 * y)) && p != i && h == 0)
                  {
                    goLeft = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goLeft = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goLeft = -3;
                  }
                  }
                }
              }
            }
          }
        }
        if(head[i][0].x - x < 0)
        {
          if((wales || wallKaos[0] != 0 ) && activPowers[i][0] != 1)
          {
            goLeft = x;
            if(x == 1)
            {
              goLeft = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //******************rigth
      for(int x = 1; x < 7; x++)
      {
        boolean found = false;
        for(int y = -x; y < x+1; y++)
        {
          for(int p = 0; p < (player + ai); p++)
          {
            if((angle[p] != 0 || x <= 2) && playerLeft[p])
            {
              for(int h = 0; h < head[p][0].z; h++)
              {
                if(head[i][0].x+x == head[p][h].x && head[i][0].y+y == head[p][h].y)
                {
                  if(abs(x)+abs(y) < goRigth && (random(-3,3) <= diff || p == i))
                  {
                    goRigth = abs(x) + abs(y);
                    found = true;
                  }
                  if(diff > 0)
                  {
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (180 + (90 * y)) && p != i && h == 0)
                  {
                    goRigth= 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goRigth = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goRigth = -3;
                  }
                  }
                }
              }
            }
          }
        }
        if(head[i][0].x + x > (wales ? tileCount[0] - 2 : tileCount[0]))
        {
          if((wales || wallKaos[0] != 0) && activPowers[i][0] != 1 )
          {
            goRigth = x;
            if(x == 1)
            {
              goRigth = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      if(diff > 1)
      {
      boolean stopU = false;
      boolean stopD = false;
      boolean stopL = false;
      boolean stopR = false;
      
      for(int h = 1; h < head[i][0].z; h++)
      {
        for(int x = 1; x < head[i][0].z/2; x++)
        {
          if(head[i][0].x+x == head[i][h].x && head[i][0].y == head[i][h].y && !stopR)
          {
            goRigth -= 4 - sqrt(x);
            stopR = true;
          }
          if(head[i][0].x-x == head[i][h].x && head[i][0].y == head[i][h].y && !stopL)
          {
            goLeft -= 4 - sqrt(x);
            stopL = true;
          }
          if(head[i][0].x == head[i][h].x && head[i][0].y+x == head[i][h].y && !stopD)
          {
            goDown -= 4 - sqrt(x);
            stopD = true;
          }
          if(head[i][0].x == head[i][h].x && head[i][0].y-x == head[i][h].y && !stopU)
          {
            goUp -= 4 - sqrt(x);
            stopU = true;
          }
        }
      }
      }
      
      for(int p = 0; p < player + ai;p++)
      {
        if(activPowers[p][0] == 1)
        {
          if(head[i][1].y == head[p][0].y && head[i][1].x == head[p][0].x && movement[i].x == movement[p].x && movement[i].y == movement[p].y)
          {
            switch(angle[i])
            {
              case 0:
                goRigth = -1;
              break;
              case 90:
                goUp = -1;
              break;
              case 180:
                goLeft = -1;
              break;
              case 270:
                goDown = -1;
              break;
            }
          }
          
          else if(head[i][2].y == head[p][0].y && head[i][2].x == head[p][0].x && movement[i] == movement[p] && movement[i].y == movement[p].y)
          {
            switch(angle[i])
            {
              case 0:
                goRigth = 0;
              break;
              case 90:
                goUp = 0;
              break;
              case 180:
                goLeft = 0;
              break;
              case 270:
                goDown = 0;
              break;
            }
          }
        }
      }
      
      int dir[] = {goUp, goDown, goLeft};
      
      switch(angle[i])
      {
        case 0:
          dir[0] = goUp;
          dir[1] = goDown;
          dir[2] = goRigth;
        break;
        case 90:
          dir[0] = goUp;
          dir[1] = goLeft;
          dir[2] = goRigth;
        break;
        case 180:
          dir[0] = goUp;
          dir[1] = goDown;
          dir[2] = goLeft;
        break;
        case 270:
          dir[0] = goLeft;
          dir[1] = goDown;
          dir[2] = goRigth;
        break;
      }
      
      if(min(dir) > 6 || (dir[0] + dir[1] + dir[2]) > 25)
      {
        for(int a = 0; a < appleAmount; a++)
        {
          if(head[i][0].x == apple[a].x)
          {
            if(head[i][0].y > apple[a].y)
            {
              goUp += 1;
            }
            else
            {
              goDown += 1;
            }
          }
          if(head[i][0].y == apple[a].y)
          {
            if(head[i][0].x > apple[a].x)
            {
              goLeft += 1;
            }
            else
            {
              goRigth += 1;
            }
          }
        }
      }
      
      if(min(dir) > 6 || (dir[0] + dir[1] + dir[2]) > 25)
      {
        if(head[i][0].x == power.x)
        {
          if(head[i][0].y > power.y)
          {
            goUp += 1;
          }
          else
          {
            goDown += 1;
          }
        }
        if(head[i][0].y == power.y)
        {
          if(head[i][0].x > power.x)
          {
            goLeft += 1;
          }
          else
          {
            goRigth += 1;
          }
        }
      }
      
      if(diff > 2)
      for(int p = 0; p < player + ai; p++)
      {
        switch(angle[i])
        {
          case 0:
            if(head[i][0].x-1 == head[p][0].x && head[i][0].y == head[p][0].y)
              goRigth -= 5;
          break;
          case 90:
             if(head[i][0].x == head[p][0].x && head[i][0].y+1 == head[p][0].y)
              goUp -= 5;
          break;
          case 180:
             if(head[i][0].x+1 == head[p][0].x && head[i][0].y == head[p][0].y)
              goLeft -= 5;
          break;
          case 270:
             if(head[i][0].x == head[p][0].x && head[i][0].y-1 == head[p][0].y)
              goDown -= 5;
          break;
        }
      }
      
      if(goUp > goDown && goUp > goLeft && goUp > goRigth)
      {
        angle[i] = 90;
      }
      else if(goDown > goUp && goDown > goLeft && goDown > goRigth)
      {
        angle[i] = 270;
      }
      else if(goLeft > goUp && goLeft > goDown && goLeft > goRigth)
      {
        angle[i] = 180;
      }
      else if(goRigth > goUp && goRigth > goDown && goRigth > goLeft)
      {
        angle[i] = 0;
      } 
      else
      {
        if(goUp < 4 && goLeft == goRigth && angle[i] == 90)
        {
          if(random(2) < 1)
          {
            angle[i] = 180;
          }
          else
          {
            angle[i] = 0;
          }
        }
        if(goLeft < 4 && goUp == goDown && angle[i] == 180)
        {
          if(random(2) < 1)
          {
            angle[i] = 90;
          }
          else
          {
            angle[i] = 270;
          }
        }
        if(goDown < 4 && goLeft == goRigth && angle[i] == 270)
        {
          if(random(2) < 1)
          {
            angle[i] = 0;
          }
          else
          {
            angle[i] = 180;
          }
        }
        if(goRigth < 4 && goDown == goUp && angle[i] == 0)
        {
          if(random(2) < 1)
          {
            angle[i] = 90;
          }
          else
          {
            angle[i] = 270;
          }
        }
      }
      
      }
      switch(angle[i])
      {
        case 0:
          movement[i].x = 1;
          movement[i].y = 0;
        break;
        case 90:
          movement[i].x = 0;
          movement[i].y = -1;
        break;
        case 180:
          movement[i].x = -1;
          movement[i].y = 0;
        break;
        case 270:
          movement[i].x = 0;
          movement[i].y = 1;
        break;
      }
    }
  }
  
  void ajustTilesize()
  {
    /*tilesize = int(size.x * width/tileCount[0]);
    
    spacing[0] = int(size.x * width / tilesize - floor(size.x * width / tilesize)) * tilesize / 2;
    spacing[1] = int(size.y * height / tilesize - floor(size.y * height / tilesize)) * tilesize / 2;*/
    
    tileCount[0] = int(size.x * width/tilesize);
    tileCount[1] = int(size.y * height/tilesize);
    
    spacing[0] = int(size.x * width - floor(size.x * width));
    spacing[1] = int(size.y * height - floor(size.y * height));
    
    if(wales)
    {
     tileCount[0] -= 2;
     tileCount[1] -= 2;
    }
    
  }
  
  void render()
  {
    
    ajustTilesize();
    
    if(wales)
    {
      stroke(colors[1]);
      strokeWeight(2 * tilesize);
    }
    else
    {
      noStroke();
    }
    fill(colors[0]);
    
    rect(pos.x * width, pos.y * height, size.x * width, size.y * height);
    
    for(int p = 0; p < player + ai; p++)
    {
        noStroke();
        fill(pColor[p]);
        rectMode(CENTER);
         
        strokeJoin(MITER);
        stroke(colors[0]);
        strokeWeight(tilesize/10);
         
        for(int h = 0; h < head[p][0].z ; h++)
        {  
          rect((spacing[0] + (head[p][h].x * tilesize + tilesize/2)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][h].y * tilesize + tilesize/2)) + (wales ? tilesize : 0) + pos.y * height, tilesize * ((((float)head[p][0].z-h)/head[p][0].z)*0.2f + 0.8f), tilesize * ((((float)head[p][0].z-h)/head[p][0].z)*0.2f + 0.8f));
        }
        if(movement[p].y == -1)
          shape(eyesUp,(spacing[0] + (head[p][0].x * tilesize)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][0].y * tilesize)) + (wales ? tilesize : 0) + pos.y * height, tilesize, tilesize);
        else if(movement[p].y == 1)
          shape(eyesDown,(spacing[0] + (head[p][0].x * tilesize)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][0].y * tilesize)) + (wales ? tilesize : 0) + pos.y * height, tilesize, tilesize);
        else if(movement[p].x == 1)
          shape(eyesRight,(spacing[0] + (head[p][0].x * tilesize)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][0].y * tilesize)) + (wales ? tilesize : 0) + pos.y * height, tilesize, tilesize);
        else if(movement[p].x == -1)
          shape(eyesLeft,(spacing[0] + (head[p][0].x * tilesize)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][0].y * tilesize)) + (wales ? tilesize : 0) + pos.y * height, tilesize, tilesize);
        else
          shape(eyesUp,(spacing[0] + (head[p][0].x * tilesize)) + (wales ? tilesize : 0) + pos.x*width,( spacing[1]  + (head[p][0].y * tilesize)) + (wales ? tilesize : 0) + pos.y * height, tilesize, tilesize);
        
        
        
        if(activPowers[p][0] != 0)
        {
          if(activPowers[p][0] == 1 && playerLeft[p])
            stroke(0, 233, 255, 100);
          else if(activPowers[p][0] == 4 && playerLeft[p])
            stroke(59, 214, 12, 100);
          else if(activPowers[p][0] == 6 && playerLeft[p])
            stroke(43, 145, 13, 100);
          else if(activPowers[p][0] == 5 && playerLeft[p])
            stroke(255, 123, 0, 100);
          else
            noStroke();
      
          noFill();
          strokeWeight(2*tilesize);
          beginShape(POINTS);
          for(int h = 0; h < head[p][0].z; h++)
          {
          
             vertex(pos.x * width + spacing[0] + (head[p][h].x * tilesize) + (wales ? (3*tilesize/2) : (tilesize/2)),pos.y * height + spacing[1] + (head[p][h].y * tilesize) + (wales ? (3*tilesize/2) : (tilesize/2)));
           
          }
          endShape();
        }
        
        
        explosion[p].render();
      
    }
    for(int a = 0; a < appleAmount; a++)
    {
      strokeJoin(MITER);
      strokeWeight(tilesize/7);
      stroke(0);
      fill(255, 0, 0);
      rectMode(CORNER);
      
      rect((spacing[0] + (apple[a].x * tilesize)) + (wales ? tilesize : 0),( spacing[1] + (apple[a].y * tilesize)) + (wales ? tilesize : 0), tilesize, tilesize);
      
    }
    
         
     shape(powerUpS,pos.x * width + spacing[0] + (power.x *tilesize) + (wales ? tilesize : 0), pos.y * height + spacing[1] + (power.y*tilesize) + (wales ? tilesize : 0), 2*tilesize, 2*tilesize);
    
     
    
  }
  
  void gameOverScreen()
  {
    
    
  }
  
  void colision()
  {
    if(!standStill)
    {
    if(powerUp)
    {
      if(millis() - lastPower > 20000)
      {
        boolean redo = true;
        while(redo)
        {
          redo = false;
          power.x = (int) random(1,tileCount[0]-2);
          power.y = (int) random(1,tileCount[1]-2);
          
          for(int p = 0; p < player + ai; p++)
          {
            if(playerLeft[p])
            {
              for(int h = 0; h < head[p][0].z; h++)
              {
                if(head[p][h].x == power.x && head[p][h].y == power.y)
                {
                  redo = true;
                }
                if(head[p][h].x-1 == power.x && head[p][h].y == power.y)
                {
                  redo = true;
                }
                if(head[p][h].x == power.x && head[p][h].y-1 == power.y)
                {
                  redo = true;
                }
                if(head[p][h].x-1 == power.x && head[p][h].y-1 == power.y)
                {
                  redo = true;
                }
              }
            }
            
          }
 
        }
        lastPower = millis();
      }
    }
      for(int p = 0; p < player + ai; p++)
      {
        if(activPowers[p][0] != 0 && millis() - activPowers[p][1] > 20000)
        {
          activPowers[p][0] = 0;
        }
        if(wallKaos[0] != 0 && millis() - wallKaos[1] > 20000)
        {
          wallKaos[0] = 0;
          wales = tempWall;
        }
        if(((head[p][0].x == power.x && head[p][0].y == power.y) || (head[p][0].x-1 == power.x && head[p][0].y == power.y) || (head[p][0].x == power.x && head[p][0].y-1 == power.y) || (head[p][0].x-1 == power.x && head[p][0].y-1 == power.y))&& playerLeft[p])
        {
          switch((int)random(0,9))
          {
            case 0:
              activPowers[p][0] = 1;
              activPowers[p][1] = millis();
            break;
            case 1:
              activPowers[p][0] = 2;
              head[p][0].z += 10;
              for(int h = 0; h < 10; h++)
              {
                head[p][ head[p][0].z-1-h].x = head[p][ head[p][0].z-11].x; 
                head[p][ head[p][0].z-1-h].y = head[p][ head[p][0].z-11].y; 
              }
              activPowers[p][1] = millis();
            break;
            case 2:
              activPowers[p][0] = 3;
               head[p][0].z /= 2;
              activPowers[p][1] = millis();
            break;
            case 3:
              activPowers[p][0] = 4;
              activPowers[p][1] = millis();
            break;
            case 4:
              activPowers[p][0] = 5;
              for(int p2 = 0; p2 < player + ai;p2++)
              {
                if(p2 != p)
                {
                  activPowers[p2][0] = 4;
                  activPowers[p2][1] = millis();
                }
              }
              activPowers[p][1] = millis();
            break;
            case 5:
              activPowers[p][0] = 6;
              activPowers[p][1] = millis();
            break;
            case 6:
              activPowers[p][0] = 7;
              head[p][0].z  += 5;
              for(int h = 0; h < 5; h++)
              {
                head[p][head[p][0].z -1-h].x = head[p][head[p][0].z -6].x; 
                head[p][head[p][0].z -1-h].y = head[p][head[p][0].z -6].y; 
              }
              wallKaos[0] = round(random(50,100));
              wallKaos[1] = millis();
              activPowers[p][1] = millis();
            break;
            case 7:
              activPowers[p][0] = 5;
              activPowers[p][1] = millis();
            break;
            case 8:
              activPowers[p][0] = 5;
              activPowers[p][1] = millis();
            break;
            default:
              activPowers[p][0] = 1;
              activPowers[p][1] = millis();
            break;
          }
          power.x = -100;
        }
      }
      
    
    if(wallKaos[0] != 0)
    {
      if(millis() % wallKaos[0] == 0)
      {
        wales = !wales;
      }
    }
    
    boolean playerDied[] = new boolean[21];
    
    for(int p = 0; p < player + ai; p++)
    {
      if(playerLeft[p] )
      {
      for(int a = 0; a < appleAmount; a++)
      {
        if(head[p][0].x == apple[a].x && head[p][0].y == apple[a].y)
        {
          head[p][0].z++;
          head[p][head[p][0].z-1].x = head[p][head[p][0].z-2].x;
          head[p][head[p][0].z-1].y = head[p][head[p][0].z-2].y;
          eaten++;
          
          resetApple(a);
         }
        }
        if(head[p][0].x < 0 || head[p][0].x >= tileCount[0] || head[p][0].y < 0 || head[p][0].y >= tileCount[1])
        {
          if(wales && activPowers[p][0] != 1)
          {
            playerLeft[p] = false;
            explosion[p].activate(head[p][0].x * tilesize +  spacing[0] - (movement[p].x * tilesize / 2), head[p][0].y * tilesize +  spacing[1] - (movement[p].y * tilesize / 2), tilesize, tilesize);
            playerDied[p] = true; 
          }
        }
        for(int p2 = 0; p2 < player + ai; p2++)
        {
          if((activPowers[p][0] != 1 || p == p2))
          {
            for(int h = 0; h < head[p2][0].z; h++)
            {
              if(!(waveMode && p >= player && p2 >= player && p != p2))
              {
              if(p != p2 || h != 0)
              {
                if(head[p][0].x == head[p2][h].x && head[p][0].y == head[p2][h].y && !standStill)
                {
                  playerLeft[p] = false;
                  explosion[p].activate(head[p][0].x * tilesize +  spacing[0] - (movement[p].x * tilesize / 2), head[p][0].y * tilesize +  spacing[1] - (movement[p].y * tilesize / 2), tilesize, tilesize);
                  playerDied[p] = true; 
                }
              }
              }
            }
          }
        }
      }
    }
    
    for(int p = 0; p < player + ai; p++)
    {
      if(playerDied[p])
        head[p][0].x = -200;
    }
  }
  }
  
  
  void wave(int wave)
  {
    for( int p = player; p < wave + player; p++)
    {
      switch((p - player) % 4)
      {
        case 0: 
          head[p][0].x = ((p - player) / 4 + 1) * tileCount[0] / 6;
          head[p][0].y = -100/tilesize;
          
          movement[p].x = 0;
          movement[p].y = 1;
        break;
        case 1: 
          head[p][0].y = ((p - player -1) / 4 +1) * tileCount[1] / 6;
          head[p][0].x = tileCount[0] + 100 / tilesize;
          
          movement[p].y = 0;
          movement[p].x = -1;
        break;
        case 2: 
          head[p][0].x = ((p - player -2) / 4 +1) * tileCount[0] / 6;
          head[p][0].y = tileCount[1] + 100 / tilesize;
          
          movement[p].x = 0;
          movement[p].y = -1;
        break;
        case 3: 
          head[p][0].y = ((p - player -3) / 4 +1) * tileCount[1] / 6;
          head[p][0].x = - 100 / tilesize;
          
          movement[p].y = 0;
          movement[p].x = 1;
        break;
      }
      
      head[p][0].z = startSize;
      
      for(int h = 1; h < startSize; h++)
      {
        head[p][h].x = head[p][h-1].x - movement[p].x;
        head[p][h].y = head[p][h-1].y - movement[p].y;
      }
      
      activPowers[p][0] = 1;
      activPowers[p][1] = millis() - 19000;
      playerLeft[p] = true;
    }
    ai = wave;
  }  
}

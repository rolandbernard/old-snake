
int angle=0;
int angle2=0;
int snakesize=5;
int snakesize2=5;
int time=0;
int headx[] = new int[2500];
int heady[] = new int[2500];
int applex=(round(random(47))+1)*8;
int appley=(round(random(47))+1)*8;
int headx2[] = new int[2500];
int heady2[] = new int[2500];
boolean redo=true;
boolean stopgame=false;
void setup()
{
  restart();
  size(400,400);
  textAlign(CENTER);
  PFont font;
  font = loadFont("MyScriptFont-18.vlw");
  textFont(font);
}
void draw()
{
  if (stopgame)
  {
  }
  else
  {
  time+=1;
  fill(255,0,0);
  stroke(0);
  rect(applex,appley,8,8);
  fill(0);
  stroke(0);
  rect(0,0,width,8);
  rect(0,height-8,width,8);
  rect(0,0,8,height);
  rect(width-8,0,8,height);
  if ((time % 5)==0)
  {
    travel();
    display();
    checkdead();
  }
  }
}
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP && angle!=270 && (heady[0]-8)!=heady[1])
    {
      angle=90;
    }
    if (keyCode == DOWN && angle!=90 && (heady[0]+8)!=heady[1])
    {
      angle=270;
    }if (keyCode == LEFT && angle!=0 && (headx[0]-8)!=headx[1])
    {
      angle=180;
    }if (keyCode == RIGHT && angle!=180 && (headx[0]+8)!=headx[1])
    {
      angle=0;
    }
    if (keyCode == SHIFT)
    {
      restart();
    }
  }
  if (keyPressed) {
  if (key == 'w'  && angle2!=270 && (heady2[0]-8)!=heady2[1])
    {
      angle2=90;
    }
    if (key == 's' && angle2!=90 && (heady2[0]+8)!=heady2[1])
    {
      angle2=270;
    }if (key == 'a' && angle2!=0 && (headx2[0]-8)!=headx2[1])
    {
      angle2=180;
    }if (key == 'd' && angle2!=180 && (headx2[0]+8)!=headx2[1])
    {
      angle2=0;
    }
  }
}
void travel()
{
  for(int i=snakesize-1;i>=0;i--)
  {
    if (i!=0)
    {
      headx[i]=headx[i-1];
      heady[i]=heady[i-1];
    }
    else
    {
      switch(angle)
      {
        case 0:
        headx[0]+=8;
        break;
        case 90:
        heady[0]-=8;
        break;
        case 180:
        headx[0]-=8;
        break;
        case 270:
        heady[0]+=8;
        break;
      }
    }
  }
  for(int i=snakesize2-1;i>=0;i--)
  {
    if (i!=0)
    {
      headx2[i]=headx2[i-1];
      heady2[i]=heady2[i-1];
    }
    else
    {
      switch(angle2)
      {
        case 0:
        headx2[0]+=8;
        break;
        case 90:
        heady2[0]-=8;
        break;
        case 180:
        headx2[0]-=8;
        break;
        case 270:
        heady2[0]+=8;
        break;
      }
    }
  }
  
}
void display()
{
  if (headx[0]==applex && heady[0]==appley)
  {
    snakesize+=round(random(3)+1);
    redo=true;
    while(redo)
    {
      applex=(round(random(47))+1)*8;
      appley=(round(random(47))+1)*8;
      for(int i=0;i<snakesize;i++)
      {
        
        if (applex==headx[i] && appley==heady[i])
        {
          redo=true;
        }
        else
        {
          redo=false;
          i=1000;
        }
      }
    }
  }
  stroke(255);
  fill(255, 0 ,25);
  rect(headx[0],heady[0],8,8);
  fill(255);
  noStroke();
  rect(headx[snakesize-1],heady[snakesize-1],8,8);
  
  if (headx2[0]==applex && heady2[0]==appley)
  {
    snakesize2+=round(random(3)+1);
    redo=true;
    while(redo)
    {
      applex=(round(random(47))+1)*8;
      appley=(round(random(47))+1)*8;
      for(int i=0;i<snakesize2;i++)
      {
        
        if (applex==headx2[i] && appley==heady2[i])
        {
          redo=true;
        }
        else
        {
          redo=false;
          i=1000;
        }
      }
    }
  }
  stroke(255);
  fill(0, 255, 25);
  rect(headx2[0],heady2[0],8,8);
  fill(255);
  noStroke();
  rect(headx2[snakesize2-1],heady2[snakesize2-1],8,8);
  
}
void checkdead()
{
  
  for(int i=1;i<snakesize;i++)
  {
    if (headx[0]==headx[i] && heady[0]==heady[i])
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150);
      fill(0, 255, 25);
      text("Green player won!",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
    if (headx[0]==headx2[i] && heady[0]==heady2[i])
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150);
      fill(0, 255, 25);
      text("Green player won",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
    if (headx[0]>=(width-8) || heady[0]>=(height-8) || headx[0]<=0 || heady[0]<=0)
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150);
      fill(0, 255, 25);
      text("Green player won",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
  
}

for(int i=1;i<snakesize2;i++)
  {
    if (headx2[0]==headx2[i] && heady2[0]==heady2[i])
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150);
      fill(255, 0 ,25);
      text("Red player won!",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
    if (headx2[0]==headx[i] && heady2[0]==heady[i])
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150); 
      fill(255, 0 ,25);
      text("Red player won!",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
    if (headx2[0]>=(width-8) || heady2[0]>=(height-8) || headx2[0]<=0 || heady2[0]<=0)
    {
      fill(255);
      rect(125,125,160,100);
      fill(0);
      text("GAME OVER",200,150);
      fill(255, 0 ,25);
      text("Red player won!",200,175);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
 
  
}

if (headx[0]==headx2[0] && heady[0]==heady2[0])
    {
      fill(255);
      rect(125,125,160,100);
      fill(255,0,0);
      text("GAME OVER",200,150);
      fill(0);
      text("To restart, press Shift.",200,200);
      stopgame=true;
    }
}

void restart()
{
  background(255);
  headx[0]=200;
  heady[0]=248;
  headx2[0]=200;
  heady2[0]=152;
  for(int i=1;i<1000;i++)
  {
    headx[i]=0;
    heady[i]=0;
  }
  for(int i=1;i<1000;i++)
  {
    headx2[i]=0;
    heady2[i]=0;
  }
  stopgame=false;
  applex=(round(random(47))+1)*8;
  appley=(round(random(47))+1)*8;
  snakesize=5;
  snakesize2=5;
  time=0;
  angle=0;
  angle2=180;
  redo=true;
}
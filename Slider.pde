class slider
{
  float size,cirkSize, posX, posY, maxVal=100, minVal = 0,lastX;
  float value;
  boolean lastPres = false;
  int colore[][] = new int[3][3];
  int moveMulti = 2;
  
  slider(float i_size, float i_cirkSize,float i_posX,float i_posY,float i_value, int i_minVal,int i_maxVal)
  {
    size = i_size;
    cirkSize = i_cirkSize;
    posX = i_posX;
    posY = i_posY;
    value = i_value;
    maxVal = i_maxVal;
    minVal = i_minVal;
  }
  
  slider(float i_size, float i_cirkSize,float i_posX,float i_posY,float i_value, int i_minVal,int i_maxVal, int i_color[][])
  {
    size = i_size;
    cirkSize = i_cirkSize;
    posX = i_posX;
    posY = i_posY;
    value = i_value;
    maxVal = i_maxVal;
    minVal = i_minVal;
    colore = i_color;
  }
  
  void setColors(int L1, int L2, int L3, int F1, int F2, int F3, int R1, int R2, int R3)
  {
    colore[0][0] = L1;
    colore[0][1] = L2;
    colore[0][2] = L3;
    colore[1][0] = F1;
    colore[1][1] = F2;
    colore[1][2] = F3;
    colore[2][0] = R1;
    colore[2][1] = R2;
    colore[2][2] = R3;
  }
  
  void render()
  {
    strokeWeight(cirkSize/10 * width);
    strokeJoin(BEVEL);
    stroke(colore[0][0],colore[0][1],colore[0][2]);
    line((posX - cirkSize/2) * width, posY * height, (posX + cirkSize/2 + size) * width, posY * height);
    line((posX - cirkSize/2) * width, posY * height - (cirkSize/4) * width, (posX - cirkSize/2) * width , posY * height + (cirkSize/4) * width);
    line((posX + cirkSize/2 + size) * width, posY * height - (cirkSize/4) * width, (posX + cirkSize/2 + size) * width, posY * height + (cirkSize/4) * width);
    stroke(colore[2][0],colore[2][1],colore[2][2]);
    fill(colore[1][0],colore[1][1],colore[1][2]);
    ellipseMode(CENTER);
    ellipse((posX + map(value,minVal,maxVal,0,size)) * width, posY * height, cirkSize * width, cirkSize * width);
  }
  
  int returnValue()
  {
    if (mouseX > (posX - (cirkSize))* width && mouseX < posX * width + size * width && mouseY > (posY * height - (cirkSize/2)*width) && mouseY < (posY*height + (cirkSize/2)*width) )
    {
      cursor(HAND);
      hand = true;
      if (mousePressed)
      {
        if(lastPres)
        {
          float valueB = value;
          valueB = value + (moveMulti) * (mouseX - lastX) * (maxVal-minVal) / (size * width);
          
          if(valueB < minVal)
          {
            valueB = minVal;
          }else if(valueB > maxVal)
          {
            valueB = maxVal; 
          }
          value = valueB;
        
        }
        lastX = mouseX;
        lastPres = true;
      }else
      {
        lastPres = false;
      }
    }else
    {
      if(lastPres && mousePressed)
      {
        lastPres = true;
      }
    }
    int returnVal = round(value);
    return returnVal;
  }
  
}
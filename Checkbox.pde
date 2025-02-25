class checkBox
{
  float sizeX, sizeY, posX, posY;
  int colore[][] = new int[2][3];
  boolean pressd;
  boolean checked = false;
  int srokeSize;
  boolean changeS = true;
  PShape checkSymb;
  boolean hover = false;
  
  checkBox(float i_posX,float  i_posY,float i_sizeX,float i_sizeY, boolean i_checked)
  {
    posX = i_posX;
    posY = i_posY;
    sizeX = i_sizeX;
    sizeY = i_sizeY;
    checked = i_checked;
    
    checkSymb = loadShape("resources/game/grafiks/check.svg");
  }
  
  
  checkBox(float i_posX,float  i_posY,float i_sizeX,float i_sizeY, boolean i_checked, int i_color[][])
  {
    posX = i_posX;
    posY = i_posY;
    sizeX = i_sizeX;
    sizeY = i_sizeY;
    checked = i_checked;
    colore = i_color;
    
    checkSymb = loadShape("resources/game/grafiks/check.svg");
  }
  
  void setColors(int F1, int F2, int F3, int R1, int R2, int R3)
  {
    colore[0][0] = F1;
    colore[0][1] = F2;
    colore[0][2] = F3;
    colore[1][0] = R1;
    colore[1][1] = R2;
    colore[1][2] = R3;
  }
  
  void render()
  {
    if(changeS)
     srokeSize = (int) sizeY*height/10;
     stroke(colore[1][0],colore[1][1],colore[1][2]);
     fill(colore[0][0],colore[0][1],colore[0][2]);
     strokeWeight(srokeSize);
     strokeJoin(BEVEL);
     rect(posX*width, posY*height, sizeX*width, sizeY*width);
     noFill();
     if(checked)
     {   
        shape(checkSymb, posX * width, posY * height, sizeX * width, sizeY * width);
     }
  }
  
  boolean checked()
  {
    if(mouseX > posX*width && mouseX < (posX + sizeX)*width && mouseY > posY*height && mouseY < (posY * height + sizeY * width))
    {
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         if(!pressd)
         {
            checked = !checked; 
         }
         
         pressd = true;
         
       } else {
         
         
         pressd = false;
       }
        
    }
    else
      hover = false;
      
    return checked;
  }
  
}
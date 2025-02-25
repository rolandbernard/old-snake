class button
{
  float sizeX, sizeY, posX, posY;
  int colore[][] = new int[3][3];
  text m_text;
  boolean pressd;
  boolean hover;
  int srokeSize;
  boolean changeS = true;
  
  button(float i_posX,float  i_posY,float i_sizeX,float i_sizeY,float i_textSize,String i_text)
  {
    posX = i_posX;
    posY = i_posY;
    sizeX = i_sizeX;
    sizeY = i_sizeY;
    m_text = new text(posX + sizeX/2, posY + sizeY/2, i_textSize, i_text, CENTER, CENTER, color(colore[2][0], colore[2][1], colore[2][2]));
    
  }
  
  button(float i_posX,float  i_posY,float i_sizeX,float i_sizeY,float i_textSize,String i_text, int i_colore[][])
  {
    posX = i_posX;
    posY = i_posY;
    sizeX = i_sizeX;
    sizeY = i_sizeY;
    colore = i_colore;
    m_text = new text(posX + sizeX/2, posY + sizeY * 0.5, i_textSize, i_text, CENTER, CENTER, color(colore[2][0], colore[2][1], colore[2][2]));
  }
  
  void setColors(int F1, int F2, int F3, int R1, int R2, int R3, int T1, int T2, int T3)
  {
    colore[0][0] = F1;
    colore[0][1] = F2;
    colore[0][2] = F3;
    colore[1][0] = R1;
    colore[1][1] = R2;
    colore[1][2] = R3;
    colore[2][0] = T1;
    colore[2][1] = T2;
    colore[2][2] = T3;
  }
  
  void render()
  {
    if(!hover)
    {
      stroke(colore[1][0],colore[1][1],colore[1][2]);
      fill(colore[0][0],colore[0][1],colore[0][2]);
    }else
    {
      stroke(colore[1][0]*0.9f,colore[1][1]*0.9f,colore[1][2]*0.9f);
      fill(colore[0][0]*0.9f,colore[0][1]*0.9f,colore[0][2]*0.9f);
    }
    if(changeS)
      srokeSize = (int) sizeY / 10 * height;
      strokeWeight(srokeSize);
      strokeJoin(BEVEL);
      rect(posX * width, posY * height, sizeX * width, sizeY * height);
      fill(colore[2][0],colore[2][1],colore[2][2]);
      
      m_text.render();
    
  }
  
  boolean presd()
  {
    if(mouseX > posX * width && mouseX < (posX + sizeX) * width && mouseY > posY * height && mouseY < (posY + sizeY) * height )
    {
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         if(!pressd)
         {
           pressd = true;
           return true;
         }
         else
         {
           return false;
         }
         
       } else {
         
         pressd = false;
         return false;
       }
        
    } else {
      
      hover = false;
      pressd = false;
      return false;
      
    }
    
  }
  
}
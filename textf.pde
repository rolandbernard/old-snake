


class textf
{
  PVector pos = new PVector(), size = new PVector();
  String text = "";
  float texts;
  PFont font;
  int controlX;
  color c[] = new color[2];
  int keyPr = -1;
  
  textf(float x, float y, float dx, float dy, float textsize, color i_c[])
  {
    pos.x = x;
    pos.y = y;
    size.x = dx;
    size.y = dy;
    texts = textsize;
    c = i_c;
    font = createFont("Arial Rounded MT Bold", texts * width);
  }
  
  void render()
  {
    if(width != controlX)
    {
      font = createFont("Arial Rounded MT Bold", texts * width);
      controlX = width;
    }
    
    stroke(c[1]);
    fill(c[0]);
    rect(pos.x * width, pos.y * height, size.x * width, size.y * height);
    
    fill(0);
    textAlign(LEFT,CENTER);
    text(text,(pos.x + 0.05 * size.x) * width,(pos.y + size.y/2) * height - texts * width * 0.115);
  }
  
  void input()
  {
    if(keyPressed)
    {
      if (key == BACKSPACE || key == DELETE) {
           if (text.length() > 0 ) {
             text = text.substring( 0 , text.length()- 1 );
           }
      }
    }
    
    if(text.length() <= 10)
    {
    if( keytr[0] ) { text += "a"; keytr[0] = false; }
    if( keytr[1] ) { text += "b"; keytr[1] = false; }
    if( keytr[2] ) { text += "c"; keytr[2] = false; } 
    if( keytr[3] ) { text += "d"; keytr[3] = false; }
    if( keytr[4] ) { text += "e"; keytr[4] = false; }
    if( keytr[5] ) { text += "f"; keytr[5] = false; }
    if( keytr[6] ) { text += "g"; keytr[6] = false; }
    if( keytr[7] ) { text += "h"; keytr[7] = false; }
    if( keytr[8] ) { text += "i"; keytr[8] = false; }
    if( keytr[9] ) { text += "j"; keytr[9] = false; }
    if( keytr[10] ) { text += "k"; keytr[10] = false; }
    if( keytr[11] ) { text += "l"; keytr[11] = false; }
    if( keytr[12] ) { text += "m"; keytr[12] = false; }
    if( keytr[13] ) { text += "n"; keytr[13] = false; }
    if( keytr[14] ) { text += "o"; keytr[14] = false; }
    if( keytr[15] ) { text += "p"; keytr[15] = false; }
    if( keytr[16] ) { text += "q"; keytr[16] = false; }
    if( keytr[17] ) { text += "r"; keytr[17] = false; }
    if( keytr[18] ) { text += "s"; keytr[18] = false; }
    if( keytr[19] ) { text += "t"; keytr[19] = false; }
    if( keytr[20] ) { text += "u"; keytr[20] = false; }
    if( keytr[21] ) { text += "v"; keytr[21] = false; }
    if( keytr[22] ) { text += "w"; keytr[22] = false; }
    if( keytr[23] ) { text += "x"; keytr[23] = false; }
    if( keytr[24] ) { text += "y"; keytr[24] = false; }
    if( keytr[25] ) { text += "z"; keytr[25] = false; }
    
    if( keytr[26] ) { text += "A"; keytr[26] = false; }
    if( keytr[27] ) { text += "B"; keytr[27] = false; }
    if( keytr[28] ) { text += "C"; keytr[28] = false; } 
    if( keytr[29] ) { text += "D"; keytr[29] = false; }
    if( keytr[30] ) { text += "E"; keytr[30] = false; }
    if( keytr[31] ) { text += "F"; keytr[31] = false; }
    if( keytr[32] ) { text += "G"; keytr[32] = false; }
    if( keytr[33] ) { text += "H"; keytr[33] = false; }
    if( keytr[34] ) { text += "I"; keytr[34] = false; }
    if( keytr[35] ) { text += "J"; keytr[35] = false; }
    if( keytr[36] ) { text += "K"; keytr[36] = false; }
    if( keytr[37] ) { text += "L"; keytr[37] = false; }
    if( keytr[38] ) { text += "M"; keytr[38] = false; }
    if( keytr[39] ) { text += "N"; keytr[39] = false; }
    if( keytr[40] ) { text += "O"; keytr[40] = false; }
    if( keytr[41] ) { text += "P"; keytr[41] = false; }
    if( keytr[42] ) { text += "Q"; keytr[42] = false; }
    if( keytr[43] ) { text += "R"; keytr[43] = false; }
    if( keytr[44] ) { text += "S"; keytr[44] = false; }
    if( keytr[45] ) { text += "T"; keytr[45] = false; }
    if( keytr[46] ) { text += "U"; keytr[46] = false; }
    if( keytr[47] ) { text += "V"; keytr[47] = false; }
    if( keytr[48] ) { text += "W"; keytr[48] = false; }
    if( keytr[49] ) { text += "X"; keytr[49] = false; }
    if( keytr[50] ) { text += "Y"; keytr[50] = false; }
    if( keytr[51] ) { text += "Z"; keytr[51] = false; }
    
    if( keytr[52] ) { text += " "; keytr[52] = false; }
    if( keytr[53] ) { text += "."; keytr[53] = false; }
    if( keytr[54] ) { text += "_"; keytr[54] = false; }
    }
  }
}
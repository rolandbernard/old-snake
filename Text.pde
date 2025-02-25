class text
{
  PVector pos = new PVector();
  float size;
  int controlX;
  int alignH = CENTER,alignV = CENTER;
  String fontName = "Arial Rounded MT Bold",textO = "";
  PFont font;
  color c;
  
  text(float x,float y,float i_size,String i_textO,int i_alignH,int i_alignV, color i_c)
  {
    pos.x = x;
    pos.y = y;
    size = i_size; 
    textO = i_textO;
    alignH = i_alignH;
    alignV = i_alignV;
    font = createFont(fontName, size * width);
    controlX = width;
    c = i_c;
  }
  
  void render(String output)
  {
    if(width != controlX)
    {
      font = createFont(fontName, size * width);
      controlX = width;
    }
    
    fill(c);
    textAlign(alignH,alignV);
    textFont(font);
    text(output, pos.x * width, pos.y * height);
  }
  
  void sizeEdit()
  {
    if(width != controlX)
    {
      controlX = width;
      font = createFont(fontName, size * width);
    }
  }
  
  void render()
  {
    if(width != controlX)
    {
      font = createFont(fontName, size * width);
      controlX = width;
    }
    
    fill(c);
    textAlign(alignH,alignV);
    textFont(font);
    text(textO, pos.x * width, pos.y * height - size * width * 0.115);
  }
}
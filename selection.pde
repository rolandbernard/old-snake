

class selection
{
  PVector pos = new PVector(), size = new PVector();
  text options[];
  int index = -1;
  int hoverIndex;
  boolean expandet = false;
  color c[];
  svgButton expand;
  float textSize;
  
  selection(float x, float y, float dx, float dy, String i_selection[], float i_textSize, color i_c[])
  {
    pos.x = x;
    pos.y = y;
    size.x = dx;
    size.y = dy;
    c = i_c;
    textSize = i_textSize;
    
    options = new text[i_selection.length];
    
    for(int i = 0; i < options.length; i++)
    {
      options[i] = new text(pos.x+size.x*0.05, pos.y + size.y * (i + 1) + size.y *0.5,textSize, i_selection[i],LEFT, CENTER, c[2]);
    }
    
    expand = new svgButton("resources/game/grafiks/expand.svg", pos.x + size.x, pos.y, size.y, size.y, 3, c);
  }
  
  int returnIndex()
  {
    if(expand.pressd())
    {
      expandet = !expandet;
    }
    
    if(mouseX > pos.x * width && mouseX < (pos.x + size.x) * width)
      hoverIndex = (int) ( ( mouseY - pos.y * height ) / (size.y * height) ) - 1; 
    else 
      hoverIndex = -1;
      
      
    if(hoverIndex >= 0 && hoverIndex < options.length && expandet)
    {
      cursor(HAND);
      hand = true;
      if(mousePressed)
      {
        index = hoverIndex;
        expandet = false;
      }
    }
    
    
      
    return index;
  }
  
  void render()
  {
    fill(c[0]);
    stroke(0);
    strokeWeight(size.y * 0.05 * height);
    rect(pos.x * width, pos.y * height, size.x * width, size.y * height);
    
    if(index > -1)
    {
      options[index].sizeEdit();
      fill(c[2]);
      textAlign(CENTER,CENTER);
      textFont(options[index].font);
      text(options[index].textO, (pos.x + size.x * 0.5) * width - size.y * height * 0.5, (pos.y + size.y * 0.5) * height - textSize * width * 0.115);
    }
    
    
    stroke(c[1]);
    fill(c[0]);
    if(expandet)
    {
      strokeWeight(size.y * 0.01 * height);
      for(int i = 0; i < options.length; i++)
      {
        rect((pos.x+ size.x * .03)  * width , (pos.y+size.y*(i+1)) * height ,size.x * width, size.y * height);
        if(hoverIndex == i)
        {
          fill(255,40);
          noStroke();
          rect((pos.x + size.x * .03)  * width , (pos.y+size.y*(i+1)) * height ,size.x * width, size.y * height);
          stroke(c[1]);
          fill(c[0]);
        }
      }
      for(int i = 0; i < options.length; i++)
      {
        options[i].render();
      }
    }
    
    expand.render();
    
  }
  
};


class svgButton
{
  boolean pressed, hover;
  PShape shape = new PShape();
  PVector pos = new PVector(), size = new PVector();
  int relation;
  color c[] = new color[2];
  
  svgButton(String path, float x, float y, float dx, float dy, int i_relation, color i_c[])
  {
    pos.x = x;
    pos.y = y;
    size.x = dx;
    size.y = dy;
    
    relation = i_relation;
    
    c[0] = i_c[0];
    c[1] = i_c[1];
    
    shape = loadShape(path);
  }
  
  void render()
  {
    fill(c[0]);
    stroke(c[1]);
    strokeWeight(size.y * 0.05 * height);
    if(hover)
      switch(relation)
      {
        case 1: 
          rect(pos.x * width * 0.999, pos.y * height * 0.999, size.x * width + 0.002 * width, size.y * width + 0.002 * height);
          shape(shape, pos.x * width * 0.999, pos.y * height * 0.999, size.x * width + 0.002 * width, size.y * width + 0.002 * width);
        break;
        case 2: 
          rect(pos.x * width * 0.999, pos.y * height * 0.999, size.x * height + 0.002 * width, size.y * height + 0.002 * height);
          shape(shape, pos.x * width * 0.999, pos.y * height * 0.999, size.x * height + 0.002 * width, size.y * height + 0.002 * height);
        break;
        case 3: 
          rect((pos.x * width - size.x * height) * 0.999, pos.y * height * 0.999, size.x * height + 0.002 * width, size.y * height + 0.002 * height);
          shape(shape,( pos.x * width - size.x * height) * 0.999, pos.y * height * 0.999 , size.x * height + 0.002 * width, size.y * height + 0.002 * height);
        break;
        default: 
          rect(pos.x * width * 0.999, pos.y * height * 0.999, size.x * width + 0.002 * width, size.y * height + 0.002 * height);
          shape(shape, pos.x * width * 0.999, pos.y * height * 0.999, size.x * width + 0.002 * width, size.y * height + 0.002 * height);
        break;     
      }
    else
      switch(relation)
      {
        case 1: 
          rect(pos.x * width, pos.y * height, size.x * width, size.y * width);
          shape(shape, pos.x * width, pos.y * height, size.x * width, size.y * width);
        break;
        case 2: 
          rect(pos.x * width, pos.y * height, size.x * height, size.y * height);
          shape(shape, pos.x * width, pos.y * height, size.x * height, size.y * height);
        break;
        case 3: 
          rect(pos.x * width - size.x * height, pos.y * height, size.x * height, size.y * height);
          shape(shape, pos.x * width - size.x * height, pos.y * height, size.x * height, size.y * height);
        break;
        default: 
          rect(pos.x * width, pos.y * height, size.x * width, size.y * height);
          shape(shape, pos.x * width, pos.y * height, size.x * width, size.y * height);
        break;     
      }
  }
  
  boolean pressd()
  {
    switch(relation)
      {
        case 1: 
          
    if(mouseX > pos.x * width && mouseX < (pos.x + size.y) * width && mouseY > pos.y * height && mouseY < pos.y * height + size.y * width )
    {
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         if(!pressed)
         {
           pressed = true;
           lll = millis();
           return true;
         }
         else
         {
           return false;
         }
         
       } else {
         
         pressed = false;
         return false;
       }
        
    } else {
      
      hover = false;
      pressed = false;
      return false;
      
    }
    
  
        case 2: 
        
          
    if(mouseX > pos.x * width && mouseX < pos.x * width + size.y * height && mouseY > pos.y * height && mouseY < (pos.y + size.y) * height )
    {
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         if(!pressed)
         {
           pressed = true;
           lll = millis();
           return true;
         }
         else
         {
           return false;
         }
         
       } else {
         
         pressed = false;
         return false;
       }
        
    } else {
      
      hover = false;
      pressed = false;
      return false;
      
    }
    
        case 3: 
        
    if(mouseX > pos.x * width - size.x * height && mouseX < (pos.x + size.y) * width - size.x * height && mouseY > pos.y * height && mouseY < (pos.y + size.y) * height )
    {
      
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         if(!pressed)
         {
           pressed = true;
           lll = millis();
           return true;
         }
         else
         {
           return false;
         }
         
       } else {
         
         pressed = false;
         return false;
       }
        
    } else {
      
      hover = false;
      pressed = false;
      return false;
      
    }
    
  
          
        default: 
        
    if(mouseX > pos.x * width && mouseX < (pos.x + size.y) * width && mouseY > pos.y * height && mouseY < (pos.y + size.y) * height )
    {
      hover = true;
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         if(!pressed)
         {
           pressed = true;
           lll = millis();
           return true;
         }
         else
         {
           return false;
         }
         
       } else {
         
         pressed = false;
         return false;
       }
        
    } else {
      
      hover = false;
      pressed = false;
      return false;
      
    }
    
  
             
      }
      
  }
  
};
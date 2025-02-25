
class picture
{
  PImage img;
  PVector pos = new PVector(),dim = new PVector();
  int relation;
  
  picture(String path, float x, float y, float dx, float dy, int i_relation)
  {
    img = loadImage(path);
    
    pos.x = x;
    pos.y = y;
    
    dim.x = dx;
    dim.y = dy;
    
    relation = i_relation;
  }
  
  picture(String path, PVector i_pos, PVector i_dim)
  {
    img = loadImage(path);
    
    pos = i_pos;
    
    dim = i_dim;
  }
  
  void render()
  {
     switch(relation)
      {
        case 1: 
          image(img, width * pos.x , height * pos.y, width * dim.x, width * dim.y);
        break;
        case 2: 
          image(img, width * pos.x , height * pos.y, height * dim.x, height * dim.y);
        break;
        default: 
          image(img, width * pos.x , height * pos.y, width * dim.x, height * dim.y);
        break;     
      }
    
  }
  
  
};
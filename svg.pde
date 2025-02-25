
class svg
{
  PShape shape;
  PVector pos = new PVector(),dim  = new PVector();
  int relation;
  
  svg(String path, float x, float y, float dx, float dy, int i_relation)
  {
      
      shape = loadShape(path);
    
      pos.x = x;
      pos.y = y;
    
      dim.x = dx;
      dim.y = dy;
      
      relation = i_relation;
    
  }
  
  svg(String path, PVector i_pos, PVector i_dim)
  {
    shape = loadShape(path);
    
    pos = i_pos;
    
    dim = i_dim;
  }
  
  void render()
  {
    switch(relation)
      {
        case 1: 
          shape(shape, pos.x * width, pos.y * height, dim.x * width, dim.y * width);
        break;
        case 2: 
          shape(shape, pos.x * width, pos.y * height, dim.x * height, dim.y * height);
        break;
        default: 
          shape(shape, pos.x * width, pos.y * height, dim.x * width, dim.y * height);
        break;     
      }
    
  }
  
  
};
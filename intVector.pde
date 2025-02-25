

class intVector
{
  int x , y , z ;
  
  intVector(int i_x, int i_y, int i_z)
  {
    x = i_x;
    y = i_y;
    z = i_z;
  }
  
  intVector(int i_x, int i_y)
  {
    x = i_x;
    y = i_y;
  }
  
  intVector()
  {
    x = 0;
    y = 0;
    z = 0;
  }
  
  intVector(PVector i_pos)
  {
    x = (int) i_pos.x;
    y = (int) i_pos.y;
  }
  
  void add(intVector i_vect)
  {
    x += i_vect.x;
    y += i_vect.y;
    //z += i_vect.z;
  }
  
  void mult(intVector i_vect)
  {
    x *= i_vect.x;
    y *= i_vect.y;
    z *= i_vect.z;
  }
  
  void mult(float i_scale)
  {
    x *= i_scale;
    y *= i_scale;
    z *= i_scale;
  }
  
  void sub(intVector i_vect)
  {
    x -= i_vect.x;
    y -= i_vect.y;
    z -= i_vect.z;
  }
}
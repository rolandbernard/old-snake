




class miniLayout
{
  button m_button[];
  checkBox m_checkbox[];
  slider m_slider[];
  picture m_picture[];
  svg m_svg[];
  text m_text[];
  svgButton m_svgButton[];
  selection m_selection[];
  
  float rectData[][];
  color rectFill[];
  color rectStroke[];
  
  int sliderValue[];
  int selectionIndex[];
  boolean checkBoxStat[];
  
  int sizeList[] = new int[7];
  
  color c[] = new color[2];
  PVector pos = new PVector(),size = new PVector();
  
  miniLayout(String path, float x, float y, float dx, float dy, color i_c[])
  {
    c[0] = i_c[0];
    c[1] = i_c[1];
    
    pos.x = x;
    pos.y = y;
    size.x = dx;
    size.y = dy;
    
    ArrayList<String> obj = new ArrayList<String>();
    String buffer;
    try
    {
       BufferedReader reader = createReader(path); 
       if(reader != null)
       {
         do
         {
              buffer = reader.readLine();
              if(buffer != null && buffer != "" && buffer.charAt(0) != '/' && !buffer.equalsIgnoreCase("END"))
              {
                obj.add(buffer);
              }
          
        }
        while(!buffer.equalsIgnoreCase("END"));
    
        reader.close();
      
       }
       else 
       {
         buffer = null;
         print("Layout file error: " + path);
       }
       
    }
    catch(IOException e) 
    {
      e.printStackTrace();
    }
    loading++;
    
    buffer = obj.get(0);
    sizeList = int( split(buffer,"|"));
    
    m_button= new button[sizeList[0]];
    m_checkbox = new checkBox[sizeList[1]];
    m_slider = new slider[sizeList[2]];
    m_picture = new picture[sizeList[3]];
    m_svg = new svg[sizeList[4]];
    m_text = new text[sizeList[5]];
    
    rectData = new float[sizeList[6]][4];
    rectFill = new color[sizeList[6]];
    rectStroke = new color[sizeList[6]];
    
    m_svgButton = new svgButton[sizeList[7]];
    m_selection = new selection[sizeList[8]];
  
    sliderValue = new int[sizeList[2]];
    selectionIndex = new int[sizeList[8]];
    checkBoxStat = new boolean[sizeList[1]];
    
    
    int index = 1;
    for(int i = 0; i < sizeList[0]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      int m_color[][] = { {int(aList[6]), int(aList[7]), int(aList[8]) }, {int(aList[9]), int(aList[10]), int(aList[11])}, {int(aList[12]), int(aList[13]), int(aList[14])} };
      m_button[i] = new button( int(aList[0])/10000f * dx + x, int(aList[1])/10000f * dy + y, int(aList[2])/10000f * dx, int(aList[3])/10000f * dy, int(aList[4])/10000f * dx, aList[5] , m_color);
      loading++;
    }
    index += sizeList[0];
    
    for(int i = 0; i < sizeList[1]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      int m_color[][] = { {int(aList[5]), int(aList[6]), int(aList[7]) }, {int(aList[8]), int(aList[9]), int(aList[10])} };
      m_checkbox[i] = new checkBox( int(aList[0])/10000f * dx + x, int(aList[1])/10000f * dy + y, int(aList[2])/10000f * dx, int(aList[3])/10000f * dy, boolean( int(aList[4]) ), m_color);
      loading++;
    }
    index += sizeList[1];
    
    for(int i = 0; i < sizeList[2]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      int m_color[][] = { {int(aList[7]), int(aList[8]), int(aList[9]) }, {int(aList[10]), int(aList[11]), int(aList[12])}, {int(aList[13]), int(aList[14]), int(aList[15])} };
      m_slider[i] = new slider( int(aList[0])/10000f * dx, int(aList[1])/10000f * 0.35, int(aList[2])/10000f * dx + x, int(aList[3])/10000f * dy + y, int(aList[4])/10000f, int(aList[5]), int(aList[6]) , m_color);
      loading++;
    }
    index += sizeList[2];
    
    for(int i = 0; i < sizeList[3]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      
      m_picture[i] = new picture(aList[0], int(aList[1])/10000f * dx + x, int(aList[2])/10000f * dy + y, int(aList[3])/10000f * dx, int(aList[4])/10000f * dy, int(aList[5]));
      loading++;
    }
    index += sizeList[3];
    
    for(int i = 0; i < sizeList[4]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      
      m_svg[i] = new svg(aList[0], int(aList[1])/10000f * dx + x, int(aList[2])/10000f * dy + y, int(aList[3])/10000f * dx, int(aList[4])/10000f * dy, int(aList[5]));
      loading++;
    }
    index += sizeList[4];
    
    for(int i = 0; i < sizeList[5]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      color m_color = color( int(aList[6]), int(aList[7]), int(aList[8]));
      m_text[i] = new text(int(aList[0])/10000f * dx + x, int(aList[1])/10000f * dy + y, int(aList[2])/10000f * dx, aList[3], int(aList[4]), int(aList[5]), m_color);
      loading++;
    }
    index += sizeList[5];
    
    for(int i = 0; i < sizeList[6]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,'|');
      
      
      rectData[i][0] = int(aList[0])/10000f * dx + x;
      rectData[i][1] = int(aList[1])/10000f * dy + y;
      rectData[i][2] = int(aList[2])/10000f * dx;
      rectData[i][3] = int(aList[3])/10000f * dy;
      rectFill[i] = color(int(aList[4]), int(aList[5]), int(aList[6]));
      rectStroke[i] = color(int(aList[7]), int(aList[8]), int(aList[9]));
      loading++;
    }
    index += sizeList[6];
    
    for(int i = 0; i < sizeList[7]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      color m_color[] = {color( int(aList[6]), int(aList[7]), int(aList[8]), int(aList[9])), color( int(aList[10]), int(aList[11]), int(aList[12]), int(aList[13]))};
      m_svgButton[i] = new svgButton( aList[0], int(aList[1])/10000f * dx + x, int(aList[2])/10000f * dy + y, int(aList[3])/10000f * dx, int(aList[4])/10000f * dy, int(aList[5]), m_color);
          loading++;       
    }
    index += sizeList[7];
    
    for(int i = 0; i < sizeList[8]; i++)
    {
      buffer = obj.get(index+i);
      String aList[] = split(buffer,"|");
      
      String oList[] = split(aList[4],";");
      
      color m_color[] = {color( int(aList[6]), int(aList[7]), int(aList[8])), color( int(aList[9]), int(aList[10]), int(aList[11])), color( int(aList[12]), int(aList[13]), int(aList[14]))};
      m_selection[i] = new selection(int(aList[0])/10000f * dx + x, int(aList[1])/10000f * dy + y, int(aList[2])/10000f * dx, int(aList[3])/10000f * dy, oList, int(aList[5])/10000f * .35, m_color);
                loading++; 
    }
    index += sizeList[8];
    
  }
  
  int returnButton()
  {
    for(int i = 0; i < sizeList[0]; i++)
    {
      if(m_button[i].presd())
        return i+1;
    }
    return 0;
  }
  
  int returnSvgButton()
  {
    for(int i = 0; i < sizeList[7]; i++)
    {
      if(m_svgButton[i].pressd())
        return i+1;
    }
    return 0;
  }
  
  void checkStats()
  {
    for(int i = 0; i < sizeList[2]; i++)
    {
      sliderValue[i] = m_slider[i].returnValue();
    }
    
    for(int i = 0; i < sizeList[8]; i++)
    {
      selectionIndex[i] = m_selection[i].returnIndex();
    }
    
    for(int i = 0; i < sizeList[1]; i++)
    {
      checkBoxStat[i] = m_checkbox[i].checked();
    }
  }
  
  void render()
  {
    strokeWeight(size.y * 0.01 * height);
    stroke(c[1]);
    fill(c[0]);
    rect(pos.x * width, pos.y * height, size.x * width, size.y * height);
    for(int i = 0; i < sizeList[6]; i++)
    {
      strokeWeight(rectData[i][3] * 0.01 * height);
      fill(rectFill[i]);
      stroke(rectStroke[i]);
      rect(rectData[i][0] * width, rectData[i][1] * height, rectData[i][2] * width, rectData[i][3] * height);
    }
    
    for(int i = 0; i < sizeList[3]; i++)
    {
        m_picture[i].render();
    }
    
    for(int i = 0; i < sizeList[4]; i++)
    {
        m_svg[i].render();
    }
    
    for(int i = 0; i < sizeList[0]; i++)
    {
      m_button[i].render();
    }
    
    for(int i = 0; i < sizeList[7]; i++)
    {
      m_svgButton[i].render();
    }
    
    for(int i = 0; i < sizeList[2]; i++)
    {
      m_slider[i].render();
    }
    
    for(int i = 0; i < sizeList[8]; i++)
    {
      m_selection[i].render();
    }
    
    for(int i = 0; i < sizeList[1]; i++)
    {
      m_checkbox[i].render();
    }
    
    for(int i = 0; i < sizeList[5]; i++)
    {
      m_text[i].render();
    }
  }
}
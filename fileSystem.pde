


class file
{
  PrintWriter writer;
  BufferedReader reader;
  String path;
  String inBuffer;
  String outBuffer;
  
  file(String i_path)
  {
    path = i_path;
  }
  
  String readLn()
  {
    try
    {
      reader = createReader(path); 
      if(reader != null)
      {
        inBuffer = reader.readLine();
        reader.close();
      }
    }
    catch(IOException e) 
    {
      e.printStackTrace();
      inBuffer = "";
      writer = createWriter(path); 
      writer.close();
    }
    
    
    return inBuffer;
  }
  
  String[] read()
  {
    ArrayList<String> obj = new ArrayList<String>();
    
    try
    {
      reader = createReader(path); 
    
      do
      {
          if(reader != null)
          {
            inBuffer = reader.readLine();
            if(inBuffer != null && inBuffer != "")
              obj.add(inBuffer);
          }
          else 
            inBuffer = null;
      }
      while(inBuffer != null && inBuffer != "");
      
      if(reader != null)
        reader.close();
    }
    catch(IOException e) 
    {
      e.printStackTrace();
    }
    
    String out[] = obj.toArray(new String[obj.size()]);
    return out;
  }
  
  private void readIntern()
  {
    try
    {
      reader = createReader(path); 
      if(reader != null)
        inBuffer = reader.readLine();
    }
    catch(IOException e) 
    {
      e.printStackTrace();
      inBuffer = "";
      writer = createWriter(path); 
      writer.close();
    }
  }
  
  void buffer(String stringToBuffer)
  {
    outBuffer += stringToBuffer;
  }
  
  void clearBuffer()
  {
    outBuffer = "";
    inBuffer = "";
  }
  
  void writeNew()
  {
    writer = createWriter(path); 
    writer.println(outBuffer);
    writer.flush();
    writer.close();
  }
  
  void writeAdd()
  {
    readIntern();
    writer = createWriter(path); 
    writer.println(inBuffer + outBuffer);
    writer.flush();
    writer.close();
  }
  
};
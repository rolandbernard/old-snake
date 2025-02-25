String version = "0.1.5";

int pageAt = -1;
int appleAmount = 3;
boolean powerUp = false;
boolean wales = true;
int player = 2;
int aiPlayer = 1;
int colors[][] = new int[4][3];
int backR = 210;
int backG = 210;
int backB = 210;
int startLengh = 7;
int tilesize = 10;
PFont font;
boolean hand = false;
int wait = 0;
boolean fullscreen = false;


int colore[][] = {{255,0,0},{20,255,0},{255,0,255},{0,0,150}};

game background = new game(0,0,400,400);
game gameS = new game(0, 0, width, height);
game gameA = new game(0, 0, width, height);
game gameM = new game(0, 0, width, height);


button singlePlay = new button(1,1,1,1,1,"Singleplayer");
button aiPlay = new button(1,1,1,1,1,"Ai");
button multiPlay = new button(1,1,1,1,1,"Multiplayer");
button options = new button(1,1,1,1,1,"Options");

button back = new button(1,1,1,1,1,"Back");
slider backgroundColR = new slider(1,1,1,1,210, 0,255);
slider backgroundColG = new slider(1,1,1,1,210, 0,255);
slider backgroundColB = new slider(1,1,1,1,210, 0,255);
slider startSize = new slider(1,1,1,1,5, 2,300);
slider apples = new slider(1,1,1,1,3, 1,100);
slider tileSize = new slider(1,1,1,1,10, 2,100);
checkBox wall = new checkBox(1,1,1,1, true);
checkBox powerUps = new checkBox(1,1,1,1, false);
checkBox fullSc = new checkBox(1,1,1,1, false);

slider playerColor[][] = {{new slider(1,1,1,1,colore[0][0], 0,255),new slider(1,1,1,1,colore[0][1], 0,255),new slider(1,1,1,1,colore[0][2], 0,255)},{new slider(1,1,1,1,colore[1][0], 0,255),new slider(1,1,1,1,colore[1][1], 0,255),new slider(1,1,1,1,colore[1][2], 0,255)},{new slider(1,1,1,1,colore[2][0], 0,255),new slider(1,1,1,1,colore[2][1], 0,255),new slider(1,1,1,1,colore[2][2], 0,255)},{new slider(1,1,1,1,colore[3][0], 0,255),new slider(1,1,1,1,colore[3][1], 0,255),new slider(1,1,1,1,colore[3][2], 0,255)}};
button start = new button(1,1,1,1,1,"Play");
slider playerS = new  slider(1,1,1,1,2, 0,300);

button again = new button(1,1,1,1,1,"Again");
button home = new button(1,1,1,1,1,"Home");

button exit = new button(1,1,1,1,1,"Exit");

PrintWriter writeOption;
BufferedReader readOption;
String line;

void settings()
{
  size(800,600,P2D);
  PJOGL.setIcon("icon.png");
}

void setup()
{
  //fullScreen();
  frameRate(1000);
  surface.setResizable(true);
  
  
  try 
  {
    readOption = createReader(sketchPath("")+"config.rcn"); 
    if(readOption != null)
      line = readOption.readLine();
  }
  catch (IOException e) 
  {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    writeOption = createWriter("config.rcn"); 
    writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
    writeOption.flush();
    writeOption.close();
  } 
  else 
  {
    String[] pieces = split(line, "/");
    
    appleAmount = int(pieces[0]);
    powerUp = boolean( int(pieces[1]) );
    wales = boolean( int(pieces[2]) );
    colore[0][0] = int(pieces[3]);
    colore[0][1] = int(pieces[4]);
    colore[0][2] = int(pieces[5]);
    colore[1][0] = int(pieces[6]);
    colore[1][1] = int(pieces[7]);
    colore[1][2] = int(pieces[8]);
    colore[2][0] = int(pieces[9]);
    colore[2][1] = int(pieces[10]);
    colore[2][2] = int(pieces[11]);
    colore[3][0] = int(pieces[12]);
    colore[3][1] = int(pieces[13]);
    colore[3][2] = int(pieces[14]);
    backR = int(pieces[15]);
    backG = int(pieces[16]);
    backB = int(pieces[17]);
    startLengh = int(pieces[18]);
    tilesize = int(pieces[19]);
    fullscreen = boolean( int(pieces[20]) );
  }
  
  //PImage icon = loadImage("icon.png");
  //surface.setIcon(icon);
  
  background.startGame(10,false,false,0,4,colore,5,5);
  background.setColor(210,210,210,0,0,0);
  
  singlePlay.setColors(47, 112, 216,1, 19, 48,219, 244, 198);
  multiPlay.setColors(47, 112, 216,1, 19, 48,219, 244, 198);
  aiPlay.setColors(47, 112, 216,1, 19, 48,219, 244, 198);
  options.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  
  back.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  backgroundColR.setColors(10,10,10,97, 117, 150, 10,10,10);
  backgroundColR.value = backR;
  backgroundColG.setColors(10,10,10,97, 117, 150, 10,10,10);
  backgroundColG.value = backG;
  backgroundColB.setColors(10,10,10,97, 117, 150, 10,10,10);
  backgroundColB.value = backB;
  for(int p = 0; p < 4; p++)
  {
    for(int s = 0; s < 3; s++)
    {
      playerColor[p][s].setColors(10,10,10,97, 117, 150, 10,10,10);
      playerColor[p][s].value = colore[p][s];
    }
  }
  playerS.setColors(10, 4, 122,97, 117, 150, 10, 10, 10);
  start.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  startSize.setColors(10, 4, 122,97, 117, 150, 10,10,10);
  startSize.value = startLengh;
  apples.setColors(10, 4, 122,97, 117, 150, 10, 10, 10);
  apples.value = appleAmount;
  tileSize.setColors(10, 4, 122,97, 117, 150, 10, 10, 10);
  tileSize.value = tilesize;
  wall.setColors(148, 155, 143,12, 0, 30, 3, 255, 0);
  wall.checked = wales;
  powerUps.setColors(148, 155,143, 12,0, 30,  3, 255, 0);
  powerUps.checked = powerUp;
  fullSc.setColors(148, 155,143, 12,0, 30,  3, 255, 0);
  fullSc.checked = fullscreen;
  tileSize.moveMulti = 2;
  again.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  home.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  exit.setColors(148, 155, 143,1, 19, 48,13, 6, 35);
  exit.changeS = false;
  
  if(fullscreen)
  {
      
  }
}

void draw()
{
  if (width < 400) {
    surface.setSize(400, height);
  }
  if (height < 300) {
    surface.setSize(width, 300);
  }
  if(!hand)
  {
    cursor(ARROW);
  }
  hand = false;
  noStroke();
  fill(255);
  rect(0,0,width,height);

  
  if (pageAt == -1 || pageAt == 0)
  {
    background.sizeX = width;
    background.sizeY = height;
    background.tilesize = (height) / 80;
    background.aiMove();
    background.travel();
    background.colision();
    background.render();
  
    if(background.winning())
    {
      background.startGame(10,false,false,0,4,colore,5,5);
    }
    
    stroke(1, 19, 48);
    fill(127,127,127,200);
    rect(0,0,width,height);
    fill(255,0,0);
    textAlign(CENTER,CENTER);
    font = createFont("ARLRDBD.TTF", 0.18*width);
    textFont(font);
    text("Snake",(width/2)-(0.005*width),(0.14*height)-(0.005*width));
    fill(70,80,255);
    text("Snake",(width/2),(0.14*height));
    fill(0,250,55);
    text("Snake",(width/2)+(0.005*width),(0.14*height)+(0.005*width));
    
    singlePlay.posX = width/4 + width/20;
    singlePlay.posY = 9*height/25;
    singlePlay.sizeX = width/2 - width/10;
    singlePlay.sizeY = height/10;
    singlePlay.textSize = width/24;
    singlePlay.render();
    if(singlePlay.presd() && pageAt == 0)
    {
      pageAt = 5;
    }
    
    aiPlay.posX = width/4 + width/20;
    aiPlay.posY = 9*height/25 + height/6;
    aiPlay.sizeX = width/2  - width/10;
    aiPlay.sizeY = height/10;
    aiPlay.textSize = width/24;
    aiPlay.render();
    if(aiPlay.presd() && pageAt == 0)
    {
      pageAt = 6;
    }
    
    multiPlay.posX = width/4 + width/20;
    multiPlay.posY = 9*height/25 + 2*height/6;
    multiPlay.sizeX = width/2 - width/10;
    multiPlay.sizeY = height/10;
    multiPlay.textSize = width/24;
    multiPlay.render();
    if(multiPlay.presd() && pageAt == 0)
    {
      pageAt = 7;
    }
    
    options.posX = 20*width/25 ;
    options.posY = 23*height/25 - height/80;
    options.sizeX = width/6;
    options.sizeY = height/16;
    options.textSize = width/30;
    options.render();
    if(options.presd() && pageAt == 0)
    {
      pageAt = 1;
    }
    
    exit.srokeSize = height/200;
    exit.posX = 22*width/25 + width/210;
    exit.posY =  23*height/25 - height/18;
    exit.sizeX = width/12;
    exit.sizeY = height/32;
    exit.textSize = width/50;
    exit.render();
    if(exit.presd() && pageAt == 0)
    {
      exit();
    }
    
    PImage img = loadImage("logo.png");
    image(img, 0+height/50,5*height/6-height/22, height/6 ,height/6);
    fill(0);
    textAlign(CENTER,BOTTOM);
    font = createFont("ARLRDBD.TTF", 0.018*width);
    textFont(font);
    text("Roland Bernard", height/12 + height/48, height-height/80);
    
    if(mouseX < height/6 && mouseX > height/50 && mouseY > height-height/6)
    {
      hand = true;
      cursor(HAND);
      if(mousePressed && pageAt == 0)
      {
        link("https://mega.nz/#!kUcDhIzK!OGLmreZ8kzzUJMucT_e3QejIJhfy05iEhJB67x66H08"); 
      }
    }
    
    if(pageAt == -1)
    {
      wait++;
      if(wait > 10)
      {
        wait = 0;
        pageAt = 0;
      }
      
    }
  }
  else if (pageAt == 1 || pageAt == 2 || pageAt == 3 || pageAt == 4)
  {
    background.sizeX = width;
    background.sizeY = height;
    background.tilesize = (height) / 80;
    background.aiMove();
    background.travel();
    background.colision();
    background.render();
  
    if(background.winning())
    {
      background.startGame(10,false,false,0,4,colore,5,5);
    }
    
    stroke(1, 19, 48);
    fill(127,127,127,200);
    rect(0,0,width,height);
    
    back.posX = height/30;
    back.posY = height/30;
    back.sizeX = width/7; 
    back.sizeY = height/16; 
    back.textSize = width/30;
    back.render();
    if(back.presd())
    {
      if(fullscreen)
      {
        
      }
      else
      {
        
      }
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
      switch(pageAt)
      {
        case 1: 
          pageAt = -1;
        break;
        case 2: 
          pageAt = 5;
        break;
        case 3: 
          pageAt = 6;
        break;
        case 4: 
          pageAt = 7;
        break;
      }
    }
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Background:", width/12 , height/5);
    stroke(0);
    fill(backR, backG, backB);
    strokeWeight(height/400);
    rect(width/3 , height/5 - height/10 + height/100 , width/15, height/5);
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("R:", width/3 + width/15 + width/70 , height/5 - height/15+ height/200);
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("G:", width/3 + width/15 + width/70, height/5+ height/200);
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("B:", width/3 + width/15 + width/70, height/5 + height/15 + height/200);
    
    backgroundColR.posX = width/3 + width/17 + width/10;
    backgroundColG.posX = width/3 + width/17 + width/10;
    backgroundColB.posX = width/3 + width/17 + width/10;
    backgroundColR.posY = height/5 - height/15 + height/85;
    backgroundColG.posY = height/5 + height/85;
    backgroundColB.posY = height/5 + height/15 + height/85;
    backgroundColR.size = width/3 + width/8;
    backgroundColG.size = width/3 + width/8;
    backgroundColB.size = width/3 + width/8;
    backgroundColR.cirkSize = height/30;
    backgroundColG.cirkSize = height/30;
    backgroundColB.cirkSize = height/30;
    backgroundColR.value = backR;
    backgroundColG.value = backG;
    backgroundColB.value = backB;
    backgroundColR.render();
    backgroundColG.render();
    backgroundColB.render();
    backR = backgroundColR.returnValue();
    backG = backgroundColG.returnValue();
    backB = backgroundColB.returnValue();
    
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Apples:", width/12 , height/5 + height/5);
    textAlign(RIGHT,CENTER);
    text(appleAmount, width/8 + width/4 , height/5 + height/5);
    
    apples.posX = width/12 + width/3;
    apples.posY = height/5 + height/5 + height/200;
    apples.size = width/12 + width/3 + width/9 + width/100;
    apples.value = appleAmount;
    apples.cirkSize = height/30;
    apples.render();
    appleAmount  = apples.returnValue();
    
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Initial length:", width/12 , 2 * height/5 + height/7);
    textAlign(RIGHT,CENTER);
    text(startLengh, width/8 + width/4 , 2 * height/5 + height/7);
    startSize.posX = width/12 + width/3;
    startSize.posY = height/5 + height/5 + height/200 + height/7;
    startSize.size = width/12 + width/3 + width/9 + width/100;
    startSize.cirkSize = height/30;
    startSize.render();
    startLengh  = startSize.returnValue();
    startSize.value = startLengh;
    
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Tilesize:", width/12 , 2 * height/5 + 2*height/7);
    textAlign(RIGHT,CENTER);
    text(tilesize, width/8 + width/4 , 2 * height/5 + 2*height/7);
    tileSize.posX = width/12 + width/3;
    tileSize.posY = height/5 + height/5 + height/200 + 2*height/7;
    tileSize.size = width/12 + width/3 + width/9 + width/100;
    tileSize.cirkSize = height/30;
    tileSize.render();
    tilesize  = tileSize.returnValue();
    
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Walls:", width/6 , 2 * height/5 + 3*height/7);
    
    wall.posX = width/6 + width/8;
    wall.posY =  2 * height/5 + 3*height/7 - height/50;
    wall.sizeX = height/20;
    wall.sizeY = height/20;
    wall.render();
    wales = wall.checke();
    
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Powerups:", 3*width/5 , 2 * height/5 + 3*height/7);
    
    powerUps.posX = 3*width/5 + width/5;
    powerUps.posY =  2 * height/5 + 3*height/7 - height/50;
    powerUps.sizeX = height/20;
    powerUps.sizeY = height/20;
    powerUps.render();
    powerUp = powerUps.checke();
    
    /*fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Fullscreen:", width/6 , 2 * height/5 + 4*height/7 - height/22);
    fullSc.posX = width/6 + width/8 + width/15;
    fullSc.posY =  2 * height/5 + 4*height/7  - height/22 - height/50;
    fullSc.sizeX = height/20;
    fullSc.sizeY = height/20;
    fullSc.render();
    fullscreen = fullSc.checke();*/
    
  }
  else if(pageAt == 5)
  {
    background.sizeX = width;
    background.sizeY = height;
    background.tilesize = (height) / 80;
    background.aiMove();
    background.travel();
    background.colision();
    background.render();
  
    if(background.winning())
    {
      background.startGame(10,false,false,0,4,colore,5,5);
    }
    
    stroke(1, 19, 48);
    fill(127,127,127,200);
    rect(0,0,width,height);
    
    stroke(10);
    fill(90);   strokeWeight(height/100);
    rect( width/15, height/8, width-2*width/15,height-height/5);
    
    start.posX = width-height/30 - width/7 ;
    start.posY = height-height/30 - height/16;
    start.sizeX = width/7; 
    start.sizeY = height/16; 
    start.textSize = width/30;
    start.render();
    if(start.presd() || keyz[16])
    {
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
      gameS.sizeX = width;
      gameS.sizeY = height;
      gameS.setColor(backR,backG,backB,0,0,0);
      gameS.startGame(appleAmount, powerUp, wales, 1, 0, colore, startLengh, tilesize);
      pageAt = 8;
    }
    
    back.posX = height/30;
    back.posY = height-height/30 - height/16;
    back.sizeX = width/7; 
    back.sizeY = height/16; 
    back.textSize = width/30;
    back.render();
    if(back.presd())
    {
      pageAt = -1;
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
    }
    
    stroke(10);
    fill(colore[0][0], colore[0][1], colore[0][2]);
    strokeWeight(height/100);
    rect( width/15, height/8, width-2*width/15,height/5);
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Color:", width/7 , height/3 + height/9);
    fill(0);
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/40);
    textFont(font);
    text("R:", width/7 + width/6 , height/3 + height/9 - height/15 + height/200);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/40);
    textFont(font);
    text("G:", width/7 + width/6, height/3 + height/9 + height/200);
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/40);
    textFont(font);
    text("B:", width/7 + width/6, height/3 + height/9 + height/15 + height/200);
    
    
    playerColor[0][0].posX = width/3 + width/17;
    playerColor[0][1].posX = width/3 + width/17;
    playerColor[0][2].posX = width/3 + width/17;
    playerColor[0][0].posY = height/3 + height/9 - height/15 + height/100;
    playerColor[0][1].posY = height/3 + height/9 + height/100;
    playerColor[0][2].posY = height/3 + height/9 + height/15 + height/100;
    playerColor[0][0].size = width/3 + width/8;
    playerColor[0][1].size = width/3 + width/8;
    playerColor[0][2].size = width/3 + width/8;
    playerColor[0][0].cirkSize = height/30;
    playerColor[0][1].cirkSize = height/30;
    playerColor[0][2].cirkSize = height/30;
    playerColor[0][0].value = colore[0][0];
    playerColor[0][1].value = colore[0][1];
    playerColor[0][2].value = colore[0][2];
    playerColor[0][0].render();
    playerColor[0][1].render();
    playerColor[0][2].render();
    colore[0][0] = playerColor[0][0].returnValue();
    colore[0][1] = playerColor[0][1].returnValue();
    colore[0][2] = playerColor[0][2].returnValue();
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Controls:", width/7 , 3*height/4 + height/16);
    fill(0);
    
    stroke(10);
    strokeWeight(height/300);
    textAlign(CENTER,CENTER);
    font = createFont("ARLRDBD.TTF", height/40);
    textFont(font);
    
    fill(199, 201, 175);
    rect( width/2 ,3*height/4 - height/20, height/15,height/15);
    fill(0);
    text("Up", width/2 + height/30,3*height/4 - height/20 + height/30);
    
    
    fill(199, 201, 175);
    rect( width/2 ,3*height/4 - height/20 + height/15 + height/45, height/15,height/15);
    fill(0);
    font = createFont("ARLRDBD.TTF", height/45);
    textFont(font);
    text("Down", width/2 + height/30,3*height/4 - height/20 + height/15 + height/45 + height/30);
    
    fill(199, 201, 175);
    rect( width/2 - height/15 - height/45,3*height/4 - height/20 + height/15 + height/45, height/15,height/15);
    fill(0);
    font = createFont("ARLRDBD.TTF", height/45);
    textFont(font);
    text("Left", width/2 - height/15 - height/45 + height/30,3*height/4 - height/20 + height/15 + height/45 + height/30);
    
    fill(199, 201, 175);
    rect( width/2 + height/15 + height/45,3*height/4 - height/20 + height/15 + height/45, height/15,height/15);
    fill(0);
    font = createFont("ARLRDBD.TTF", height/45);
    textFont(font);
    text("Right", width/2 + height/15 + height/45 + height/30,3*height/4 - height/20 + height/15 + height/45 + height/30);
    
  }
  else if(pageAt == 8)
  {
    //surface.setSize(gameS.sizeX, gameS.sizeY);
    gameS.input();
    gameS.travel();
    gameS.colision();
    gameS.render();
    if(!gameS.playerLeft[0])
    {
      stroke(10);
      strokeWeight(height/200);
      fill(240);
      rect( width/2-width/4,height/2-height/6,width/2, height/3);
      fill(211, 48, 48);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", width/15);
      textFont(font);
      text("Game Over", width/2 , height/2 - height/10);
      font = createFont("ARLRDBD.TTF", width/30);
      textFont(font);
      fill(0);
      text("Score: " + gameS.eaten, width/2 , height/2);
      
      again.posX = width/2 + width/4 - height/30 - width/7 ;
      again.posY = height/2 + height/6 -height/30 - height/16;
      again.sizeX = width/7; 
      again.sizeY = height/16; 
      again.textSize = width/30;
      again.render();
      if(again.presd() || keyz[16])
      {
        gameS.sizeX = width;
        gameS.sizeY = height;
        gameS.setColor(backR,backG,backB,0,0,0);
        gameS.startGame(appleAmount, powerUp, wales, 1, 0, colore, startLengh, tilesize);
        pageAt = 8;
      }
      
      home.posX = width/2 - width/4 - width/7 + height/30 + width/7 ;
      home.posY = height/2 + height/6 - height/30 - height/16;
      home.sizeX = width/7; 
      home.sizeY = height/16; 
      home.textSize = width/30;
      home.render();
      if(home.presd())
      {
        pageAt = -1;
      }
      
      
    }
    else
    {
      noCursor();
      hand = true;
    }
  }
  else if(pageAt == 6)
  {
    background.sizeX = width;
    background.sizeY = height;
    background.tilesize = (height) / 80;
    background.aiMove();
    background.travel();
    background.colision();
    background.render();
  
    if(background.winning())
    {
      background.startGame(10,false,false,0,4,colore,5,5);
    }
    
    stroke(1, 19, 48);
    fill(127,127,127,200);
    rect(0,0,width,height);
    
    //*****************
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Ai player:", width/9 , height/8 - height/120);
    textAlign(RIGHT,CENTER);
    text(aiPlayer, width/4 + width/12, height/8 - height/150);
    
    playerS.posX = width/4 + width/8;
    playerS.posY = height/8;
    playerS.size = width/2;
    playerS.cirkSize = height/20;
    playerS.render();
    int playerRes = playerS.returnValue();
    if(playerRes < 100)
    {
      aiPlayer = 1;
    }
    else if(playerRes < 200)
    {
      aiPlayer = 2;
    }
    else
    {
      aiPlayer = 3;
    }
    
    if(aiPlayer == 1)
    {
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, width/2-3*width/30,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, width/2-3*width/30,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("R:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("G:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("B:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[0][0].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][1].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][2].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[0][1].posY = height/3 + height/9 + height/200;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[0][0].size = width/6 + width/16;
      playerColor[0][1].size = width/6 + width/16;
      playerColor[0][2].size = width/6 + width/16;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Controls:",  width/7 - width/15 , 3*height/4 + height/16);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      
      //******
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 +  width/2-3*width/30 + width/15, 2*height/8, width/2-3*width/30 ,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15+  width/2-3*width/30 + width/15, 2*height/8, width/2-3*width/30,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Color:", width/7 - width/15+  width/2-3*width/30 + width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("R:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("G:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("B:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[1][0].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][1].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][2].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[1][1].posY = height/3 + height/9 + height/200;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[1][0].size = width/6 + width/16;
      playerColor[1][1].size = width/6 + width/16;
      playerColor[1][2].size = width/6 + width/16;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      /*fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Controls:",  width/7 - width/15 +  width/2-3*width/30 + width/15, 3*height/4 + height/16);
      fill(0);
    
       stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);*/
    }
    else if(aiPlayer == 2)
    {
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[0][0].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][1].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][2].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[0][1].posY = height/3 + height/9 + height/200;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[0][0].size = 2*width/18 + width/32;
      playerColor[0][1].size = 2*width/18 + width/32;
      playerColor[0][2].size = 2*width/18 + width/32;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 , height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/9,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //*********2
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ 2*width/6-3*width/90, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[1][0].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][1].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][2].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[1][1].posY = height/3 + height/9 + height/200;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[1][0].size = 2*width/18 + width/32;
      playerColor[1][1].size = 2*width/18 + width/32;
      playerColor[1][2].size = 2*width/18 + width/32;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      /*
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 + 2*width/6-3*width/90, height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      */
      
      
      //*****3
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + 2*width/6-3*width/90+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[2][0], colore[2][1], colore[2][2]);
      strokeWeight(height/100);
      rect( width/15+ 2*width/6-3*width/90+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[2][0].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][1].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][2].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[2][1].posY = height/3 + height/9 + height/200;
      playerColor[2][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[2][0].size = 2*width/18 + width/32;
      playerColor[2][1].size = 2*width/18 + width/32;
      playerColor[2][2].size = 2*width/18 + width/32;
      playerColor[2][0].cirkSize = height/30;
      playerColor[2][1].cirkSize = height/30;
      playerColor[2][2].cirkSize = height/30;
      playerColor[2][0].render();
      playerColor[2][1].render();
      playerColor[2][2].render();
      colore[2][0] = playerColor[2][0].returnValue();
      colore[2][1] = playerColor[2][1].returnValue();
      colore[2][2] = playerColor[2][2].returnValue();
    
      /*
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 + 2*width/6-3*width/90+ 2*width/6-3*width/90, height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      */
    
    
    }
    else if(aiPlayer == 3)
    {
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[0][0].posX = width/7 - width/15 + width/24;
      playerColor[0][1].posX = width/7 - width/15 + width/24;
      playerColor[0][2].posX = width/7 - width/15 + width/24;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[0][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[0][0].size = width/12 + width/32;
      playerColor[0][1].size = width/12 + width/32;
      playerColor[0][2].size = width/12 + width/32;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 , height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/7,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //***********2
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15 + width/4-3*width/120, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15 + width/4-3*width/120, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15 + width/4-3*width/120, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15 + width/4-3*width/120, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[1][0].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][1].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][2].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[1][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[1][0].size = width/12 + width/32;
      playerColor[1][1].size = width/12 + width/32;
      playerColor[1][2].size = width/12 + width/32;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      /*fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15  + width/4-3*width/120, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7 + width/4-3*width/120,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7  + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      */
      //*****3
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/2-3*width/60, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[2][0], colore[2][1], colore[2][2]);
      strokeWeight(height/100);
      rect( width/15+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ width/2-3*width/60, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15+ width/2-3*width/60, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15+ width/2-3*width/60, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15+ width/2-3*width/60, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[2][0].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][1].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][2].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[2][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[2][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[2][0].size = width/12 + width/32;
      playerColor[2][1].size = width/12 + width/32;
      playerColor[2][2].size = width/12 + width/32;
      playerColor[2][0].cirkSize = height/30;
      playerColor[2][1].cirkSize = height/30;
      playerColor[2][2].cirkSize = height/30;
      playerColor[2][0].render();
      playerColor[2][1].render();
      playerColor[2][2].render();
      colore[2][0] = playerColor[2][0].returnValue();
      colore[2][1] = playerColor[2][1].returnValue();
      colore[2][2] = playerColor[2][2].returnValue();
    
      /*fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15+ width/2-3*width/60, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7+ width/2-3*width/60,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      */
      //***********4
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[3][0], colore[3][1], colore[3][2]);
      strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[3][0].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][1].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][2].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[3][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[3][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[3][0].size = width/12 + width/32;
      playerColor[3][1].size = width/12 + width/32;
      playerColor[3][2].size = width/12 + width/32;
      playerColor[3][0].cirkSize = height/30;
      playerColor[3][1].cirkSize = height/30;
      playerColor[3][2].cirkSize = height/30;
      playerColor[3][0].render();
      playerColor[3][1].render();
      playerColor[3][2].render();
      colore[3][0] = playerColor[3][0].returnValue();
      colore[3][1] = playerColor[3][1].returnValue();
      colore[3][2] = playerColor[3][2].returnValue();
    
      /*fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15  + width/4-3*width/120+ width/2-3*width/60, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7  + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);*/
      
    }
    
    //***************
    
    start.posX = width-height/30 - width/7 ;
    start.posY = height-height/30 - height/16;
    start.sizeX = width/7; 
    start.sizeY = height/16; 
    start.textSize = width/30;
    start.render();
    if(start.presd() || keyz[16])
    {
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
      gameA.sizeX = width;
      gameA.sizeY = height;
      gameA.setColor(backR,backG,backB,0,0,0);
      gameA.startGame(appleAmount, powerUp, wales, 1, aiPlayer, colore, startLengh, tilesize);
      pageAt = 9;
    }
    
    back.posX = height/30;
    back.posY = height-height/30 - height/16;
    back.sizeX = width/7; 
    back.sizeY = height/16; 
    back.textSize = width/30;
    back.render();
    if(back.presd())
    {
      pageAt = -1;
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
    }
    
  }
  else if(pageAt == 9)
  {
    //surface.setSize(gameS.sizeX, gameS.sizeY);
    gameA.input();
    gameA.aiMove();
    gameA.travel();
    if(!gameA.winning() && gameA.playerLeft[0])
      gameA.colision();
    gameA.render();
    if(!gameA.playerLeft[0])
    {
      stroke(10);
      strokeWeight(height/200);
      fill(240);
      rect( width/2-width/4,height/2-height/6,width/2, height/3);
      fill(211, 48, 48);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", width/15);
      textFont(font);
      text("Game Over", width/2 , height/2 - height/10);
      font = createFont("ARLRDBD.TTF", width/30);
      textFont(font);
      fill(0);
      text("Score: " + gameA.eaten, width/2 , height/2);
      
      again.posX = width/2 + width/4 - height/30 - width/7 ;
      again.posY = height/2 + height/6 -height/30 - height/16;
      again.sizeX = width/7; 
      again.sizeY = height/16; 
      again.textSize = width/30;
      again.render();
      if(again.presd() || keyz[16])
      {
        gameA.sizeX = width;
        gameA.sizeY = height;
        gameA.setColor(backR,backG,backB,0,0,0);
        gameA.startGame(appleAmount, powerUp, wales, 1, aiPlayer, colore, startLengh, tilesize);
        pageAt = 9;
      }
      
      home.posX = width/2 - width/4 - width/7 + height/30 + width/7 ;
      home.posY = height/2 + height/6 - height/30 - height/16;
      home.sizeX = width/7; 
      home.sizeY = height/16; 
      home.textSize = width/30;
      home.render();
      if(home.presd())
      {
        pageAt = -1;
      }
      
      
    }
    else if(gameA.winning())
    {
      stroke(10);
      strokeWeight(height/200);
      fill(240);
      rect( width/2-width/4,height/2-height/6,width/2, height/3);
      fill(211, 48, 48);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", width/15);
      textFont(font);
      text("You won", width/2 , height/2 - height/10);
      font = createFont("ARLRDBD.TTF", width/30);
      textFont(font);
      fill(0);
      text("Score: Infinity" , width/2 , height/2);
      
      again.posX = width/2 + width/4 - height/30 - width/7 ;
      again.posY = height/2 + height/6 -height/30 - height/16;
      again.sizeX = width/7; 
      again.sizeY = height/16; 
      again.textSize = width/30;
      again.render();
      if(again.presd())
      {
        gameA.sizeX = width;
        gameA.sizeY = height;
        gameA.setColor(backR,backG,backB,0,0,0);
        gameA.startGame(appleAmount, powerUp, wales, 1, aiPlayer, colore, startLengh, tilesize);
        pageAt = 9;
      }
      
      home.posX = width/2 - width/4 - width/7 + height/30 + width/7 ;
      home.posY = height/2 + height/6 - height/30 - height/16;
      home.sizeX = width/7; 
      home.sizeY = height/16; 
      home.textSize = width/30;
      home.render();
      if(home.presd())
      {
        pageAt = -1;
      }
      
      
    }
    else
    {
      noCursor();
      hand = true;
    }
    
  }
  else if(pageAt == 7)
  {
    background.sizeX = width;
    background.sizeY = height;
    background.tilesize = (height) / 80;
    background.aiMove();
    background.travel();
    background.colision();
    background.render();
  
    if(background.winning())
    {
      background.startGame(10,false,false,0,4,colore,5,5);
    }
    
    stroke(1, 19, 48);
    fill(127,127,127,200);
    rect(0,0,width,height);
    
    //*****************
    
    fill(0);
    textAlign(LEFT,CENTER);
    font = createFont("ARLRDBD.TTF", width/30);
    textFont(font);
    text("Player:", width/9 , height/8 - height/120);
    textAlign(RIGHT,CENTER);
    text(player, width/4 + width/12, height/8 - height/150);
    
    playerS.posX = width/4 + width/8;
    playerS.posY = height/8;
    playerS.size = width/2;
    playerS.cirkSize = height/20;
    playerS.render();
    int playerRes = playerS.returnValue();
    if(playerRes < 100)
    {
      player = 2;
    }
    else if(playerRes < 200)
    {
      player = 3;
    }
    else
    {
      player = 4;
    }
    
    if(player == 2)
    {
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, width/2-3*width/30,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, width/2-3*width/30,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("R:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("G:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("B:", width/7 + width/6 - width/6 + width/50, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[0][0].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][1].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][2].posX = width/3 + width/17 - width/5+ width/50;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[0][1].posY = height/3 + height/9 + height/200;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[0][0].size = width/6 + width/16;
      playerColor[0][1].size = width/6 + width/16;
      playerColor[0][2].size = width/6 + width/16;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Controls:",  width/7 - width/15 , 3*height/4 + height/16);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      
      //******
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 +  width/2-3*width/30 + width/15, 2*height/8, width/2-3*width/30 ,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15+  width/2-3*width/30 + width/15, 2*height/8, width/2-3*width/30,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Color:", width/7 - width/15+  width/2-3*width/30 + width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("R:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("G:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("B:", width/7 + width/6 - width/6 + width/50+  width/2-3*width/30 + width/15, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[1][0].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][1].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][2].posX = width/3 + width/17 - width/5+ width/50+  width/2-3*width/30 + width/15;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[1][1].posY = height/3 + height/9 + height/200;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[1][0].size = width/6 + width/16;
      playerColor[1][1].size = width/6 + width/16;
      playerColor[1][2].size = width/6 + width/16;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/50);
      textFont(font);
      text("Controls:",  width/7 - width/15 +  width/2-3*width/30 + width/15, 3*height/4 + height/16);
      fill(0);
    
       stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("W", width/2 + height/30 - width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("S", width/2 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("A", width/2 - height/15 - height/45 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("D", width/2 + height/15 + height/45 + height/30- width/4 +width/28+  width/2-3*width/30 + width/15,3*height/4 - height/20 + height/15 + height/45 + height/30);
    }
    else if(player == 3)
    {
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[0][0].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][1].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][2].posX = 2*width/7 + width/17 - width/5+ width/50;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[0][1].posY = height/3 + height/9 + height/200;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[0][0].size = 2*width/18 + width/32;
      playerColor[0][1].size = 2*width/18 + width/32;
      playerColor[0][2].size = 2*width/18 + width/32;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 , height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/9,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //*********2
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ 2*width/6-3*width/90, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/65);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[1][0].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][1].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][2].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[1][1].posY = height/3 + height/9 + height/200;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[1][0].size = 2*width/18 + width/32;
      playerColor[1][1].size = 2*width/18 + width/32;
      playerColor[1][2].size = 2*width/18 + width/32;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 + 2*width/6-3*width/90, height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("W", width/2 + height/30 - width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("S", width/2 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("A", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("D", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      
      
      
      //*****3
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + 2*width/6-3*width/90+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[2][0], colore[2][1], colore[2][2]);
      strokeWeight(height/100);
      rect( width/15+ 2*width/6-3*width/90+ 2*width/6-3*width/90, 2*height/8, 2*width/6-6*width/90,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 - height/15 + height/400);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 + height/400);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", 2*width/18 + width/6 - width/6 + width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90, height/3 + height/9 + height/15 + height/400);
      
    
      playerColor[2][0].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][1].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][2].posX = 2*width/7 + width/17 - width/5+ width/50+ 2*width/6-3*width/90+ 2*width/6-3*width/90;
      playerColor[2][0].posY = height/3 + height/9 - height/15 + height/200;
      playerColor[2][1].posY = height/3 + height/9 + height/200;
      playerColor[2][2].posY = height/3 + height/9 + height/15 + height/200;
      playerColor[2][0].size = 2*width/18 + width/32;
      playerColor[2][1].size = 2*width/18 + width/32;
      playerColor[2][2].size = 2*width/18 + width/32;
      playerColor[2][0].cirkSize = height/30;
      playerColor[2][1].cirkSize = height/30;
      playerColor[2][2].cirkSize = height/30;
      playerColor[2][0].render();
      playerColor[2][1].render();
      playerColor[2][2].render();
      colore[2][0] = playerColor[2][0].returnValue();
      colore[2][1] = playerColor[2][1].returnValue();
      colore[2][2] = playerColor[2][2].returnValue();
    
      
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 + 2*width/6-3*width/90+ 2*width/6-3*width/90, height/2 + height/8);
      fill(0);
    
      stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("8", width/2 + height/30 - width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("5", width/2 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28 - width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("4", width/2 - height/15 - height/45 + height/30- width/4 +width/28 - width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("6", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/9+ 2*width/6-3*width/90+ 2*width/6-3*width/90,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      
    
    
    }
    else if(player == 4)
    {
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[0][0], colore[0][1], colore[0][2]);
      strokeWeight(height/100);
      rect( width/15, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[0][0].posX = width/7 - width/15 + width/24;
      playerColor[0][1].posX = width/7 - width/15 + width/24;
      playerColor[0][2].posX = width/7 - width/15 + width/24;
      playerColor[0][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[0][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[0][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[0][0].size = width/12 + width/32;
      playerColor[0][1].size = width/12 + width/32;
      playerColor[0][2].size = width/12 + width/32;
      playerColor[0][0].cirkSize = height/30;
      playerColor[0][1].cirkSize = height/30;
      playerColor[0][2].cirkSize = height/30;
      playerColor[0][0].render();
      playerColor[0][1].render();
      playerColor[0][2].render();
      colore[0][0] = playerColor[0][0].returnValue();
      colore[0][1] = playerColor[0][1].returnValue();
      colore[0][2] = playerColor[0][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15 , height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/50);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("Up", width/2 + height/30 - width/4 +width/28- width/7,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Down", width/2 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Left", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/55);
      textFont(font);
      text("Right", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //***********2
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[1][0], colore[1][1], colore[1][2]);
      strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15 + width/4-3*width/120, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15 + width/4-3*width/120, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15 + width/4-3*width/120, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15 + width/4-3*width/120, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[1][0].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][1].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][2].posX = width/7 - width/15 + width/24 + width/4-3*width/120;
      playerColor[1][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[1][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[1][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[1][0].size = width/12 + width/32;
      playerColor[1][1].size = width/12 + width/32;
      playerColor[1][2].size = width/12 + width/32;
      playerColor[1][0].cirkSize = height/30;
      playerColor[1][1].cirkSize = height/30;
      playerColor[1][2].cirkSize = height/30;
      playerColor[1][0].render();
      playerColor[1][1].render();
      playerColor[1][2].render();
      colore[1][0] = playerColor[1][0].returnValue();
      colore[1][1] = playerColor[1][1].returnValue();
      colore[1][2] = playerColor[1][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15  + width/4-3*width/120, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7 + width/4-3*width/120,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("W", width/2 + height/30 - width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7  + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("S", width/2 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("A", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("D", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //*****3
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/2-3*width/60, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[2][0], colore[2][1], colore[2][2]);
      strokeWeight(height/100);
      rect( width/15+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15+ width/2-3*width/60, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15+ width/2-3*width/60, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15+ width/2-3*width/60, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15+ width/2-3*width/60, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[2][0].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][1].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][2].posX = width/7 - width/15 + width/24+ width/2-3*width/60;
      playerColor[2][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[2][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[2][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[2][0].size = width/12 + width/32;
      playerColor[2][1].size = width/12 + width/32;
      playerColor[2][2].size = width/12 + width/32;
      playerColor[2][0].cirkSize = height/30;
      playerColor[2][1].cirkSize = height/30;
      playerColor[2][2].cirkSize = height/30;
      playerColor[2][0].render();
      playerColor[2][1].render();
      playerColor[2][2].render();
      colore[2][0] = playerColor[2][0].returnValue();
      colore[2][1] = playerColor[2][1].returnValue();
      colore[2][2] = playerColor[2][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15+ width/2-3*width/60, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7+ width/2-3*width/60,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("8", width/2 + height/30 - width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("5", width/2 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("4", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("6", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      //***********4
      
      stroke(10);
      fill(90);   strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height-height/5 - height/8);
      
      stroke(10);
      fill(colore[3][0], colore[3][1], colore[3][2]);
      strokeWeight(height/100);
      rect( width/15 + width/4-3*width/120+ width/2-3*width/60, 2*height/8, width/4-3*width/60,height/5- height/8);
    
      fill(0);
      textAlign(LEFT,TOP);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Color:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/100);
      fill(0);
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("R:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 - height/15 + height/50);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("G:",width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 + height/50);
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/75);
      textFont(font);
      text("B:", width/7 - width/15 + width/4-3*width/120+ width/2-3*width/60, height/3 + height/9 + height/15 + height/50);
      
    
      playerColor[3][0].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][1].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][2].posX = width/7 - width/15 + width/24 + width/4-3*width/120+ width/2-3*width/60;
      playerColor[3][0].posY = height/3 + height/9 - height/15 + height/50 + height/400;
      playerColor[3][1].posY = height/3 + height/9 + height/50 + height/400;
      playerColor[3][2].posY = height/3 + height/9 + height/15 + height/50 + height/400;
      playerColor[3][0].size = width/12 + width/32;
      playerColor[3][1].size = width/12 + width/32;
      playerColor[3][2].size = width/12 + width/32;
      playerColor[3][0].cirkSize = height/30;
      playerColor[3][1].cirkSize = height/30;
      playerColor[3][2].cirkSize = height/30;
      playerColor[3][0].render();
      playerColor[3][1].render();
      playerColor[3][2].render();
      colore[3][0] = playerColor[3][0].returnValue();
      colore[3][1] = playerColor[3][1].returnValue();
      colore[3][2] = playerColor[3][2].returnValue();
    
      fill(0);
      textAlign(LEFT,CENTER);
      font = createFont("ARLRDBD.TTF", width/60);
      textFont(font);
      text("Controls:",  width/7 - width/15  + width/4-3*width/120+ width/2-3*width/60, height/2 + height/8);
      fill(0);
    
        stroke(10);
      strokeWeight(height/300);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
    
      fill(199, 201, 175);
      rect( width/2 - width/4 +width/28 - width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20, height/15,height/15);
      fill(0);
      text("U", width/2 + height/30 - width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/30);
      
      
      fill(199, 201, 175);
      rect( width/2- width/4 +width/28- width/7  + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("J", width/2 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 - height/15 - height/45- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("H", width/2 - height/15 - height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
      fill(199, 201, 175);
      rect( width/2 + height/15 + height/45- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 , height/15,height/15);
      fill(0);
      font = createFont("ARLRDBD.TTF", height/35);
      textFont(font);
      text("K", width/2 + height/15 + height/45 + height/30- width/4 +width/28- width/7 + width/4-3*width/120+ width/2-3*width/60,3*height/4 - height/20 + height/15 + height/45 + height/30);
      
    }
    
    //***************
    
    start.posX = width-height/30 - width/7 ;
    start.posY = height-height/30 - height/16;
    start.sizeX = width/7; 
    start.sizeY = height/16; 
    start.textSize = width/30;
    start.render();
    if(start.presd() || keyz[16])
    {
     writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
      gameM.sizeX = width;
      gameM.sizeY = height;
      gameM.setColor(backR,backG,backB,0,0,0);
      gameM.startGame(appleAmount, powerUp, wales, player, 0, colore, startLengh, tilesize);
      pageAt = 10;
    }
    
    back.posX = height/30;
    back.posY = height-height/30 - height/16;
    back.sizeX = width/7; 
    back.sizeY = height/16; 
    back.textSize = width/30;
    back.render();
    if(back.presd())
    {
      pageAt = -1;
      writeOption = createWriter("config.rcn"); 
      writeOption.println(appleAmount + "/" + int(powerUp) + "/" + int(wales) + "/" + colore[0][0] + "/" + colore[0][1] + "/" + colore[0][2] + "/" + colore[1][0] + "/" + colore[1][1]+ "/" + colore[1][2] + "/" + colore[2][0] + "/" + colore[2][1] + "/" + colore[2][2] + "/" + colore[3][0] + "/" + colore[3][1] + "/" + colore[3][2] + "/" + backR + "/" + backG + "/" + backB + "/" + startLengh + "/" + tilesize + "/" + int(fullscreen));
      writeOption.flush();
      writeOption.close();
    }
    
  }
  else if(pageAt == 10)
  {
    //surface.setSize(gameS.sizeX, gameS.sizeY);
    gameM.input();
    gameM.travel();
    gameM.input();
    
    if(!gameM.winning())
      gameM.colision();
      
    gameM.input();
    gameM.render();
    if(gameM.winning())
    {
      int winner = gameM.winner();
      stroke(10);
      strokeWeight(height/200);
      fill(240);
      rect( width/2-width/4,height/2-height/6,width/2, height/3);
      fill(0);
      textAlign(CENTER,CENTER);
      font = createFont("ARLRDBD.TTF", width/20);
      textFont(font);
      if(winner != 5)
      {
        text("The winner is:", width/2 , height/2 - height/9);
        fill(colore[winner][0],colore[winner][1],colore[winner][2]);
        rect(width/2 - width/6 , height/2 - height/24, width/3, height/12);
      }
      
      again.posX = width/2 + width/4 - height/30 - width/7 ;
      again.posY = height/2 + height/6 -height/30 - height/16;
      again.sizeX = width/7; 
      again.sizeY = height/16; 
      again.textSize = width/30;
      again.render();
      if(again.presd() || keyz[16])
      {
        gameM.sizeX = width;
        gameM.sizeY = height;
        gameM.setColor(backR,backG,backB,0,0,0);
        gameM.startGame(appleAmount, powerUp, wales, player, 0, colore, startLengh, tilesize);
        pageAt = 10;
      }
      
      home.posX = width/2 - width/4 - width/7 + height/30 + width/7 ;
      home.posY = height/2 + height/6 - height/30 - height/16;
      home.sizeX = width/7; 
      home.sizeY = height/16; 
      home.textSize = width/30;
      home.render();
      if(home.presd())
      {
        pageAt = -1;
      }
      
      
    }
    else
    {
      noCursor();
      hand = true;
    }
    
   }
  
  
}

class game
{
  //***************************************//
  int posX;
  int posY;
  int sizeX;
  int sizeY;
  int colors[][] = new int[2][3];
  int tilesX;
  int tilesY;
  int restX1;
  int restY1;
  
  //**********Game Varibles****************//
  int headX[][] = new int[4][2500];
  int headY[][] = new int[4][2500];
  int appleX[] = new int[2500];
  int appleY[] = new int[2500];
  int power[] = new int[2];
  int angle[] = new int[4];
  int pLength[] = new int[4];
  long playTime = 0;
  long startTime = 0;
  long lastMove[] = new long[4];
  int powerAktiv[][] = new int[4][2];
  int lastPower;
  int deadPoint[][] = new int[4][3];
  boolean gameOn = false;
  boolean playerLeft[] = new boolean[4];
  int playersLeft = 4;
  int colisions = 0;
  int eaten = 0;
  int eatenAtCol = 0;
  float exp1[][] = 
{{-0.22,0.37},
 {0.26,0.1},
 {0.61,0.42},
 {0.79,-0.15},
 {1,-0.5},
 {0.69,-0.64},
 {0.36,-1.22},
 {0.07,-0.76},
 {-0.39,-0.76},
 {-0.13,-0.23}};
   int wallKaos[] = {0,0};
  
  //**********Game Setings*****************//
   
  int appleAmount;
  boolean powerUp;
  boolean wales;
  int player;
  int aiPlayer;
  int Pcolors[][] = new int[4][3];
  int tilesize;
  int size[] = new int[2];
  
  
  
  game(int posXi, int posYi, int sizeXi, int sizeYi)
  {
    posX = posXi;
    posY = posYi;
    sizeX = sizeXi;
    sizeY = sizeYi; 
  }
  
  void setColor(int F1, int F2, int F3, int W1, int W2, int W3)
  {
    colors[0][0] = F1;
    colors[0][1] = F2;
    colors[0][2] = F3;
    colors[1][0] = W1;
    colors[1][1] = W2;
    colors[1][2] = W3;
  }
  
  void startGame(int appleAmounti, boolean powerUpi, boolean walesi, int playeri, int aiPlayeri, int Pcolorsi[][], int startLenghi, int tilesizei)
  {
    for(int i = 0; i < 4; i++)
    {
      for(int b = 0; b < 3; b++)
      {
        Pcolors[i][b] = Pcolorsi[i][b];
      }
    }
    
    appleAmount = appleAmounti;
    powerUp  = powerUpi;
    wales  = walesi;
    player = playeri;
    aiPlayer = aiPlayeri;
    startLengh = startLenghi;
    tilesize = tilesizei;
    
    checkSize();
    
    gameOn = true;
    restart();
  }
  
  void restart()
  {
    for(int p = 0; p < 4; p++)
    {
      playerLeft[p] = true;
      powerAktiv[p][0] = 0;
      powerAktiv[p][1] = 0;
    }
    power[0] = -100;
    power[1] = 0;
    boolean redo = true;
    wallKaos[0] = 0;
    wallKaos[1] = 0;
    lastPower = 0;
    eaten = 0;
    playersLeft = (player + aiPlayer);
    int changeKonX = 0;
    int changeKonY = 0;
    for(int p = 0; p < 4; p++)
    {
      pLength[p] = startLengh;
      switch(p)
      {
        case 0: 
          headX[p][0] = size[0]/2;
          headY[p][0] = size[1]/3;
          angle[p] = 0;
          changeKonX = -1;
          changeKonY = 0;
        break;
        case 1: 
          headX[p][0] = size[0]/2;
          headY[p][0] = 2*size[1]/3;
          angle[p] = 180;
          changeKonX = 1;
          changeKonY = 0;
        break;
        case 2: 
          headX[p][0] = size[0]/3;
          headY[p][0] = size[1]/2;
          angle[p] = 90;
          changeKonX = 0;
          changeKonY = 1;
        break;
        case 3: 
          headX[p][0] = 2*size[0]/3;
          headY[p][0] = size[1]/2;
          angle[p] = 270;
          changeKonX = 0;
          changeKonY = -1;
        break;
        default: break;
      }
      for(int h = 1; h < startLengh; h++)
      {
        headX[p][h] = headX[p][0] + changeKonX * h;
        headY[p][h] = headY[p][0] + changeKonY * h;
      }
    }
    for(int a = 0; a < appleAmount; a++)
    {
      redo = true;
      while(redo)
      {
        redo = false;
        appleX[a] = (int) random(1,size[0]-1);
        appleY[a] = (int) random(1,size[1]-1);
        for(int p = 0; p < (player + aiPlayer); p++)
        {
          for(int h = 0; h < pLength[p]; h++)
          {
            if(headX[p][h] == appleX[a] && headY[p][h] == appleY[a])
            {
              redo = true;
            }
          }
          
        }
      }
    }
    
  }
  
  void travel()
  {
    for(int p = 0; p < (player + aiPlayer);p++)
    {
        int timeS = 200*(4 * (int)( sqrt(20 * pLength[p]))/tilesize + 10)/min(size[0],size[1]);
        if(!playerLeft[p])
        {
          timeS /= 10;
        }
        if(powerAktiv[p][0] == 4)
        {
          timeS *= 1.8;
        }
        if(powerAktiv[p][0] == 5)
        {
          timeS /= 2;
        }
        if(powerAktiv[p][0] == 1)
        {
          timeS /= 1.8;
        }
        if(powerAktiv[p][0] == 6)
        {
          timeS *= 4;
        }
        if(timeS <= (millis() - lastMove[p]))
        {
          lastMove[p] = millis();
          for(int h = pLength[p] - 1; h >= 0 ; h--)
          {
            if (h!=0)
            {
              headX[p][h]=headX[p][h-1];
              headY[p][h]=headY[p][h-1];
            }
            else if (playerLeft[p])
            {
              switch(angle[p])
              {
                case 0:
                headX[p][0]+=1;
                if((!wales || powerAktiv[p][0] == 1) && headX[p][0] >= size[0])
                {
                  headX[p][0] = 0;
                }
                break;
                case 90:
                headY[p][0]-=1;
                if((!wales || powerAktiv[p][0] == 1) && headY[p][0] < 0)
                {
                  headY[p][0] = size[1]-1;
                }
                break;
                case 180:
                headX[p][0]-=1;
                if((!wales || powerAktiv[p][0] == 1) && headX[p][0] < 0)
                {
                  headX[p][0] = size[0]-1;
                }
                break;
                case 270:
                headY[p][0]+=1;
                if((!wales || powerAktiv[p][0] == 1) && headY[p][0] >= size[1])
                {
                  headY[p][0] = 0;
                }
                break;
              }
            }    
          }
        }
      
    }
    
  }
  
  boolean winning()
  {
    int test = 0;
    for(int p = 0; p < (player + aiPlayer); p++)
    {
      if(playerLeft[p])
      {
        test++;
      }
    }
    if(test <= 1)
    {
      return true;
    }
    else
    {
      return false;
    }
    
  }
  
  int winner()
  {
    int test = 5;
    for(int p = 0; p < (player + aiPlayer); p++)
    {
      if(playerLeft[p])
      {
        test = p;
      }
    }
    
    return test;
  }
  
  void checkSize()
  {
    
    int restX = sizeX % tilesize;
    restX1 = restX/2;
    int endSizeX = sizeX - restX;
    int restY = sizeY % tilesize;
    restY1 = restY/2;
    int endSizeY = sizeY - restY;
    
    size[0] = (endSizeX/tilesize);
    size[1] = (endSizeY/tilesize);
    
    if(wales)
    {
     size[0] -= 2;
     size[1] -= 2;
    }
    
  }
  
  void input()
  {
    //keyPressed();
  //}

    if(keyPressed)
    {
  //void keyPressed()
  //{
       /*************Player1************
        if (keyCode == UP  && angle[0]!=270 && (headY[0][0]-1)!=headY[0][1])
        {
          angle[0]=90;
        }
        if (keyCode == DOWN && angle[0]!=90 && (headY[0][0]+1)!=headY[0][1])
        {
          angle[0]=270;
        }if (keyCode == LEFT && angle[0]!=0 && (headX[0][0]-1)!=headX[0][1])
        {
          angle[0]=180;
        }if (keyCode == RIGHT && angle[0]!=180 && (headX[0][0]+1)!=headX[0][1])
        {
          angle[0]=0;
        }
       
       if(player > 1)
       {
       //*************Player2************
        if ((key == 'w' || key == 'W')  && angle[1]!=270 && (headY[1][0]-1)!=headY[1][1])
        {
          angle[1]=90;
        }
        if ((key == 's'  || key == 'S')&& angle[1]!=90 && (headY[1][0]+1)!=headY[1][1])
        {
          angle[1]=270;
        }if ((key == 'a'  || key == 'A')&& angle[1]!=0 && (headX[1][0]-1)!=headX[1][1])
        {
          angle[1]=180;
        }if ((key == 'd' || key == 'D') && angle[1]!=180 && (headX[1][0]+1)!=headX[1][1])
        {
          angle[1]=0;
        }
       }
       if(player > 2)
       {
        //*************Player3************
        if (key == '8'  && angle[2]!=270 && (headY[2][0]-1)!=headY[2][1])
        {
          angle[2]=90;
        }
        if (key == '5' && angle[2]!=90 && (headY[2][0]+1)!=headY[2][1])
        {
          angle[2]=270;
        }if (key == '4' && angle[2]!=0 && (headX[2][0]-1)!=headX[2][1])
        {
          angle[2]=180;
        }if (key == '6' && angle[2]!=180 && (headX[2][0]+1)!=headX[2][1])
        {
          angle[2]=0;
        }
       }
       if(player > 3)
       {
        //*************Player4************
        if ((key == 'u'  || key == 'W') && angle[3]!=270 && (headY[3][0]-1)!=headY[3][1])
        {
          angle[3]=90;
        }
        if ((key == 'j'  || key == 'J')&& angle[3]!=90 && (headY[3][0]+1)!=headY[3][1])
        {
          angle[3]=270;
        }if ((key == 'h'  || key == 'H')&& angle[3]!=0 && (headX[3][0]-1)!=headX[3][1])
        {
          angle[3]=180;
        }if ((key == 'k'  || key == 'K')&& angle[3]!=180 && (headX[3][0]+1)!=headX[3][1])
        {
          angle[3]=0;
        }
       }
       //**************************/
      
 // }
  
  //void keyReleased()
  //{
       //*************Player1************
        if (keyz[12]  && angle[0]!=270 && (headY[0][0]-1)!=headY[0][1])
        {
          angle[0]=90;
        }
        if (keyz[13] && angle[0]!=90 && (headY[0][0]+1)!=headY[0][1])
        {
          angle[0]=270;
        }if (keyz[14] && angle[0]!=0 && (headX[0][0]-1)!=headX[0][1])
        {
          angle[0]=180;
        }if (keyz[15] && angle[0]!=180 && (headX[0][0]+1)!=headX[0][1])
        {
          angle[0]=0;
        }
      }
       
       if(player > 1)
       {
       //*************Player2************
        if (keyz[0]  && angle[1]!=270 && (headY[1][0]-1)!=headY[1][1])
        {
          angle[1]=90;
        }
        if (keyz[1] && angle[1]!=90 && (headY[1][0]+1)!=headY[1][1])
        {
          angle[1]=270;
        }if ( keyz[2] && angle[1]!=0 && (headX[1][0]-1)!=headX[1][1])
        {
          angle[1]=180;
        }if ( keyz[3] && angle[1]!=180 && (headX[1][0]+1)!=headX[1][1])
        {
          angle[1]=0;
        }
       }
       if(player > 2)
       {
        //*************Player3************
        if (keyz[4]  && angle[2]!=270 && (headY[2][0]-1)!=headY[2][1])
        {
          angle[2]=90;
        }
        if (keyz[5] && angle[2]!=90 && (headY[2][0]+1)!=headY[2][1])
        {
          angle[2]=270;
        }if (keyz[6] && angle[2]!=0 && (headX[2][0]-1)!=headX[2][1])
        {
          angle[2]=180;
        }if (keyz[7] && angle[2]!=180 && (headX[2][0]+1)!=headX[2][1])
        {
          angle[2]=0;
        }
       }
       if(player > 3)
       {
        //*************Player4************
        if (keyz[8] && angle[3]!=270 && (headY[3][0]-1)!=headY[3][1])
        {
          angle[3]=90;
        }
        if (keyz[9] && angle[3]!=90 && (headY[3][0]+1)!=headY[3][1])
        {
          angle[3]=270;
        }if (keyz[10] && angle[3]!=0 && (headX[3][0]-1)!=headX[3][1])
        {
          angle[3]=180;
        }if (keyz[11] && angle[3]!=180 && (headX[3][0]+1)!=headX[3][1])
        {
          angle[3]=0;
        }
       
      //**************************/
  }
  }
  
  void aiMove()
  {
    for(int i = player; i < (player + aiPlayer);i++)
    {
      if(playerLeft[i])
      {
      int goUp = 20;
      int goDown = 20;
      int goLeft = 20;
      int goRigth = 20;
      //**************up
      for(int y = 1; y < 7; y++)
      {
        boolean found = false;
        for(int x = -y; x < y+1; x++)
        {
          for(int p = 0; p < (player + aiPlayer); p++)
          {
            if((angle[p] != 90 || y <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < pLength[p]; h++)
              {
                if(headX[i][0]+x == headX[p][h] && headY[i][0]-y == headY[p][h])
                {
                  if(abs(x)+abs(y) < goUp)
                  {
                    goUp = abs(x) + abs(y);
                    found = true; 
                  }
                  if(abs(x) == 1 && abs(y) == 1 && angle[p] == (90 + (90 * x))&& p != i && h == 0)
                  {
                    goUp = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goUp = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goUp = -3;
                  }
                }
              }
            }
          }
        }
        if(headY[i][0] - y < 0)
        {
          if(wales || wallKaos[0] != 0)
          {
            goUp = y;
            if(y == 1)
            {
              goUp = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //****************************************down
      for(int y = 1; y < 7; y++)
      {
        boolean found = false;
        for(int x = -y; x < y+1; x++)
        {
          for(int p = 0; p < (player + aiPlayer); p++)
          {
            if((angle[p] != 270 || y <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < pLength[p]; h++)
              {
                if(headX[i][0]+x == headX[p][h] && headY[i][0]+y == headY[p][h])
                {
                  if(abs(x)+abs(y) < goDown)
                  {
                    goDown = abs(x) + abs(y);
                    found = true;
                  }
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (90 + (90 * x))&& p != i && h == 0)
                  {
                    goDown = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goDown= 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goDown = -3;
                  }
                }
              }
            }
          }
        }
        if(headY[i][0] + y > size[1])
        {
          if(wales || wallKaos[0] != 0)
          {
            goDown = y;
            if(y == 1)
            {
              goDown = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //***************************left
      for(int x = 1; x < 7; x++)
      {
        boolean found = false;
        for(int y = -x; y < x+1; y++)
        {
          for(int p = 0; p < (player + aiPlayer); p++)
          {
            if((angle[p] != 180 || x <= 2 ) && playerLeft[p])
            {
              for(int h = 0; h < pLength[p]; h++)
              {
                if(headX[i][0]-x == headX[p][h] && headY[i][0]+y == headY[p][h])
                {
                  if(abs(x)+abs(y) < goLeft)
                  {
                    goLeft = abs(x) + abs(y);
                    found = true;
                  }
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (180 - (90 * y)) && p != i && h == 0)
                  {
                    goLeft = 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goLeft = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goLeft = -3;
                  }
                }
              }
            }
          }
        }
        if(headX[i][0] - x < 0)
        {
          if(wales || wallKaos[0] != 0)
          {
            goLeft = x;
            if(x == 1)
            {
              goLeft = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      
      //******************rigth
      for(int x = 1; x < 7; x++)
      {
        boolean found = false;
        for(int y = -x; y < x+1; y++)
        {
          for(int p = 0; p < (player + aiPlayer); p++)
          {
            if((angle[p] != 0 || x <= 2) && playerLeft[p])
            {
              for(int h = 0; h < pLength[p]; h++)
              {
                if(headX[i][0]+x == headX[p][h] && headY[i][0]+y == headY[p][h])
                {
                  if(abs(x)+abs(y) < goRigth)
                  {
                    goRigth = abs(x) + abs(y);
                    found = true;
                  }
                   if(abs(x) == 1 && abs(y) == 1 && angle[p] == (180 + (90 * y)) && p != i && h == 0)
                  {
                    goRigth= 0;
                  }
                  if(abs(x) + abs(y) <= 2)
                  {
                    goRigth = 1;
                  }
                  if(abs(x) + abs(y) == 1)
                  {
                    goRigth = -3;
                  }
                }
              }
            }
          }
        }
        if(headX[i][0] + x > size[0])
        {
          if(wales || wallKaos[0] != 0)
          {
            goRigth = x;
            if(x == 1)
            {
              goRigth = -2;
            }
            break;
          }
        }
        if(found)
        {
         break; 
        }
      }
      
      boolean stopU = false;
      boolean stopD = false;
      boolean stopL = false;
      boolean stopR = false;
      
      for(int h = 1; h < pLength[i]; h++)
      {
        for(int x = 1; x < pLength[i]/2; x++)
        {
          if(headX[i][0]+x == headX[i][h] && headY[i][0] == headY[i][h] && !stopR)
          {
            goRigth -= 4 - sqrt(x);
            stopR = true;
          }
          if(headX[i][0]-x == headX[i][h] && headY[i][0] == headY[i][h] && !stopL)
          {
            goLeft -= 4 - sqrt(x);
            stopL = true;
          }
          if(headX[i][0] == headX[i][h] && headY[i][0]+x == headY[i][h] && !stopD)
          {
            goDown -= 4 - sqrt(x);
            stopD = true;
          }
          if(headX[i][0] == headX[i][h] && headY[i][0]-x == headY[i][h] && !stopU)
          {
            goUp -= 4 - sqrt(x);
            stopU = true;
          }
        }
      }
      
      int dir[] = {goUp, goDown, goLeft};
      
      switch(angle[i])
      {
        case 0:
          dir[0] = goUp;
          dir[1] = goDown;
          dir[2] = goRigth;
        break;
        case 90:
          dir[0] = goUp;
          dir[1] = goLeft;
          dir[2] = goRigth;
        break;
        case 180:
          dir[0] = goUp;
          dir[1] = goDown;
          dir[2] = goLeft;
        break;
        case 270:
          dir[0] = goLeft;
          dir[1] = goDown;
          dir[2] = goRigth;
        break;
      }
      
      if(min(dir) > 6 || (dir[0] + dir[1] + dir[2]) > 25)
      {
        for(int a = 0; a < appleAmount; a++)
        {
          if(headX[i][0] == appleX[a])
          {
            if(headY[i][0] > appleY[a])
            {
              goUp += 3;
            }
            else
            {
              goDown += 3;
            }
          }
          if(headY[i][0] == appleY[a])
          {
            if(headX[i][0] > appleX[a])
            {
              goLeft += 3;
            }
            else
            {
              goRigth += 3;
            }
          }
        }
      }
      
      if(min(dir) > 6 || (dir[0] + dir[1] + dir[2]) > 25)
      {
        if(headX[i][0] == power[0])
        {
          if(headY[i][0] > power[1])
          {
            goUp += 2;
          }
          else
          {
            goDown += 2;
          }
        }
        if(headY[i][0] == power[1])
        {
          if(headX[i][0] > power[0])
          {
            goLeft += 2;
          }
          else
          {
            goRigth += 2;
          }
        }
      }
      
      for(int p = 0; p < player + aiPlayer; p++)
      {
        switch(angle[i])
        {
          case 0:
            if(headX[i][0]-1 == headX[p][0] && headY[i][0] == headY[p][0])
              goRigth -= 5;
          break;
          case 90:
             if(headX[i][0] == headX[p][0] && headY[i][0]+1 == headY[p][0])
              goUp -= 5;
          break;
          case 180:
             if(headX[i][0]+1 == headX[p][0] && headY[i][0] == headY[p][0])
              goLeft -= 5;
          break;
          case 270:
             if(headX[i][0] == headX[p][0] && headY[i][0]-1 == headY[p][0])
              goDown -= 5;
          break;
        }
      }
      
      if(goUp > goDown && goUp > goLeft && goUp > goRigth)
      {
        angle[i] = 90;
      }
      else if(goDown > goUp && goDown > goLeft && goDown > goRigth)
      {
        angle[i] = 270;
      }
      else if(goLeft > goUp && goLeft > goDown && goLeft > goRigth)
      {
        angle[i] = 180;
      }
      else if(goRigth > goUp && goRigth > goDown && goRigth > goLeft)
      {
        angle[i] = 0;
      } 
      else
      {
        if(goUp < 4 && goLeft == goRigth && angle[i] == 90)
        {
          if(random(2) < 1)
          {
            angle[i] = 180;
          }
          else
          {
            angle[i] = 0;
          }
        }
        if(goLeft < 4 && goUp == goDown && angle[i] == 180)
        {
          if(random(2) < 1)
          {
            angle[i] = 90;
          }
          else
          {
            angle[i] = 270;
          }
        }
        if(goDown < 4 && goLeft == goRigth && angle[i] == 270)
        {
          if(random(2) < 1)
          {
            angle[i] = 0;
          }
          else
          {
            angle[i] = 180;
          }
        }
        if(goRigth < 4 && goDown == goUp && angle[i] == 0)
        {
          if(random(2) < 1)
          {
            angle[i] = 90;
          }
          else
          {
            angle[i] = 270;
          }
        }
      }
      
      }
    }
  }
  
  void render()
  {
    
    checkSize();
    if(wales)
    {
      stroke(colors[1][1], colors[1][1], colors[1][2]);
      strokeWeight(2*tilesize);
    }
    else
    {
      noStroke();
    }
    fill(colors[0][0], colors[0][1], colors[0][2]);
    if(!wales)
    {
      rect(posX + restX1, posY + restY1, size[0] * tilesize, size[1] * tilesize);
    }
    else
    {
      rect(posX + restX1, posY + restY1, size[0] * tilesize + 2*tilesize, size[1] * tilesize + 2*tilesize);
    }
    
    for(int p = 0; p < (player + aiPlayer); p++)
    {
        for(int h = 0; h < pLength[p]; h++)
        {  
          strokeJoin(MITER);
          strokeWeight(tilesize/10);
          stroke(colors[0][1], colors[0][1], colors[0][2]);
          fill(Pcolors[p][0], Pcolors[p][1], Pcolors[p][2]);
          rectMode(CORNER);
          if(wales)
          {
            rect((restX1 + (headX[p][h] * tilesize)) + tilesize + posX,( restY1 + (headY[p][h] * tilesize)) + tilesize + posY, tilesize, tilesize);
          }
          else
          {
            rect((restX1 + (headX[p][h] * tilesize)) + posX,( restY1 + (headY[p][h] * tilesize)) + posY, tilesize, tilesize);
          }
        }
      
    }
    for(int a = 0; a < appleAmount; a++)
    {
      strokeJoin(MITER);
      strokeWeight(tilesize/7);
      stroke(0);
      fill(255, 0, 0);
      rectMode(CORNER);
      if(wales)
      {
         rect((restX1 + (appleX[a] * tilesize)) + tilesize,( restY1 + (appleY[a] * tilesize)) + tilesize, tilesize, tilesize);
      }
      else
      {
        rect((restX1 + (appleX[a] * tilesize)),( restY1 + (appleY[a] * tilesize)), tilesize, tilesize);
      }
    }
    
    for(int p = 0; p < (player + aiPlayer); p++)
    {
      if(powerAktiv[p][0] == 1 && playerLeft[p])
      {
         noFill();
         stroke(0, 233, 255, 100);
         strokeWeight(2*tilesize);
         beginShape(POINTS);
         for(int h = 0; h < pLength[p]; h++)
         {
           if(wales)
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (3*tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (3*tilesize/2));
           }
           else
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (tilesize/2));
           }
         }
         endShape();
         
        
      }
      if(powerAktiv[p][0] == 4 && playerLeft[p])
      {
         noFill();
         stroke(59, 214, 12, 100);
         strokeWeight(2*tilesize);
         beginShape(POINTS);
         for(int h = 0; h < pLength[p]; h++)
         {
           if(wales)
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (3*tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (3*tilesize/2));
           }
           else
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (tilesize/2));
           }
         }
         endShape();
        
      }
      if(powerAktiv[p][0] == 6 && playerLeft[p])
      {
         noFill();
         stroke(43, 145, 13, 100);
         strokeWeight(2*tilesize);
         beginShape(POINTS);
         for(int h = 0; h < pLength[p]; h++)
         {
           if(wales)
           {
              vertex(posX + restX1 + (headX[p][h]*tilesize) + (3*tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (3*tilesize/2));
           }
           else
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (tilesize/2));
           }
         }
        endShape();
        
      }
      if(powerAktiv[p][0] == 5 && playerLeft[p])
      {
         noFill();
         stroke(255, 123, 0, 100);
         strokeWeight(2*tilesize);
         beginShape(POINTS);
         for(int h = 0; h < pLength[p]; h++)
         {
           if(wales)
           {
              vertex(posX + restX1 + (headX[p][h]*tilesize) + (3*tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (3*tilesize/2));
           }
           else
           {
             vertex(posX + restX1 + (headX[p][h]*tilesize) + (tilesize/2),posY + restY1 + (headY[p][h]*tilesize) + (tilesize/2));
           }
         }
        endShape();
        
      }
      if(!playerLeft[p] && millis() - deadPoint[p][2] < 600)
      {
        noStroke();
        
        if(millis() - deadPoint[p][2] > 250)
        {
          fill(156, 42, 0);
          beginShape(/*TRIANGLE_STRIP*/);
          vertex(exp1[0][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[0][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[1][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[1][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[2][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[2][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[3][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[3][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[4][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[4][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[5][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[5][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[6][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[6][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[7][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[7][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[8][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[8][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          vertex(exp1[9][0] * tilesize * 6 + deadPoint[p][0] * tilesize, exp1[9][1] * tilesize * -6 + deadPoint[p][1] * tilesize);
          endShape(CLOSE);
        
        }
        
        if(millis() - deadPoint[p][2] > 50)
        {
          fill(227, 140, 45);
          beginShape(/*TRIANGLE_STRIP*/);
          vertex(exp1[0][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[0][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[1][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[1][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[2][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[2][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[3][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[3][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[4][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[4][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[5][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[5][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[6][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[6][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[7][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[7][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[8][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[8][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          vertex(exp1[9][0] * tilesize * -4 + deadPoint[p][0] * tilesize, exp1[9][1] * tilesize * -4 + deadPoint[p][1] * tilesize);
          endShape(CLOSE);
        
        }
        
        fill(249, 255, 94);
        beginShape(TRIANGLE_STRIP);
        vertex(exp1[0][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[0][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[1][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[1][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[2][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[2][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[3][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[3][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[4][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[4][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[5][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[5][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[6][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[6][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[7][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[7][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[8][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[8][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        vertex(exp1[9][0] * tilesize * 2 + deadPoint[p][0] * tilesize, exp1[9][1] * tilesize * 2 + deadPoint[p][1] * tilesize);
        endShape(CLOSE);
        
      }
    }
    
    fill(0, 225, 255);
    stroke(0);
    strokeWeight(tilesize/5);
    if(wales)
    {
      rect(posX + restX1 + (power[0]*tilesize) + tilesize, posY + restY1 + (power[1]*tilesize) + tilesize, 2*tilesize, 2*tilesize);
    }
    else
    {
      rect(posX + restX1 + (power[0]*tilesize), posY + restY1 + (power[1]*tilesize), 2*tilesize, 2*tilesize);
    }
    
  }
  
  void gameOverScreen()
  {
    
    
  }
  
  void colision()
  {
    if(powerUp)
    {
      if(millis() - lastPower > 20000)
      {
        boolean redo = true;
        while(redo)
        {
          redo = false;
          power[0] = (int) random(1,size[0]-2);
          power[1] = (int) random(1,size[1]-2);
          
          for(int p = 0; p < (player + aiPlayer); p++)
          {
            if(playerLeft[p])
            {
              for(int h = 0; h < pLength[p]; h++)
              {
                if(headX[p][h] == power[0] && headY[p][h] == power[1])
                {
                  redo = true;
                }
                if(headX[p][h]-1 == power[0] && headY[p][h] == power[1])
                {
                  redo = true;
                }
                if(headX[p][h] == power[0] && headY[p][h]-1 == power[1])
                {
                  redo = true;
                }
                if(headX[p][h]-1 == power[0] && headY[p][h]-1 == power[1])
                {
                  redo = true;
                }
              }
            }
            
          }
 
        }
        lastPower = millis();
      }
      
      for(int p = 0; p < player + aiPlayer; p++)
      {
        if(powerAktiv[p][0] != 0 && millis() - powerAktiv[p][1] > 20000)
        {
          powerAktiv[p][0] = 0;
        }
        if(wallKaos[0] != 0 && millis() - wallKaos[1] > 20000)
        {
          wallKaos[0] = 0;
        }
        if(((headX[p][0] == power[0] && headY[p][0] == power[1]) || (headX[p][0]-1 == power[0] && headY[p][0] == power[1]) || (headX[p][0] == power[0] && headY[p][0]-1 == power[1]) || (headX[p][0]-1 == power[0] && headY[p][0]-1 == power[1]))&& playerLeft[p])
        {
          switch((int)random(0,7))
          {
            case 0:
              powerAktiv[p][0] = 1;
              powerAktiv[p][1] = millis();
            break;
            case 1:
              powerAktiv[p][0] = 2;
              pLength[p] += 10;
              for(int h = 0; h < 10; h++)
              {
                headX[p][pLength[p]-1-h] = headX[p][pLength[p]-11]; 
                headY[p][pLength[p]-1-h] = headY[p][pLength[p]-11]; 
              }
              powerAktiv[p][1] = millis();
            break;
            case 2:
              powerAktiv[p][0] = 3;
              pLength[p] /= 2;
              powerAktiv[p][1] = millis();
            break;
            case 3:
              powerAktiv[p][0] = 4;
              powerAktiv[p][1] = millis();
            break;
            case 4:
              powerAktiv[p][0] = 5;
              for(int p2 = 0; p2 < player + aiPlayer;p2++)
              {
                if(p2 != p)
                {
                  powerAktiv[p2][0] = 4;
                  powerAktiv[p2][1] = millis();
                }
              }
              powerAktiv[p][1] = millis();
            break;
            case 5:
              powerAktiv[p][0] = 6;
              powerAktiv[p][1] = millis();
            break;
            case 6:
              powerAktiv[p][0] = 7;
              pLength[p] += 5;
              for(int h = 0; h < 5; h++)
              {
                headX[p][pLength[p]-1-h] = headX[p][pLength[p]-6]; 
                headY[p][pLength[p]-1-h] = headY[p][pLength[p]-6]; 
              }
              wallKaos[0] = round(random(5,10));
              wallKaos[1] = millis();
              powerAktiv[p][1] = millis();
            break;
            default:
              powerAktiv[p][0] = 1;
              powerAktiv[p][1] = millis();
            break;
          }
          power[0] = -100;
        }
      }
      
    }
    if(wallKaos[0] != 0)
    {
      if(millis() % wallKaos[0] == 0)
      {
        wales = !wales;
      }
    }
    
    for(int p = 0; p < player + aiPlayer; p++)
    {
      if(playerLeft[p] )
      {
      for(int a = 0; a < appleAmount; a++)
      {
        if(headX[p][0] == appleX[a] && headY[p][0] == appleY[a])
        {
          eaten++;
          pLength[p]++;
          headX[p][pLength[p]-1] = headX[p][pLength[p]-2];
          headY[p][pLength[p]-1] = headY[p][pLength[p]-2];
          
          
          boolean redo = true;
          while(redo)
          {
            redo = false;
            appleX[a] = (int) random(1,size[0]-1);
            appleY[a] = (int) random(1,size[1]-1);
            for(int p3 = 0; p3 < (player + aiPlayer); p3++)
            {
              if(playerLeft[p3])
              {
                for(int h = 0; h < pLength[p3]; h++)
                {
                  if(headX[p][h] == appleX[a] && headY[p][h] == appleY[a])
                  {
                    redo = true;
                  }
                }
              }
              
             }
   
          }
         }
        }
        if(headX[p][0] < 0 || headX[p][0] >= size[0] || headY[p][0] < 0 || headY[p][0] >= size[1])
        {
          if(wales && powerAktiv[p][0] != 1)
          {
            colisions++;
            playerLeft[p] = false;
            deadPoint[p][0] = headX[p][0];
            deadPoint[p][1] = headY[p][0];
            deadPoint[p][2] = millis();
            headX[p][0] = -50;
          }
        }
        for(int p2 = 0; p2 < player + aiPlayer; p2++)
        {
          if(playerLeft[p2] && powerAktiv[p][0] != 1)
          {
            for(int h = 0; h < pLength[p2]; h++)
            {
              if(p != p2 || h != 0)
              {
                if(headX[p][0] == headX[p2][h] && headY[p][0] == headY[p2][h])
                {
                  colisions++;
                  playerLeft[p] = false;
                  deadPoint[p][0] = headX[p][0];
                  deadPoint[p][1] = headY[p][0];
                  deadPoint[p][2] = millis();
                  headX[p][0] = -50;
                }
              }
            }
          }
        }
      }
    }
    if(colisions == 0)
    {
      eatenAtCol = eaten;
    }
  }
}

class checkBox
{
  int sizeX, sizeY, posX, posY;
  int colore[][] = new int[3][3];
  boolean pressd;
  boolean checked = false;
  int srokeSize;
  boolean changeS = true;
  
  checkBox(int posXi,int  posYi,int sizeXi,int sizeYi, boolean checkedi)
  {
    posX = posXi;
    posY = posYi;
    sizeX = sizeXi;
    sizeY = sizeYi;
    checked = checkedi;
  }
  
  void setColors(int F1, int F2, int F3, int R1, int R2, int R3, int H1, int H2, int H3)
  {
    colore[0][0] = F1;
    colore[0][1] = F2;
    colore[0][2] = F3;
    colore[1][0] = R1;
    colore[1][1] = R2;
    colore[1][2] = R3;
    colore[2][0] = H1;
    colore[2][1] = H2;
    colore[2][2] = H3;
  }
  
  void render()
  {
    if(changeS)
     srokeSize = sizeY/10;
     stroke(colore[1][0],colore[1][1],colore[1][2]);
     fill(colore[0][0],colore[0][1],colore[0][2]);
     strokeWeight(srokeSize);
     strokeJoin(BEVEL);
     rect(posX, posY, sizeX, sizeY);
     noFill();
     stroke(colore[2][0],colore[2][1],colore[2][2]);
     if(checked)
     {   
       strokeWeight(sizeY/5);   
       strokeJoin(ROUND);
       beginShape();
       vertex(posX + 0.15*sizeX, posY + sizeY/2);
       vertex(posX + 0.4 * sizeX, posY + sizeY - 0.1*sizeY);
       vertex(posX + 0.85*sizeX, posY + 0.1 * sizeY);
       endShape();
      }
  }
  
  boolean checke()
  {
    if(mouseX > posX && mouseX < (posX + sizeX) && mouseY > posY && mouseY < (posY + sizeY) )
    {
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         if(!pressd)
         {
            checked = !checked; 
         }
         
         pressd = true;
         
       } else {
         
         
         pressd = false;
       }
        
    }
    return checked;
  }
  
}

class button
{
  int sizeX, sizeY, posX, posY, textSize;
  int colore[][] = new int[3][3];
  String text;
  boolean pressd;
  int srokeSize;
  boolean changeS = true;
  
  button(int posXi,int  posYi,int sizeXi,int sizeYi,int textSizei,String texti)
  {
    posX = posXi;
    posY = posYi;
    sizeX = sizeXi;
    sizeY = sizeYi;
    textSize = textSizei;
    text = texti;
    
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
    if(!pressd)
    {
      stroke(colore[1][0],colore[1][1],colore[1][2]);
      fill(colore[0][0],colore[0][1],colore[0][2]);
    }else
    {
      stroke(colore[1][0]*0.8f,colore[1][1]*0.8f,colore[1][2]*0.8f);
      fill(colore[0][0]*0.8f,colore[0][1]*0.8f,colore[0][2]*0.8f);
    }
    if(changeS)
     srokeSize = sizeY/10;
      strokeWeight(srokeSize);
      strokeJoin(BEVEL);
      rect(posX, posY, sizeX, sizeY);
      fill(colore[2][0],colore[2][1],colore[2][2]);
      textAlign(CENTER, CENTER);
      PFont myfont = createFont("ARLRDBD.TTF", textSize);
      textFont(myFont);
      text(text, posX + (sizeX/2), posY + (sizeY/2) - (sizeY/9));
    
  }
  
  boolean presd()
  {
    if(mouseX > posX && mouseX < (posX + sizeX) && mouseY > posY && mouseY < (posY + sizeY) )
    {
      cursor(HAND);
      hand = true;
       if (mousePressed) {
         
         
         pressd = true;
         return true;
         
       } else {
         
         
         pressd = false;
         return false;
       }
        
    } else {
      
      pressd = false;
      return false;
      
    }
    
  }
  
}

class slider
{
  int size,cirkSize, posX, posY, maxVal=100, minVal = 0,lastX;
  float value;
  boolean lastPres = false;
  int colore[][] = new int[3][3];
  int moveMulti = 2;
  
  slider(int sizei, int cirkSizei,int posXi,int posYi,int valuei, int minVali,int maxVali)
  {
    size = sizei;
    cirkSize = cirkSizei;
    posX = posXi;
    posY = posYi;
    value = valuei;
    maxVal = maxVali;
    minVal = minVali;
  }
  
  void setColors(int L1, int L2, int L3, int F1, int F2, int F3, int R1, int R2, int R3)
  {
    colore[0][0] = L1;
    colore[0][1] = L2;
    colore[0][2] = L3;
    colore[1][0] = F1;
    colore[1][1] = F2;
    colore[1][2] = F3;
    colore[2][0] = R1;
    colore[2][1] = R2;
    colore[2][2] = R3;
  }
  
  void render()
  {
    strokeWeight(cirkSize/10);
    strokeJoin(BEVEL);
    stroke(colore[0][0],colore[0][1],colore[0][2]);
    line(posX - cirkSize/2, posY, posX + cirkSize/2 + size, posY);
    line(posX - cirkSize/2, posY - (cirkSize/4), posX - cirkSize/2, posY + (cirkSize/4));
    line(posX + cirkSize/2 + size, posY - (cirkSize/4), posX + cirkSize/2 + size, posY + (cirkSize/4));
    stroke(colore[2][0],colore[2][1],colore[2][2]);
    fill(colore[1][0],colore[1][1],colore[1][2]);
    ellipseMode(CENTER);
    ellipse(posX + map(value,minVal,maxVal,0,size), posY, cirkSize, cirkSize);
  }
  
  int returnValue()
  {
    if (mouseX > (posX /*+ map(value,minVal,maxVal,0,size) - (cirkSize)*/) && mouseX < (posX + size/*+ map(value,minVal,maxVal,0,size) + (cirkSize)*/) && mouseY > (posY - (cirkSize)) && mouseY < (posY + (cirkSize)) )
    {
      cursor(HAND);
      hand = true;
      if (mousePressed)
      {
        if(lastPres)
        {
          float valueB = value;
          valueB = value + float(moveMulti)*float(mouseX - lastX)*float(maxVal-minVal)/float(size);
          
          if(valueB < minVal)
          {
            valueB = minVal;
          }else if(valueB > maxVal)
          {
            valueB = maxVal; 
          }
          value = valueB;
        
        }
        lastX = mouseX;
        lastPres = true;
      }else
      {
        lastPres = false;
      }
    }else
    {
      if(lastPres && mousePressed)
      {
        lastPres = true;
      }
    }
    int returnVal = round(value);
    return returnVal;
  }
  
}

boolean keyz[] = new boolean[17];

void keyPressed() {
  if (key == 'W' || key == 'w')  {keyz[0] = true; keyz[1] = false; keyz[2] = false; keyz[3] = false;}
  if (key == 'S' || key == 's')  {keyz[0] = false; keyz[1] = true; keyz[2] = false; keyz[3] = false;}
  if (key == 'A' || key == 'a')  {keyz[0] = false; keyz[1] = false; keyz[2] = true; keyz[3] = false;}
  if (key == 'D' || key == 'd')  {keyz[0] = false; keyz[1] = false; keyz[2] = false; keyz[3] = true;}
  if (key == '8')  {keyz[4] = true; keyz[5] = false; keyz[6] = false; keyz[7] = false;}
  if (key == '5')  {keyz[4] = false; keyz[5] = true; keyz[6] = false; keyz[7] = false;}
  if (key == '4')  {keyz[4] = false; keyz[5] = false; keyz[6] = true; keyz[7] = false;}
  if (key == '6')  {keyz[4] = false; keyz[5] = false; keyz[6] = false; keyz[7] = true;}
  if (key == 'u' || key == 'U')  {keyz[8] = true; keyz[9] = false; keyz[10] = false; keyz[11] = false;}
  if (key == 'j' || key == 'J')  {keyz[8] = false; keyz[9] = true; keyz[10] = false; keyz[11] = false;}
  if (key == 'h' || key == 'H')  {keyz[8] = false; keyz[9] = false; keyz[10] = true; keyz[11] = false;}
  if (key == 'k' || key == 'K')  {keyz[8] = false; keyz[9] = false; keyz[10] = false; keyz[11] = true;}
  if (keyCode == UP)  {keyz[12] = true; keyz[13] = false; keyz[14] = false; keyz[15] = false;}
  if (keyCode == DOWN)  {keyz[12] = false; keyz[13] = true; keyz[14] = false; keyz[15] = false;}
  if (keyCode == LEFT)  {keyz[12] = false; keyz[13] = false; keyz[14] = true; keyz[15] = false;}
  if (keyCode == RIGHT)  {keyz[12] = false; keyz[13] = false; keyz[14] = false; keyz[15] = true;}
  if (key == ENTER || key == RETURN) {keyz[16] = true;}
}

void keyReleased() {
  /*if (key == 'W' || key == 'w')  {keyz[0] = false; keyz[1] = false; keyz[2] = false; keyz[3] = false;}
  if (key == 'S' || key == 's')  {keyz[0] = false; keyz[1] = false; keyz[2] = false; keyz[3] = false;}
  if (key == 'A' || key == 'a')  {keyz[0] = false; keyz[1] = false; keyz[2] = false; keyz[3] = false;}
  if (key == 'D' || key == 'd')  {keyz[0] = false; keyz[1] = false; keyz[2] = false; keyz[3] = false;}
  if (key == '8')  {keyz[4] = false; keyz[5] = false; keyz[6] = false; keyz[7] = false;}
  if (key == '5')  {keyz[4] = false; keyz[5] = false; keyz[6] = false; keyz[7] = false;}
  if (key == '4')  {keyz[4] = false; keyz[5] = false; keyz[6] = false; keyz[7] = false;}
  if (key == '6')  {keyz[4] = false; keyz[5] = false; keyz[6] = false; keyz[7] = false;}
  if (key == 'u' || key == 'U')  {keyz[8] = false; keyz[9] = false; keyz[10] = false; keyz[11] = false;}
  if (key == 'j' || key == 'J')  {keyz[8] = false; keyz[9] = false; keyz[10] = false; keyz[11] = false;}
  if (key == 'h' || key == 'H')  {keyz[8] = false; keyz[9] = false; keyz[10] = false; keyz[11] = false;}
  if (key == 'k' || key == 'K')  {keyz[8] = false; keyz[9] = false; keyz[10] = false; keyz[11] = false;}
  if (keyCode == UP)  {keyz[12] = false; keyz[13] = false; keyz[14] = false; keyz[15] = false;}
  if (keyCode == DOWN)  {keyz[12] = false; keyz[13] = false; keyz[14] = false; keyz[15] = false;}
  if (keyCode == LEFT)  {keyz[12] = false; keyz[13] = false; keyz[14] = false; keyz[15] = false;}
  if (keyCode == RIGHT)  {keyz[12] = false; keyz[13] = false; keyz[14] = false; keyz[15] = false;}*/
  if (key == ENTER || key == RETURN) {keyz[16] = false;}
}
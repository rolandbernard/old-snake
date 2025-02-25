import java.util.ArrayList;

boolean hand = false;

game m_game;
boolean ingame = false;
boolean gameOver = false;
boolean saved = false;
boolean back = true;

layout l_start;
layout l_options;
layout l_mode;
//layout l_conection;
layout l_singleplayer;
layout l_wave;
layout l_aiPlay;
layout l_multiplayer;
PFont font;
textf name;
button nameB;
svgButton home, again;

file options;
file highscore;
file logF;

PShape cwasd;
PShape cupdown;
PShape c8456;
PShape cuhjk;

PImage logo;

int pageAt;

int apple, tilesize, startsize, diff, player, ai;
int cont[] = new int[4];
boolean wall, powerUp, diagonal;

int tempMode;
int waveI = 0;
boolean wave;
long waveText = 0;
int score = 0;

String highscores[] = new String[10];
int highscoreP[] = new int[10];

color c[] = { color(200), color(0) };
color pC[] = new color[21];

int loading = 0;

void settings()
{
  orientation(LANDSCAPE);
  //size(displayWidth,displayHeight);
  size(800,450);
}



private void prepareExitHandler () {

Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {

public void run () {

  System.out.println("SHUTDOWN HOOK");

   ingame = false;
  back = false;
  gameOver = true;

  delay(200);

}

}));

}

void setup()
{
  frameRate(60);
  
  surface.setResizable(false);
  surface.setIcon(loadImage("resources/icon/game/icon32.png"));
  background(0);
  
  prepareExitHandler ();
  
  thread("loadBar");
  
  loading++;
  
  font = createFont("Arial Rounded MT Bold", 0.1 * width);
  
  loading++;
  
  l_start = new layout("resources/game/layouts/start.txt");
  loading++;
  l_options = new layout("resources/game/layouts/options.txt");
  loading++;
  l_mode = new layout("resources/game/layouts/mode.txt");
  loading++;
  //l_conection = new layout("resources/game/layouts/conection.txt");
  l_singleplayer = new layout("resources/game/layouts/singleplayerPc.txt");
  loading++;
  l_aiPlay = new layout("resources/game/layouts/aiPlay.txt");
  loading++;
  l_wave = new layout("resources/game/layouts/wave.txt");
  loading++;
  l_multiplayer = new layout("resources/game/layouts/multiplayerPc.txt");
  loading++;
   
  options = new file(dataPath("") + "/saveData/options.dat");
  highscore = new file(dataPath("") + "/saveData/highscore.dat");
  logF = new file(dataPath("") + "/saveData/log.dat");
  
  loading++;
  
  cwasd = loadShape("resources/game/grafiks/wasd.svg");
  loading++;
  cupdown = loadShape("resources/game/grafiks/upleftdownright.svg");
  loading++;
  c8456 = loadShape("resources/game/grafiks/8456.svg");
  loading++;
  cuhjk = loadShape("resources/game/grafiks/uhjk.svg");
  
  color tct[] = {color(255,0),color(255,0)};
  home = new svgButton("resources/game/grafiks/home.svg",0.305,0.680,0.09,0.09,2,tct);
  again = new svgButton("resources/game/grafiks/again.svg",0.695,0.680,0.09,0.09,3,tct);
  
  color [] colF = { color(220), color(55)};
  int [][] colB = {{200,200,200}, {55,55,55}, {0,0,0}};
  name = new textf(0.36, 0.6, 0.2, 0.05, 0.025, colF);
  nameB = new button(0.57,0.6,0.08,0.05,0.025,"Save", colB);
  
  String input = options.readLn();
  
  if(input == null || input == "")
  {
    apple = 5;
    tilesize = min( height, width ) / 40;
    startsize = 5;
    diff = 2;
    player = 2;
    ai = 2;
    cont[0] = 0;
    cont[1] = 1;
    cont[2] = 2;
    cont[3] = 3;
    pC[0] = #13BF7E;
    pC[1] = #43BF13;
    pC[2] = #E0FC0F;
    pC[3] = #4808FC;
    for(int i = 4; i < 21; i++)
    {
      pC[i] = #ED1616;
    }
    wall = true;
    powerUp = false;
    diagonal = false;
    writeOptions();
  }
  else
  {
    String list[] = split(input,'|');
    apple = int(list[0]);
    tilesize = int(list[1]);
    startsize = int(list[2]);
    diff = int(list[3]);
    player = int(list[4]);
    ai = int(list[5]);
    cont[0] = int(list[6]);
    cont[1] = int(list[7]);
    cont[2] = int(list[8]);
    cont[3] = int(list[9]);
    pC[0] = int(list[10]);
    pC[1] = int(list[11]);
    pC[2] = int(list[12]);
    pC[3] = int(list[13]);
    for(int i = 4; i < 21; i++)
    {
      pC[i] = int(list[14]);
    }
    wall = boolean( int(list[15]));
    powerUp = boolean( int(list[16]));
    diagonal = boolean( int(list[17]));
  }
  
  loading++;
  
  input = highscore.readLn();
  
  if(input == null || input == "")
  {
    for(int i = 0; i < 10; i++)
    {
      highscores[i] = "---";
      highscoreP[i] = 0;
    }
    writeHighscore();
  }
  else
  {
    String list[] = split(input,'|');
    for(int i = 0; i < 10; i++)
    {
      highscores[i] = list[2*i];
      highscoreP[i] = int(list[2*i + 1]);
    }
  }
  
  loading++;
  
  writeOptions(); pageAt =  0;
  
  m_game = new game(0,0,1,1,c);
  ingame = true;
  
  m_game.startGame(5, 1, 4, 5, 10,3, false, true, false, false, pC);

  loading++;
    
  thread("gameAi");
  thread("gameMove");
  thread("gameInput");
  thread("backgroundCheck");
  
  surface.setResizable(true);
}

void loadBar()
{
  while(loading < 153)
  {
    rect(0.1*width, 0.475*height, 0.8 * width / 153 * loading, 0.05 * height);
  }
}

void draw()
{
  if(!hand)
    cursor(ARROW);
  else
    hand = false;
  
  m_game.render();
  
  if(pageAt != 8)
  {
    fill(0,120);
    rect(0,0,width,height);
  }
  
  switch(pageAt)
  {
    case 0:
      l_start.render();
    break;
    case 1:
      fill(c[0]);
      stroke(55);
      rect(0.05*width,0.05*height,0.4*width,0.3*height);
      l_options.render();
      textFont(l_options.m_text[0].font);
      textAlign(RIGHT,CENTER);
      text(l_options.sliderValue[3],0.3 * width, 0.4 * height - l_options.m_text[0].size * width * 0.115);
      text(l_options.sliderValue[4],0.3 * width, 0.5 * height - l_options.m_text[0].size * width * 0.115);
      text(l_options.sliderValue[5],0.3 * width, 0.6 * height - l_options.m_text[0].size * width * 0.115);
    break;
    case 2:
      l_mode.render();
    break;
    //case 3:
    //  l_conection.render();
    //  stroke(230,220);
    //  strokeWeight( 0.01333 * height);
    //  fill(230,220);
    //  rect(0.3666*width,0.3*height,0.2666*width,0.2666*width);
    //  rect(0.6832*width,0.3*height,0.2666*width,0.2666*width);
    //break;
    case 4:
      l_singleplayer.render();
      fill(pC[0]);
      stroke(55);
      rect(0.075*width,0.125*height,0.2*width,0.25*height);
      
      for(int i = 0; i < 10; i++)
      {
        fill(55);
        textAlign(RIGHT,CENTER);
        text(i+1,0.685*width, (0.22+0.05*i)*height);
        textAlign(LEFT,CENTER);
        text(".",0.685*width, (0.22+0.05*i)*height);
        textAlign(RIGHT,CENTER);
        text(highscores[i],0.83*width, (0.22+0.05*i)*height);
        textAlign(LEFT,CENTER);
        text(highscoreP[i],0.85*width, (0.22+0.05*i)*height);
      }
      
      switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 1:
              shape(cupdown, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 2:
              shape(c8456, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 3:
              shape(cuhjk, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
          }
          
        l_singleplayer.m_selection[0].render();
    break;
    case 5:
      l_wave.render();
      fill(pC[0]);
      stroke(55);
      rect(0.075*width,0.125*height,0.2*width,0.25*height);
      
      fill(pC[4]);
      rect(0.675*width,0.095*height,0.25*width,0.20*height);
      
      switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 1:
              shape(cupdown, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 2:
              shape(c8456, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
            case 3:
              shape(cuhjk, 0.275*width - 0.125*height,0.5*height,0.3*height,0.3*height);
            break;
          }
          
        l_wave.m_selection[0].render();
      
      
    break;
    case 6:
      l_aiPlay.render();
      fill(pC[0]);
      stroke(55);
      rect(0.075*width,0.125*height,0.2*width,0.25*height);
      
      fill(pC[4]);
      rect(0.675*width,0.145*height,0.25*width,0.20*height);
      
      switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.275*width - 0.125*height,0.525*height,0.3*height,0.3*height);
            break;
            case 1:
              shape(cupdown, 0.275*width - 0.125*height,0.525*height,0.3*height,0.3*height);
            break;
            case 2:
              shape(c8456, 0.275*width - 0.125*height,0.525*height,0.3*height,0.3*height);
            break;
            case 3:
              shape(cuhjk, 0.275*width - 0.125*height,0.525*height,0.3*height,0.3*height);
            break;
          }
          
        l_aiPlay.m_selection[0].render();
      
      textFont(l_aiPlay.m_text[1].font);
      fill(0);
      textAlign(CENTER,CENTER);
      text( Integer.toString(ai), 0.3 * width, 0.05 * height - l_aiPlay.m_text[0].size * width * 0.115);
      
    break;
    case 7:
      l_multiplayer.render();
      
      switch(player)
      {
        case 2:
          fill(pC[0]);
          rect(0.07*width,0.2*height,0.175*width,0.15*height);
          
          fill(pC[1]);
          rect(0.52*width,0.2*height,0.175*width,0.15*height);
          
          switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.275*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 1:
              shape(cupdown, 0.275*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 2:
              shape(c8456, 0.275*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 3:
              shape(cuhjk, 0.275*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[0].m_selection[0].render();
          
          
          
          switch(cont[1])
          {
            case 0:
              shape(cwasd, 0.725*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 1:
              shape(cupdown, 0.725*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 2:
              shape(c8456, 0.725*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
            case 3:
              shape(cuhjk, 0.725*width - 0.125*height,0.435*height,0.25*height,0.25*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[1].m_selection[0].render();
          
          
        break;
        case 3:
        
          fill(pC[0]);
          rect(0.07*width,0.2*height,0.1*width,0.15*height);
          
          fill(pC[1]);
          rect(0.37*width,0.2*height,0.1*width,0.15*height);
          
          fill(pC[2]);
          rect(0.673*width,0.2*height,0.1*width,0.15*height);
          
          
          switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.195*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.195*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.195*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.195*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[2].m_selection[0].render();
          
          switch(cont[1])
          {
            case 0:
              shape(cwasd, 0.495*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.495*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.495*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.495*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[3].m_selection[0].render();
          
          switch(cont[2])
          {
            case 0:
              shape(cwasd, 0.7953*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.7953*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.7953*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.7953*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[4].m_selection[0].render();
        
        break;
        case 4:
        
          fill(pC[0]);
          rect(0.07*width,0.2*height,0.06*width,0.15*height);
          
          fill(pC[1]);
          rect(0.295*width,0.2*height,0.06*width,0.15*height);
          
          fill(pC[2]);
          rect(0.525*width,0.2*height,0.06*width,0.15*height);
          
          fill(pC[3]);
          rect(0.75*width,0.2*height,0.06*width,0.15*height);
        
         switch(cont[0])
          {
            case 0:
              shape(cwasd, 0.155*width - 0.1*height,0.455*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.155*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.155*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.155*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[5].m_selection[0].render();
          
          switch(cont[1])
          {
            case 0:
              shape(cwasd, 0.375*width - 0.1*height,0.455*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.375*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.375*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.375*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[6].m_selection[0].render();
          
          switch(cont[2])
          {
            case 0:
              shape(cwasd, 0.61*width - 0.1*height,0.455*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.61*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.61*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.61*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[7].m_selection[0].render();
          
          switch(cont[3])
          {
            case 0:
              shape(cwasd, 0.835*width - 0.1*height,0.455*height,0.2*height,0.2*height);
            break;
            case 1:
              shape(cupdown, 0.835*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 2:
              shape(c8456, 0.835*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
            case 3:
              shape(cuhjk, 0.835*width - 0.1*height,0.45*height,0.2*height,0.2*height);
            break;
          }
          l_multiplayer.m_layoutArray[0].lays[8].m_selection[0].render();
          
          
        break;
      }
      
      fill(pC[4]);
      rect(0.075*width,0.725*height,0.2*width,0.15*height);
      
      textFont(l_multiplayer.m_text[0].font);
      fill(0);
      textAlign(CENTER,CENTER);
      text( Integer.toString(player), 0.3 * width, 0.05 * height - l_multiplayer.m_text[0].size * width * 0.115);
      text( Integer.toString(ai), 0.3 * width, 0.1 * height - l_multiplayer.m_text[0].size * width * 0.115);
      
    break;
    case 8:
    
    if(!ingame)
    {
      background(0);
    }
    
    if(!gameOver)
    {
      hand = true;
      noCursor();
      
      
      if(millis() - waveText < 1000)
      {
       textAlign(CENTER,CENTER);
       fill(#06D170);
       textFont(font);
       text("Wave " + Integer.toString(waveI), width/2, height/2);
      }
    }
    else
    {
   
    
    if(gameOver && tempMode == 0)
    {
      fill(240);
      stroke(55);
      rect(0.3 * width, 0.425 * height, 0.4 * width, 0.35 * height); 
      name.render();
      nameB.render();
      home.render();
      again.render();
      textFont(createFont("Arial Rounded MT Bold", width * 0.15));
      textAlign(CENTER, CENTER);
      fill(55);
      text("GAME OVER", 0.5 * width, 0.13 * height);
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(createFont("Arial Rounded MT Bold", width * 0.03));
      text("Score: " + Integer.toString(score), 0.5 * width, 0.5 * height);
    }
    
    if(gameOver && tempMode == 2)
    {
      fill(240);
      stroke(55);
      rect(0.3 * width, 0.525 * height, 0.4 * width, 0.25 * height); 
      home.render();
      again.render();
      textFont(createFont("Arial Rounded MT Bold", width * 0.15));
      textAlign(CENTER, CENTER);
      fill(55);
      text("GAME OVER", 0.5 * width, 0.13 * height);
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(createFont("Arial Rounded MT Bold", width * 0.03));
      if(m_game.playerLeft[0])
        text("You won!", 0.5 * width, 0.6 * height);
      else
        text("You lost!", 0.5 * width, 0.6 * height);
    }
    
    if(gameOver && tempMode == 1)
    {
      fill(240);
      stroke(55);
      rect(0.3 * width, 0.425 * height, 0.4 * width, 0.35 * height); 
      home.render();
      again.render();
      textFont(createFont("Arial Rounded MT Bold", width * 0.15));
      textAlign(CENTER, CENTER);
      fill(55);
      text("GAME OVER", 0.5 * width, 0.13 * height);
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(createFont("Arial Rounded MT Bold", width * 0.03));
      text("You got to:", 0.5 * width, 0.5 * height);
      textFont(createFont("Arial Rounded MT Bold", width * 0.04));
      text("Wave: " + Integer.toString(waveI), 0.5 * width, 0.6 * height);
    }
    
    if(gameOver && tempMode == 3)
    {
      fill(240);
      stroke(55);
      rect(0.3 * width, 0.425 * height, 0.4 * width, 0.35 * height); 
      home.render();
      again.render();
      textFont(createFont("Arial Rounded MT Bold", width * 0.15));
      textAlign(CENTER, CENTER);
      fill(55);
      text("GAME OVER", 0.5 * width, 0.13 * height);
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(createFont("Arial Rounded MT Bold", width * 0.03));
      if(m_game.winning() && m_game.winner() < player)
      {
        text("Player " + Integer.toString(m_game.winner()) + " won!", 0.5 * width, 0.475 * height);
        fill(m_game.pColor[m_game.winner()]);
        rect(0.3125 * width, 0.55 * height, 0.375 * width, 0.1 * height);
      }
      else
        text("You lost!", 0.5 * width, 0.5 * height);
    
    }
    }
    
    break;
  }
  //backgroundCheck();
  
    if(keyz[17])
    {
      println(frameRate);
    }
}

long lll = 0;

void backgroundCheck()
{
  
  
  
  while(back)
  {
    
    
    gameMove();
    
    if(millis() - lll > 300)
    switch(pageAt)
    {
      case 0:
        switch(l_start.returnSvgButton())
        {
          case 1:
          
            writeOptions(); pageAt =  2;
            delay(200);
          break;
          case 2:
          
           l_multiplayer.m_slider[0].value = red(pC[4]);
           l_multiplayer.m_slider[1].value = green(pC[4]);
           l_multiplayer.m_slider[2].value = blue(pC[4]);
           l_multiplayer.m_slider[3].value = player;
           l_multiplayer.m_slider[4].value = ai;
           l_multiplayer.m_selection[0].index = diff;
           l_multiplayer.m_layoutArray[0].amount = player;
           
           //*****************
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_selection[0].index = cont[1];
           //*****************
           
           //*****************
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_selection[0].index = cont[2];
           //*****************
           
           //*****************
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_selection[0].index = cont[2];
           
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[0].value = red(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[1].value = green(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[2].value = blue(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_selection[0].index = cont[3];
           //*****************
          
            writeOptions(); pageAt =  7;
            delay(200);
          break;
          case 3:
            l_options.m_slider[0].value = red(c[0]);
            l_options.m_slider[1].value = green(c[0]);
            l_options.m_slider[2].value = blue(c[0]);
            l_options.m_slider[3].value = apple;
            l_options.m_slider[4].value = startsize;
            l_options.m_slider[5].value = tilesize;
            l_options.m_checkbox[0].checked = wall;
            l_options.m_checkbox[1].checked = powerUp;
            l_options.m_checkbox[2].checked = diagonal;
            writeOptions(); pageAt =  1;
            delay(200);
          break;
        }
        l_start.checkStats();
      break;
      case 1:
       switch(l_options.returnSvgButton())
       {
         case 1:
           writeOptions(); pageAt =  0;
            delay(200);
         break;
       }
       l_options.checkStats();
       c[0] = color(l_options.sliderValue[0], l_options.sliderValue[1], l_options.sliderValue[2]);
       apple = l_options.sliderValue[3];
       startsize = l_options.sliderValue[4];
       tilesize = l_options.sliderValue[5];
       wall = l_options.checkBoxStat[0];
       powerUp = l_options.checkBoxStat[1];
       diagonal = l_options.checkBoxStat[2];
      break;
      case 2:
       switch(l_mode.returnSvgButton())
       {
         case 1:
           l_singleplayer.m_slider[0].value = red(pC[0]);
           l_singleplayer.m_slider[1].value = green(pC[0]);
           l_singleplayer.m_slider[2].value = blue(pC[0]);
           l_singleplayer.m_selection[0].index = cont[0];
           writeOptions(); pageAt =  4;
            delay(200);
         break;
         case 2:
           l_aiPlay.m_slider[0].value = red(pC[0]);
           l_aiPlay.m_slider[1].value = green(pC[0]);
           l_aiPlay.m_slider[2].value = blue(pC[0]);
           l_aiPlay.m_slider[3].value = red(pC[4]);
           l_aiPlay.m_slider[4].value = green(pC[4]);
           l_aiPlay.m_slider[5].value = blue(pC[4]);
             
           if(ai <= 0)
             l_aiPlay.m_slider[6].value = 1;
           else
             l_aiPlay.m_slider[6].value = ai;
             
           l_aiPlay.m_selection[0].index = cont[0];
           l_aiPlay.m_selection[1].index = diff;
           writeOptions(); pageAt =  6;
            delay(200);
         break;
         case 3:
           l_wave.m_slider[0].value = red(pC[0]);
           l_wave.m_slider[1].value = green(pC[0]);
           l_wave.m_slider[2].value = blue(pC[0]);
           l_wave.m_slider[3].value = red(pC[4]);
           l_wave.m_slider[4].value = green(pC[4]);
           l_wave.m_slider[5].value = blue(pC[4]);
           l_wave.m_selection[0].index = cont[0];
           l_wave.m_selection[1].index = diff;
           writeOptions(); pageAt =  5;
            delay(200);
         break;
         case 4:
           writeOptions(); pageAt =  0;
            delay(200);
         break;
       }
       l_mode.checkStats();
      break;
      //case 3:
      // if(l_conection.m_svgButton[0].pressd())
      //   writeOptions(); pageAt =  7;
      // if(l_conection.m_svgButton[3].pressd())
      //   writeOptions(); pageAt =  0;
      //   
      // l_conection.checkStats();
      //break;
      case 4:
       switch(l_singleplayer.returnSvgButton())
       {
         case 1:
           writeOptions(); pageAt =  2;
           writeOptions();
           delay(200);
         break;
         case 2:
           tempMode = 0;
           writeOptions(); pageAt =  8;
           gameOver = false;
           writeOptions();
           ingame = false;
           m_game.startGame(apple, 1, 0, startsize, tilesize, diff, wall, powerUp, diagonal, false, colorSet(1));
           ingame = true;
           thread("gameAi");
          thread("gameMove");
           thread("gameInput");
         break;
       }
         
       l_singleplayer.checkStats();
       
       pC[0] = color(l_singleplayer.sliderValue[0], l_singleplayer.sliderValue[1], l_singleplayer.sliderValue[2]);
       cont[0] = l_singleplayer.selectionIndex[0];
       
      break;
      case 5:
       switch(l_wave.returnSvgButton())
       {
         case 1:
           writeOptions(); pageAt =  2;
           writeOptions();
            delay(200);
         break;
         case 2:
           tempMode = 1;
           writeOptions(); pageAt =  8;
           gameOver = false;
           writeOptions();
           ingame = false;
           waveI = 0;
           m_game.startGame(apple, 1, 0, startsize, tilesize, diff, wall, powerUp, diagonal, true, colorSet(1));
           ingame = true;
           thread("gameAi");
           thread("gameMove");
           thread("gameInput");
         break;
       }
       
       pC[0] = color(l_wave.sliderValue[0], l_wave.sliderValue[1], l_wave.sliderValue[2]);
       pC[4] = color(l_wave.sliderValue[3], l_wave.sliderValue[4], l_wave.sliderValue[5]);
       
       cont[0] = l_wave.selectionIndex[0];
       diff = l_wave.selectionIndex[1];
       
       l_wave.checkStats();
      break;
      case 6:
       switch(l_aiPlay.returnSvgButton())
       {
         case 1:
           writeOptions(); pageAt =  2;
           writeOptions();
            delay(200);
         break;
         case 2:
           tempMode = 2;
           writeOptions(); pageAt =  8;
           gameOver = false;
           writeOptions();
           ingame = false;
           m_game.startGame(apple, 1, ai, startsize, tilesize, diff, wall, powerUp, diagonal, false, colorSet(1));
           ingame = true;
           thread("gameAi");
           thread("gameMove");
           thread("gameInput");
         break;
       }
       
       pC[0] = color(l_aiPlay.sliderValue[0], l_aiPlay.sliderValue[1], l_aiPlay.sliderValue[2]);
       pC[4] = color(l_aiPlay.sliderValue[3], l_aiPlay.sliderValue[4], l_aiPlay.sliderValue[5]);
       ai = l_aiPlay.sliderValue[6];
       
       cont[0] = l_aiPlay.selectionIndex[0];
       diff = l_aiPlay.selectionIndex[1];
       
       l_aiPlay.checkStats();
      break;
      case 7:
       switch(l_multiplayer.returnSvgButton())
       {
         case 1:
           writeOptions(); pageAt =  0;
           writeOptions();
            delay(200);
         break;
         case 2:
           tempMode = 3;
           writeOptions(); pageAt =  8;
           gameOver = false;
           writeOptions();
           ingame = false;
           m_game.startGame(apple, player, ai, startsize, tilesize, diff, wall, powerUp, diagonal, false, colorSet(player));
           ingame = true;
           thread("gameAi");
           thread("gameMove");
           thread("gameInput");
         break;
       }
       checkArray();
       l_multiplayer.checkStats();
      break;
      case 8:
      
      if(tempMode == 1)
      {
         if(m_game.winning() && m_game.playerLeft[0])
        {
          waveText = millis();
          waveI++;
          m_game.wave(waveI);
        }
      }
      
      boolean tempLeft = false;
      for(int i = 0; i < m_game.player; i++)
      {
        if(m_game.playerLeft[i])
          tempLeft = true;
      }
      if((!tempLeft || (m_game.winning() && tempMode != 0) ) && !gameOver )
      {
        saved = false;
        for(int i = 0; i < 52; i++)
        {
          keyt[i] = false;
          keytr[i] = false;
        }
        gameOver = true;
        score = m_game.eaten;
      }
      if(gameOver)
      {
        if(tempMode == 0)
        {
          name.input();
          if(nameB.presd() && !saved)
          {
            saved = true;
            for(int i = 0; i < 10; i++)
            {
              if(score > highscoreP[i])
              {
                for(int i2 = i; i2 < 9; i2++)
                {
                  highscoreP[i2+1] = highscoreP[i2];
                  highscores[i2+1] = highscores[i2];
                }
                highscoreP[i] = score;
                highscores[i] = name.text;
                break;
              }
            }
            writeHighscore();
          }
        }
        if(home.pressd())
        {
          ingame = false;
          
          m_game.startGame(5, 0, 4, 5, 10,3, false, true, true, false, pC);

          ingame = true;
          
          thread("gameAi");
          
          pageAt = 0;
          
          
          saved = false;
        }
        if(again.pressd())
        {
          waveI = 0;
          gameOver = false;
          if(tempMode == 1)
            m_game.ai = 0;
          m_game.restart();
          saved = false;
          
        }
      }
      
      if(!ingame)
      {
        log("Error: fatal system shutdown.");
      }
      
      break;
    }
    
   
    delay(1);
  }
}

void gameMove()
{
  //while(ingame)
  {
    m_game.travel();
    
    delay(1);
    
    if(!gameOver)
      m_game.colision();
    
  }
}

void gameAi()
{
  while(ingame)
  {
    m_game.aiMove();
    
    
    delay(1);
  }
}

void gameInput()
{
  while(ingame)
  {
    m_game.input();
  }
}

void writeOptions()
{
    options.clearBuffer();
    options.buffer(Integer.toString(apple));
    options.buffer("|");
    options.buffer(Integer.toString(tilesize));
    options.buffer("|");
    options.buffer(Integer.toString(startsize));
    options.buffer("|");
    options.buffer(Integer.toString(diff));
    options.buffer("|");
    options.buffer(Integer.toString(player));
    options.buffer("|");
    options.buffer(Integer.toString(ai));
    options.buffer("|");
    options.buffer(Integer.toString(cont[0]));
    options.buffer("|");
    options.buffer(Integer.toString(cont[1]));
    options.buffer("|");
    options.buffer(Integer.toString(cont[2]));
    options.buffer("|");
    options.buffer(Integer.toString(cont[3]));
    options.buffer("|");
    options.buffer(Integer.toString(pC[0]));
    options.buffer("|");
    options.buffer(Integer.toString(pC[1]));
    options.buffer("|");
    options.buffer(Integer.toString(pC[2]));
    options.buffer("|");
    options.buffer(Integer.toString(pC[3]));
    options.buffer("|");
    options.buffer(Integer.toString(pC[4]));
    options.buffer("|");
    options.buffer(Integer.toString( int(wall)));
    options.buffer("|");
    options.buffer(Integer.toString( int(powerUp)));
    options.buffer("|");
    options.buffer(Integer.toString( int(diagonal)));
    options.writeNew();
}

void writeHighscore()
{
  highscore.clearBuffer();
  for(int i = 0; i < 10; i++)
  {
    highscore.buffer(highscores[i]);
    highscore.buffer("|");
    highscore.buffer(Integer.toString(highscoreP[i]));
    highscore.buffer("|");
  }
  highscore.writeNew();
}

void log(String log)
{
  logF.clearBuffer();
  logF.buffer(Integer.toString(hour()));
  logF.buffer(":");
  logF.buffer(Integer.toString(minute()));
  logF.buffer(":");
  logF.buffer(Integer.toString(second()));
  logF.buffer("  ");
  logF.buffer(Integer.toString(day()));
  logF.buffer(".");
  logF.buffer(Integer.toString(month()));
  logF.buffer(".");
  logF.buffer(Integer.toString(year()));
  logF.buffer(":  ");
  logF.buffer(log);
  logF.buffer("\n");
  logF.writeAdd();
}

void checkArray()
{
  pC[4] = color( l_multiplayer.sliderValue[0], l_multiplayer.sliderValue[1], l_multiplayer.sliderValue[2]);
  player = l_multiplayer.sliderValue[3];
  ai = l_multiplayer.sliderValue[4];
  diff = l_multiplayer.selectionIndex[0];
  l_multiplayer.m_layoutArray[0].amount = player;
  
  switch(player)
    {
      case 2: 
        pC[0] = color( l_multiplayer.m_layoutArray[0].lays[0].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[0].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[0].sliderValue[2]);
        cont[0] = l_multiplayer.m_layoutArray[0].lays[0].selectionIndex[0];
        
        pC[1] = color( l_multiplayer.m_layoutArray[0].lays[1].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[1].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[1].sliderValue[2]);
        cont[1] = l_multiplayer.m_layoutArray[0].lays[1].selectionIndex[0];
        
        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
        
          //*****************
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_selection[0].index = cont[2];
           //*****************
           
           //*****************
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_selection[0].index = cont[2];
           
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[0].value = red(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[1].value = green(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[2].value = blue(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_selection[0].index = cont[3];
           //*****************
        
        
      break;
      case 3:
        pC[0] = color( l_multiplayer.m_layoutArray[0].lays[2].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[2].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[2].sliderValue[2]);
        cont[0] = l_multiplayer.m_layoutArray[0].lays[2].selectionIndex[0];
        
        pC[1] = color( l_multiplayer.m_layoutArray[0].lays[3].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[3].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[3].sliderValue[2]);
        cont[1] = l_multiplayer.m_layoutArray[0].lays[3].selectionIndex[0];
        
        pC[2] = color( l_multiplayer.m_layoutArray[0].lays[4].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[4].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[4].sliderValue[2]);
        cont[2] = l_multiplayer.m_layoutArray[0].lays[4].selectionIndex[0];
        
        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
        
           //*****************
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_selection[0].index = cont[1];
           //*****************
        
           //*****************
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[5].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[6].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[7].m_selection[0].index = cont[2];
           
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[0].value = red(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[1].value = green(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_slider[2].value = blue(pC[3]);
           l_multiplayer.m_layoutArray[0].lays[8].m_selection[0].index = cont[3];
           //*****************
           
      break;
      case 4:
        pC[0] = color( l_multiplayer.m_layoutArray[0].lays[5].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[5].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[5].sliderValue[2]);
        cont[0] = l_multiplayer.m_layoutArray[0].lays[5].selectionIndex[0];
        
        pC[1] = color( l_multiplayer.m_layoutArray[0].lays[6].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[6].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[6].sliderValue[2]);
        cont[1] = l_multiplayer.m_layoutArray[0].lays[6].selectionIndex[0];
        
        pC[2] = color( l_multiplayer.m_layoutArray[0].lays[7].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[7].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[7].sliderValue[2]);
        cont[2] = l_multiplayer.m_layoutArray[0].lays[7].selectionIndex[0];
        
        pC[3] = color( l_multiplayer.m_layoutArray[0].lays[8].sliderValue[0], l_multiplayer.m_layoutArray[0].lays[8].sliderValue[1], l_multiplayer.m_layoutArray[0].lays[8].sliderValue[2]);
        cont[3] = l_multiplayer.m_layoutArray[0].lays[8].selectionIndex[0];
        
        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
        
           //*****************
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[0].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[1].m_selection[0].index = cont[1];
           //*****************
           
           //*****************
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[0].value = red(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[1].value = green(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_slider[2].value = blue(pC[0]);
           l_multiplayer.m_layoutArray[0].lays[2].m_selection[0].index = cont[0];
           
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[0].value = red(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[1].value = green(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_slider[2].value = blue(pC[1]);
           l_multiplayer.m_layoutArray[0].lays[3].m_selection[0].index = cont[1];
           
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[0].value = red(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[1].value = green(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_slider[2].value = blue(pC[2]);
           l_multiplayer.m_layoutArray[0].lays[4].m_selection[0].index = cont[2];
           //*****************
        
        
      break;
    } 
}       

color [] colorSet(int pl)
{
  color temp[] = new color[21];
  for(int i = 0; i < pl; i++)
  {
    temp[i] = pC[i];
  }
  for(int i = pl; i < 21; i++)
  {
    temp[i] = pC[4];
  }
  return temp;
}
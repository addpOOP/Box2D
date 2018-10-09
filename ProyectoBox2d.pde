//Alejandro David Diaz Palafox A1
//Programacion Orientada a Objetos
//144206

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import beads.*;
import processing.sound.*;

Box2DProcessing box2d;
Boundari uno;
Particulas dos;

ArrayList<Boundari> boundaries;
ArrayList<Flipper> flipperr;
ArrayList<Particulas> Particulass;


PImage imagen;
PImage fondo;
PImage slingshoti;
PImage slingshotd;
PImage bumper1;
PImage bumper2;
PImage bumper3;

SoundFile file;

void setup() {
  size(450, 550);
  smooth();
  
  file = new SoundFile(this, "jungla.wav");
  file.loop();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  Particulass = new ArrayList<Particulas>();
  boundaries = new ArrayList<Boundari>();
  flipperr = new ArrayList<Flipper>();

  boundaries.add(new Boundari(70, 400, 100, 10, 30));
  boundaries.add(new Boundari(120, 460, 80, 10, 50));
  boundaries.add(new Boundari(370, 400, 100, 10, 130));
  boundaries.add(new Boundari(310, 460, 80, 10, 60));
  boundaries.add(new Boundari(310, 350, 80, 10, 130));
  boundaries.add(new Boundari(130, 350, 80, 10, 30));
  
    boundaries.add(new Boundari(225, 150, 30, 40, 0));
    boundaries.add(new Boundari(150, 200, 30, 40, 0));
    boundaries.add(new Boundari(300, 200, 30, 40, 0));
    
    
  boundaries.add(new Boundari(width-5, height/2, 10, height, 0));
  boundaries.add(new Boundari(5, height/2, 10, height, 0));

  imagen= loadImage("8.png");
  fondo= loadImage("9.jpg");
  slingshoti= loadImage("1.png");
  slingshotd= loadImage("2.png");
  bumper1= loadImage("5.png");
  bumper2= loadImage("4.png");
  bumper3= loadImage("3.png");
  
  
  addFlippers();
}


void draw() {
  background(255);
  userInput();
  box2d.setGravity(0, -3);
  image(fondo, 0, 0);
  
  drawGame();
  
  pushMatrix();
  noStroke();
  rect(225,600,450,100);
  popMatrix();
  
  pushMatrix();
  fill (random(255), random(0), random(255));
  textSize(14);
  text("press Z for left button",20,30);
  popMatrix();
  
  pushMatrix();
  fill (random(255), random(0), random(255));
  textSize(14);
  text("press M for right button",20,50);
  popMatrix();
  
  pushMatrix();
  translate(115,290);
  rotate(0.3);
  scale(0.04);
  image(slingshoti, 100,200);
  popMatrix();
  
  pushMatrix();
  translate(280,295);
  rotate(0);
  scale(0.04);
  image(slingshotd, 100,200);
  popMatrix();
  
  pushMatrix();
  translate(160,60);
  rotate(0);
  scale(0.3);
  image(bumper1, 100,200);
  popMatrix();
  
  pushMatrix();
  translate(90,110);
  rotate(0);
  scale(0.3);
  image(bumper2, 100,200);
  popMatrix();
  
  pushMatrix();
  translate(240,110);
  rotate(0);
  scale(0.3);
  image(bumper3, 100,200);
  popMatrix();

  if (random(1) < 0.2) {
    float sz = random(4, 8);
    Particulass.add(new Particulas(width/2, -20, sz));
  }

  box2d.step();

  for (int i = Particulass.size()-1; i >= 0; i--) {
    Particulas p = Particulass.get(i);
    p.display();
    if (p.done()) {
      Particulass.remove(i);
    }
  }
}

void drawGame()
{
  box2d.step();

  for (Flipper f : flipperr)
  {
    f.render();
  }
}


void endContact(Contact cp) {
}

void userInput()
{
  if ((keyPressed && (key == 'z' || key == 'Z')))
  {
    for (Flipper f : flipperr)
    {
      f.flip(100000, true);
    }
  }

  if ((keyPressed && (key == 'm' || key == 'M')))
  {
    for (Flipper f : flipperr)
    {
      f.flip(100000, false);
    }
  }
}

void addFlippers()
{
  Flipper flipper = new Flipper(new Vec2( 160, 475), true);
  fill(255);
  flipperr.add(flipper);

  flipper = new Flipper(new Vec2( 270, 475), false);
  fill(255);
  flipperr.add(flipper);
}
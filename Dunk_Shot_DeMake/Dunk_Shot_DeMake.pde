Ball2 ball;
Basket[] basket = new Basket[2];
boolean acertouCesta = false, voltou = false;
float angle;
int[] pointPosition = new int[2];
int pontuation = 0, perfectCount = 0, bounceCount = 0, timer =0;
boolean perfect = true;


PFont atariFont;

void setup() {
  size(540, 960);
  rectMode(CENTER);
  background(0);
  imgBall = loadImage("ball.png");
  atariFont = loadFont("PressStart2P-Regular-48.vlw");
  textFont(atariFont);
  ball = new Ball2();
  for (int i =0; i<2; i++) {
    basket[i] = new Basket(i);
  }
}

void draw() {


  noStroke();
  switch(gameState) {
  case 0:
    background(0);
    menu();
    break;
  case 1:
    background(0);
    game();
    break;
  case 2:
    background(0);
    gameOver();
    break;
  default:
    break;
  }
}

void mouseClicked() {
  switch(gameState) {
  case 0:
    if (mouseX>width/2-200 && mouseX<width/2+200
      && mouseY>height/2-50 && mouseY<height/2+50) {

      gameState = 1;
    }
    break;
  case 1:
    if (ball.rota==0) {
      ball.rota = 1;
    }
    break;
  case 2:

    if ( mouseX>width/2-240 && mouseX<width/2-10
      && mouseY>height/2-50 && mouseY<height/2+50) {
      gameState = 1;
      pontuation = 0;
      perfectCount = 0;
      bounceCount = 0;
    } else if ( mouseX>width/2+10 && mouseX<width/2+240
      && mouseY>height/2-50 && mouseY<height/2+50) {
      gameState = 0;
      pontuation = 0;
      perfectCount = 0;
      bounceCount = 0;
    }
    break;

  default:
    break;
  }
}

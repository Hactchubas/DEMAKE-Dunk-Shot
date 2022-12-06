PImage basketImg;



class Basket {
  float posX;
  float posY;

  Basket(int wich) {
    basketImg = loadImage("basket0.png");
    if (wich == 0) {
      posX = ball.posX;
      posY = ball.posY;
    } else {

      
      posX = random(100, width-100);
      posY = random(200, height -400);
    }
  }

  void display(int wich) {
    if (wich == 0) {
      push();
      translate(posX, posY);
      float angle;
      angle = atan2(mouseY-posY, mouseX-posX);
      //rotate(angle+PI/2);
      noFill();
      stroke(167);
      strokeWeight(5);

      imageMode(CENTER);
      if (angle < -5*PI/9 || angle > 5*PI/9) {
        basketImg = loadImage("basket-1.png");
        image(basketImg, 0, 15);
      } else  if (angle > -4*PI/9 && angle < 4*PI/9) {
        basketImg = loadImage("basket1.png");
        image(basketImg, 0, 15);
      } else {
        basketImg = loadImage("basket0.png");
        image(basketImg, 0, 15);
      }



      pop();
    } else {


      noFill();
      stroke(167);
      strokeWeight(5);
      imageMode(CENTER);
      basketImg = loadImage("basket0.png");
      image(basketImg, posX, posY+20);
    }
  }
}

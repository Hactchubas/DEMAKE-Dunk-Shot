

PImage imgBall;
class Ball2 {

  float posX, posY;
  int rota=0;
  color cor;
  int maxHight;

  PVector location;
  PVector velocity;
  PVector acceleration;

  Ball2() {
    cor = color(255, 170, 0);
    posX = 450;
    posY = height/2+300;
    maxHight = int(posY);
    location = new PVector(posX, posY);
    velocity = new PVector(0, 0);
  }

  void Mirar(boolean acertou) {
    background(0);
    if (!acertou && !voltou) {
      location = new PVector(posX, posY);
      velocity = new PVector(0, 0);
    } else {
      velocity = new PVector(0, 0);
    }
    if (voltou) {
      ball.location.x = basket[0].posX;
      ball.location.y = basket[0].posY;
    }
    PVector mouse = new PVector(mouseX, mouseY);

    velocity = PVector.sub(mouse, location);
    velocity.mult(0.04);
    display();
    trajetoria();
  }

  void trajetoria() {
    perfect = true;
    PVector locationMira = location.copy();
    PVector velocityMira = new PVector(0, 0);
    PVector mouseMira = new PVector(mouseX, mouseY);
    velocityMira = PVector.sub(mouseMira, locationMira);
    velocityMira.mult(0.04);
    for (int i = 1; i < 40; i++) {

      PVector gravityMira = new PVector(locationMira.x, locationMira.y+10);
      PVector accelerationMira = PVector.sub(gravityMira, locationMira);
      
      accelerationMira.setMag(0.5);      
      velocityMira.add(accelerationMira);
      
      if (locationMira.x <= 0 || locationMira.x >= width ) {
        velocityMira.x *= -1;
      }
      locationMira.add(velocityMira);
      if (i%3 == 0) {
        fill(179, 40, 120);
        rect(locationMira.x, locationMira.y, 20-i*3/10, 20-i*3/10);
      }
    }
  }

  boolean Atirar() {
    boolean acertou = false;
    acertou = update();
    if (acertou) {
      pontua();
      maxHight = height/2+300;
      rota = 2;
    }
    display();
    return acertou;
  }
  boolean update() {
    background(0);
    boolean acertou = false;
    println(maxHight);
    if (location.y < maxHight) {
      maxHight = int(location.y);
    }
    Colisao();
    acertou = cesta();
    if (acertou) {
      return acertou;
    }
    outOfBounds();
    
    PVector gravity = new PVector(location.x, location.y+10);
    PVector acceleration = PVector.sub(gravity, location);
    
    acceleration.setMag(0.5);
    velocity.add(acceleration);    
    location.add(velocity);

    return acertou;
  }

  void display() {    
    imageMode(CENTER);
    image(imgBall,location.x,location.y);
  }

  void Colisao() {

    if ( maxHight > basket[1].posY && dist(location.x, location.y, basket[1].posX, basket[1].posY) < 50) {
      checkCollision(new PVector(basket[1].posX, basket[1].posY), 2);
    }
    for (int i =0; i<2; i++) {
      if (i == 1 || maxHight < basket[0].posY-30) {
        if (dist(location.x, location.y, basket[i].posX-30, basket[i].posY) < 20) {
          checkCollision(new PVector(basket[i].posX-30, basket[i].posY), 0);

          perfect = false;
        } else if (dist(location.x, location.y, basket[1].posX+30, basket[1].posY) < 20) {
          checkCollision(new PVector(basket[i].posX+30, basket[i].posY), 1);

          perfect = false;
        }
      }
    }
  }

  boolean cesta() {
    boolean acertou = false;
    if (   location.x > basket[1].posX-30 && location.x < basket[1].posX+30
      && location.y > basket[1].posY    && location.y < basket[1].posY+20
      && maxHight < basket[1].posY) {
      acertou = true;
    } else if (   location.x > basket[0].posX-30 && location.x < basket[0].posX+30
      && location.y > basket[0].posY    && location.y < basket[0].posY+20
      && maxHight < basket[0].posY-20) {
      ball.location.x = basket[0].posX;
      ball.location.y = basket[0].posY;
      rota =0;
      voltou = true;
    }

    return acertou;
  }

  void outOfBounds() {
    if (location.y > height) {
      rota = 0;
      for (int i =0; i<2; i++) {
        basket[i] = new Basket(i);
      }

      gameState = 2;
    }
    if (location.x <= 0 || location.x >= width ) {
      velocity.x *= -1;
      bounceCount++;
    }
  }

  void pontua() {
    if (perfect) {
      perfectCount++;
      pontuation = pontuation + perfectCount + 1;
    } else {
      perfectCount = 0;
      pontuation++;
    }
    pontuation += bounceCount;    
  }


  void checkCollision(PVector quina, int lado) {

    // Get distances between the balls components
    PVector distanceVect = PVector.sub(quina, location);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching

    float minDistance = 15;
    if (lado == 2) {
      minDistance =  60;
    }
   // ellipse(quina.x, quina.y, minDistance, minDistance);

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      quina.add(correctionVector);
      location.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = 0;
      vTemp[1].y  = 0;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate
       the final velocity along the x-axis. */
      PVector[] vFinal = {
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((40 - 20) * vTemp[0].x + 2 * 20 * vTemp[1].x) / (40 + 20);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((20 - 40) * vTemp[1].x + 2 * 40 * vTemp[0].x) / (40 + 20);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = {
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      //// update balls to screen position
      //quina.x = location.x + bFinal[1].x;
      //quina.y = location.y + bFinal[1].y;

      //location.add(bFinal[0]);

      // update velocities
      //velocity.x = (cosine * vFinal[0].x - sine * vFinal[0].y);
      //velocity.y = (cosine * vFinal[0].y + sine * vFinal[0].x);
      velocity.x = 0.8*(cosine * velocity.x - sine * velocity.y);
      velocity.y = 0.8*(cosine * velocity.y + sine * velocity.x);
      velocity.limit(15);
      if (velocity.x < quina.x &&  lado == 0) {
        velocity.mult(-1);
      } else if (lado==2 && ball.location.x > basket[1].posX) {
        velocity.mult(-1);
        velocity.rotate(PI/2);
      }
    }
  }
}

int gameState = 0;

void game() {
  if (ball.rota==0) {
    ball.Mirar(acertouCesta);

    for (int i =0; i<2; i++) {
      basket[i].display(i);
    }
  } else if (ball.rota==1) {
    acertouCesta = ball.Atirar();
    if (acertouCesta) {
      timer = 0;
      pointPosition[0] = int(basket[1].posX);
      pointPosition[1] = int(basket[1].posY);
      basket[0] = basket[1];
    }
    for (int i =0; i<2; i++) {
      basket[i].display(i);
    }
  } else if (ball.rota == 2) {
    basket[0].posY += 10;

    background(0);
    for (int i =0; i<2; i++) {
      ball.location.y = basket[0].posY+5;
      ball.location.x = basket[0].posX;
      ball.display();
      basket[i].display(i);
    }
    if (basket[0].posY  >= height/2+300) {
      basket[1] = new Basket(1);
      bounceCount =0;
      ball.rota = 0;
    }
  }
  angle = atan2(mouseY-basket[0].posY, mouseX-basket[0].posX);

  fill(179, 40, 120);
  textSize(48);
  textAlign(CENTER, TOP);
  text(pontuation, width/2, 10);
  if (perfectCount >0) {
    fill(179, 40, 120);
    textSize(28);
    textAlign(CENTER, TOP);
    text("\nPERFECT STREAK: " +(perfectCount), width/2, 100);
  }
  pointText();
}




void pointText() {

  if (timer < 40 ) {
    if ( perfectCount > 0) {
      
      fill(179, 40, 120);
      textSize(24);
      text("PERFECT +"+perfectCount, pointPosition[0], pointPosition[1]+100);
      
    }
    if (bounceCount > 0) {
      fill(179, 40, 120);
      textSize(24);
      text("BOUNCE", pointPosition[0], pointPosition[1]+50);
    }
    timer++;
  }
}

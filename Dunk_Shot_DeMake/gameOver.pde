

void gameOver() {
  fill(255, 170, 0);
  textSize(48);
  textAlign(CENTER, TOP);
  text("GAME OVER", width/2, 300);
  textSize(32);
  text("SCORE", width/2, height-200);
  text(pontuation, width/2, height-100);

  rectMode(CENTER);
  rect(width/2-125, height/2, 230, 100);
  rect(width/2+125, height/2, 230, 100);
  textSize(24);
  fill(255);
  text("TRY AGAIN", width/2-125, height/2-10);
  text("MAIN MENU", width/2+125, height/2-10);  
}

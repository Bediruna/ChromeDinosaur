void setup(){

  size(500,500);
  
}

double score = 0;

float floorHeight = 430;
  
int playerHeight = 36;
int playerWidth = 40;
float playerX = 100;
float playerY = 400;
float gravity = 3;
int jumpHeight = 125;

float rightAnimate = 0;
float leftAnimate = 0;

float gameSpeed = 5;
float cloudSpeed = gameSpeed / 8;

void drawDino(float x, float y){
  
  noStroke();
  fill(0);
  
  //neck
  rect(x+20, y+2, 8, 26);
  
  //head, topmost part
  rect(x+22, y, 16, 11);
  
  //nose
  rect(x+38, y+2, 2, 9);
  
  //mouth
  rect(x+28, y+11, 2, 2);
  
  //bottom lip
  rect(x+28, y+13, 8, 2);
  
  //arm
  rect(x+28, y+19, 4, 2);
  
  //hand
  rect(x+30, y+21, 2, 2);
  
  //body
  rect(x+18, y+15, 10, 13);
  
  rect(x+15, y+17, 11, 14);
  
  rect(x+12, y+19, 12, 14);
  
  rect(x+10, y+21, 12, 14);
  
  
  //right thigh
  rect(x+18, y+35, 4, 2);
  
  //right leg
  rect(x+20, y+37 -rightAnimate, 2, 6);
  
  //right foot
  rect(x+22, y+41 -rightAnimate, 2, 2);
  
  //Left thigh
  rect(x+10, y+35 -leftAnimate, 6, 2);
  
  //left knee
  rect(x+10, y+37 -leftAnimate, 4, 2);
  
  //left leg
  rect(x+10, y+39 -leftAnimate, 2, 4);
  
  //left foot
  rect(x+12, y+41 -leftAnimate, 2, 2);
  
  //tail
  rect(x+8, y+23, 2, 12);
  
  rect(x+6, y+23, 2, 10);
  
  rect(x+4, y+21, 2, 10);
  
  rect(x+2, y+19, 2, 10);
  
  //End of tail, leftmost part
  rect(x, y+15, 2, 12);
  
  //eye
  fill(255);
  rect(x+24, y+3, 2, 2);
  
  stroke(0);
  fill(0);
  
}

void restartGame(){
  
  gameSpeed = 5;
  gravity = 3;
  jumpHeight = 125;
  score = 0;
  cact1.resetCoords();
  
}

class GroundLine{
  
  float x1 = random(500);
  float y1 = random(432, 497);
  float x2 = x1 + random(2, 15);
  float y2 = y1;
  
  void generateCoords(){
    
    x1 = random(505, 550);
    y1 = random(433, 497);
    x2 = x1 + random(2, 15);
    y2 = y1;
  
  }
  
  void move(){
    strokeWeight(1);
    line(x1, y1, x2, y2);
  
    x1 -= gameSpeed;
    x2 -= gameSpeed;
    
    if(x1 < - 10){
      generateCoords();
    }
    
  }
  
}

class Cloud{
  
  float x = random(50, 500);
  float y = random(50, 130);
  float size = random(50, 70);
  
  
  void resetCoords(){
    
    x = random(550, 700);
    y = random(50, 130);
    size = random(50, 70);
    
  }
  
  void move(){
    
    fill(255);
    //left arc
    arc(x, y, size, size, radians(70), radians(290), OPEN);
    //right arc
    arc(x + 70, y, size, size, radians(250), radians(470), OPEN);
    
    //top arc
    arc(x + 35, y - 2, size + 10, size + 10, radians(217), radians(323), OPEN);
    
    //bottom arc
    arc(x + 35, y + 2, size + 10, size + 10, radians(37), radians(143), OPEN);
    
    x -= cloudSpeed;
    
    if(x < - 150){
      resetCoords();
    }
    
  }
  
}

class Cactus{
  
  float cactusWidth = 23;
  float cactusHeight = 46;
  
  float x =  550;
  float y = floorHeight - cactusHeight + 10;

  float leftArmRaise = 0;
  float rightArmRaise = 0;
  
  void resetCoords(){
    x = random(500, 600);
    y = floorHeight - cactusHeight + random(8, 14);
  
    leftArmRaise = random(-3, 3);
    rightArmRaise = random(-3, 3);
    
  }
  
  void move(){
    
    drawCactus(x, y, leftArmRaise, rightArmRaise);
    
    x -= gameSpeed;
    
    //collision
    if(x < playerX + playerWidth && x + cactusWidth > playerX+10 && playerY + playerHeight > y){
      gameOver();
    }
    
    if(x < 0 - cactusWidth){
      resetCoords();
    }
    
  }
  
  
  void drawCactus(float x, float y, float leftRaise, float rightRaise){
  
    noStroke();
    fill(0);
    
    //left arm
    rect(x+0, y+13 +leftRaise, 5, 14);
    rect(x+1, y+12 +leftRaise, 3, 1);
    rect(x+0, y+26 +leftRaise, 8, 2);
    rect(x+1, y+28 +leftRaise, 7, 1);
    rect(x+2, y+29 +leftRaise, 6, 1);
    rect(x+3, y+30 +leftRaise, 5, 1);
    
    
    //Body
    rect(x+8, y+1, 7, 45);
    rect(x+9, y, 5, 1);
    
    //Right arm
    rect(x+15, y+26 +rightRaise, 4, 4);
    rect(x+19, y+26 +rightRaise, 1, 3);
    rect(x+20, y+26 +rightRaise, 1, 2);
    rect(x+14, y+26 +rightRaise, 1, 1);
    
    rect(x+18, y+11 +rightRaise, 5, 15);
    rect(x+19, y+10 +rightRaise, 3, 1);
    
    stroke(0);
    fill(0);
    
  }
  
}

//Draws score
void count(){
  
  textSize(20);
  text((int)score, 460, 20);
  if(gameSpeed != 0){
    score += (gameSpeed / 8);
  }
  
}

GroundLine gl1= new GroundLine();
GroundLine gl2= new GroundLine();
GroundLine gl3= new GroundLine();
GroundLine gl4= new GroundLine();

Cloud cl1 = new Cloud();
Cloud cl2 = new Cloud();

void backgroundMovement(){
  
  gl1.move();
  gl2.move();
  gl3.move();
  gl4.move();
  
  if(cl1.x < cl2.x + 110 && cl1.x >= cl2.x - 10){
    cl1.resetCoords();
  }else{
    cl1.move();
  }
  
  if(cl2.x < cl1.x + 110 && cl2.x >= cl1.x - 10){
    cl2.resetCoords();
  }else{
    cl2.move();
  }
  
}

Cactus cact1 = new Cactus();

void drawObstacles(){
  cact1.move();
  
}

void playerMovement(){
  
  //Jump
  if(playerY == 400){
    if(keyPressed){
      if(key == 'w' || key == ' ' || keyCode == UP){
        playerY -= jumpHeight;
      }
    }
  }  
  
  //Gravity
  if(playerY < 400){
    playerY += gravity;
  }else{playerY = 400;}
  
  
  if(gameSpeed != 0 && playerY == 400){
    
    //Animate right foot
    if(frameCount % 16 == 1){
      rightAnimate = 3;
      leftAnimate = 0;
    }else if(frameCount % 8 == 1){
      rightAnimate = 0;
      leftAnimate = 3;
    }
        
  }
  
}


void gameOver(){
  gameSpeed = 0;
  gravity = 0;
  jumpHeight = 0;
  
  float resetBoxX = 230;
  float restBoxY = 260;
  
  fill(1);
  textSize(32);
  text("GAME OVER", 155, 240);
  
  //Drawing the reset button
  fill(0);
  rect(resetBoxX, restBoxY, 40, 35, 7);
  stroke(255);
  strokeWeight(4);
  
  line(resetBoxX+10, restBoxY + 25, resetBoxX+30, restBoxY + 25);//bottom line
  
  line(resetBoxX+10, restBoxY + 25, resetBoxX+10, restBoxY + 10);//Left line
  
  line(resetBoxX+30, restBoxY + 25, resetBoxX+30, restBoxY + 10);//right line
  
  line(resetBoxX+10, restBoxY + 10, resetBoxX+15, restBoxY + 10);//top line
  
  triangle(resetBoxX+18, restBoxY + 9, resetBoxX+18, restBoxY + 11, resetBoxX+19, restBoxY + 10);
  
  line(resetBoxX+26, restBoxY + 10, resetBoxX+30, restBoxY + 10);//top line right
  
  stroke(0);
  
  if(keyPressed){
      if(key == ' '){
        restartGame();
      }
    }
    if (mousePressed) {
      restartGame();
    }
  
}

void draw(){
  
  background(255);
  strokeWeight(2);
  
  count();

  line(0, floorHeight, width, floorHeight);//floor line
  backgroundMovement();
  
  drawObstacles();
  
  drawDino(playerX, playerY);
  playerMovement();

  
}

void shapeSketch0() {

}

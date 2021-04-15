import java.util.ArrayList;

PImage frame1, frame2, pieton, pietonConverted;
int redRectBX, redRectBY, redRectEX = 16, redRectEY = 16;
int goalBX, goalBY;
boolean nextFrame = false;
int offset1 = 50, offset2 = 100;
int jason, steven;

ArrayList<Position> elts = new ArrayList<Position>();

/*void mouseClicked(){
  if(redRectBX == -1){
    redRectBX = mouseX;
    redRectBY = mouseY;
  }
  else if(redRectEX == -1){
    redRectEX = mouseX;
    redRectEY = mouseY;
    pieton = frame1.get(redRectBX, redRectBY, redRectEX-redRectBX, redRectEY-redRectBY);
    goalBX = redRectBX-offset1;
    goalBY = redRectBY-offset1;
    findPieton(frame2.get(redRectBX-offset1, redRectBY-offset2, redRectEX-redRectBX+offset2, redRectEY-redRectBY+offset2), pieton);
  }
}*/

/*int luminance(color pixel){
  int R, G, B;
  R = (int) red(pixel);
  G = (int) green(pixel);
  B = (int) blue(pixel);
  
  float option;
  option = (0.299*R + 0.587*G + 0.114*B);
  //option = 16 + (0.299*R) + (0.587*G) + (0.114*B);
  return (int) Math.floor(option);
}*/

int luminance(color pixel){
  return (int) (red(pixel)+green(pixel)+blue(pixel))/3;
}

void findPieton(PImage source, PImage pieton){
  int diff, value, oldValue;
  int indexX=0, indexY=0;
  PImage sourceTemp;
  int yes = 16*16;
  oldValue = -1;
  for(int i=0; i<1080; i+=8){
    for(int j=0; j<1920; j+=8){
      sourceTemp = source.get(j, i, 16, 16); //<>//
      value = 0;
      for(int k=0; k < yes; k+=4){
        //diff = luminance(sourceTemp.pixels[k]) - luminance(pieton.pixels[k]);
        diff = (int) (brightness(sourceTemp.pixels[k]) - brightness(pieton.pixels[k])); //<>//
        value += (diff * diff);
      }
      value = value / yes; //<>//
      if((oldValue > value) || (oldValue == -1)){
        //print("iteration: ",i," out of: ",offset2*offset2," with mse: ",value,"\n");
        oldValue = value; //<>//
        indexX = j;
        indexY = i;
      }
    }
  }
  goalBX = indexX;
  goalBY = indexY;
}

void setup(){
  size(1920, 1080);
  frame1 = loadImage("frame1.png");
  frame2 = loadImage("frame2.png");
  
  redRectBX = 0;
  redRectBY = 0;
  for(int i=0; i<67; i++){
    for(int j=0; j<120; j++){
      pieton = frame1.get(redRectBX, redRectBY, redRectEX, redRectEY);
      findPieton(frame2, pieton);
      elts.add(new Position(goalBX, goalBY));
      print((i*120+j),"out of 8040\n");
      redRectBX += 16;
    }
    redRectBY += 16;
    redRectBX = 0;
  }
}

void draw(){
  image(frame1, 0, 0);
  strokeWeight(1);
  fill(0, 0, 0, 0);
  stroke(255, 0, 0);
  
  redRectBX = 0;
  redRectBY = 0;
  
  for(int i=0; i<67; i++){
    for(int j=0; j<120; j++){
      goalBX = elts.get(i*120+j).x;
      goalBY = elts.get(i*120+j).y;
      
      image(frame2.get(goalBX, goalBY, 16, 16), redRectBX, redRectBY);
      //rect(redRectBX, redRectBY, redRectEX, redRectEY);
      redRectBX += 16;
    }
    redRectBY += 16;
    redRectBX = 0;
  }
  
  save("result.png");
  print("hurry up");
  delay(5000);
  
  //stroke(0, 255, 0);
  //rect(redRectBX-offset1, redRectBY-offset1, redRectEX-redRectBX+offset2, redRectEY-redRectBY+offset2);
  //nextFrame = true;
  /*else{
    delay(1000);
    image(frame2, 0, 0);
    stroke(0, 255, 0);
    rect(redRectBX-offset1, redRectBY-offset1, redRectEX-redRectBX+offset2, redRectEY-redRectBY+offset2);
    stroke(255, 0, 0);
    rect(goalBX, goalBY, redRectEX-redRectBX, redRectEY-redRectBY);
  }*/
}

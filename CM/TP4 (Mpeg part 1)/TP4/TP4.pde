import java.util.ArrayList;

PImage frame1, frame2, pieton, pietonConverted;
int redRectBX = -1, redRectBY, redRectEX=-1, redRectEY;
int goalBX, goalBY;
boolean nextFrame = false;

void mouseClicked(){
  if(redRectBX == -1){
    redRectBX = mouseX;
    redRectBY = mouseY;
  }
  else if(redRectEX == -1){
    redRectEX = mouseX;
    redRectEY = mouseY;
    pieton = frame1.get(redRectBX, redRectBY, redRectEX-redRectBX, redRectEY-redRectBY);
    goalBX = redRectBX-50;
    goalBY = redRectBY-50;
    findPieton(frame2.get(redRectBX-50, redRectBY-50, redRectEX-redRectBX+100, redRectEY-redRectBY+100), pieton);
  }
}

int luminance(color pixel){
  int R, G, B;
  R = (int) red(pixel);
  G = (int) green(pixel);
  B = (int) blue(pixel);
  
  float option;
  //option = (0.299*R + 0.587*G + 0.114*B);
  option = 16 + (0.299*R) + (0.587*G) + (0.114*B);
  return (int) Math.floor(option);
}

void findPieton(PImage source, PImage pieton){
  int value, oldValue=-1;
  int indexX=0, indexY=0;
  PImage sourceTemp;
  int yes = pieton.width * pieton.height/2;
  
  for(int i=0; i<100;i+=3){
    for(int j=0; j<100; j+=3){
      sourceTemp = source.get(j, i, pieton.width, pieton.height);
      value = 0;
      for(int k=0; k<yes; k+=3){
        value += Math.abs(luminance(sourceTemp.pixels[k]) - luminance(pieton.pixels[k]));
        //value += luminance(sourceTemp.pixels[k]) - luminance(pieton.pixels[k]);
        
        //value += Math.abs(red(sourceTemp.pixels[k]) - red(pieton.pixels[k]));
        //value += Math.abs(green(sourceTemp.pixels[k]) - green(pieton.pixels[k]));
        //value += Math.abs(blue(sourceTemp.pixels[k]) - blue(pieton.pixels[k]));
      }
      //print("value now contains: ",value,"\t i: ",i," j: ",j,"\n");
      if(oldValue > value || oldValue == -1){
        oldValue = value;
        indexX = i;
        indexY = j;
        //print("new index: ",indexX,indexY,"\n");
      }
    }
  }
  goalBX += indexX;
  goalBY += indexY;
}

void setup(){
  size(1920, 1080);
  frame1 = loadImage("frame1.png");
  frame2 = loadImage("frame2.png");
}

void draw(){
  if(!nextFrame){
    image(frame1, 0, 0);
    strokeWeight(3);
    fill(0, 0, 0, 0);
    if(redRectEX != -1){
      stroke(255, 0, 0);
      rect(redRectBX, redRectBY, redRectEX-redRectBX, redRectEY-redRectBY);
      stroke(0, 255, 0);
      rect(redRectBX-50, redRectBY-50, redRectEX-redRectBX+100, redRectEY-redRectBY+100);
      nextFrame = true;
    }
  }
  else{
    delay(1000);
    image(frame2, 0, 0);
    stroke(0, 255, 0);
    rect(redRectBX-50, redRectBY-50, redRectEX-redRectBX+100, redRectEY-redRectBY+100);
    stroke(255, 0, 0);
    rect(goalBX, goalBY, redRectEX-redRectBX, redRectEY-redRectBY);
  }
}

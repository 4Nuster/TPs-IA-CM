import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

boolean printSwitch=false;
int tour;
int i,j, w, h,k=0;
float r,g,b;
int [][]actual={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
              {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
              {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,3,0,0,0,0,0,0,1,0,0,1},
              {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
              {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
              {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
              
int [][]obst={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
              {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
              {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,3,0,0,0,0,0,0,1,0,0,1},
              {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
              {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
              {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
              {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

int content(Position location, int [][]obst){
  return obst[location.y][location.x];
}

boolean notInBoth(ArrayList<Tuple> OPENED, ArrayList<Tuple> CLOSED, Position pos){
  for(Tuple t : OPENED){
    if(t.son.equal(pos)) return false;
  }
  for(Tuple t : CLOSED){
    if(t.son.equal(pos)) return false;
  }
  return true;
}
      
ArrayList<Position> breadthFirst(Position begin, int [][]obst){
  boolean found = false;
  Position position;
  Tuple tuple;
  ArrayList<Position> result = new ArrayList<Position>();
  ArrayList<Tuple> OPENED = new ArrayList<Tuple>();
  ArrayList<Tuple> CLOSED = new ArrayList<Tuple>();
  if(content(begin, obst) == 3){
    found = true;
    result.add(begin);
  }
  else{
    if(!begin.hasPath()) return result;
    else OPENED.add(new Tuple(new Position(0,0), begin));
  }
  while(OPENED.size()!=0 && !found){
    //print("size: "+OPENED.size()+" "+found+"\n");
    /*try{
      Thread.sleep(200);
    }
    catch(InterruptedException ex){
      Thread.currentThread().interrupt();
    }*/
    tuple = OPENED.get(0);
    OPENED.remove(0);
    CLOSED.add(tuple);
    if(content(tuple.son, obst)!=1){
      if(tuple.son.hasPathDown()){
        position = tuple.son.down();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathLeft()){
        position = tuple.son.left();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathUp()){
        position = tuple.son.up();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathRight()){
        position = tuple.son.right();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
    }
  }
  //print("this time size: "+OPENED.size()+" "+found+"\n");
  if(found){
    tuple = OPENED.get(OPENED.size()-1);
    //result.add(tuple.son);
    position = tuple.parent;
    result.add(position);
    while(CLOSED.size()!=0 && !position.equal(begin)){
      tuple = CLOSED.get(CLOSED.size()-1);
      CLOSED.remove(CLOSED.size()-1);
      if(tuple.son.equal(position)){
        position = tuple.parent;
        result.add(position);
      }
    }
    result.remove(result.size()-1);
  }
  //for(Position i : result) print(i.x+" "+i.y+"\n");
  return result;
}

/*ArrayList<Position> depthFirst(Position begin, int [][]obst){
  boolean found = false;
  Position position;
  Tuple tuple;
  ArrayList<Position> result = new ArrayList<Position>();
  ArrayList<Tuple> OPENED = new ArrayList<Tuple>();
  ArrayList<Tuple> CLOSED = new ArrayList<Tuple>();
  return result;
}*/

boolean found = false;
Position begin = new Position(6, 1);
Position position;
Tuple tuple;
ArrayList<Position> result = new ArrayList<Position>();
ArrayList<Tuple> OPENED = new ArrayList<Tuple>();
ArrayList<Tuple> CLOSED = new ArrayList<Tuple>();
ArrayList<Tuple> tempList = new ArrayList<Tuple>();

void setup() {
  size(512, 512);
  w=512;
  h=512;
  tour=0;
  
  if(content(begin, obst) == 3){
    found = true;
    result.add(begin);
  }
  else{
    if(begin.hasPath()) OPENED.add(new Tuple(new Position(0,0), begin));
  }
  while(OPENED.size()!=0 && !found){
    tuple = OPENED.get(0);
    OPENED.remove(0);
    CLOSED.add(tuple);
    if(content(tuple.son, obst)!=1){
      if(tuple.son.hasPathDown()){
        position = tuple.son.down();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathLeft()){
        position = tuple.son.left();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathUp()){
        position = tuple.son.up();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
      if(tuple.son.hasPathRight()){
        position = tuple.son.right();
        if(notInBoth(OPENED,CLOSED,position)) OPENED.add(new Tuple(tuple.son, position));
        if(content(position, obst) == 3){
          found = true;
          continue;
        }
      }
    }
  }
  //print("this time size: "+OPENED.size()+" "+found+"\n");
  if(found){
    for(Tuple CE: CLOSED) tempList.add(CE);
    tuple = OPENED.get(OPENED.size()-1);
    //result.add(tuple.son);
    position = tuple.parent;
    result.add(position);
    while(tempList.size()!=0 && !position.equal(begin)){
      tuple = tempList.get(tempList.size()-1);
      tempList.remove(tempList.size()-1);
      if(tuple.son.equal(position)){
        position = tuple.parent;
        result.add(position);
      }
    }
    result.remove(result.size()-1);
  }
}

void draw() {
  //ArrayList<Position> result = breadthFirst(new Position(6,1), obst);
  //print("in the end "+result.size()+"\n");
  /*for(Position i : result){
    obst[i.y][i.x] = 4;
    //print(i.x+" "+i.y+"\n");
  }*/
  
  //PImage out=createImage(w,h,RGB);
  //out.
 // background(0);
  fill(255);
  loadPixels();
  
  for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {

      // Calculate the 1D pixel location
      int loc = x + y*w;
      int stepx=w/16;
      int stepy=h/16;
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
        case 4: r=255; g=255; b=0; break;
        case 5: if(!printSwitch){ r=201; g=118; b=54;} else{ obst[i][j] = actual[i][j];} break;
      }      
      color c = color(r, g, b);
      //out.
      pixels[loc]=c;
      //obst[0][0]= 2;
    }
  }
//  delay(30);
  
      //out.
      //obst[k][k] = 2;
      
      delay(100);
      if(!printSwitch){
        begin = CLOSED.get(k).son;
        if(content(begin, obst) ==0) obst[begin.y][begin.x] = 5;
        k++;
        if(k == CLOSED.size()){
          printSwitch = true;
          k = result.size()-1;
        }
      }
      else{
        if(k>=0){
          begin = result.get(k);
          obst[begin.y][begin.x] = 4;
          k--;
        }
      }
      updatePixels();
      //loadPixels();
      //pixels[0] = color(255,255,0);
      //updatePixels();
      //out.save("grille_prog1"+".bmp");
      //tour++;
      //if(tour==1)exit();

}

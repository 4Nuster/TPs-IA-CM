import java.util.ArrayList;

int fetch(ArrayList<HuffmanElt> chars, String character){
  for(HuffmanElt c : chars){
    if(c.character.equals(character)) return chars.indexOf(c);
  }
  return -1;
}

int fetchCode(ArrayList<HuffmanElt> chars, String code){
  for(HuffmanElt c : chars){
    if(c.code.equals(code)) return chars.indexOf(c);
  }
  return -1;
}

int getMin(ArrayList<HuffmanElt>chars){
  int min = chars.get(0).occ;
  int ind = 0;
  for(HuffmanElt c : chars){
    if(c.occ <= min){
      min = c.occ;
      ind = chars.indexOf(c);
    }
  }
  return ind;
}

ArrayList<HuffmanElt> setCoordinates(ArrayList<HuffmanElt> chars){
  int max = chars.get(getMin(chars)).code.length();
  for(HuffmanElt elt : chars){
    if(elt.code.equals("")){
      elt.x = 50;
      elt.y = 70;
      continue;
    }
    elt.x = 50*(unbinary(elt.code)+1)*(int) pow(2,max-elt.code.length());
    elt.x -= 50*((int) pow(2,max-elt.code.length())-1);
    elt.y = 70*(elt.code.length()+1);
  }
  return chars;
}

void drawLines(HuffmanElt elt){
  //stroke(255);
  if(elt.character.equals("")){
    stroke(255,0,0);
    strokeWeight(4);
    line(elt.x,elt.y,elt.sonG.x,elt.sonG.y);
    drawLines(elt.sonG);
    stroke(0,255,0);
    strokeWeight(4);
    line(elt.x,elt.y,elt.sonR.x,elt.sonR.y);
    drawLines(elt.sonR);
  }
  strokeWeight(1);
}

ArrayList<HuffmanElt> tree(String message){
  ArrayList<HuffmanElt> chars = new ArrayList<HuffmanElt>();
  ArrayList<HuffmanElt> temp = new ArrayList<HuffmanElt>();
  String character;
  HuffmanElt tree, sonG, sonR;
  
    int index;
  
  for(int i=0;i<message.length();i++){
    character = message.substring(i,i+1);
    index = fetch(chars, character);
    if(index != -1){
      chars.get(index).inc();
    }
    else{
      chars.add(new HuffmanElt(character));
    }
  }
  
  temp = chars;
  tree = temp.get(0);
  while(temp.size()>1){
    sonG = temp.get(getMin(temp));
    temp.remove(getMin(temp));
    sonR = temp.get(getMin(temp));
    temp.remove(getMin(temp));
    tree = new HuffmanElt("",sonG,sonR);
    tree.occ = sonG.occ + sonR.occ;
    temp.add(tree);
  }
    
  tree.paint("");
  temp = tree.fillArray(temp);
  
  chars = setCoordinates(chars);
  return chars;
}

void setup(){
  size(900, 512);
  fill(0);
}

void draw(){
  //String message = "bccabbddaeccbbaeddcc";
  String message = "this_is_a_message";
  ArrayList<HuffmanElt> chars = tree(message);
  String result = "";

  background(43, 93, 110);
  
  for(int i=0; i<message.length();i++){
    result += chars.get(fetch(chars,message.substring(i,i+1))).code + " ";
  }
    
  //print("before: ",message,"\n");
  //print("after: ",result,"\n");
  //print("table: \n");
  //for(HuffmanElt c : chars) print(c.character,c.occ,c.code,c.x,c.y,"\n");
  
  fill(255);
  textSize(14);
  text("before: "+message, 100, 20);
  text("after: "+result, 100, 40);
  fill(255, 0, 0);
  text("red: 0", 100, 60);
  fill(0, 255, 0);
  text("green: 1", 150, 60);
  fill(255);
  text("taux compression: "+Float.toString((float) 1.0-((float) result.length()/((float) (message.length()*8)))),220,60);
  
  drawLines(chars.get(0));
  
  stroke(255);
  for(HuffmanElt elt : chars){
    if(elt.character.equals("")){
      fill(255);
      rect(elt.x-25,elt.y-30,50,50);
      fill(0);
      text(elt.occ,elt.x-5,elt.y);
    }
    else{
      fill(255);
      ellipse(elt.x,elt.y,50,50);
      fill(0);
      text(elt.character+":"+elt.occ,elt.x-10,elt.y);
    }
  }
  //updatePixels();
  //delay(1000);
  //exit();
}

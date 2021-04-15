class HuffmanElt{
  String character, code;
  int occ, x, y;
  HuffmanElt parent, sonG, sonR;
  
  HuffmanElt(String character){
    this.character = character;
    occ = 1;
    code = "";
    parent = null;
    sonG = null;
    sonR = null;
  }
  
  HuffmanElt(String character, HuffmanElt sonG, HuffmanElt sonR){
    this.character = character;
    occ = 1;
    code = "";
    parent = null;
    this.sonG = sonG;
    this.sonR = sonR;
  }
  
  void inc(){
    occ++;
  }
  
  void paint(String msg){
    code += msg;
    if(sonG != null) sonG.paint(msg+"0");
    if(sonR != null) sonR.paint(msg+"1");
  }
  
  ArrayList<HuffmanElt> fillArray(ArrayList<HuffmanElt> array){
    array.add(this);
    if(sonG != null) array = sonG.fillArray(array);
    if(sonR != null) array = sonR.fillArray(array);
    return array;
  }
}

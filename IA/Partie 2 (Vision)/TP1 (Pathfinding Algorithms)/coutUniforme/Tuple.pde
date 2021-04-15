public class Tuple{
  public Position parent, son;
  int cout;
  public Tuple(Position parent, Position son, int cout){
    this.parent = parent;
    this.son = son;
    this.cout = cout;
  }
  
  public boolean equal(Tuple something){
    return son.equal(something.son);
  }
}

public class Tuple{
  public Position parent, son;
  public Tuple(Position parent, Position son){
    this.parent = parent;
    this.son = son;
  }
  
  public boolean equal(Tuple something){
    return son.equal(something.son);
  }
}

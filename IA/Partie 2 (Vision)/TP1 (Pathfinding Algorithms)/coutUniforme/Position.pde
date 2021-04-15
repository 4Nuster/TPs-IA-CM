public class Position{
  public int x,y;
  public Position(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public boolean equal(Position something){
    return (this.x==something.x && this.y==something.y);
  }
  
  public boolean hasPathLeft(){
    return this.x>0;
  }
  
  public boolean hasPathRight(){
    return this.x<15;
  }
  
  public boolean hasPathUp(){
    return this.y>0;
  }
  
  public boolean hasPathDown(){
    return this.y<15;
  }
  
  public boolean hasPath(){
    return (hasPathUp() || hasPathDown() || hasPathRight() || hasPathLeft());
  }
  
  public Position up(){
    return new Position( x, y-1);
  }
  
  public Position down(){
    return new Position( x, y+1);
  }
  
  public Position left(){
    return new Position( x-1, y);
  }
  
  public Position right(){
    return new Position( x+1, y);
  }
}

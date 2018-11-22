class Vertex{
  private PVector vec;
  public float x;
  public float y;
  public float z;
  private PVector[] projMatrix = new PVector[3];
  
  private void buildProjMatrix(float teta){
    projMatrix[0] = new PVector( 1, 0, cos(teta) );
    projMatrix[1] = new PVector( 0, 1, sin(teta) );
    projMatrix[2] = new PVector( 0, 0, 0 );
  }
  
  public Vertex(float x, float y){
    vec = new PVector(x, y, 0);
  }
  
  public Vertex(float x, float y, float z){
    vec = new PVector(x, y, z);
  }
  
  public Vertex(PVector point){
    vec = point.copy();
  }
  
  public void project(float teta){
    buildProjMatrix(teta);
    x = vec.dot(projMatrix[0]);
    y = vec.dot(projMatrix[1]);
    z = vec.dot(projMatrix[2]);
  }
  
  public void printVertex(){
    println("( " + vec.x + "; " + vec.y + "; " + vec.z + " )");
  }
  
  public void add(Vertex v){
    vec.add(v.vec);
  }
  
  public void add(float x, float y){
    vec.x += x;
    vec.y += y;
  }
  
  public void sub(Vertex v){
    vec.sub(v.vec);
  }
  
  public void sub(float x, float y){
    vec.x -= x;
    vec.y -= y;
  }
  
  public void mult(float n){
    vec.mult(n);
  }
  
  public void div(float n){
    vec.div(n);
  }
  
  public void setYValue(float y){
    vec.y = y;
  }
  
  public Vertex clone(){
    return new Vertex(vec.x, vec.y, vec.z);
  }
  
  public PVector truePoints(){
    return vec.copy();
  }
  
  public PVector projectSpecial(PVector P1, PVector P2){
    float k = P1.z/(P2.z - P1.z);
    return new PVector( (P1.x + (P1.x - P1.x)*k), (P1.y + (P1.y - P1.y)*k) );
  }
}

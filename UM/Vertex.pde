class Vertex{
  private PVector vec;
  public float x;
  public float y;
  public float z;
  private PVector[] projMatrix = new PVector[3];
  private final float teta;
  
  private void buildProjMatrix(){
    projMatrix[0] = new PVector( 1, 0, cos(teta) );
    projMatrix[1] = new PVector( 0, 1, sin(teta) );
    projMatrix[2] = new PVector( 0, 0, 0 );
  }
  
  public Vertex(float x, float y){
    vec = new PVector(x, y, 0);
    teta = radians(120);
    project();
  }
  
  public Vertex(float x, float y, float z){
    vec = new PVector(x, y, z);
    teta = radians(120);
    project();
  }
  
  public Vertex(PVector point){
    vec = point.copy();
    teta = radians(120);
    project();
  }
  
  private void project(){
    buildProjMatrix();
    x = vec.dot(projMatrix[0]);
    y = vec.dot(projMatrix[1]);
    z = vec.dot(projMatrix[2]);
  }
  
  public void printVertex(){
    println("( " + vec.x + "; " + vec.y + "; " + vec.z + " )");
  }
  
  public void add(Vertex v){
    vec.add(v.vec);
    project();
  }
  
  public void add(float x, float y){
    vec.x += x;
    vec.y += y;
    project();
  }
  
  public void sub(Vertex v){
    vec.sub(v.vec);
    project();
  }
  
  public void sub(float x, float y){
    vec.x -= x;
    vec.y -= y;
    project();
  }
  
  public void mult(float n){
    vec.mult(n);
    project();
  }
  
  public void div(float n){
    vec.div(n);
    project();
  }
  
  public void setYValue(float y){
    vec.y = y;
    project();
  }
  
  public Vertex clone(){
    return new Vertex(vec.x, vec.y, vec.z);
  }
  
  public PVector truePoints(){
    return vec.copy();
  }
  
  public void rotate(float teta){
    Quaternio p = new Quaternio(0, this.vec);
    PVector n = new PVector(0,0,1);
    Quaternio q = new Quaternio(cos(teta/2), n.mult(sin(teta/2)));
    Quaternio qConj = new Quaternio(cos(teta/2), n.mult(-sin(teta/2))); 
    this.vec = q.prod(p).prod(qConj).getVector();
    project();
  }
}

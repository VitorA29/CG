class Edge {
  public Vertex A;
  public Vertex B;
  
  public Edge(Vertex A, Vertex B){
    this.A = A;
    this.B = B;
  }
  
  public void printEdge(){
    print("A - ");
    A.printVertex();
    print("B - ");
    B.printVertex();
  }
  
  public Edge clone(){
    return new Edge(A.clone(), B.clone());
  }
  
  public void draw(){
    line(A.x, A.y, A.z, B.x, B.y, B.z);
  }
  public void drawCurve(){
    Vertex c1 = A.clone();
    Vertex c2 = B.clone();
    bezier(A.x, A.y, A.z, c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, B.x, B.y, B.z);
  }
  
  public void rotate(float theta, PVector center){
    A.rotate(theta, center);
  }
}

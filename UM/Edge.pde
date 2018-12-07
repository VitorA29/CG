class Edge {
  public Vertex A;
  public Vertex B;
  private Vertex[] controls;
  
  public Edge(Vertex A, Vertex B){
    this.A = A;
    this.B = B;
    this.controls = null;
  }
  
  public Edge(Vertex A, Vertex B, Vertex[] controls){
    this.A = A;
    this.B = B;
    this.controls = controls;
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
  public void drawCurve(PVector center){
    A.add(center.x, center.y);
    B.add(center.x, center.y);
    if(controls != null){
      bezier(A.x, A.y, A.z, controls[0].x, controls[0].y, controls[0].z, controls[1].x, controls[1].y, controls[1].z, B.x, B.y, B.z);
    }
    else{
      line(A.x, A.y, A.z, B.x, B.y, B.z);
    }
    A.sub(center.x, center.y);
    B.sub(center.x, center.y);
  }
  
  public void rotate(float theta){
    A.rotate(theta);
  }
}

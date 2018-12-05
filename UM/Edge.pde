class Edge {
  public Vertex A;
  public Vertex B;
  
  public Edge(Vertex A, Vertex B){
    this.A = A;
    this.B = B;
  }
  
  public void printEdge(){
    print("A - ");
    A.add(center);
    A.printVertex();
    A.sub(center);
    print("B - ");
    B.add(center);
    B.printVertex();
    B.sub(center);
  }
  
  public Edge clone(){
    return new Edge(A.clone(), B.clone());
  }
  
  public void draw(Vertex center){
    A.add(center);
    B.add(center);
    line(A.x, A.y, A.z, B.x, B.y, B.z);
    A.sub(center);
    B.sub(center);
  }
  public void drawCurve(Vertex center){
    Vertex c1 = A.clone();
    A.add(center);
    Vertex c2 = B.clone();
    B.add(center);
    bezier(A.x, A.y, A.z, c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, B.x, B.y, B.z);
    A.sub(center);
    B.sub(center);
  }
}

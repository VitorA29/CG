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
  
  public void draw(Vertex center){
    A.add(center);
    B.add(center);
    float teta = radians(120);
    A.project(teta);
    B.project(teta);
    fill(204, 102, 0);
    line(A.x, A.y, A.z, B.x, B.y, B.z);
    A.sub(center);
    B.sub(center);
  }
}

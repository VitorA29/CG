class Edge {
  public Vertex A;
  public Vertex B;
  public Vertex[] controls;
  
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
    Vertex[] vertexHolder;
    if(controls != null){
      vertexHolder = new Vertex[2];
      vertexHolder[0] = controls[0].clone();
      vertexHolder[1] = controls[1].clone();
    }
    else{
      vertexHolder = null;
    }
    return new Edge(A.clone(), B.clone(), vertexHolder);
  }
  
  public void draw(){
    line(A.x, A.y, A.z, B.x, B.y, B.z);
  }
  public void drawCurve(PVector center){
    A.add(center);
    B.add(center);
    if(controls != null){
      for(int i=0; i<controls.length; i++){
        controls[i].add(center);
      }
    }
    if(controls != null){
      // ellipse(controls[0].x, controls[0].y, 5, 5);
      bezier(A.x, A.y, A.z, controls[0].x, controls[0].y, controls[0].z, controls[1].x, controls[1].y, controls[1].z, B.x, B.y, B.z);
    }
    else{
      line(A.x, A.y, A.z, B.x, B.y, B.z);
    }
    A.sub(center);
    B.sub(center);
    if(controls != null){
      for(int i=0; i<controls.length; i++){
        controls[i].sub(center);
      }
    }
  }
  
  public void rotate(float theta){
    A.rotate(theta);
    if(controls != null){
      for(int i=0; i<controls.length; i++){
        controls[i].rotate(theta);
      }
    }
  }
}

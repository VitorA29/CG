class Face{
  public Edge[] edges;
  public PShape shape;
  public PVector center;
  
  public Face(Edge[] edges, PVector center){
    this.edges = edges;
    this.center = center;
  }
  
  public void printFace(){
    for(int i=0; i<edges.length; i++){
      println("######E" + (i+1) + "#####");
      edges[i].printEdge();
    }
  }
  
  public float normal(PVector out){
    HashMap<String, PVector> map = getNormal();
    PVector link = PVector.sub( out, map.get("center") );
    return map.get("normal").dot( link );
  }
  
   public HashMap<String, PVector> getNormal(){
    PVector centerHolder = edges[0].B.truePoints();
    PVector v1 = PVector.sub( edges[0].A.truePoints(), centerHolder );
    PVector v2 = PVector.sub( edges[1].B.truePoints(), centerHolder );
    PVector normal = v1.cross( v2 );
    HashMap<String, PVector> map = new HashMap<String, PVector>();
    map.put("normal", normal);
    map.put("center", centerHolder);
    return map;
  }
  
  public Face mirrorFace(){
    ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
    for( int i = ( edges.length - 1 ) ; i>=0; i--){
      vertexList.add( edges[i].B.clone() );
    }
    Edge[] edgesArray = new Edge[edges.length];
    for(int i=0; i<vertexList.size(); i++){
      edgesArray[i] = new Edge( vertexList.get(i), vertexList.get( ( ( i + 1 ) == vertexList.size() ? 0 : ( i + 1 ) ) ) );
    }
    return new Face(edgesArray, center);
  }
  
  public void inic(){
     shape = createShape();
     shape.beginShape();
     for(int i = 0; i < edges.length; i++){
         shape.vertex(edges[i].A.x, edges[i].A.y);
     }
     shape.endShape(CLOSE);
    
  }
  
  public void draw(){
    for(int i=0; i<edges.length; i++){
      edges[i].draw();
    }
  }
  
  public void drawCurve(){
    for(int i=0; i<edges.length; i++){
      edges[i].drawCurve(center);
    }
  }
  
  public void drawAndPaint(Vertex light){
    this.inic();
    HashMap<String, PVector> map = this.getNormal();
    PVector normal = map.get("normal");
    normal.normalize();
    PVector lightHolder = light.truePoints();
    PVector aux = PVector.sub( lightHolder, map.get("center") );
    aux.normalize();
    float escalarValue = normal.dot(aux);
    float colorValue = escalarValue * 255;
    colorValue = abs(colorValue);
    shape.setFill(color(255, 255, (colorValue) ));
    //shape.setStroke(false);
    shape(shape);
  }
  
  public void rotate(float theta){
    for(int i=0; i<edges.length; i++){
      edges[i].rotate(theta);
    }
  }
  
  public Face shift(float z){
    Edge[] newEdges = new Edge[edges.length];
    for(int i=0; i<edges.length; i++){
      newEdges[i] = edges[i].clone();
      newEdges[i].A.add(0, 0, z);
      newEdges[i].B.add(0, 0, z);
      if(newEdges[i].controls != null){
        newEdges[i].controls[0].add(0, 0, z);
        newEdges[i].controls[1].add(0, 0, z);
      }
    }
    PVector newCenter = center.copy();
    newCenter.z += z;
    return new Face(newEdges, newCenter);
  }
}

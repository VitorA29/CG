class Face{
  public Edge[] edges;
  public PShape shape;
  
  public Face(Edge[] edges){
    this.edges = edges;
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
    return new Face(edgesArray);
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
      edges[i].drawCurve();
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
  
  public void rotate(float teta){
    for(int i=0; i<edges.length; i++){
      edges[i].rotate(teta);
    }
  }
}

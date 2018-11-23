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
  //ERICK: retornar o vetor normal e calcular o produto dessas normais com o vetor observador
  //esquce, finalmente entendi qq tu t afazendo e que dot é o produto interno dessa palhaçada.
  public float normal(Vertex center, PVector out){
    HashMap<String, PVector> map = getNormal(center);
    PVector link = PVector.sub( out, map.get("center") );
    return map.get("normal").dot( link );
  }
  
   public HashMap<String, PVector> getNormal(Vertex center){
    edges[0].A.add(center);
    edges[0].B.add(center);
    edges[1].B.add(center);
    PVector centerHolder = edges[0].B.truePoints();
    PVector v1 = PVector.sub( edges[0].A.truePoints(), centerHolder );
    PVector v2 = PVector.sub( edges[1].B.truePoints(), centerHolder );
    PVector normal = v1.cross( v2 );
    edges[0].A.sub(center);
    edges[0].B.sub(center);
    edges[1].B.sub(center);
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
  
  public void draw(Vertex center){
    for(int i=0; i<edges.length; i++){
      edges[i].draw(center);
    }
  }
  
  public void drawAndPaint(){
    this.inic();
    //shape.fill();
    shape(shape);
  }
}

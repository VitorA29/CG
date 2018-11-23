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
    edges[0].A.add(center);
    edges[0].B.add(center);
    edges[1].B.add(center);
    PVector centerHolder = edges[0].B.truePoints();
    PVector v1 = PVector.sub( edges[0].A.truePoints(), centerHolder );
    PVector v2 = PVector.sub( edges[1].B.truePoints(), centerHolder );
    println("cu");
    println(v1);
    println("cu2");
    println(v2);
    //fill(255, 0, 0);
    //ellipse(edges[0].A.x, edges[0].A.y, 5, 5);
    //fill(0, 0, 0);
    //ellipse(edges[1].B.x, edges[1].B.y, 5, 5);
    PVector normal = v1.cross( v2 );
    normal.y = -normal.y;
    //return normal;
    PVector link = PVector.sub( out, centerHolder );
    ////line(edges[0].B.x, edges[0].B.y,edges[0].B.z, edges[0].B.x + normal.x, edges[0].B.y + normal.y, edges[0].B.z + normal.z);
    edges[0].A.sub(center);
    edges[0].B.sub(center);
    edges[1].B.sub(center);
    return normal.dot( link );
  }
  
   public HashMap<String, PVector> getNormal(Vertex center){
    edges[0].A.add(center);
    edges[0].B.add(center);
    edges[1].B.add(center);
    PVector centerHolder = edges[0].B.truePoints();
    PVector v1 = PVector.sub( edges[0].A.truePoints(), centerHolder );
    PVector v2 = PVector.sub( edges[1].B.truePoints(), centerHolder );
    println("cu");
    println(v1);
    println("cu2");
    println(v2);
    //fill(255, 0, 0);
    //ellipse(edges[0].A.x, edges[0].A.y, 5, 5);
    //fill(0, 0, 0);
    //ellipse(edges[1].B.x, edges[1].B.y, 5, 5);
    PVector normal = v1.cross( v2 );
    normal.y = -normal.y;
    HashMap<String, PVector> map = new HashMap<>();
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

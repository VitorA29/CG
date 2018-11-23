class CgObject{
  public Face[] faces;
  public Vertex center;
  
  public CgObject(Face[] faces){
    this.faces = faces;
  }
  
  public CgObject(Face face, Vertex center, float depth){
    this.center = center;
    Face copyFace = face.mirrorFace();
    ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
    for(int i=0; i<copyFace.edges.length; i++){
      if(!vertexList.contains(copyFace.edges[i].A)){
        vertexList.add(copyFace.edges[i].A);
      }
      if(!vertexList.contains(copyFace.edges[i].B)){
        vertexList.add(copyFace.edges[i].B);
      }
    }
    Vertex depthVertex = new Vertex(0, 0, depth);
    for(Vertex vertex : vertexList){
      vertex.sub(depthVertex);
    }
    depthVertex.div(2);
    center.sub(depthVertex);
    ArrayList<Face> faceList = new ArrayList<Face>();
    faceList.add(face);
    for(int i=0; i<face.edges.length; i++){
      Edge edgeHelper = copyFace.edges[copyFace.edges.length - 1 - i];
      Edge[] newEdges = { edgeHelper, new Edge(edgeHelper.B, face.edges[i].A), face.edges[i], new Edge(face.edges[i].B, edgeHelper.A)};
      faceList.add(new Face(newEdges));
    }
    faceList.add(copyFace);
    Face[] faces = new Face[faceList.size()];
    for(int i = 0; i<faceList.size(); i++){
      faces[i] = faceList.get(i);
    }
    this.faces = faces;
  }
  
  public void draw(int i, PVector observer){
    faces[i].draw(center);
    //fill(204, 102, 0);
    println(faces[i].normal(center, observer));
  }
  
  // num 1
  public void draw(){
    for(int i=0; i<faces.length; i++){
      faces[i].draw(center);
    }
  }
  
  // num 2
  public void draw(PVector observer){
    for(int i=0; i<faces.length; i++){
      if(faces[i].normal(center, observer)>0)
        faces[i].draw(center);
    }
  }
  
  // num 3
  public void drawAndPaint(PVector observer){
    //float intern = (faces[i].normal(center, observer)
    for(int i=0; i<faces.length; i++){
      if(faces[i].normal(center, observer)>0)
        faces[i].drawAndPaint();
    }
  }
}

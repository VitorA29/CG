class CgObject{
  public Face[] faces;
  
  public CgObject(Face[] faces){
    this.faces = faces;
  }
  
  public CgObject(Face face, float depth){
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
    ArrayList<Face> faceList = new ArrayList<Face>();
    faceList.add(face);
    for(int i=0; i<face.edges.length; i++){
      Edge edgeHelper = copyFace.edges[copyFace.edges.length - 1 - i];
      Edge[] newEdges = { new Edge(face.edges[i].B, face.edges[i].A), new Edge(face.edges[i].A, edgeHelper.B),
                            new Edge(edgeHelper.B, edgeHelper.A), new Edge(edgeHelper.A, face.edges[i].B)};
      faceList.add(new Face(newEdges, null));//consertar
    }
    faceList.add(copyFace);
    Face[] faces = new Face[faceList.size()];
    for(int i = 0; i<faceList.size(); i++){
      faces[i] = faceList.get(i);
    }
    this.faces = faces;
  }
  
  // num 1 OK
  public void draw(){
    for(int i=0; i<faces.length; i++){
      faces[i].draw();
    }
  }
  
  // num 2 OK
  public void draw(PVector observer){
    for(int i=0; i<faces.length; i++){
      if(faces[i].normal(observer)>0){
        faces[i].draw();
      }
    }
  }
  
  public void draw(int i, PVector observer){
    faces[i].draw();
    Vertex normal = new Vertex(faces[i].getNormal().get("normal"));
    print("normal - "+faces[i].normal(observer) + " - ");
    normal.printVertex();
  }
  
  // num 3
  public void drawAndPaint(PVector observer, Vertex light){
    //float intern = (faces[i].normal(center, observer)
    colorMode(HSB);
    for(int i=0; i<faces.length; i++){
      if(faces[i].normal(observer)>0)
        faces[i].drawAndPaint(light);
    }
  }
}

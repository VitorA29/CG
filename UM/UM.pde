CgObject um;
Vertex observer;
int points;
float size;
Vertex center;
float teta;
float[] vel;
float omega;
int frames_per_sec = 30;

//Defining windows consts
int[] window = { 800, 600 };

int[] auraWindow = { 100, 100 };

//Aura Coordenates
float[] origin = {50,50};
float[] destiny = { 0, 100};

//Animation Controllerm
int elapsed_frames;
int max_frames = 0*frames_per_sec;

void applyAura(){
  // Transforming X
  origin[0] = (origin[0]*window[0])/auraWindow[0];
  destiny[0] = (destiny[0]*window[0])/auraWindow[0];
  
  //Transforming Y
  origin[1] = (origin[1]*(-window[1]))/auraWindow[1] + window[1];
  destiny[1] = (destiny[1]*(-window[1]))/auraWindow[1] + window[1];
}

void applyRotation(float teta){
  float[][] rotationMatrix = new float[4][4];
  rotationMatrix[0][0] = cos(teta);
  rotationMatrix[0][1] = sin(teta);
  rotationMatrix[0][2] = 0;
  rotationMatrix[0][3] = 0;
  rotationMatrix[1][0] = -sin(teta);
  rotationMatrix[1][1] = cos(teta);
  rotationMatrix[1][2] = 0;
  rotationMatrix[1][3] = 0;
  rotationMatrix[2][0] = 0;
  rotationMatrix[2][1] = 0;
  rotationMatrix[2][2] = 1;
  rotationMatrix[2][3] = 0;
  rotationMatrix[3][0] = 0;
  rotationMatrix[3][1] = 0;
  rotationMatrix[3][2] = 0;
  rotationMatrix[3][3] = 1;
}

void setup(){
  size(800, 600, P3D);
  elapsed_frames = 0;
  
  applyAura();
  
  points = 11;
  size = 25;
  teta = PI/3;
  vel = new float[2];
  //vel[0] = (size)/frames_per_sec;
  vel[0]=(destiny[0]-origin[0])/max_frames;
  vel[1]=(destiny[1]-origin[1])/max_frames;
  omega = (PI/2)/max_frames;
  
  float base = size/2;
  
  //Object Contruction
  ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
  vertexList.add(new Vertex( 0, 0 ));
  vertexList.add(new Vertex( 3*size, 0 ));
  vertexList.add(new Vertex( 3*size, base ));
  vertexList.add(new Vertex( 2*size, base ));
  vertexList.add(new Vertex( 2*size, 4*size ));
  //A
  vertexList.add(new Vertex( size, 4*size ));
  //B
  float noseSize = size*1.1;
  vertexList.add( vertexList.get(5).clone() );
  vertexList.get(6).sub(noseSize*sin(teta), noseSize*cos(teta) );
  //C
  vertexList.add( vertexList.get(6).clone() );
  vertexList.get(7).add( size*cos(teta), -size*sin(teta) );
  vertexList.get(7).printVertex();
  //D 
  PVector pointHelper = vertexList.get(7).truePoints();
  Vertex D = new Vertex( size, pointHelper.y + (size - pointHelper.x)/tan(teta)  );
  vertexList.add( D );
  D.printVertex();
  vertexList.add(new Vertex( size, base ));
  vertexList.add(new Vertex( 0, base ));
  
  Edge E1 = new Edge(vertexList.get(0), vertexList.get(1));
  Edge E2 = new Edge(vertexList.get(1), vertexList.get(2));
  Edge E3 = new Edge(vertexList.get(2), vertexList.get(3));
  Edge E4 = new Edge(vertexList.get(3), vertexList.get(4));
  Edge E5 = new Edge(vertexList.get(4), vertexList.get(5));
  Edge E6 = new Edge(vertexList.get(5), vertexList.get(6));
  Edge E7 = new Edge(vertexList.get(6), vertexList.get(7));
  Edge E8 = new Edge(vertexList.get(7), vertexList.get(8));
  Edge E9 = new Edge(vertexList.get(8), vertexList.get(9));
  Edge E10 = new Edge(vertexList.get(9), vertexList.get(10));
  Edge E11 = new Edge(vertexList.get(10), vertexList.get(0));
  
  Edge[] edges = { E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11 };
  Face F = new Face( edges );
 
  //Y-Axis Correction
  for(Vertex ver : vertexList){
    PVector vertexHelper = ver.truePoints();
    ver.setYValue(4*size - vertexHelper.y);
  }
  
  //Center definition
  center = new Vertex(1.5*size, (3+0.5)*size/2);
  
  //Object referential alteration
  for(Vertex ver : vertexList){
    ver.sub(center);
  }
  
  //Centering object in screean
  center = new Vertex( origin[0], origin[1] );
  
  um = new CgObject(F, center, base);
  observer = new Vertex(origin[0], origin[1], 100);
  um.draw(observer.truePoints());
}

void draw(){
  //if(elapsed_frames<=max_frames){
    background(255);
    um.draw(observer.truePoints());
    fill(0,0,0);
    ellipse(observer.x, observer.y, 5, 5);
    fill(255,0,0);
    ellipse(center.x, center.y, 5, 5);
    //ERICK: comentado a parte que movimenta a imagem a fim de efetuar a primeira entrega (12/09)
    //ellipse(center[0],center[1], center[2],5,5,5); // --> que bagulho feio
    
    //center[0]+=vel[0];
    //center[1]+=vel[1];
    //if((center[0]>=width-size*2) || (center[0]<=size*2))vel= -vel;
    
    //applyRotation(omega);
    
    //elapsed_frames++;
  //}
}

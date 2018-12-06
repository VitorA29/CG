CgObject um;
Face face;
Vertex observer;
Vertex light;
int points;
float size;

float teta;
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
int max_frames = 1*frames_per_sec;

void applyAura(){
  // Transforming X
  origin[0] = (origin[0]*window[0])/auraWindow[0];
  destiny[0] = (destiny[0]*window[0])/auraWindow[0];
  
  //Transforming Y
  origin[1] = (origin[1]*(-window[1]))/auraWindow[1] + window[1];
  destiny[1] = (destiny[1]*(-window[1]))/auraWindow[1] + window[1];
}

void setup(){
  size(800, 600, P3D);
  elapsed_frames = 0;
  
  applyAura();
  
  points = 11;
  size = 25;
  
  teta = PI/3;
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
  //D 
  PVector pointHelper = vertexList.get(7).truePoints();
  Vertex D = new Vertex( size, pointHelper.y + (size - pointHelper.x)/tan(teta)  );
  vertexList.add( D );
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
 
  //Y-Axis Correction
  for(Vertex ver : vertexList){
    PVector vertexHelper = ver.truePoints();
    ver.setYValue(4*size - vertexHelper.y);
  }
  
  //Center definition
  Vertex center = new Vertex(1.5*size, (3+0.5)*size/2);
  
  //Object referential alteration
  for(Vertex ver : vertexList){
    ver.sub(center);
  }
  
  //Centering object in screean
  center = new Vertex( origin[0], origin[1] );
  
  //Object referential alteration
  for(Vertex ver : vertexList){
    ver.add(center);
  }
  
  face = new Face( edges, center.truePoints() );
  um = new CgObject(face, base);
  observer = new Vertex(origin[0], origin[1], 100);
  light = new Vertex( origin[0] + 100, origin[1]-100, 200);
  //light = new Vertex( 200, origin[1]-100, 100);
}

void draw(){
    background(255);
    if(elapsed_frames <= 0/*max_frames*/){
      println("rotation");
      face.rotate(PI/2);
    }
    face.drawCurve();
    //um.draw(); //Forma 1
    //um.draw(observer.truePoints()); //Forma 2
    //um.drawAndPaint(observer.truePoints(), light); //Forma 3
    fill(0,0,0);
    //ellipse(observer.x, observer.y, 5, 5);
    //fill(255,0,0);
    //ellipse(center.x, center.y, 5, 5);
    fill(255,255,255);
    //ellipse(light.x, light.y, 5, 5);
    
    elapsed_frames++;
}

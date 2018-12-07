CgObject um;
Face face;
float base;
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
int max_frames = 5*frames_per_sec;

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
  omega = (2*PI)/max_frames;
  
  base = size/2;
  
  //Object Contruction
  ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
  vertexList.add(new Vertex( 0, 0 ));//0
  vertexList.add(new Vertex( 3*size, 0 ));//1
  vertexList.add(new Vertex( 3*size, base ));//2
  vertexList.add(new Vertex( 2*size, base ));//3
  vertexList.add(new Vertex( 2*size, 4*size ));//4
  //A
  vertexList.add(new Vertex( size, 4*size ));//5
  //B
  float noseSize = size*1.1;
  vertexList.add( vertexList.get(5).clone() );//6
  vertexList.get(6).sub(noseSize*sin(teta), noseSize*cos(teta) );
  //C
  vertexList.add( vertexList.get(6).clone() );//7
  vertexList.get(7).add( size*cos(teta), -size*sin(teta) );
  //D 
  PVector pointHelper = vertexList.get(7).truePoints();
  Vertex D = new Vertex( size, pointHelper.y + (size - pointHelper.x)/tan(teta)  );//8
  vertexList.add( D );
  vertexList.add(new Vertex( size, base ));//9
  vertexList.add(new Vertex( 0, base ));//10
  
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
  
  Vertex[] c3 = {new Vertex(vertexList.get(2).x,vertexList.get(2).y+8), new Vertex(vertexList.get(3).x, vertexList.get(3).y+8)};
  Vertex[] c4 = {new Vertex(vertexList.get(3).x,vertexList.get(3).y-10), new Vertex(vertexList.get(4).x, vertexList.get(4).y-10)};
  Vertex[] c5 = {new Vertex(vertexList.get(4).x,vertexList.get(4).y-10), new Vertex(vertexList.get(5).x, vertexList.get(4).y-10)};
  Vertex[] c6 = {new Vertex(vertexList.get(5).x,vertexList.get(5).y+10), new Vertex(vertexList.get(6).x, vertexList.get(6).y+10)};
  Vertex[] c7 = {new Vertex(vertexList.get(6).x,vertexList.get(6).y+10), new Vertex(vertexList.get(7).x, vertexList.get(7).y+10)};
  Vertex[] c8 = {new Vertex(vertexList.get(7).x,vertexList.get(7).y-10), new Vertex(vertexList.get(8).x, vertexList.get(8).y-10)};
  Vertex[] c9 = {new Vertex(vertexList.get(8).x,vertexList.get(8).y-10), new Vertex(vertexList.get(9).x, vertexList.get(9).y-10)};
  Vertex[] c10 = {new Vertex(vertexList.get(9).x,vertexList.get(9).y+8), new Vertex(vertexList.get(10).x, vertexList.get(10).y+8)};
  
  Edge E1 = new Edge(vertexList.get(0), vertexList.get(1));
  Vertex[] controlsE2 = new Vertex[2];
  PVector controlsE2Holder = PVector.add(vertexList.get(1).truePoints(), vertexList.get(2).truePoints());
  controlsE2Holder.div(2);
  controlsE2Holder.add(base/2,0,0);
  controlsE2[0] = new Vertex(controlsE2Holder);
  controlsE2[1] = new Vertex(controlsE2Holder);
  Edge E2 = new Edge(vertexList.get(1), vertexList.get(2), controlsE2);// essa
  Edge E3 = new Edge(vertexList.get(2), vertexList.get(3),c3);
  Edge E4 = new Edge(vertexList.get(3), vertexList.get(4),c4);
  Edge E5 = new Edge(vertexList.get(4), vertexList.get(5),c5);// essa
  Edge E6 = new Edge(vertexList.get(5), vertexList.get(6),c6);
  Edge E7 = new Edge(vertexList.get(6), vertexList.get(7),c7);// essa
  Edge E8 = new Edge(vertexList.get(7), vertexList.get(8),c8);
  Edge E9 = new Edge(vertexList.get(8), vertexList.get(9),c9);
  Edge E10 = new Edge(vertexList.get(9), vertexList.get(10),c10);
  Vertex[] controlsE11 = new Vertex[2];
  PVector controlsE11Holder = PVector.add(vertexList.get(10).truePoints(), vertexList.get(0).truePoints());
  controlsE11Holder.div(2);
  controlsE11Holder.add(-base/2,0,0);
  controlsE11[0] = new Vertex(controlsE11Holder);
  controlsE11[1] = new Vertex(controlsE11Holder);
  Edge E11 = new Edge(vertexList.get(10), vertexList.get(0), controlsE11);// essa
  
  Edge[] edges = { E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11 };
  
  //Centering object in screean
  center = new Vertex( origin[0], origin[1] );
  
  face = new Face( edges, center.truePoints() );
  Face[] facesArray = { face };
  um = new CgObject(facesArray);
  observer = new Vertex(origin[0], origin[1], 100);
  light = new Vertex( origin[0] + 100, origin[1]-100, 200);
  //light = new Vertex( 200, origin[1]-100, 100);
}

void draw(){
    background(255);
    if(elapsed_frames <= max_frames){
      face.rotate(omega);
    }
    um.drawWire(base);
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

class Quaternio{
 private float scalar;
 private PVector vector;
 
 public Quaternio(float scalar, PVector vector){
  this.scalar = scalar;
  this.vector = vector;
 }
 
 public Quaternio prod(Quaternio qtn){
  this.scalar = this.scalar*qtn.scalar + this.vector.dot(qtn.vector);
  this.vector = qtn.vector.mult(this.scalar).add(this.vector.mult(qtn.scalar)).add(this.vector.cross(qtn.vector));
  return this;
 }
 public PVector getVector(){
   return vector;
 }
}

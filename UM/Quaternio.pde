class Quaternio{
 private float scalar;
 private PVector vector;
 
 public Quaternio(float scalar, PVector vector){
  this.scalar = scalar;
  this.vector = vector;
 }
 
 public Quaternio prod(Quaternio qtn){
  float ResultScalar = this.scalar*qtn.scalar + this.vector.dot(qtn.vector);
  PVector ResultVector = PVector.mult(qtn.vector, this.scalar);
  ResultVector = PVector.add(PVector.mult(this.vector, qtn.scalar), vector);
  ResultVector = PVector.add(this.vector.cross(qtn.vector), vector);
  return new Quaternio(ResultScalar, ResultVector);
 }
 public PVector getVector(){
   return vector;
 }
}

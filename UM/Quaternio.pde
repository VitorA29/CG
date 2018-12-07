class Quaternio{
 private float scalar;
 private PVector vector;
 
 public Quaternio(float scalar, PVector vector){
  this.scalar = scalar;
  this.vector = vector;
 }
 
 public Quaternio prod(Quaternio qtn){
  float resultScalar = this.scalar*qtn.scalar + this.vector.dot(qtn.vector);
  PVector resultVector = PVector.mult(qtn.vector, this.scalar);
  resultVector = PVector.add(PVector.mult(this.vector, qtn.scalar), resultVector);
  resultVector = PVector.add(this.vector.cross(qtn.vector), resultVector);
  return new Quaternio(resultScalar, resultVector);
 }
 public PVector getVector(){
   return vector;
 }
}

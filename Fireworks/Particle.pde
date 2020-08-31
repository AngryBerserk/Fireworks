class Particle{
  PVector pos;
  boolean firework;
  float lifespan;
  color hu;
  PVector vel;
  PVector acc;
  
  Particle(float x, float y, color hu, boolean firework){
    pos = new PVector(x,y);
    this.firework = firework;
    lifespan = 100 + random(155);
    this.hu = hu;
    acc = new PVector(0,0);
    if (firework){
      vel = new PVector(0,random(-14,-10));
    }else{
      vel = new PVector(random(2)-1,random(2)-1);
      vel.mult(random(8,16));
    }  
  }

  void applyForce(PVector force){
    acc.add(force);
  }

  boolean done(){
    if (firework)
      return vel.y >= 0;
    else
      return lifespan < 0;
  }

  void update(){
    if (!firework){
      vel.mult(0.9);
      lifespan -= 3;
    }
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void show(){ 
    if (!firework){
      strokeWeight(2);
      stroke(hu, lifespan);
      }else{
        strokeWeight(4);
        stroke(hu, 255);
      }
      point(pos.x, pos.y);
  }
}
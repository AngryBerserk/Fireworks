ArrayList<Particle> fireworks = new ArrayList<Particle>();
PVector gravity;
PImage backbuffer;
ArrayList<Particle> toKill = new ArrayList<Particle>();
ArrayList<Particle> toSpawn = new ArrayList<Particle>();

void setup() {
  size(800, 600);
  //fullScreen();
  stroke(255);
  strokeWeight(4);
  background(0);
  backbuffer = createImage(width,height,RGB);
  colorMode(RGB);
  gravity = new PVector(0,0.2);
}

void draw() {
  background(0, 0, 0, 25);
  if (random(1) < 0.05)
    fireworks.add(new Particle(random(width),height, color(random(255),random(255),random(255)), true));
  for(Particle f : fireworks){
    update(f);
    f.show();
    if (f.done())
      toKill.add(f);
  }
  backbuffer.loadPixels();
  for (int x = 0; x<width; x++){
    for (int y = 0; y<height; y++){
        int  index = x+y*width;
        float sumR = 0;
        float sumG = 0;
        float sumB = 0;
        for(Particle f : fireworks){
          float d = dist(x,y,f.pos.x, f.pos.y);
          if (d<5000){
            sumR += 5 * red(f.hu) / d;
            sumG += 5 * green(f.hu) / d;
            sumB += 5 * blue(f.hu) / d;
          }
        }
        backbuffer.pixels[index] = color(constrain(sumR, 0, 220),constrain(sumG, 0, 220),constrain(sumB, 0, 220));
      }
    }
    backbuffer.updatePixels();
    image(backbuffer,0,0);
  kill();
}

void kill(){
  for(Particle p : toKill)
    fireworks.remove(p);
  toKill.clear();
  for(Particle p : toSpawn)
    fireworks.add(p);
  toSpawn.clear();
}

void update(Particle p){
      p.applyForce(gravity);
      p.update();
      if((p.firework && p.vel.y >= 0)|| (!p.firework && random(1)<0.001))
        explode(p);
}


void explode(Particle p){
    for (int i = 0; i < 3; i++)
      toSpawn.add(new Particle(p.pos.x, p.pos.y, p.hu, false));
    toKill.add(p);
    
}
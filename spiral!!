
Graph graph = new Graph();


float zoomFactor = 1;

void settings() {
  size(400, 400);
}
void setup() {
  background(0);
}
void draw() {
  background(0);
    stroke(255,255,0);
    graph.newDot(true);
      graph.display();
}
class Graph {
  float zoom = 1;
  PVector outermostPoint = new PVector(0,0);
  PVector firstDot;
  ArrayList <PVector> dots = new ArrayList<PVector>();
  float stepSize = 0.0062318;
  float t; //time (x or theta)
  double arcLength = 0;
  
  Graph() {
    
  }
  void zoomUpdate() {
    zoom = ( height/2)/outermostPoint.mag();
  }
  void display() {
    this.zoomUpdate();
    float prevX = firstDot.x * zoom;
    float prevY = firstDot.y * zoom;
    ellipse((width/2) +prevX,(height/2) - prevY,5,5);
    for(int i = 1; i<dots.size(); i++) {
      PVector dot = dots.get(i);
      float x = dot.x * zoom;
      float y = dot.y * zoom;
      fill(255,0,0);
      ellipse((width/2) + x,(height/2) - y,5,5);
      fill(0,255,255);
      stroke(0,255,0);
      line((width/2) + prevX,(height/2) + -prevY,(width/2) + x,(height/2) - y);
      float segmentLength = sqrt((x-prevX)*(x-prevX)+(y-prevY)*(y-prevY));
      if(segmentLength > 0) {
        arcLength = arcLength + segmentLength;
      }
      //println(arcLength);
      if(dot.mag() > outermostPoint.mag()){
       outermostPoint = dot; 
      }
      prevX = x;
      prevY = y;
    }
    
  }
  void newDot(boolean polar) {
    PVector newDot = new PVector(t,this.function(t));
    if(polar) {
      newDot = this.toCartesian(newDot);
    }
    dots.add(newDot);
    if(t==0) {
      firstDot = newDot;
    }
    t=t+stepSize;
     
  }
  float function(float x) {
   return 261.63* pow(2,x/12);
  }
  PVector toCartesian(PVector polar) {
    float theta = polar.x;
    float r = polar.y;
    return new PVector(theta*cos(r),theta*sin(r));
  }
  
  PVector toPolar(PVector cartesian){
    //i added it casue its cool
    return new PVector(atan2(cartesian.y,cartesian.x),sqrt(cartesian.x*cartesian.x+cartesian.y*cartesian.y));
  }  
}

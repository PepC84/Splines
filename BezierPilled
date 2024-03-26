// screensize {
final int PROGRAM_WIDTH = 1280;
final int PROGRAM_HEIGHT = 720;
// screensize }

//Bezier {
boolean manualMode;
int pointersOnScreen = 0;
int MANUAL_BEZIER_TOTAL_POINTS = 1000;
//Table manualTable = new Table();
//Bezier }
Bezier manualBezier;
void settings() {
  size(PROGRAM_WIDTH,PROGRAM_HEIGHT);
}
void setup() {
  manualBezier = new Bezier(MANUAL_BEZIER_TOTAL_POINTS);
}
void draw() {
  background(255);

  manualBezier.display();
  
}
void mouseReleased() {
  if(manualMode == true) {manualBezier.setPoints(false); }
}
 void keyPressed() {
 
  if(keyCode == 'M') { manualMode = !manualMode; manualBezier.setPoints(true); }
}
 
void keyReleased() {
 
  if(keyCode == 'P') { manualBezier.printPoints(); }
  if(keyCode == 'T') { manualBezier.printTable(); }
}

class Bezier {
  int q;
  boolean constructed;
  boolean tableDone;
  PVector p0,p1,p2,p3;
  PVector[] p = new PVector [4];
  float[] xP = new float[4];
  float[] yP = new float[4];
  Table table;
 Bezier(int qq, PVector[] pp) {
   p = pp;
   q = qq;
   constructed = true;
   for(int i=0;i<4;i++) {
     xP[i] = p[i].x;
     yP[i] = p[i].y;
   }
 }
 Bezier(int qq) {
   q = qq; //how many points
   
 }
 void printPoints() {
   if(constructed == true) {
     println(p[0].x,p[0].y);
      println(p1.x,p[1].y);
       println(p[2].x,p[2].y);
        println(p[3].x,p[3].y);
   }
   
   }
   void printTable() {
     Table T = this.getTable();
     for(int i=0; i<T.getRowCount();i++) {
        
     }
     for (TableRow row : T.rows()) {
          println(row.getFloat("X") + ": " + row.getFloat("Y"));
      }
    }
Table getTable() {
  if(tableDone==false) {
   return createTable(); 
  }
  return table;
}
void saveTable() {
  
 this.getTable(); 
 
}

   
Table createTable() {
  if(tableDone == true) {
   return getTable(); 
  }
 float step = 1/float(q);
 //T is the table that has all the points for the bezier
 Table T = new Table();
 T.addColumn("X");
 T.addColumn("Y");
 for(float i = 0;i < 1; i+= step) {
   TableRow n = T.addRow();
   PVector a = cubicBezier(i);
   n.setFloat("X",a.x);
   n.setFloat("Y",a.y);
 }
 tableDone=true;
 table = T;
 return T;
 
}

 
 
 void setPoints(boolean restart) {
    if(pointersOnScreen == 4 && restart == false) {
     return; 
    } 
    if(restart == true) {
     pointersOnScreen = 0;

     for(int i=0; i < 4; i++) {
      p[i] = null; 
     }
     constructed = false;
     tableDone=false;
     return;
    }
    if(pointersOnScreen == 3) {
     constructed = true; 
    }
  p[pointersOnScreen] = new PVector(mouseX,mouseY);
   pointersOnScreen++;
 }
 void updateFloatArraysToVectorArrays() {
     for(int i = 0; i < 4;i++) {
      xP[i] = p[i].x;
      yP[i] = p[i].y;
    }
 }
 void drawMiniTrueBezier() {
   updateFloatArraysToVectorArrays();
   float xLength = max(xP) - min(xP);
   float yLength = max(yP) - min(yP);
   float[] miniCurveX = new float[4];
   float[] miniCurveY = new float[4];
  
    for(int i = 0; i < 4;i++) {
   miniCurveX[i]   = 100/xLength * xP[i]  + 10  - 100/xLength * min(xP);
   miniCurveY[i]   = 100/yLength * yP[i]+ 10 - 100/yLength * min(yP) ;
    }

   rect(10,10,100,100);
   bezier(miniCurveX[0],miniCurveY[0],miniCurveX[1],miniCurveY[1],miniCurveX[2],miniCurveY[2],miniCurveX[3],miniCurveY[3]);
   
    for(int i = 0; i < 3; i++) {
     switch(i) {
       case 0:
         stroke(255,0,0);
       break;
       case 1:
         stroke(0,255,0);
       break;
       case 2:
         stroke(0,0,255);
       break;
      }
      line(miniCurveX[i],miniCurveY[i],miniCurveX[i+1],miniCurveY[i+1]);
    }

  
 }
 void display() {
  if(constructed == true) {
    for(int i = 0; i < 3; i++) {
     switch(i) {
       case 0:
         stroke(255,0,0);
       break;
       case 1:
         stroke(0,255,0);
       break;
       case 2:
         stroke(0,0,255);
       break;
      }
      line(p[i].x,p[i].y,p[i+1].x,p[i+1].y);
    }
    stroke(0);
    this.drawTable();
    drawMiniTrueBezier(); 
  } else {
   stroke(0);
    if (pointersOnScreen == 0) {
     return; 
    }
   stroke(255,20,147); 
   line(p[pointersOnScreen - 1 ].x,p[pointersOnScreen - 1].y,mouseX,mouseY);
   if (pointersOnScreen == 1) {
    return; 
   }
   for(int i=0; i < pointersOnScreen -1; i++) {
     
     line(p[i].x,p[i].y,p[i+1].x,p[i+1].y);
   }
  }
  
  
 }
void drawTable() {

  loadPixels();
      for (TableRow row : this.getTable().rows()) {
        try {
            pixels[int(row.getFloat("Y"))*width +int(row.getFloat("X")) ] = #FF0000;
        } catch(Exception e) {
            continue;
        }
       }     
 updatePixels();
}
 PVector cubicBezier(float t) {
   float q = 1-t;
   float w = sq(q);
   float e = w * q;
   
   float x = e*p[0].x   + 3 * t * w * p[1].x   + 3 * sq(t) * p[2].x * q + sq(t) * t * p[3].x  ;
   float y =  e*p[0].y   + 3 * t * w * p[1].y   + 3 * sq(t) * p[2].y * q + sq(t) * t * p[3].y; 
   //setting up vector multiplication in processing is a pain in the ass\\
   return new PVector(x,y);

  }
  
  
}


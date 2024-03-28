// screensize {
final int PROGRAM_WIDTH = 1280;
final int PROGRAM_HEIGHT = 720;
// screensize }
//Bezier {
boolean loadTableMode = false;
boolean drawingBezier = false;
int BEZIER_LUT_POINTS = 1000000;
float TARGET_SEPARATION = 0.2;
Table globalBezierTable = new Table();
Table loadedTable = new Table();
boolean cleared = false;
int pointersOnScreen = 0;
int beziersOnScreen = 0;
boolean displayStraightLines = true;
PVector[] drawingPoints = new PVector[4];
ArrayList <Bezier> bezierArr = new ArrayList<Bezier>();

TextInput nameFileText;

void settings() {
  size(PROGRAM_WIDTH,PROGRAM_HEIGHT);
}
void setup() {
  nameFileText = new TextInput(color(0,255,0),color(46,139,87),10,120 ,110,20);
  background(0);
}
void draw() {
  if (loadTableMode) {
      loadPixels();
      for (TableRow row : loadedTable.rows()) {
        try {
            pixels[int(row.getFloat(1))*width +int(row.getFloat(0)) ] = #FF0000;
        } catch(Exception e) {
            continue;
        }
       }     
   updatePixels();
    if(cleared == false) {
     cleared = true;
     background(0);
     stroke(0, 255, 255);
     line(0,height/3,width,height/3);
     line(width/3,0,width/3,height);
     line(0,height - height/3,width,height - height/3);
     line(width - width/3,0,width - width/3,height);
     stroke(255,0,255);
     line(0,height/2,width,height/2);
     line(width/2,0,width/2,height);
     line(0,height - height/4,width,height - height/4);
     line(width - width/4,0,width - width/4,height);
     line(0,height/4,width,height/4);
     line(width/4,0,width/4,height);
     stroke(0);
    }
    
  } else {
      background(0);
           stroke(0, 255, 255);

     line(0,height/3,width,height/3);
     line(width/3,0,width/3,height);
     line(0,height - height/3,width,height - height/3);
     line(width - width/3,0,width - width/3,height);
     stroke(255,0,255);
     line(0,height/2,width,height/2);
     line(width/2,0,width/2,height);
     line(0,height - height/4,width,height - height/4);
     line(width - width/4,0,width - width/4,height);
     line(0,height/4,width,height/4);
     line(width/4,0,width/4,height);
     stroke(0);
       nameFileText.display();
       for(Bezier part : bezierArr ) {

       part.display(); 
    }  
        if(drawingBezier) {   
      drawingBezierFunction();
      } else {
        if ( pointersOnScreen == 0 ) { 
      } else {
          pointersOnScreen = 1;
      }
    } 
  }

}

void drawingBezierFunction(){
       if (pointersOnScreen == 0) {
       return; 
     }
     stroke(255,20,147); 
     line(drawingPoints[pointersOnScreen - 1 ].x,drawingPoints[pointersOnScreen - 1].y,mouseX,mouseY);
     if (pointersOnScreen == 1) {
       return; 
     }
     for(int i=0; i < pointersOnScreen -1; i++) {
     
       line(drawingPoints[i].x,drawingPoints[i].y,drawingPoints[i+1].x,drawingPoints[i+1].y);
     }
}

void mousePressed() {
    if(loadTableMode == true ) { 
    return;  
  }
  nameFileText.selected = false;
 if(nameFileText.checkHitbox()){nameFileText.status = true; nameFileText.selected = true;  }
}
void mouseReleased() {
  if(loadTableMode == true ) { 
    
    return;  
  }
    
  if(nameFileText.checkHitbox()) { nameFileText.status = false;}
  if(drawingBezier == true ) {
    pointersOnScreen++;
    if(pointersOnScreen == 4) {
     beziersOnScreen++;
     pointersOnScreen=1;
     drawingPoints[3] = new PVector(mouseX,mouseY);
      for(int i = 0 ; i<4;i++) {
     }
     PVector[] temp = new PVector[4];
     for(int i = 0; i < 4; i++ ) {
       temp[i] = drawingPoints[i];
     }
     beziersOnScreen++;
     temp = drawingPoints;
     Bezier a = new Bezier(temp,beziersOnScreen);
     a.createTable();
     if(beziersOnScreen >2) {
     globalBezierTable.removeRow(globalBezierTable.getRowCount()-1);
     }
         for(TableRow row : a.T.rows()) {
          globalBezierTable.addRow(row); 
         }
     bezierArr.add(a);
     drawingPoints[0] = drawingPoints[3] ;
     return;
    }
    drawingPoints[pointersOnScreen-1] = new PVector(mouseX,mouseY);
  } else {
    if (pointersOnScreen >1) {
       pointersOnScreen = 1;
    }
   }
}
 void keyPressed() {
     if(loadTableMode == true ) { 
    drawingBezier = false;
    return;  
  }
  if(nameFileText.selected == true)  {
    if(keyCode== BACKSPACE) {
      if(nameFileText.input.equals("") ){
        return;
      }
      nameFileText.input = nameFileText.input.substring(0,nameFileText.input.length() -1);
      return;
    }
    if (keyCode == ENTER){
      nameFileText.selected = false;
      nameFileText.enter = true;
      saveTable(globalBezierTable, "data/" + nameFileText.input + " xX "+ globalBezierTable.getRowCount() +" Xx  By SplineLover84.csv");
      return;
    }
    if(key == CODED) {
      
    }  else {
      nameFileText.input += key;
      return;
    }
  } 
  if(keyCode == 'M') { 
    drawingBezier = !drawingBezier;
    
  }
    if(keyCode == 'R') { 
    
    pointersOnScreen = 0;
     bezierArr = new ArrayList<Bezier>();
    
  }
}
void keyReleased() {
  
   if(keyCode == 'L') { 
       selectInput("Select a file to process:", "fileSelected");
  }
  if(loadTableMode == true) {
   return; 
  }
  if(nameFileText.selected == true) {
    return;
  }
  if(keyCode == 'J') {
   displayStraightLines = !displayStraightLines ;
  }
  if(keyCode == 'P') {  
      for(Bezier part : bezierArr ) {
         part.printPoints(); 
      }
  }
  if(keyCode == 'T') { 
      println(globalBezierTable);
  }


}
void fileSelected(File selection) {
    if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println( selection.getAbsolutePath());
    loadedTable = loadTable(selection.getAbsolutePath(),"csv");
      loadTableMode = true;
      cleared = false;
  }
  background(255);
}

class Bezier {
  int BEZIER_TOTAL_POINTS;
  int id;
  PVector[] p = new PVector[4];
  float[] xP = new float[4];
  float[] yP = new float[4];
  Table T = new Table();
 Bezier(PVector[] pp,int idd) {
   p = pp;
   id = idd;
   for(int i=0;i<4;i++) {
     xP[i] = p[i].x;
     yP[i] = p[i].y;
     
   }
 }
  void printPoints() {
     println(p[0].x,p[0].y);
      println(p[1].x,p[1].y);
       println(p[2].x,p[2].y);
        println(p[3].x,p[3].y);
   
   }
void printCurve() {
     for (TableRow row : T.rows()) {
          println(row.getFloat("X") + ": " + row.getFloat("Y"));
      }
    }
void createTable() {
 T.addColumn("X");
 T.addColumn("Y");
 float distSum = 0;
 FloatList sumLUT = new FloatList();
 float step = 1/float(BEZIER_LUT_POINTS);
 for(float i=step;i<1;i+= step) {
   sumLUT.append(distSum);
   distSum = distSum +  dist(cubicBezier(i).x,cubicBezier(i).y,cubicBezier(i+step).x,cubicBezier(step+i).y);
 }
 float arcLength = sumLUT.get(sumLUT.size()-1) ;
 for(float j = 0; j< 1 ; j += TARGET_SEPARATION/arcLength) {
   float targetDist = arcLength * j ;
   for(int i = 0; i < sumLUT.size()-1; i++) {
     float nowDistSum = sumLUT.get(i);
     float nextDistSum = sumLUT.get(i+1);
     if (targetDist >= nowDistSum && targetDist < nextDistSum) {
       float adjustedT = map(targetDist,nowDistSum,nextDistSum,i/float(sumLUT.size()),(i+1)/float(sumLUT.size()));
       TableRow n = T.addRow();
       PVector a = cubicBezier(adjustedT);
       n.setFloat("X",a.x);
       n.setFloat("Y",a.y);
     }
   }
 }
BEZIER_TOTAL_POINTS = T.getRowCount();
}
  void display() {
   if (displayStraightLines) {
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
      line(xP[i],yP[i],xP[i+1],yP[i+1]); 
    }
   }
    stroke(0);
      loadPixels();
      for (TableRow row : T.rows()) {
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
class Box{
  color o;
  int x,y,xL,yL;
  color f;
  String text;

  Box(color outline,color fill,int xx,int yy , int xLength, int yLength) { 
    o=outline;
    f=fill;
    x=xx;
    y=yy;
    xL=xLength;
    yL=yLength;
  }
   void display() {
    stroke(o); 
    fill(f); 
    rect(x,y,xL,yL);
    fill(255);
    stroke(0);
  }
}
class TextBox extends Box{
  color o;
  int x,y,xL,yL;
  color f;
  String text;

  TextBox(color outline,color fill,int xx,int yy , int xLength, int yLength,String t) { 
    super(outline,fill,xx,yy,xLength,yLength);
    text = t;
  }
   void display() {
    super.display();
    text(text,x+2,y+15);
  }
  
}
class TextInput extends Box{
  String input = "";
  boolean status; //boolean status, true if pressed false if released;
  boolean selected;
  boolean enter;
  TextInput(color outline,color fill,int xx,int yy , int xLength, int yLength) { 
    super(outline,fill,xx,yy,xLength,yLength);
  }
  void display() {
    if(status) {
      stroke(f);
    } else {
     stroke(o);
    }
    fill(f); 
    rect(x,y,xL,yL);
    fill(0);
    if(selected) {
      if(frameCount%60 < 30) {text(input + "_",x+2,y + 15);} else {text(input,x+2,y+ 15);  }
    } else {
     text(input,x+2,y + 15); 
    }
    fill(255);
  }
  boolean checkHitbox() {
    
   if (mouseX > x && mouseX < x + xL && mouseY > y && mouseY < y + yL ) {
     
    return true;
    
   }
   return false;
  }
}

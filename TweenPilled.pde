// screensize {
final int PROGRAM_WIDTH = 1280;
final int PROGRAM_HEIGHT = 720;
boolean restartDraw ;
// screensize }
Table tween = new Table();
TextInput nameFileText;
void settings() {
  size(PROGRAM_WIDTH+1, PROGRAM_HEIGHT+1);
}
void setup() {
  nameFileText = new TextInput(color(0, 255, 0), color(46, 139, 87), 10, 120, 110, 20);
  background(0);
}
void draw() {
  
  if (restartDraw) {
    background(0);
    stroke(0, 255, 255);
    line(0, height/3, width, height/3);
    line(width/3, 0, width/3, height);
    line(0, height - height/3, width, height - height/3);
    line(width - width/3, 0, width - width/3, height);
    stroke(255, 0, 255);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);
    line(0, height - height/4, width, height - height/4);
    line(width - width/4, 0, width - width/4, height);
    line(0, height/4, width, height/4);
    line(width/4, 0, width/4, height);
    stroke(0);
    int id = 0;
    for (TableRow row : tween.rows()) {
      set(int(map(id,0,tween.getRowCount()+1,0,float(PROGRAM_WIDTH))),int(map(1-row.getFloat("Y"),0,1,0,PROGRAM_HEIGHT)),#FF0000);
        id++;
    }
    nameFileText.display();
  } else {
    createTween();
  }
}
void createTween() {
  final float STEP = (0.00001);
  final int INV_STEP = 10000;
  tween.addColumn("Y");
  //float easeDirection;
  for (float i =0; i<INV_STEP; i++) {
    // tween.addRow().setFloat(int(i*STEP) , pow(i,5));

    TableRow newRow = tween.addRow();
    newRow.setFloat("Y", pow(norm(i,0,INV_STEP), 5));
    println(i, pow(norm(i,0,INV_STEP), 5));
  }
  restartDraw= true;
}
void mousePressed() {
  nameFileText.selected = false;
  if (nameFileText.checkHitbox()) {
    nameFileText.status = true;
    nameFileText.selected = true;
  }
}
void mouseReleased() {
  if (nameFileText.checkHitbox()) {
    nameFileText.status = false;
  }
}
void keyPressed() {

  if (nameFileText.selected == true) {
    if (keyCode== BACKSPACE) {
      if (nameFileText.input.equals("") ) {
        return;
      }
      nameFileText.input = nameFileText.input.substring(0, nameFileText.input.length() -1);
      return;
    }
    if (keyCode == ENTER) {
      nameFileText.selected = false;
      nameFileText.enter = true;
      saveTable(tween, "data/" + nameFileText.input + " xX "+ tween.getRowCount() +" Xx tween.csv");
      return;
    }
    if (key == CODED) {
    } else {
      nameFileText.input += key;
      return;
    }
  }
}
void keyReleased() {
}

class Box {
  color o;
  int x, y, xL, yL;
  color f;
  String text;

  Box(color outline, color fill, int xx, int yy, int xLength, int yLength) {
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
    rect(x, y, xL, yL);
    fill(255);
    stroke(0);
  }
}
class TextBox extends Box {
  color o;
  int x, y, xL, yL;
  color f;
  String text;

  TextBox(color outline, color fill, int xx, int yy, int xLength, int yLength, String t) {
    super(outline, fill, xx, yy, xLength, yLength);
    text = t;
  }
  void display() {
    super.display();
    text(text, x+2, y+15);
  }
}
class TextInput extends Box {
  String input = "";
  boolean status; //boolean status, true if pressed false if released;
  boolean selected;
  boolean enter;
  TextInput(color outline, color fill, int xx, int yy, int xLength, int yLength) {
    super(outline, fill, xx, yy, xLength, yLength);
  }
  void display() {
    if (status) {
      stroke(f);
    } else {
      stroke(o);
    }
    fill(f);
    rect(x, y, xL, yL);
    fill(0);
    if (selected) {
      if (frameCount%60 < 30) {
        text(input + "_", x+2, y + 15);
      } else {
        text(input, x+2, y+ 15);
      }
    } else {
      text(input, x+2, y + 15);
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

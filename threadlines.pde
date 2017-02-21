PImage img;
ArrayList<HLine> pix;
color bg;

//modify these
int margin = 10;
int threads = 3;
int looseness = 10;
boolean smooth = true;
int thickness = 2;

void setup() {
  //make sure to change these!
  img = loadImage("image.png"); //make sure to rename this to your image!
  size(1280, 720); //replace with w/h of your image
  bg = color(255, 255, 255); //background color of your image
  strokeWeight(thickness);
  
  noFill();
  image(img, 0, 0);  
  loadPixels();
  pix = new ArrayList<HLine>();
  
  //grab points
  boolean started;
  int x1,y,x2;
  for (int i = 0; i < height; i += margin) {
    started = false;
    x1 = 0;
    x2 = 0;
    y = i;
    for (int j = 0; j < width; j++) {
      if (get(j, i) != bg && !started) { //start point
        started = true;
        x1 = j; 
      }
      
      if ((get(j, i) == bg  || j == width - 1) && started) { //end point
        x2 = j;
        pix.add(new HLine(x1, x2, y));
        started = false;
      }
    }
  }
}

void draw() {
  //clear image
  background(bg);
  
  //draw threads
  for (int i = 0; i < threads; i++) {
    for (V3 v : pix) {
      stroke(0, 0, 0);
      if (smooth) {
        bezier(v.x1, v.y, (v.x1+v.x2)/2, v.y + random(-looseness, looseness), 
          (v.x1+v.x2)/2, v.y + random(-looseness, looseness), v.x2, v.y);
      } else {
        bezier(v.x1, v.y, random(v.x1,v.x2), v.y + random(-looseness, looseness),
          random(v.x1,v.x2), v.y + random(-looseness, looseness), v.x2, v.y);
      }
    }
  }
  saveFrame("m" + margin + " t" + threads+ " l" + looseness + " t" + thickness + ".png");
  exit();
  
}

class HLine { //probably unnecessary
  int x1, y, x2;
  HLine (int x1, int x2, int y) {
    this.x1 = x1;
    this.y = y;
    this.x2 = x2;
  }
}
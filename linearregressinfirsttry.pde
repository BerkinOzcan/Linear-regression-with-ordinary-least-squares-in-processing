// Gets your mouse position and taps, adds an DataPoint object to the data array.
// Draws circles to represent data points.
//Maps the canvas so that it fits the cartesian coordinate system (bottom left corner being (0,0) and top right corner being (1,1)


ArrayList<DataPoints> data = new ArrayList<DataPoints>(); // array for storing datapoint objects
float m =0.5;
float b = 0;      // inital values for m and b are random
void setup() {
size(600,600);
}

void draw() {
background(50);
for (int i=0; i<data.size(); i++) {   // iterate through datapoint objects, map their xPos and yPos values to the canvas then draw them as little circles
  DataPoints d = data.get(i);
  float x = map(d.xPos, 0, 1, 0, width);
  float y = map(d.yPos, 0, 1, height, 0);
  stroke(255);
  fill(255);
  ellipse(x, y, 20, 20);
}


stroke(255,0,255);
if(data.size() > 1 && calcLinearRegression() == true) {      // make sure that there is more than one datapoints and
drawLine();                                                  // in the formula shown in readme file (equation number 1)
}

}
void mousePressed() {                     // add datapoints every time user presses
float x = map(mouseX, 0, width, 0, 1);
float y = map(mouseY, 0, height, 1, 0);
data.add(new DataPoints(x, y));

}

boolean calcLinearRegression() {  // check if denominator is zero, if not return true

  float xsum = 0;
  float ysum = 0;
  for(int i=0; i<data.size(); i++) {        
    DataPoints d = data.get(i);
    xsum += d.xPos;
    ysum += d.yPos;
  }
  float xmean = xsum / data.size();   // do the calculations
  float ymean = ysum / data.size();
  
  
  float numerator = 0;
  float denominator = 0;
  for(int i=0; i<data.size(); i++) {
        DataPoints d = data.get(i);
  numerator += (d.xPos - xmean) * (d.yPos - ymean);
  denominator += (d.xPos - xmean) * (d.xPos - xmean);
  }
  m = numerator / denominator;
  b = ymean - m * xmean;
  if(denominator != 0) return true;
  else return false;
}

void drawLine() {
  float x1 = 0;                               //draw a line between (x1,y1) and (x2,y2)
  float y1 = m * x1 + b;                      // notice that x1 and x2 are most left and most right of the canvas.
  float x2 = 1;                               // y1 and y2 values are what correspond to the x values in the y=mx equation.
  float y2 = m * x2 + b;
  x1 = map(x1, 0, 1, 0, width);
  y1 = map(y1, 0, 1, height, 0);
  x2 = map(x2, 0, 1, 0, width);
  y2 = map(y2, 0, 1, height, 0);
  line(x1,y1,x2,y2);

}

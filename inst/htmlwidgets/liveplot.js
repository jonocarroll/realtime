var g = 50;  //margin
var plot_width = 725 + g;
var plot_height = 100;
var grid_width = 100;
  
var ws = new WebSocket("ws://localhost:9454/");
var data_stream = [];
  
ws.onmessage = function(msg) {
  console.log(msg);
  var data0 = JSON.parse(msg.data);
  data_stream.push(data0.x[0]);
};  
  
function setup() {
  createCanvas(plot_width, plot_height); // use a multiple of 50 for height
  noFill();
}
  
/**
* Grid Lines
*/
function grid() {
  var w = canvas.width,
  h = canvas.height;
  /**
  * draw the axes
  *
  * stroke(0); // black
  * line(0, 0, w, 0);
  * line(0, 0, 0, h);
  */
  
  /**
  * i is used for both x and y to draw
  * a line every 50 pixels starting at
  * XXX.5 to offset the canvas edgesXXX
  * http://jsfiddle.net/DarkThrone/DNUCw/
  */
  stroke(255); // white
  for(var i = 0; i < w || i < h; i += grid_width) {
    // draw horizontal lines
    line(i + g, 0, i + g, h);
    // draw vertical lines
    line(0, h - i + g, w, h - i + g);
  }
  
  /**
  * white out the axes space
  */
  noStroke();
  fill(255, 255, 255);
  rect(0, height-g, width, height);
  rect(0, 0, g, height);
  noFill();
  
  /**
  * draw the tick marks
  */
  stroke(0); // black
  for (var i = grid_width; i < (w - g) || i < (h - g); i += grid_width) {
    // draw horizontal lines
    line(g + i, height - g, g + i, height - g + 5);
    // draw vertical lines
    line(g, i - g, g - 5, i - g);
  }
  
  /**
  * draw the tick labels
  */
  textSize(12);
  textAlign(CENTER, CENTER);
  textFont('Helvetica');
  for (var i = grid_width; i < (w - g) || i < (h - g); i += grid_width) {
    // draw y labels
    text(i, g - 20, height - g - i);
    // draw x labels
    text(i, i + g, height - g + 20);
  }
  
  /**
  * draw the axis label
  */
  text("frequency", g + (plot_width - g)/2, h - 10);
}
  
function draw() {
  background('#ebebeb'); // grey92
  grid();
  
  beginShape();
  for (i = 0; i < data_stream.length; i++) {
    stroke(0);
    vertex(i + g, map(data_stream[i], 0, 255, height - g, g) );
  }
  endShape();
}

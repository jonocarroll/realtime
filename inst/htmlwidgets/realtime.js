HTMLWidgets.widget({
  name: "realtime",
  type: "output",
  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        // set global constants
        var y_data = [];
        var padding = 50;
        var start_x = 0;
        // define function to create plot
        var fun = function(p) {
          p.setup = function() {
            p.createCanvas(width, height);
            p.noFill();
          };
          p.draw = function() {
            /* initialize variables */
            var w = p.canvas.width, h = p.canvas.height;
            var gridwidth = 100;

            /* get new data from R */
            // generate random number between zero and one
            var new_data = Math.random();

            /* append new data to array */
            y_data.push(new_data);
            if (y_data.length > (width - padding)) {
              y_data.shift();
              start_x = start_x + 1;
            }
            var curr_min = Math.min(...y_data);
            var curr_max = Math.max(...y_data);
            var axis_min = curr_min - ((curr_max - curr_min) * 0.1);
            var axis_max = curr_max + ((curr_max - curr_min) * 0.1);

            // set background
            p.background('#ebebeb');

            /* set up plot */
            // create axes
            p.stroke(255); // white
            for(var i = 0; i < w || i < h; i += gridwidth) {
                // draw horizontal lines
                p.line(i + padding, 0, i + padding, h);
                // draw vertical lines
                p.line(0, h - i + padding, w, h - i + padding);
            }

            // white out axes space
            p.noStroke();
            p.fill(255, 255, 255);
            p.rect(0, height - padding, width, height);
            p.rect(0, 0, padding, height);
            p.noFill();

            // draw tick marks
            p.stroke(0); // black
              for (var i = gridwidth; i < (w - padding) || i < (h - padding);
                   i += gridwidth) {
                // draw horizontal lines
                p.line(padding + i, height - padding, padding + i,
                     height - padding + 5);
                // draw vertical lines
                p.line(padding, i - padding, padding - 5, i - padding);
              }

            // draw tick labels
            p.textSize(12);
            p.textAlign(p.CENTER, p.CENTER);
            p.textFont('Helvetica');
            for (var i = gridwidth; i < (w - padding) || i < (h - padding);
                 i += gridwidth) {
              // draw y labels
              var lab = p.map(i, 0, height - padding, axis_min, axis_max);
              lab = Math.round(lab * 100) / 100;
              p.text(lab, padding - 20, height - padding - i);
              // draw x labels
              p.text(i + start_x, i + padding, height - padding + 20);
            }

            // draw the axis label
            p.text("LABEL", padding + (width - padding) / 2, h - 10);

            /* add data */
            p.beginShape();
            for (i = 0; i < y_data.length; i++) {
              p.stroke(0);
              p.vertex(i + padding, p.map(y_data[i], axis_min, axis_max,
                                          height - padding, 0));
            }
            p.endShape();
          };
        };
        // create p5 sketch
        var p = new p5(fun, el.id);
      },
      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size


      }
    };
  }
});

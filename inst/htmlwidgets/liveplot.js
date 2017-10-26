HTMLWidgets.widget({
  name: "liveplot",
  type: "output",
  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        // set global constants
        var y_data = [];
        var n_points = 10;
        var padding = 50;

        // define function to create plot
        var fun = function(p) {
          p.setup = function() {
            createCanvas(width, height);
            noFill();
          };
          p.draw = function() {
            /* set up plot */
            var w = canvas.width, h = canvas.height;
            var gridwidth = 100;

            /* get new data from R */
            // generate random number between zero and one
            var new_data = Math.random();

            /* append new data to array */
            y_data.push(new_data);

            /* remove old points if needed */
            if (x_data.length > n_points) {
              x_data.shift();
              y_data.shift();
            }

            // set background
            background('#ebebeb');

            // create axes
            stroke(255); // white
            for(var i = 0; i < w || i < h; i += gridwidth) {
                // draw horizontal lines
                line(i + padding, 0, i + padding, h);
                // draw vertical lines
                line(0, h - i + padding, w, h - i + padding);
            }

            // white out axes space
            noStroke();
            fill(255, 255, 255);
            rect(0, height - padding, width, height);
            rect(0, 0, g, height);
            noFill();

            // draw tick marks
            stroke(0); // black
              for (var i = gridwidth; i < (w - padding) || i < (h - padding);
                   i += gridwidth) {
                // draw horizontal lines
                line(padding + i, height - padding, padding + i,
                     height - padding + 5);
                // draw vertical lines
                line(padding, i - padding, padding - 5, i - padding);
              }

            // draw tick labels
            textSize(12);
            textAlign(CENTER, CENTER);
            textFont('Helvetica');
            for (var i = gridwidth; i < (w - padding) || i < (h - padding);
                 i += gridwidth) {
              // draw y labels
              text(i, padding - 20, height - padding - i);
              // draw x labels
              text(i, i + padding, height - padding + 20);
            }

            // draw the axis label
            text("LABEL", padding + (plotwidth - padding) / 2, h - 10);

            /* compute y-axis range */
            var curr_min = Math.max(...y_data);
            var curr_max = Math.max(...y_data);
            var axis_min = curr_min * ((curr_max - curr_min) * 0.1);
            var axis_max = curr_max * ((curr_max - curr_min) * 1.1);

            /* add data */
            beginShape();
            for (i = 0; i < x_data.length; i++) {
              stroke(0);
              vertex(i + padding, map(x_data[i], axis_min, axis_max,
                     height - padding, padding));
            }
            endShape();
          };
          // create p5 sketch
          var new p5(fun, el.id);
        };
      },
      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size


      }
    };
  }
});

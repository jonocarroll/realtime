# arbitrary_factory <- function(txt) {
#     txt
# }

# @param sketch A p5 object.
# @param func A string of a function name.
# @param factory A function which returns a function that creates the p5 string.
arbitrary_prototype <- function(sketch, func, txt){
  section <- get_section(sketch, func)

  sketch$x[[section]] <- sketch$x[[section]] %>%
    js_append(txt)
  sketch
}

#' @export
grid <- function(sketch) {
    grid_js <- '
        function grid() {

        var g = 50;
        var plotwidth = 725 + g;
        var plotheight = 400;
        var gridwidth = 100;

        var w = 775,
            h = 400;

        /**
         * draw the axes
         *
         * p.stroke(0); // black
         * line(0, 0, w, 0);
         * line(0, 0, 0, h);
         */

        /**
         * i is used for both x and y to draw
         * a line every 50 pixels starting at
         * XXX.5 to offset the canvas edgesXXX
         * http://jsfiddle.net/DarkThrone/DNUCw/
         */
        p.stroke(255); // white
        for(var i = 0; i < w || i < h; i += gridwidth) {
            // draw horizontal lines
            p.line(i + g, 0, i + g, h);
            // draw vertical lines
            p.line(0, h - i + g, w, h - i + g);
        }

    }'
    # grid_js <- '
    # function grid() {
    #     p.rect(50, 50, 100, 100);
    # }'
    sketch <- arbitrary_prototype(sketch, "between", grid_js)
    sketch <- arbitrary_prototype(sketch, "draw", 'grid();')
    sketch
}

    # grid_js <- '
    #     function grid() {
    # 
    #     var g = 50;
    #     var plotwidth = 725 + g;
    #     var plotheight = 400;
    #     var gridwidth = 100;
    # 
    #     var w = 775,
    #         h = 400;
    # 
    #     /**
    #      * draw the axes
    #      *
    #      * p.stroke(0); // black
    #      * line(0, 0, w, 0);
    #      * line(0, 0, 0, h);
    #      */
    # 
    #     /**
    #      * i is used for both x and y to draw
    #      * a line every 50 pixels starting at
    #      * XXX.5 to offset the canvas edgesXXX
    #      * http://jsfiddle.net/DarkThrone/DNUCw/
    #      */
    #     p.stroke(125); // white
    #     for(var i = 0; i < w || i < h; i += gridwidth) {
    #         // draw horizontal lines
    #         p.line(i + g, 0, i + g, h);
    #         // draw vertical lines
    #         p.line(0, h - i + g, w, h - i + g);
    #     }
    # 
    #     /**
    #      * white out the axes space
    #      */
    #     p.noStroke();
    #     p.fill(255, 255, 255);
    #     p.rect(0, height-g, width, height);
    #     p.rect(0, 0, g, height);
    #     p.noFill();
    # 
    #     /**
    #       * draw the tick marks
    #       */
    #     p.stroke(0); // black
    #     for(var i = gridwidth; i < (w - g) || i < (h - g); i += gridwidth) {
    #         // draw horizontal lines
    #         p.line(g + i, height - g, g + i, height - g + 5);
    #         // draw vertical lines
    #         p.line(g, i - g, g - 5, i - g);
    #     }
    # 
    #     /**
    #       * draw the tick labels
    #       */
    #     p.textSize(12);
    #     p.textAlign(CENTER, CENTER);
    #     p.textFont(\'Helvetica\');
    #     for(var i = gridwidth; i < (w - g) || i < (h - g); i += gridwidth) {
    #         // draw y labels
    #         p.text(i, g - 20, height - g - i);
    #         // draw x labels
    #         p.text(i, i + g, height - g + 20);
    #     }
    # 
    #     /**
    #      * draw the axis label
    #      * p.text("frequency", g + (plotwidth - g)/2, h - 10);
    #      */
    # 
    # }'

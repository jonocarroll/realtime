#' @export
add_data_stream <- function(sketch, location) {
    pre_js <- glue::glue({'
    var ws = new WebSocket(\'{location}\');
    var data_stream = [];
  
    ws.onmessage = function(msg) {{
      console.log(msg);
      var data0 = JSON.parse(msg.data);
      data_stream.push(data0.x[0]);
    }};  
    '})
    vertex_js <- glue::glue('
        p.beginShape();
        for (i = 0; i < data_stream.length; i++) {{
           p.stroke(0);
           p.vertex(i + 50, p.map(data_stream[i], 0, 255, {sketch$height} - 50, 50) );
        }}
        p.endShape();
    ')

    sketch <- arbitrary_prototype(sketch, "pre", pre_js)
    sketch <- arbitrary_prototype(sketch, "draw", vertex_js)
    sketch
}  


    # var ws = new WebSocket(\'ws://localhost:9454/\');

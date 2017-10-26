#' @include internal.R
NULL

#' Live plot
#'
#' Create a live plot.
#'
#' @param ... TODO
#'
#' @export
liveplot <- function(message, width = 200, height = 0, elementId = NULL) {
  
  # forward options using x
  x = list()
  
  # create widget
  htmlwidgets::createWidget(
    name = 'liveplot',
    x,
    width = width,
    height = height,
    package = 'realtime',
    elementId = elementId
  )
}
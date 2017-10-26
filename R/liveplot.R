#' @include internal.R
NULL

#' Live plot
#'
#' Create a live plot.
#'
#' @param x \code{function} for fetching and process data.
#'
#' @param wait \code{numeric} number of seconds to wait between plot
#'   update.
#'
#' @param width \code{numeric} the width of the plot.
#'
#' @param height \code{numeric} the height of the plot.
#'
#' @param padding \code{numeric} the padding of the plot.
#'
#' @details The argument to \code{x} should be a function that returns
#'   a \code{numeric} vector containing a \code{X} and \code{Y} coordinates
#'   for plotting in real-time.
#'
#' @examples
#' \donttest{
#' liveplot(function() rnorm(10), 10)
#' }
#'
#' @export
liveplot <- function(x, wait = 5, width = NULL, height = NULL, padding = 0) {
  p <- htmlwidgets::createWidget(
    "liveplot",
    structure(list(wait = wait)),
    width = width, height = height,
    # sizingPolicy = htmlwidgets::sizingPolicy(
    #   defaultWidth =  400,
    #   defaultHeight = 400,
    #   padding = padding,
    #   browser.fill = FALSE
    # ),
    package = "realtime"
  )
  p
}

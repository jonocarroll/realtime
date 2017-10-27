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
#' realtime(function() rnorm(1), 10)
#' }
#'
#' @export
realtime <- function(x, wait = 5,  padding = 0, width = NULL, height = NULL,
                     elementId = NULL) {
  # validate inputs
  assertthat::assert_that(is.function(x), assertthat::is.scalar(x()),
                          assertthat::is.scalar(padding),
                          assertthat::is.count(width) || is.null(width),
                          assertthat::is.count(height) || is.null(height),
                          assertthat::is.string(elementId) ||
                            is.null(elementId))
  # set up R process to serve data
  api(x, wait = wait)
  # create html widget
  p <- htmlwidgets::createWidget(
    "realtime",
    structure(list(wait = wait)),
    width = width, height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth =  400,
      defaultHeight = 400,
      padding = padding,
      browser.fill = FALSE
    ),
    elementId = elementId,
    package = "realtime"
  )
  p
}

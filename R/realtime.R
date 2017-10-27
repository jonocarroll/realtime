#' @include internal.R
NULL

#' Live plot
#'
#' Create a live plot.
#'
#' @param x \code{function} for fetching and process data.
#'
#' @param title \code{character} title for the plot.
#'
#' @param ylim \code{numeric} range for y-axis.
#'
#' @param padding \code{numeric} the padding of the plot.
#'
#' @param width \code{numeric} the width of the plot.
#'
#' @param height \code{numeric} the height of the plot.
#'
#' @param elementId \code{character} HTML element identifier.
#'
#' @details The argument to \code{x} should be a function that returns
#'   a \code{numeric} vector containing a \code{X} and \code{Y} coordinates
#'   for plotting in real-time.
#'
#' @examples
#' \donttest{
#' realtime(function() rnorm(1, mean = 5), "Random numbers")
#' }
#'
#' @export
realtime <- function(x, title = "Real time data", ylim = NULL, padding = 0,
                     width = NULL, height = NULL, elementId = NULL) {
  # validate inputs
  assertthat::assert_that(is.function(x), assertthat::is.scalar(x()),
                          assertthat::is.string(title),
                          is.null(ylim) || (is.numeric(ylim) &&
                                            length(ylim) == 2 &&
                                            all(is.finite(ylim)) &&
                                            ylim[1] < ylim[2]),
                          assertthat::is.scalar(padding),
                          assertthat::is.count(width) || is.null(width),
                          assertthat::is.count(height) || is.null(height),
                          assertthat::is.string(elementId) ||
                            is.null(elementId))
  # set up R process to serve data
  api(x)
  # create html widget
  p <- htmlwidgets::createWidget(
    "realtime",
    structure(list(title = title, ylim = ylim)),
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

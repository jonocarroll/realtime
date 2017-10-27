#' @include internal.R
NULL

#' Wrapper functions for \code{liveplot} in \code{shiny}
#'
#' Use \code{leafletOutput()} to create a UI element, and
#'\code{renderLeaflet()} to render the widget.
#'
#' @param outputId \code{character} output variable to read from.
#'
#' @param width \code{numeric} width of the map (see \code{shinyWidgetOutput}).
#'
#' @param height \code{numeric} height of the map (see
#'   \code{shinyWidgetOutput}).
#'
#' @param expr An expression that generates an HTML widget.
#'
#' @param env The environment in which to evaluate \code{expr}.
#'
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()}).
#'   This is useful if you want to save an expression in a variable.
#'
#' @name liveplotshiny
NULL

#' @rdname liveplotshiny
#' @export
liveplotOutput <- function(outputId, width = "100%", height = 400) {
  htmlwidgets::shinyWidgetOutput(outputId, "liveplot", width, height,
                                 "liveplot")
}

#' @rdname liveplotshiny
#' @export
renderliveplot <- function(expr, env = parent.frame(), quoted = FALSE) {
 if (!quoted) expr = substitute(expr)  # force quoted
  htmlwidgets::shinyRenderWidget(expr, liveplotOutput, env, quoted = TRUE)
}

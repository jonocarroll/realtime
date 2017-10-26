#' @include include.R
NULL

#' Wrapper functions for \code{realtime} in \code{shiny}
#'
#' Use \code{leafletOutput()} to create a UI element, and
#'\code{renderLeaflet()} to render the widget.
#'
#' @param outputId \code{character }output variable to read from.
#'
#' @param width \code{numeric} width of the map (see \code{shinyWidgetOutput}).
#'
#' @param height \code{numeric} height of the map (see
#'   \code{shinyWidgetOutput}).
#'
#' @param expr An expression that generates an HTML widget.
#'
#' @param env The environment in which to evaluate \code{expr|.
#'
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})?
#'   This is useful if you want to save an expression in a variable.
#'
#' @name realtimeshiny
NULL

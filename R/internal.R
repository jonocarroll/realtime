#' Create an API
#'
#' Turn a function into an API service.
#'
#' @param x \code{function} for fetching and process data.
#'
#' @return invisible \code{TRUE}.
#'
#' @examples
#' # create an API that returns a random number
#' api(function() rnorm(1))
#'
#' # generate a random number
#'
#' @noRd
api <- function(x, wait = 0) {
  # validate inputs
  assertthat::assert_that(is.function(x), assertthat::is.scalar(x()),
                          assertthat::is.count(wait) || identical(wait, 0))
  # create api service
  x = function() rnorm(1)
  wait = 0
  s <- list(
    call = function(req) {
      stop("not implemented.")
    },
    onWSOpen = function(ws) {
      ws$onMessage(function(binary, message) {
        Sys.sleep(wait)
        if (message != "exit") {
          ws$send(x())
        } else {
          q(save = "no")
        }
      })
    }
  )
  # save data
  path <- tempfile(fileext = ".rda")
  save(s, x, wait, file = path, envir = environment())
  # create service
  cmd <- paste0("load('", path, "');",
                "httpuv::runServer('0.0.0.0', 9454, s, 250)")
  handle <- subprocess::spawn_process(R_binary(), c("--no-save", "-e", cmd))
  # return
  invisible(TRUE)
}

#' \code{R} path
#'
#' \code{R} binary path.
#'
#' @return \code{character} file path.
#'
#' @examples
#' print(R_binary())
#'
#' @noRd
R_binary <- function() {
  R_exe <- ifelse(tolower(.Platform$OS.type) == "windows", "R.exe", "R")
  return(file.path(R.home("bin"), R_exe))
}

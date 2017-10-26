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
api <- function(x) {
  handle <- subprocess::spawn_process(R_binary(), c('--no-save'))
  # create api service
  s <- list(
    call = function(req) {
      address <- ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST)
      wsUrl <- paste0("\"", "ws://", address, "\"")
      list(
        status = 200L,
        headers = list('Content-Type' = 'text/html'),
        body = "realtime api"
      )
    },
    onWSOpen = function(ws) {
      ws$onMessage(function(binary, message) {
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
  save(s, x, file = path)
  # create service
  code <- paste0("load(\"", path,
                 "\"); httpuv::runServer(\"0.0.0.0\", 9454, s, 250)\n\n")
  subprocess::process_write(handle, code)
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

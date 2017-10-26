# # An example to use the liveplot function.
# library(httpuv)
# library(jsonlite)
# 
# app <- list(
#   call = function(req) {
#     stop("call is not implemented. Something is wrong if you see this")
#   },
#   onWSOpen = function(ws) {
#     id = 1
#     while(TRUE){
#       x = rnorm(1, 150, 2.5)
#       ws$send(toJSON(list(x = x)))
#       Sys.sleep(0.1)
#       id = id+1
#     }
#   }
# )
# 
# library(realtime)
# liveplot()
# runServer("0.0.0.0", 9454, app, 250)

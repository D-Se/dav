helloA <- function() {
  system(paste(getwd(),"helloA",sep="/"))
}


#dyn.load("helloA1.so")
# 
# dyn.load("helloA1")
# helloA1 <- function() {
#   result <- .Call("helloA1")
# }
# helloA1()

# wrapper function to return a greeting.
dyn.load("helloC1")
helloC1 <- function(greeting) {
  result <- .Call("helloC1", greeting)
  return(result)
}

helloC1(c("Hello", "Hi"))


dyn.load("doubleme")
.Call("double_me2", 5L)


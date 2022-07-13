#' adaptive neuro fuzzy inference system
#' 
#' evaluate the subjective parameters of a data asset.
#' 
#' @param asset a data asset
#' @param spec a model specification
#' @param \dots arguments passed to and from methods
#'  
#' @return null
#' @references 
#' Jang, J.R. (1993). ANFIS: adaptive-network-based- fuzzy inference
#' system. *IEEE transactions on systems, man, and cybernetics, 23*(3), 665-685
#' @seealso \code{\link[=dat]{dat}} for user-facing function.
anfis <- function(asset, spec, ...) {
  NULL
}

fis <- function() {
  list(
    type = "mamdani", member = "t1",
    and = "min", or = "max", imp = "min",
    agg = "max",  defuzz = "centroid"
  )
}

##### membership functions #####
# tunable parameters in ANFIS

#' membership functions
#' @references 
#' Talpur, N., Salleh, M. N. M. & Hussain, K. (2017). 
#' An investigation of membership functions on performance of ANFIS for 
#' solving classification problems. 
#' *In IOP Conference Series: Materials Science and Engineering, 226*(1), 012103


mf_linear <- function(x, ...) {
  x %*% c(...)
}

#' generalized bell membership function
mf_bell <- function(x, a, b, c, h = 1) {
  1 / (1 + abs((x - c) / a)^ (2 * b))
}

#' Truncated triangle shape membership
#' 
#' @param a,b feet
#' @param c, d shoulders
mf_trapzoid <- function(x, a, b, c, d, h = 1) {
  max(
    0,
    min(
      1,
      (x - a) / (b - a),
      (d - x) / (d - c)
    )
  )
}


#' @param a,c feet
#' @param b tip of the curve
mf_triangular <- function(x, a, b, c, h = 1) {
  max(
    0,
    min(
      1,
      (x - a) / (c - x),
      (b - a) / (c - b)
    )
  )
}

mf_gaussian <- function(x, c, o, h = 1) {
  e <- 2.7182818284590452353602874713527
  e^(-.5 * (( x - c ) / o ) ^ 2) * h
  #exp(-(x - c)^2 / (2 * o^2)) * 1
}

mf_trim <- function(x, a, b, c, h = 1) {
  max(
    0,
    min(
      (x - a) / (b - a),
      (c - x) / (c - b)
    )
  ) * h
}
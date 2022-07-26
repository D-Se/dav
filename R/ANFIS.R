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
  build_anfis(spec)
}

# placeholder
build_anfis <- function(x) NULL

mod <- function() {
  list(
    meta = list(
      name = "",
      type = "mamdani",
      type = 1,
      `&` = "min",
      `|` = "max",
      imp = "min",
      agg = "max",
      defuzz = "centroid"
    ),
    ANFIS  = list(
      input = list(),
      antecedent = list(),
      firing_strength = list(),
      norm_fire_strength = list(),
      consequent = list() 
    )
  )
}

build <- function(mod) {
  l <- length(mod$input)
  i <- 1:l
  offset <- 0
  
  in_n <- lengths(lapply(mod$input, function(x) x$mf))
  
  out <- length(mod$output)
  out_n <- lengths(lapply(mod$output, function(x) x$mf))
  
  rule_n <- nrow(mod$rule)
  antecedent <- matrix(mod$rule[, i], nrow = rule_n)
  consequent <- matrix(mod$rule[, (l + 1):(l + out)], nrow = rule_n)
  weight <- matrix(mod$rule[, ncol(mod$rule) - 1], nrow = rule_n)
  operator <- matrix(mod$rule[, ncol(mod$rule)], nrow = rule_n)
  
  
}


##### Regular FIS membership functions #####
# tunable parameters in ANFIS

#' membership functions
#' @references 
#' Talpur, N., Salleh, M. N. M. & Hussain, K. (2017). 
#' An investigation of membership functions on performance of ANFIS for 
#' solving classification problems. 
#' *In IOP Conference Series: Materials Science and Engineering, 226*(1), 012103
#' @name membership
NULL

mf_linear <- function(x, ...) {
  x %*% c(...)
}

#' generalized bell membership function
#' @noRd
mf_bell <- function(x, a, b, c, h = 1) {
  1 / (1 + abs((x - c) / a) ^ (2 * b))
}

#' Truncated triangle shape membership
#' 
#' @param a,b feet
#' @param c, d shoulders
#' @noRd
mf_trapezoid <- function(x, a, b, c, d, h = 1) {
  max(
    0,
    min(
      1,
      (x - a) / (b - a),
      (d - x) / (d - c)
    )
  )
}


#' triangular membership function
#' 
#' @param a,c feet
#' @param b tip of the curve
#' @noRd
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

#' Guassian membership function
#' @noRd
mf_gaussian <- function(x, c, o, h = 1) {
  e <- 2.7182818284590452353602874713527
  e^(-.5 * (( x - c ) / o ) ^ 2) * h
  #exp(-(x - c)^2 / (2 * o^2)) * 1
}

#' trimmed membership function
# TODO in what situations to use this?
#' @noRd
mf_trim <- function(x, a, b, c, h = 1) {
  max(
    0,
    min(
      (x - a) / (b - a),
      (c - x) / (c - b)
    )
  ) * h
}
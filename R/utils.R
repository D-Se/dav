#' null coalescing operator
#' @name notnull
#' @param x,y a variable
#' @return LHS if true, RHS if LHS is NULL
`%||%` <- function(x, y) if(is.null(x)) y else x

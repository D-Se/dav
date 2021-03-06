#' null coalescing operator
#' @name notnull
#' @param x,y a variable
#' @return LHS if true, RHS if LHS is NULL
#' @keywords internal
#' @noRd
`%||%` <- function(x, y) if (is.null(x)) y else x

#' pretty console printing of package functions
pretty <- function() {
  if (commandArgs()[[1L]] == "RStudio") {
    Sys.getenv(c("RSTUDIO_CONSOLE_COLOR", "RSTUDIO_CONSOLE_WIDTH"))
  }
}

#' Reproducible R expressions that include randomness
#'
#' @param expr exxpression to evaluate
#' @noRd
eval_seeded <- function(expr) {
  expr <- substitute(expr)
  old <- .Random.seed
  on.exit(.Random.seed <<- old)
  set.seed(dav_seed) # package seed specified in globals.R
  eval.parent(expr)
}

#' expand custom specification
#' @param spec model specification
#' @return \strong{fml}: qualified model specification
expand_alias <- (function() {
  fun_alias <- c(
    "com", "rel"
  )
  fun_full <- paste0(c(
    "completeness", "reliability"
  ), "(data)")
  function(spec) {
    spec %||% return(NULL)
    spec[[2L]] |>
      as.expression() |>
      as.character() |>
      stringi::stri_replace_all_fixed(
        # TODO only replace partial occurrences
        fun_alias, fun_full, vectorize_all = FALSE
      ) |>
      str2lang()
  }
})()

eval_spec <- function(data, spec) {
  eval(expand_alias(spec))
}

#' introduce PR command for NEWS.md shortcuts
#' @noRd
Rd_expr_PR <- function(x) {
  baseurl <- "https://github.com/D-Se/dav/issues"
  sprintf("\\href{%s=%s}{PR#%s}", baseurl, x, x)
}

#' null coalescing operator
#' @name notnull
#' @param x,y a variable
#' @return LHS if true, RHS if LHS is NULL
`%||%` <- function(x, y) if (is.null(x)) y else x

#' checking if R object or file is a trade-able data asset
#' @param x R object or file path
#' @param ... arguments passed to or from other methods
#' @details
#' a data asset is a collection of relata that carries semantic value in a
#' context.
#' @note \code{is.asset(x)} does not test if the asset is \emph{sensible}.
#' @return boolean
#' @export
is.asset <- function(x, ...) {
  # lgl, int, num, cmpl, chr
  if (!is.atomic(x)) {
    is.recursive(x) && !is.language(x)
  } else {
    # file path and readable
    is.character(x) && file.access(x, 4L) == 0L
  }
}

asset_type <- function(x) {
  if (is.asset(x)) {
    switch(
      typeof(x),
      character = {
        if (!utils::file_test(x)) "directory" else "file"
      },
      list = {
        class <- class(x)
        if (length(class) > 1L) {
          if (inherits(x, "data.frame")) {
            "data.frame"
          } else {
            "custom format"
          }
        } else { # actual list
          if (vapply(x, function(t) any(class(t) == "list"), TRUE)) {
            "nested list"
          } else {
            "singular list"
          }
        }
      },
      S4 = {
        "S4"
      },
      E("file_type")
    )
  } else {
    E("not_asset")
  }
}

is.asset <- function(x, ...) {
  (is.character(x) && file.access(x, 4) == 0) ||
    (!is.atomic(x) && is.object(x) && length(x) > 1L)
}

#' pretty console printing of package functions
pretty <- function() {
  if (commandArgs()[[1L]] == "RStudio") {
    Sys.getenv(c("RSTUDIO_CONSOLE_COLOR", "RSTUDIO_CONSOLE_WIDTH"))
  }
}

#' reproducible r expressions that include randomness
#'
#' @param expr exxpression to evaluate
eval_seeded <- function(expr) {
  expr <- substitute(expr)
  old <- .Random.seed
  on.exit(.Random.seed <<- old)
  set.seed(SEED) # package seed
  eval.parent(expr)
}

#' expand custom specification
#' @param spec model specification
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

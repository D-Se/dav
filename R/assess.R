# intake <- function(x) {
#   string <- paste0("sed 's/\\0//g '", x)
#   data.table::fread(cmd = string, header = F)
# }

#' assess the value of data asset
#' 
#' @param ... the R object to assess the value of
#' @param formula a \emph{valuation specification}
#'
#' @return list of length x
#' @export
dva <- function(..., formula) {
  UseMethod("dva")
}

dva.formula <- function(formula = NULL, ...) {
  x <- c(...)
  fml <- alias(formula)
  #tmp <- lapply(x, template)
  
  # structure(
  #   list(
  #     # TODO list quantifiable data attributes here
  #     completeness(...)
  #   ),
  #   class = "dva"
  # )
}

#files <- list("yes.csv", "yes.test.xml", "nope")
#dva(files)

# completeness <- function(...) UseMethod("completeness")
# completeness.list <- function(...) {
#   length(...) + 1
# }
# completeness.integer <- function(...) {
#   length(...) + 3
# }


#' expand custom formula
#' @param data an object to value
#' @param x a formula of model specification that can include function aliases.
#' @param f a function
#' @noRd
#' @examples
#' \dontrun{
#' col <- function(x) ncol(x)
#' row <- function(x) nrow(x)
#' len <- function(x) length(x)
#' expand_formula(iris, ~ row + 2 col / len)
#' }
#' 
# expand_formula <- function(data, f) {
#   eval(
#     do.call("substitute", list(f, ALIAS))[[2L]]
#   )
# }
alias <- (function() {
  fun_alias <- c(
    "com", "rel"
  )
  fun_full <- paste0(c(
    "completeness", "reliability"
  ), "(data)")
  function(formula) {
    formula %||% return(NULL)
    formula[[2L]] |> 
      as.expression() |>
      as.character() |>
      stringi::stri_replace_all_fixed(
        # TODO only replace partial occurrences
        fun_alias, fun_full, vectorize_all = FALSE
      ) |>
      str2lang()
  }
})()

#ff <- ~ 2 * com + 2 * rel
#alias(ff)

compute <- function(data, formula) {
  eval(alias(formula))
}



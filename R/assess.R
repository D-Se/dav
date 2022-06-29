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
  ext <- grab_file_extension(x)
  
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

dva.default <- function(..., formula = NULL) {
  x <- c(...)
  grab_file_extension(x)
}

grab_file_extension <- function(x) { 
  ext <- sub("^.*\\.(.+?)$", "\\1", x) |> tolower()
  valid_ext <- ext[ext %in% c("csv", "xml", "json", "pdf")]
  if(length(valid_ext) != length(ext)) {
    W(1, setdiff(ext, valid_ext))
  } else {
    valid_ext
  }
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

init <- function(file) {
  #readr::read_lines_raw("testdata/iris.csv")
  data <- readr::read_file_raw(file)
  OS <- .Platform$OS.type
  
  uninformative_glyphs <- switch(OS,
                                 # \r\n = CR + LF → new line character in Windows
                                 windows = c(0x0d, 0x0a),
                                 # \r = CR (Carriage Return) new line character in Mac OS before X
                                 # \n = LF (Line Feed) new line character in Unix/Mac OS X
                                 unix = c(0x0d),
                                 "unknown"
  ) |> 
    as.raw()
  
  list(
    data = list(
      bytes = length(data)
    ),
    user = list(
      OS = OS
    )
  )
}

compute <- function(data, formula) {
  eval(alias(formula))
}



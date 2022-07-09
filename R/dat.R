#' Quantify the semantic value of data assets
#'
#' A data asset is a \dfn{managed set of relata of contextual semantic value}.
#'    Its numeric approximation, dubbed `dat`, uses expert opinions and
#'    indicators.
#'
#' @param asset `lst`|`chr` Data asset(s) to value. Can be an \R object
#'    or file path.
#' @param spec `fml` a one-sided formula to specify data attributes.
#' @param \dots arguments to pass to or from other methods.
#'
#' @includeRmd man/rmd/dat.Rmd details
#' @template data_value_attributes
#' @author Donald Seinen
#' @seealso
#'    \code{\link[=classify]{classify}} and \code{\link[=is.asset]{is.asset}}
#'    give information about asset identification and categorization.
#' \code{\link[=sleuth]{sleuth}} makes the computation process reproducible.
#'
#' @return a structure `dat` that contains:
#'    \item{value}{A numeric value.}
#'    \item{method}{A list containing the method of computation used.}
#'    \item{context}{A list containing a description of the asset, user and
#'    relevant software versions.}
#'
#' @aliases dat dat.default dat.formula
#' @export
#' @examples
#' \dontrun{
#'    dat(iris)
#' }
dat <- function(asset, spec, ...) {
  UseMethod("dat")
}

#' @rdname dat
dat.default <- function(asset, spec = ~ test, ...) {
  res <- list()
  res$meta <- sleuth(asset)
  res$spec <- expand_alias(spec)
  structure(res, class = "dat")
}

#' @rdname dat
dat.formula <- function(spec = ~ test, asset, ...) {
  dat.default(asset, spec, ...)
}

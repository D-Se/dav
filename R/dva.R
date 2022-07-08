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
#' @includeRmd man/rmd/dva.Rmd details
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
#' @aliases dva dva.default dva.formula
#' @export
#' @examples
#' \dontrun{
#'    dva(iris)
#' }
dva <- function(asset, spec, ...) {
  UseMethod("dva")
}

#' @rdname dva
dva.default <- function(asset, spec = ~ test, ...) {
  res <- list()
  res$meta <- sleuth(asset)
  res$spec <- expand_alias(spec)
  structure(res, class = "dat")
}

#' @rdname dva
dva.formula <- function(spec = ~ test, asset, ...) {
  dva.default(asset, spec, ...)
}

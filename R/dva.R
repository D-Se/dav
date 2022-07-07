#' assess the value of data asset
#'
#' \code{dva} quantifies the semantic value of data assets.
#'
#' @usage \special{dav::dva(asset, spec, \dots)}
#' @usage \special{dav::dva(spec, asset, \dots)}
#'
#' @param asset \strong{list|chr}: the data asset to value. Can be a file path
#' or an object.
#' @param spec \strong{fml}: a valuation specification.
#' @param \dots arguments to pass to or from other methods.
#'
#' @return list of length 3: a summary statistic, the method used and context of
#' evaluation.
#'
#' @details
#' A \emph{data asset} is a managed set of relata that carry contextual semantic
#' value.
#'
#' The variable \var{asset} can refer to file locations or objects in memory.
#' \describe{
#' \item{\code{\var{asset}}:}{
#'   A collection of assets. \special{dva} supports list-like structures,
#'   specifically non-atomic classes where \code{is.recursive} is \code{TRUE}.
#' }
#' \item{\code{\var{filepath}}:}{
#'   A path to directory or file
#' }
#' }
#' See the vignette at \code{vigenette('dva', 'dva')} for a detailed explanation
#' of the assumptions, limitations of the package.
#'
#' @section Data asset valuation semantics:
#' A valuation of a data asset is an approximation of its perceived value. It is
#' by no means an exact science. Definitions of concepts such as \emph{data},
#' \emph{file}, \emph{information} are contested.
#'
#' @section Data value attributes:
#' Non-divisible value drivers of data assets.
#'
#' \describe{
#' \item{\code{\var{Completeness}}:}{
#'  To what degree the asset is whole
#' }
#' \item{\code{\var{Relevance}}:}{
# TODO describe Relevance
#'    placeholder description
#' }
#' \item{\code{\var{Integrity}}:}{
# TODO describe Integrity
#'    placeholder description
#' }
#' \item{\code{\var{Timeliness}}:}{
# TODO describe accessibility
#'    placeholder description
#' }
#' \item{\code{\var{Accessibility}}:}{
# TODO describe accessibility
#'   easily and quickly retrievable
#' }
#' \item{\code{\var{Consistency}}:}{
# TODO describe Consistency
#'   placeholder description
#' }
#' \item{\code{\var{Ownership}}:}{
# TODO describe Ownership
#'    placeholder description
#' }
#' \item{\code{\var{Security}}:}{
# TODO describe Security
#'    placeholder description
#' }
#' \item{\code{\var{Sensitivity}}:}{
# TODO describe Sensitivity
#'    placeholder description
#' }
#' \item{\code{\var{Usability}}:}{
# TODO describe Usability
#'    placeholder description
#' }
#' \item{\code{\var{Volume}}:}{
# TODO describe Volume
#'    placeholder description
#' }
#' \item{\code{\var{Conciseness}}:}{
#'   Compactness of data. Examples are compressed file or versus those that
#'   have redundant or repetitive non-informative content.
#' }
#' \item{\code{\var{Documentation}}:}{
# TODO describe Documentation
#'   Metadata on the management of the asset at hand.
#' }
#' \item{\code{\var{Encryption}}:}{
# TODO describe Encryption
#'   A path to directory or file
#' }
#' \item{\code{\var{Longevity}}:}{
# TODO describe Longevity
#'   A path to directory or file
#' }
#' \item{\code{\var{Scalability}}:}{
# TODO describe Scalability
#'   A path to directory or file
#' }
#' \item{\code{\var{Scarcity}}:}{
#'   A path to directory or file
#' }
#' \item{\code{\var{Frequency}}:}{
# TODO describe Frequency
#'   A path to directory or file
#' }
#'
#' }
#'
#' @seealso
#' \code{\link[=is.asset]{dav::is.asset}} \code{\link[=classify]{dav::classify}}
#' give information about asset specification. \code{\link[=sleuth]{dav::sleuth}}
#' aid in making the process reproducible across sessions.
#'
#' @export
dva <- function(asset, spec, ...) {
  UseMethod("dva")
}

dva.default <- function(asset, spec = ~ test, ...) {
  meta <- sleuth(asset)
  spec <- expand_alias(spec)
}

dva.formula <- function(spec = ~ test, asset, ...) {
  dva.default(asset, spec, ...)
}

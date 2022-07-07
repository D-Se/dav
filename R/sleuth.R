#' investigate and document file metadata
#'
#' \code{dav::sleuth} investigates the context in which data is valued, and
#' lays the foundation for comparison of data assets based on a unified data
#' asset metadata schema.
#'
#' @usage \special{dav::sleuth(file)}
#'
#' @param asset a data asset. A \emph{filepath} or an R object.
#' @param spec a formula that describes a model specification.
#' @return list of file metadata descriptors
#'
#' @details
#' \code{sleuth} investigates and collects information on the \emph{thing\(s\)}
#' to be valued and the \emph{system} on which it is evaluated. A comparison of
#' data.
#'
#' filepaths are case sensitive.
#'
#' @section Data semantics:
#' An approximation of data value is limited by the ability to distinguish
#' noise from data and the truthfulness of their content. In \code{sleuth} files
#' are documented based on raw inputs and generally accepted practices.
#'
#' @examples
#' \dontrun{
#' sleuth(iris)
#' }
#' @importFrom stats alias
#' @importFrom utils osVersion
#' @export
sleuth <- function(asset) {
  res <- list()
  if (is.asset(asset)) {
    res$context <- context()
    # asset is a file path
    #res$asset <- classify(asset)
  } else {
    # data asset is in random access memory
    return(0)
  }
}

file_info <- function(file) {
  # directory or single file?
  !utils::file_test("-f", file)
  info <- file.info(file, extra_cols = TRUE) |> as.list()
  info
}

#' classify a given data asset
#'
#' @param asset a data asset
#'
#' @return \strong{chr}: a platform and domain independent classification.
classify <- function(asset) {
  ext <- grab_ext(asset)
  grab_mime(ext) %||% grab_magic(asset) %||% ext
}

grab_ext <- function(x) {
  # tools::file_ext and base::ifelse
  pos <- regexpr("\\.([[:alnum:]]+)$", x)
  y <- which(pos > -1L)
  n <- which(!pos > -1L)
  x[y] <- substring(x, pos + 1L)[y]
  x[n] <- ""
  x
}

grab_mime <- function(file) {
  MIME[["file"]]
}

grab_magic <- function(file) {
  # endianness can't be inferred from binary file
  # .Platform$endian
  header <- readBin(file, "raw", n = 12)
  # reading trailing byte is problematic and slow
  # system(paste0("trail -n 2 ", file), intern = TRUE) |> charToRaw()
}

#' get context on how the
context <- function() {
  res <- unclass(R.version)
  res$platform <- paste0(res$platform, " (",
                         8 * .Machine$sizeof.pointer, "-bit)")
  res <- res[c("platform", "version.string")]
  res$os <- osVersion
  # reproducibility of ANFIS states
  res$RNG <- RNGkind()
  # multi-byte character set in use?
  res$time <- Sys.time() |> `attr<-`("tzone", "UTC")
  # Latin-1 is ISO/IEC 8859-1
  res$locale <- unlist(l10n_info())[1:3]
  # res$software_versions <- extSoftVersion()[c(1, 2)]
  res
}

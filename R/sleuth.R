#' investigate and document file metadata
#'
#' \code{sleuth} investigates the context in which data is valued. It lays the
#' foundation for comparison of data assets and workflows via fuzzy
#' inference systems.
#'
#' @usage \special{sleuth(file)}
#' @usage \special{sleuth(dir, pattern = ".csv")}
#'
#' @param asset a data asset. A \emph{filepath} or an R object.
#' @param \dots arguments passed from and to methods.
#' @return list of file metadata descriptors
#'
#' @details
#' \code{sleuth} investigates and collects information on the \emph{thing\(s\)}
#' to be valued and the \emph{system} on which it is evaluated. A comparison of
#' data.
#'
#' file paths are case sensitive.
#'
#' @section Data asset semantics:
#' An approximation of data value is limited by the ability of the valuer to
#' distinguish noise from data. \code{sleuth} documents possible sources
#' of influence on the integrity of the valuation process. As the package is
#' open source, sensitive information on the users are not collected.
#' 
#' @section File classification:
#' What exactly is a file is operating system dependent. Inference on the
#' structure of files is based on MIME \(Multipurpose Internet
#' Mail Extensions\)
#'
#' @examples
#' \dontrun{
#' sleuth(iris)
#' }
#' @importFrom stats alias
#' @importFrom utils osVersion
#' @export
sleuth <- function(asset, ...) {
  res <- list()
  if (is.asset(asset)) {
    res$context <- sleuth_context()
    res$asset <- sleuth_asset(asset)
    # asset is a file path
    #res$asset <- classify(asset)
  } else {
    # data asset is in RAM
    return(0)
  }
  res
}

#' get user and context
#' 
#' Several data attributes require detailed information on the who, what, where
#' and when of data assets. Additionally to facilitate metric reproducibility,
#' some hard- nd software specifications are \(temporarily\) gathered
sleuth_context <- function() {
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

#' Find and organize the file context
#' 
#' @param asset data asset
#' @return \strong{lst} of documented file context
sleuth_asset <- function(asset) {
  res <- list()
  if(!is.asset(asset)) E("not_asset")
  res$what <- classify(asset)
  res$info <- file_info(asset)
  res
}


file_info <- function(asset, ...) {
  if (utils::file_test("-f", asset)) {
    # asset is a single file
    file.info(asset, extra_cols = TRUE) |> as.list()
  } else {
    # asset is a diretory
    files <- list.files(asset, ...)
    lapply(files, file_info, ...)
  }
}

#' classify a given data asset
#'
#' @param asset a data asset
#'
#' @return \strong{chr}: a platform and domain independent classification.
classify <- function(asset) {
  ext <- grab_ext(asset)
  mime[[ext]] %||% grab_magic(asset) %||% ext
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

grab_magic <- function(file) {
  # endianness can't be inferred from binary file
  # .Platform$endian
  header <- readBin(file, "raw", n = 12)
  # reading trailing byte is problematic and slow
  # system(paste0("trail -n 2 ", file), intern = TRUE) |> charToRaw()
  100
}

get_asset_type <- function(x) {
  switch(
    typeof(x),
    character = {
      if (!utils::file_test("-f", x)) "directory" else "file"
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
}

#' Data asset identity check
#' 
#' @description 
#' Check if object is sufficiently complex to carry possibly distinguishable
#'   semantic value. \code{is.asset} returns \code{TRUE} if the input is a
#'    list-like structure or a file path pointing to a valid file or directory.
#' 
#' @param x \R object or file path
#' @param ... arguments passed to or from other methods
#' 
#' @details
#' A data asset is a collection of relata that carries semantic value in a
#'    context. To avoid computability paradoxes constraints have to be placed on
#'    the definition. Atomic vectors carry little value on their own.
#' 
#' Calls, expressions and code in general are certainly data assets, but
#'    methods have not yet been implemented to approximate their value, and thus
#'    return \code{FALSE} for now. Do not rely on this.
#' 
#' @note \code{is.asset(x)} does only weakly check if the asset is
#'  \emph{sensible}.
#' @return boolean
#' 
#' @seealso 
#' \link[base]{is.recursive} for list-like structures, \link[base]{is.language}
#' for 
#' @export
is.asset <- function(x, ...) {
  if (is.atomic(x)) {
    # file path and readable. Exclude lgl, int, num, cmpl, chr
    is.character(x) && file.access(x, 4L) == 0L
  } else {
    is.recursive(x) && !is.language(x) && !is.function(x)
  }
}
